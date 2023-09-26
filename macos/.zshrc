# Source core .zshrc file
source ~/dotfiles/.zshrc 

# Fix builtin man pages being screwy
# --- Bugging - disable for now
#unalias run-help
#autoload run-help
#HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
#alias help=run-help

# Something to do with kubectl, I forgot
ZSH_DISABLE_COMPFIX=true

# Lua language server
alias luamake=/Users/sam/.config/nvim/lua-language-server/3rd/luamake/luamake

