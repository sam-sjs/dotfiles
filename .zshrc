#Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Fix builtin man pages being screwy
unalias run-help
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help

ZSH_DISABLE_COMPFIX=true
export VISUAL=nvim
export EDITOR="$VISUAL"
alias nv='nvim'
alias nvd='nvim -d'
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type directory . $HOME --exclude "/Library" --exclude "**/node_modules"'
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

export PATH="$HOME/go/bin:$PATH"

# Stack (Haskell) binaries dir
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
plugins=(git kubectl zsh-autosuggestions zsh-syntax-highlighting zsh-nvm)
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"
source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias luamake=/Users/sam/.config/nvim/lua-language-server/3rd/luamake/luamake
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#Nix
if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme
source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/.ghcup/env
