HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
DISABLE_MAGIC_FUNCTIONS="true"
ZSH_DISABLE_COMPFIX="true"

setopt autocd extendedglob nomatch
bindkey -e
export VISUAL=nvim
export EDITOR="$VISUAL"
path+="$HOME/.local/bin"

# Handle navigate by word at shell level
bindkey $'\e[1;3D' backward-word
bindkey $'\e[1;3C' forward-word

# Smarter completion initialization - only rebuild the dump once a day.
# stat(1) differs between BSD and GNU, so branch on the platform.
autoload -Uz compinit
if [[ $OSTYPE == darwin* ]]; then
    _zcompdump_day=$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
else
    _zcompdump_day=$(date -r ~/.zcompdump +'%j' 2>/dev/null)
fi
if [[ "$(date +'%j')" != "$_zcompdump_day" ]]; then
    compinit
else
    compinit -C
fi
unset _zcompdump_day

# Source MYOB specific settings
[[ -f "$HOME/.myob_zshrc" ]] && source "$HOME/.myob_zshrc"

# Machine-local settings - hostnames, credentials, anything not for a public repo
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# Neovim
alias nv='nvim'
alias nvd='nvim -d'
alias nf='nvim $(fzf)'

# OMZ Theme
ZSH_THEME="lukerandall-custom"

# Bitwarden SSH Agent
_bw_agent="$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
[[ -S "$_bw_agent" ]] && export SSH_AUTH_SOCK="$_bw_agent"
unset _bw_agent

# OMZ
## Stop NVM slowing down terminal load time
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

export ZSH="$HOME/.oh-my-zsh"
plugins=(git kubectl zsh-autosuggestions zsh-nvm zsh-syntax-highlighting)
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source $ZSH/oh-my-zsh.sh

# Fzf
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type directory . $HOME --exclude "/Library" --exclude "**/node_modules"'

# Decode and pretty print a JWT payload (base64url, handles missing padding)
jwt () {
    local p="${1#*.}"; p="${p%%.*}"
    p="${p//-/+}"; p="${p//_//}"
    while (( ${#p} % 4 )); do p+="="; done
    print -r -- "$p" | base64 --decode | jq
}

# Load Nix environment
alias ns='nix-shell --command "exec zsh"'
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
