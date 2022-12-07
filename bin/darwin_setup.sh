# Current issues - leaning scripts is fun!
# Need 'SF Mono' font installed
# Add qmk into .dotfiles
# Update 'kitty' (and other software) when running script

#!/bin/zsh

# Runtime flags
helpme=false
full_install=false
update=false

base_dir=$HOME/dotfiles

# Set runtime options
for arg in "$@"
do
    if [[ $arg = "--help" ]] || [[ $arg =~ ^-[^-]*h.*$ ]]; then helpme=true; fi
    if [[ $arg = "--full" ]] || [[ $arg =~ ^-[^-]*f.*$ ]]; then full_install=true; fi
    if [[ $arg = "--update" ]] || [[ $arg =~ ^-[^-]*u.*$ ]]; then update=true; fi
done

if [[ "$helpme" = true ]]; then
    echo "  --help   [-h] Display this help message (congrats on making it this far!)"
    echo "  --full   [-f] Perform full install"
    echo "  --update [-u] Update all setup packages"
    exit 0
fi

nvim_setup() {
    $base_dir/bin/setup_nvim.sh
}

brew_setup() {
    if [[ "$full_install" = true ]]; then
        if [[ ! $(which brew) ]]; then
            echo "Installing homebrew..."
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi

        echo "Installing casks..."
        casks=(kitty hammerspoon emacs)
        brew install --cask ${casks[@]}

        echo "Installing brew packages..."
        packages=(git nvim fzf python fd ripgrep maven awscli jq fontconfig dhall-json lua-language-server)
        brew install ${packages[@]}

        # Setup fzf
        /usr/local/opt/fzf/install --all

        # Setup python3 for nvim
        python3 -m pip install --user pynvim
        
        # Setup nvim
        link_nvim
        vim +'PlugInstall --sync' +qa # CHANGE THIS, NO LONGER USING PLUG
    fi

    if [[ "$update" = true ]]; then
        brew update
        python3 -m pip install --user --uprade pynvim
    fi

    ln -sf $base_dir/.hammerspoon $HOME
    nvim_setup
}

omz_setup() {
    if [[ "$full_install" = true ]]; then
        $base_dir/bin/install_omz.sh
    fi
    
    if [[ "$update" = true ]]; then
        omz update
    fi
}

p10k_setup() {
    if [[ "$full_install" = true ]]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
        echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
    fi
}

haskell_setup() {
[[ ! -f $HOME/.ghcup/env ]] && $DOT_DIR/bin/install_haskell.sh
[[ ! -e $HOME/.cabal/bin/dhall-lsp-server ]] && $DOT_DIR/bin/install_dhall.sh
}

node_setup() {
    if [[ ! $(which node) ]]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
        nvm install node
    fi
}

misc_setup() {
    npm i -g bash-language-server
}

brew_setup
$SETUPDIR/install_fonts.sh $HOME/Library/Fonts
node_setup
omz_setup
p10k_setup
haskell_setup
misc_setup

#Symlink configs
ln -sf $base_dir/.zshrc $HOME
mkdir -p $HOME/.config/kitty/
ln -sf $base_dir/kitty/* $HOME/.config/kitty/ # break up this directory to allow seperate terminal themes without having to be pushed up
ln -sf $base_dir/.p10k.zsh $HOME
ln -sf $base_dir/webstorm /usr/local/bin
ln -sf $base_dir/idea /usr/local/bin
ln -sf $base_dir/rider /usr/local/bin
ln -sf $base_dir/.emacs.d $HOME
