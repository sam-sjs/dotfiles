#!/bin/bash

packer_dir=~/.local/share/nvim/site/pack/packer/start
if [[ ! -e $packer_dir/packer.nvim ]]; then
    mkdir -p $packer_dir
    git clone --depth 1 https://github.com/wbthomason/packer.nvim $packer_dir/packer.nvim
fi

nvim_repo=$HOME/dotfiles/nvim
mkdir -p $HOME/.config/nvim/lua
ln -sf $nvim_repo/autoload/ $HOME/.config/nvim
ln -sf $nvim_repo/colors/ $HOME/.config/nvim
ln -sf $nvim_repo/ftplugin/ $HOME/.config/nvim
ln -sf $nvim_repo/init.lua $HOME/.config/nvim/init.lua
ln -sf $nvim_repo/plugins.lua $HOME/.config/nvim/lua/plugins.lua
ln -sf $nvim_repo/language-servers.lua $HOME/.config/nvim/lua/language-servers.lua

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
