# Current issues - leaning scripts is fun!
# Need 'SF Mono' font installed
# Add qmk into .dotfiles
# Update 'kitty' (and other software) when running script

#!/bin/zsh

# Runtime flags
helpme=false
full_install=false

base_dir=$HOME/.dotfiles

# Set runtime options
for arg in "$@"
do
    if [[ $arg = "--help" ]] || [[ $arg =~ ^-[^-]*h.*$ ]]; then helpme=true; fi
    if [[ $arg = "--full" ]] || [[ $arg =~ ^-[^-]*f.*$ ]]; then full_install=true; fi
done

if [ "$helpme" == true ]; then
    echo "  --help [-h] Display this help message (congrats on making it this far!)"
    echo "  --full [-f] Perform full install"
    exit 0
fi

if [ "$full_install" == true ]; then
    # Install Homebrew
    if [ ! $(which brew) ]; then
        echo "Installing homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # Update homebrew recipes
    brew update

    # Tap brew kegs
    kegs=(homebrew/cask-fonts)
    echo "Tapping kegs..."
    brew tap ${kegs[@]}

    # Install brew packages
    packages=(git nvim fzf python)
    echo "Installing packages..."
    brew install ${packages[@]}

    # Setup python3 for nvim
    python3 -m pip install --user --uprade pynvim

    # Setup fzf
    /usr/local/opt/fzf/install --all

    # Install brew casks
    casks=(kitty hammerspoon font-iosevka)
    echo "Installing casks..."
    brew install --cask ${casks[@]}

    # Install OMZ
    if [ ! -f $HOME/.oh-my-zsh/oh-my-zsh.sh ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        rm $HOME/.zshrc
    fi

    # Install OMZ plugins
    if [ ! -f $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    fi
    if [ ! -f $HOME/.oh-my-zsh/custom/themes/common.zsh-theme ]; then
        wget -O $HOME/.oh-my-zsh/custom/themes/common.zsh-theme https://raw.githubusercontent.com/jackharrisonsherlock/common/master/common.zsh-theme
    fi
fi

#Symlink configs
mkdir -p $HOME/.config/nvim
ln -s $base_dir/.zshrc $HOME
ln -s $base_dir/kitty/ $HOME/.config
ln -s $base_dir/nvim/autoload/ $HOME/.config/nvim # For the moment can't symlink entire nvim folder as plugins subfolder causes issues with submodules.
ln -s $base_dir/nvim/colors/ $HOME/.config/nvim
ln -s $base_dir/nvim/ftplugin/ $HOME/.config/nvim
ln -s $base_dir/nvim/init.vim $HOME/.config/nvim
ln -s $base_dir/.hammerspoon $HOME
