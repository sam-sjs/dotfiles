#!/bin/bash

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
ln -s $HOME/dotfiles/macos/powerlevel10k $HOME
ln -s $HOME/dotfiles/macos/.p10k.zsh $HOME
