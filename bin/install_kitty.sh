#!/bin/bash
echo "Installing kitty terminal..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
mkdir -p $HOME/.config/kitty
ln -sf $HOME/dotfiles/kitty/kitty.conf $HOME/.config/kitty/kitty.conf 
ln -sf $HOME/dotfiles/kitty/themes $HOME/.config/kitty/themes
