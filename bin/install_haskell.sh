#!/bin/bash

if  ! command -v make &> /dev/null; then
    echo "Install 'make' before running"
    exit 1
fi

export BOOTSTRAP_HASKELL_NONINTERACTIVE=1
export BOOTSTRAP_HASKELL_INSTALL_HLS=1
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
