#!/bin/bash

# Stop script if any command fails
set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "📦 Step 1: Running OS-specific installations..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 macOS detected..."
    if ! command -v brew &> /dev/null; then
        echo "🍺 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add brew to path for the rest of the script
        eval "$(/opt/homebrew/bin/brew shellenv)" || eval "$(/usr/local/bin/brew shellenv)"
    fi
    echo "🍺 Installing apps from Brewfile (Ghostty, OpenCode, etc.)..."
    brew bundle --file="$DOTFILES_DIR/mac/Brewfile"

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "🐧 Linux detected..."
    
    # Check for Debian/Ubuntu (apt)
    if command -v apt-get &> /dev/null; then
        echo "📦 Debian/Ubuntu environment detected (apt)"
        sudo apt-get update
        xargs sudo apt-get install -y < "$DOTFILES_DIR/linux/apt_packages.txt"
        
        echo "🤖 Installing OpenCode via curl..."
        curl -fsSL https://opencode.ai/install | bash

    # Check for Arch Linux (pacman)
    elif command -v pacman &> /dev/null; then
        echo "🏹 Arch Linux environment detected (pacman)"
        sudo pacman -Syu --noconfirm
        
        # Install base packages
        echo "⚙️  Installing base packages..."
        sudo pacman -S --needed --noconfirm - < "$DOTFILES_DIR/linux/pacman_packages.txt"
        
        echo "🤖 Installing OpenCode..."
        curl -fsSL https://opencode.ai/install | bash
    else
        echo "⚠️  Unknown Linux distribution. Skipping system package installation."
    fi
fi

echo "🚀 Step 2: Setting up Zsh & Plugins..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "✨ Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "✨ Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "🎨 Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

echo "🔗 Step 3: Symlinking configuration files..."

# Function to safely symlink files
sync_file() {
    local src="$1"
    local dest="$2"
    
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "Backing up $dest to $dest.bak"
        mv "$dest" "$dest.bak"
    fi
    
    ln -sf "$src" "$dest"
}

sync_file "$DOTFILES_DIR/config/.zshrc" ~/.zshrc
sync_file "$DOTFILES_DIR/config/.vimrc" ~/.vimrc

mkdir -p ~/.config/ghostty
sync_file "$DOTFILES_DIR/config/ghostty.conf" ~/.config/ghostty/config

echo "Finished! Please restart your shell."
