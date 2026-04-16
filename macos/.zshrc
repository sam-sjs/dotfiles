# Source core .zshrc file
source ~/dotfiles/.zshrc 

# Something to do with kubectl, I forgot
ZSH_DISABLE_COMPFIX=true

# Lua language server
alias luamake=/Users/sam/.config/nvim/lua-language-server/3rd/luamake/luamake

# Shortcut to iCloud drive (i.e. "cd ~icloud")
hash -d icloud=$HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs/
