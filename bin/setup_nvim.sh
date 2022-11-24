#!/bin/bash

packer_dir=~/.local/share/nvim/site/pack/packer/start
if [[ ! -e $packer_dir/packer.nvim ]]; then
    mkdir -p $packer_dir
    git clone --depth 1 https://github.com/wbthomason/packer.nvim $packer_dir/packer.nvim
fi

mkdir -p $HOME/.config/nvim/lua
ln -sf $DOT_DIR/nvim/autoload/ $HOME/.config/nvim
ln -sf $DOT_DIR/nvim/colors/ $HOME/.config/nvim
ln -sf $DOT_DIR/nvim/ftplugin/ $HOME/.config/nvim
ln -sf $DOT_DIR/nvim/init.lua $HOME/.config/nvim/init.lua
ln -sf $DOT_DIR/nvim/plugins.lua $HOME/.config/nvim/lua/plugins.lua
ln -sf $DOT_DIR/nvim/language-servers.lua $HOME/.config/nvim/lua/language-servers.lua

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
