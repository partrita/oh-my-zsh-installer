# **Oh My Zsh Installer with Plugins**

This script automates the installation of **Oh My Zsh**, **Zsh autosuggestions**, and **Zsh syntax highlighting**. It supports both Debian-based Linux and macOS.

## **Platform Support**
- **Linux** (Debian, Ubuntu, etc.)
- **macOS**

## **Features**
- Installs **Oh My Zsh**.
- Installs **Zsh autosuggestions** and **Zsh syntax highlighting** plugins.
- Optionally sets Zsh as the default shell.
---

## **Prerequisites**
- **On Linux:** The script uses `apt-get` and will install `zsh`, `curl`, and `git`.
- **On macOS:** You must have [Homebrew](https://brew.sh/) installed. The script will use it to install `zsh`, `curl`, and `git`.

---

## **How to Run**

1.  Clone this repository or download the `install_oh_my_zsh.sh` script:
    ```bash
    git clone https://github.com/MNMaqsood/oh-my-zsh-installer.git
    cd oh-my-zsh-installer
    ```

2.  Run the script using `bash`. This method does not require you to make the script executable with `chmod +x`.

    ```bash
    bash install_oh_my_zsh.sh [yes|no]
    ```

### **Arguments**
-   **`yes`**: Install Oh My Zsh and set it as the default shell.
-   **`no`** (or no argument): Install Oh My Zsh but do **not** change the default shell.

### **Examples**

-   **Install and set as default:**
    ```bash
    bash install_oh_my_zsh.sh yes
    ```

-   **Install without setting as default:**
    ```bash
    bash install_oh_my_zsh.sh no
    ```

## **License**
This project is licensed under the [MIT License](LICENSE).
