#!/bin/sh
DICTIONARY=$HOME/dotfiles/macos/dictionary/LocalDictionary
ln -sf $DICTIONARY $HOME/Library/Spelling/LocalDictionary
ln -sf $DICTIONARY $HOME/Library/Application\ Support/obsidian/Custom\ Dictionary.txt
