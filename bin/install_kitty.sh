#!/bin/bash
echo "Installing kitty terminal..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
mkdir -p $HOME/.config/kitty
ln -sf $DOT_DIR/kitty/kitty.conf $HOME/.config/kitty/kitty.conf 
ln -sf $DOT_DIR/kitty/themes $HOME/.config/kitty/themes
