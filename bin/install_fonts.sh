#!/bin/bash

if [[ "$#" -ne 1 ]]; then
    echo "Must pass font install path as argument"
    exit 1
fi

if ! command -v fc-list &> /dev/null; then
    echo "Requires 'fontconfig'"
    exit 1
fi

install_path=${1%/}
mkdir -p $install_path

fonts=$(fc-list)
iosevka=$(echo "$fonts" | grep "Iosevka" | grep -v "Term")
iosevka_term=$(echo "$fonts" | grep "Iosevka Term")
nerd_symbols=$(echo "$fonts" | grep "Symbols Nerd")

if [[ -z $iosevka ]]; then
    mkdir -p $install_path/iosevka
    echo "Installing Iosevka Font..."
    curl -L https://github.com/be5invis/Iosevka/releases/download/v15.5.2/ttf-iosevka-15.5.2.zip > iosevka.zip
    unzip -q -d $install_path/iosevka iosevka.zip
    rm -f iosevka.zip
fi

if [[ -z $iosevka_term ]]; then
    mkdir -p $install_path/iosevka_term
    echo "Installing Iosevka Term Font..."
    curl -L https://github.com/be5invis/Iosevka/releases/download/v15.5.2/ttf-iosevka-term-15.5.2.zip > iosevka_term.zip
    unzip -q -d $install_path/iosevka_term iosevka_term.zip
    rm -f iosevka_term.zip
fi

if [[ -z $nerd_symbols ]]; then
    mkdir -p $install_path/nerd_font_symbols
    echo "Installing Nerd Font Symbols..."
    curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/2.2.0-RC/NerdFontsSymbolsOnly.zip > nerd_symbols.zip
    unzip -q nerd_symbols.zip
    mv Symbols-2048-em\ Nerd\ Font\ Complete.ttf $install_path/nerd_font_symbols/Symbols-2048-em\ Nerd\ Font\ Complete.ttf
    rm -f nerd_symbols.zip Symbols* readme.md
fi

fc-cache
