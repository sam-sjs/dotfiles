export VISUAL=nvim
export EDITOR="$VISUAL"

# Neovim
alias nv='nvim'
alias nvd='nvim -d'

# Go binaries
path+="$HOME/go/bin:$PATH"

# Stack (Haskell)
## Binaries
path+="$HOME/.local/bin:$PATH"
path+="$HOME/.cabal/bin:$PATH"
## Env
source ~/.ghcup/env

# OMZ
export ZSH="$HOME/.oh-my-zsh"
plugins=(git kubectl zsh-autosuggestions zsh-syntax-highlighting)
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"
source $ZSH/oh-my-zsh.sh
source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type directory . $HOME --exclude "/Library" --exclude "**/node_modules"'

# Nix
if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
