# Aliases
alias idea='intellij-idea-ultimate-edition'
# OMZ Theme
ZSH_THEME="lukerandall"

# Source core .zshrc file
source $HOME/dotfiles/.zshrc 

# Local binaries
path+="$HOME/.local/bin"

# Setup fzf keybindings and auto completions
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Set zsh autosuggestion colour
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#798579"
