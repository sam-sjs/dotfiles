#!/bin/bash

# Install apt packages
sudo apt-get update && sudo apt-get -y install $(cat $DOT_DIR/packages $DOT_DIR/linux/packages)

# Install fonts
$DOT_DIR/bin/install_fonts.sh $HOME/.fonts

# Install kitty terminal
[[ ! -d $HOME/.local/kitty.app ]] && $DOT_DIR/bin/install_kitty.sh
mkdir -p $HOME/.local/bin/kitty
sudo -i ln -sf $HOME/.local/kitty.app/bin/kitty /usr/local/bin/kitty

# Install OMZ
$DOT_DIR/bin/install_omz.sh
[[ ! $SHELL == $(which zsh) ]] && chsh -s $(which zsh)

# Install P10k
[[ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]] && \
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install Haskell
[[ ! -f $HOME/.ghcup/env ]] && $DOT_DIR/bin/install_haskell.sh
[[ ! -e $HOME/.cabal/bin/dhall-lsp-server ]] && $DOT_DIR/bin/install_dhall.sh

# Install Awesome WM
if [[ ! -f /usr/local/bin/awesome ]]; then
    sudo apt-get build-dep awesome -y
    git clone https://github.com/awesomeWM/awesome.git && cd awesome
    make
    sudo make install
    rm -rf awesome
    ln -sf $DOT_DIR/linux/awesome ~/.config/awesome
    echo "exec awesome" > ~/.xinitrc
fi

# Install xfce4 power manager
if [[ ! -f /usr/local/bin/xfce4-power-manager ]]; then
    sudo apt-get build-dep xfce4-power-manager -y
    git clone https://gitlab.xfce.org/xfce/xfce4-power-manager.git && cd xfce4-power-manager
    ./autogen.sh
    make
    sudo make install
    rm -rf xfce4-power-manager
    ln -sf $DOT_DIR/linux/xfce4-power-manager.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
fi

# Setup neovim
$DOT_DIR/bin/setup_nvim.sh

# Link binaries 
ln -sf $(which fdfind) ~/.local/bin/fd

# Link configs
ln -sf $DOT_DIR/linux/.zshrc $HOME/.zshrc
mkdir -p $HOME/.config/rofi
ln -sf $DOT_DIR/linux/config.rasi $HOME/.config/rofi/config.rasi
sudo ln -sf $DOT_DIR/linux/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf
