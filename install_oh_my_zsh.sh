#!/bin/bash

# Exit on error
set -e

# Function to print messages
log() {
    echo -e "\e[32m$1\e[0m"
}

# Check for argument and set default if none provided
MAKE_DEFAULT_SHELL="${1:-no}"

# Display the selected option
log "Make Zsh default shell: $MAKE_DEFAULT_SHELL"

# --- OS-specific setup ---
OS="$(uname -s)"
case "$OS" in
    Linux*)
        log "Running on Linux"
        log "Installing Zsh, curl, git..."
        if ! command -v apt-get &> /dev/null; then
            log "apt-get not found. This script supports Debian-based systems."
            exit 1
        fi
        sudo apt-get update
        sudo apt-get install -y zsh curl git
        SED_INPLACE="sed -i"
        ZSH_PATH=$(which zsh)
        ;;
    Darwin*)
        log "Running on macOS"
        if ! command -v brew &> /dev/null; then
            log "Homebrew not found. Please install it from https://brew.sh/"
            exit 1
        fi
        log "Installing Zsh, curl, git using Homebrew..."
        brew install zsh curl git
        SED_INPLACE="sed -i ''"
        ZSH_PATH=$(brew --prefix)/bin/zsh
        if ! grep -Fxq "$ZSH_PATH" /etc/shells; then
            log "Adding Homebrew Zsh to /etc/shells..."
            echo "$ZSH_PATH" | sudo tee -a /etc/shells
        fi
        ;;
    *)
        log "Unsupported OS: $OS"
        exit 1
        ;;
esac
# --- End OS-specific setup ---

# Install Oh My Zsh if not already installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    log "Oh My Zsh is already installed. Skipping installation."
else
    log "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Set Zsh as the default shell if requested
if [[ "$MAKE_DEFAULT_SHELL" == "yes" ]]; then
    log "Setting Zsh as the default shell..."
    chsh -s "$ZSH_PATH"
else
    log "Zsh installation complete. Skipping setting it as the default shell."
fi

# Install Zsh plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
PLUGINS_DIR="$ZSH_CUSTOM/plugins"
AUTOSUGGESTIONS_DIR="$PLUGINS_DIR/zsh-autosuggestions"
SYNTAX_HIGHLIGHTING_DIR="$PLUGINS_DIR/zsh-syntax-highlighting"

if [ ! -d "$AUTOSUGGESTIONS_DIR" ]; then
    log "Installing Zsh autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGESTIONS_DIR"
else
    log "Zsh autosuggestions already installed. Skipping."
fi

if [ ! -d "$SYNTAX_HIGHLIGHTING_DIR" ]; then
    log "Installing Zsh syntax highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SYNTAX_HIGHLIGHTING_DIR"
else
    log "Zsh syntax highlighting already installed. Skipping."
fi

# Update .zshrc to enable plugins
log "Configuring Zsh plugins in .zshrc..."
if ! grep -q "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" ~/.zshrc; then
    if grep -q "plugins=(git)" ~/.zshrc; then
        $SED_INPLACE 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
        log "Updated plugins in .zshrc."
    else
        log "Could not find 'plugins=(git)' in .zshrc. Please add plugins manually."
    fi
else
    log "Plugins already configured in .zshrc."
fi

log "Verifying .zshrc..."
if zsh -c "source ~/.zshrc"; then
    log ".zshrc verified successfully."
else
    log "There might be an issue with your .zshrc file."
fi

log "Installation complete! Please start a new Zsh session to see the changes."
