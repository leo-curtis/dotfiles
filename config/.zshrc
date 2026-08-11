# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set your preferred theme
ZSH_THEME="robbyrussell"

# Activate your plugins (Syntax highlighting must be last)
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Ghostty Shell Integration
if [ -n "$GHOSTTY_RESOURCES_DIR" ]; then
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
fi

# Custom Aliases
alias ll="ls -la"
alias ..="cd .."

# Editor
export EDITOR='vim'

# Path
export PATH="$HOME/bin:/usr/local/bin:$PATH"
