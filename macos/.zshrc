#Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source core .zshrc file
source ~/dotfiles/.zshrc 

# Fix builtin man pages being screwy
unalias run-help
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help

# Something to do with kubectl, I forgot
ZSH_DISABLE_COMPFIX=true

# Stop NVM slowing down terminal load time
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

# Lua language server
alias luamake=/Users/sam/.config/nvim/lua-language-server/3rd/luamake/luamake

# P10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme