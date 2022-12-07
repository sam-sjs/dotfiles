#!/bin/bash

export DOT_DIR=$(pwd)

## OS Specific Setup
kernal=$(uname -s)
[[ $kernal == "Linux" ]] && ./bin/linux_setup.sh
[[ $kernal == "Darwin" ]] && ./bin/darwin_setup.sh
