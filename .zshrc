HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt autocd extendedglob nomatch
bindkey -e
export VISUAL=nvim
export EDITOR="$VISUAL"
path+="$HOME/.local/bin"

# Neovim
alias nv='nvim'
alias nvd='nvim -d'

# OMZ Theme
ZSH_THEME="lukerandall-custom"

# Go binaries
# Brew OpenSSH - Built in SecurityKeyProvider
path=(/usr/local/opt/openssh/bin $HOME/go/bin $path)

# Stack (Haskell)
## Binaries
#path+="$HOME/.ghcup/bin"
#path+="$HOME/.cabal/bin"
## Env
source ~/.ghcup/env

# Bitwarden SSH Agent
export SSH_AUTH_SOCK=/Users/sam/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock

# OMZ
## Stop NVM slowing down terminal load time
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

export ZSH="$HOME/.oh-my-zsh"
plugins=(git kubectl zsh-autosuggestions zsh-syntax-highlighting zsh-nvm)
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"
source $ZSH/oh-my-zsh.sh
source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Stop highlighting from slowing down large pastes
export ZSH_HIGHLIGHT_MAXLENGTH=150

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type directory . $HOME --exclude "/Library" --exclude "**/node_modules"'

# Decode and pretty print JWTs - not working
jwt () {
    cut -d"." -f1,2 <<< $1 | sed 's/\./\n/g' | base64 --decode | jq
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Load Nix environment
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
