# Source core .zshrc file
source ~/dotfiles/.zshrc 

# Add macos specific to path
path+="/Applications/Ghostty.app/Contents/MacOS"

# Lua language server
alias luamake=/Users/sam/.config/nvim/lua-language-server/3rd/luamake/luamake

# Shortcut to iCloud drive (i.e. "cd ~icloud")
hash -d icloud=$HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs/
