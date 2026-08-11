# Cross-Platform Dotfiles & Development Environment

An automated, unified configuration script for managing shell preferences, system settings, and development tools across **macOS** and **Linux** 

Inspired by other dotfile repos from Mathias Bynens and Adam Elmore, this setup uses a central bootstrap script to auto-detect the operating system, symlink configuration files, and install a set of development tools.

---

## Installation

To set up a brand new machine from scratch, open your terminal and run the following command. It will clone the repository to your home directory and execute the installer:

```bash
git clone https://github.com/leo-curtis/dotfiles ~/dotfiles; chmod +x ~/dotfiles/bootstrap.sh && ~/dotfiles/bootstrap.sh
```

---

## Included Stack & Applications

The bootstrap script automatically configures your workspace and provisions the following software stack based on your runtime environment:

### Core Configuration
* **Shell Framework:** [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh/) (managed via unattended installation).
* **Zsh Plugins:** `zsh-autosuggestions` and `zsh-syntax-highlighting` auto-cloned into custom plugin directories.
* **Vim Setup:** A lightweight, portable, plugin-free vim configuration.

### Operating System Provisions

| Application / Package | macOS (Homebrew) | Debian/Ubuntu (Apt) | Arch Linux (Pacman) |
| :--- | :---: | :---: | :---: |
| **Git** & **Zsh** | ✅ (Brew Core) | ✅ (Apt Package) | ✅ (Pacman Core) |
| **Curl** & **Build Tools** | ✅ (Native) | ✅ (`build-essential`) | ✅ (`base-devel`) |
| **Ghostty Terminal** | ✅ (Homebrew Cask) | ✅ (System Repo) | ✅ (Extra Repo) |
| **OpenCode AI IDE** | ✅ (`anomalyco/tap`) | ✅ (Curl Script) | ✅ (Curl Script) |

---
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

