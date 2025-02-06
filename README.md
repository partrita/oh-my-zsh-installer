# **Oh My Zsh Installer with Plugins**

This script automates the installation of **Oh My Zsh**, **Zsh autosuggestions**, and **Zsh syntax highlighting** on a new server. It also allows you to set Zsh as the default shell.

## **Features**
- Installs **Oh My Zsh**.
- Installs **Zsh autosuggestions** and **Zsh syntax highlighting** plugins.
- Optionally sets Zsh as the default shell.
---

## **Prerequisites**
Ensure your server has the following installed:
- `curl`
- `git`
- `zsh` (the script will install it if not already present)

---

## **Installation**
1. Clone this repository or download the script:
   ```bash
   git clone https://github.com/MNMaqsood/oh-my-zsh-installer.git
   cd oh-my-zsh-installer
   ```

2. Make the script executable:
   ```bash
   chmod +x install_oh_my_zsh.sh
   ```

3. Run the script with or without arguments:

### **Usage**
```bash
./install_oh_my_zsh.sh [yes|no]
```

- **Arguments:**
  - `yes`: Install Zsh and set it as the default shell.
  - `no` (default): Install Zsh without changing the default shell.

**Examples:**

- Install Oh My Zsh and make it the default shell:
  ```bash
  ./install_oh_my_zsh.sh yes
  ```

- Install Oh My Zsh without changing the default shell:
  ```bash
  ./install_oh_my_zsh.sh no
  ```

- If no argument is passed, it defaults to `no`:
  ```bash
  ./install_oh_my_zsh.sh
  ```

---

## **Script Details**

### **What the Script Does**
1. Installs Zsh if not already installed.
2. Installs **Oh My Zsh**.
3. Installs the following plugins:
   - **Zsh Autosuggestions**: Provides command suggestions based on your history.
   - **Zsh Syntax Highlighting**: Highlights commands and syntax for better readability.
4. Updates the `.zshrc` file to enable the plugins.
5. Optionally sets Zsh as the default shell.

### **Plugin Configuration**
The script modifies `.zshrc` to include the following plugins:
```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

If `.zshrc` already contains these plugins, it skips this step.

---

## **Troubleshooting**

1. **Oh My Zsh already installed**:
   If you encounter the message:
   ```
   The $ZSH folder already exists (/home/username/.oh-my-zsh).
   You'll need to remove it if you want to reinstall.
   ```
   The script automatically detects this and skips reinstallation.

2. **Permission Denied**:
   Ensure you have execution permissions for the script:
   ```bash
   chmod +x install_oh_my_zsh.sh
   ```

3. **Set Zsh manually**:
   If you choose not to set Zsh as the default shell during installation, you can do it later:
   ```bash
   chsh -s $(which zsh)
   ```

## **License**
This project is licensed under the [MIT License](LICENSE).
