# Source core .zshrc file
source ~/dotfiles/.zshrc

# Add macos specific to path
path+="/Applications/Ghostty.app/Contents/MacOS"

# Shortcut to iCloud drive (i.e. "cd ~icloud")
hash -d icloud=$HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs/

# Print at copy
alias ppbcopy="tee /dev/tty | pbcopy"
