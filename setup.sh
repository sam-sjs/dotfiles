# Current issues - leaning scripts is fun!
# Need 'SF Mono' font installed
# Add qmk into .dotfiles

#!/bin/zsh

# Runtime flags
HELP=false
FULL_INSTALL=false

# Set runtime options
for arg in "$@"
do
    case "$arg" in
        "--help" | "-h")
            HELP=true
            ;;
        "--full" | "-f")
            FULL_INSTALL=true
            ;;
    esac
done

if [ "$HELP" == true ]; then
    echo "  --help [-h] Display this help message (congrats on making it this far!)"
    echo "  --full [-f] Perform full install"
    exit 0
fi

BASEDIR=$HOME/.dotfiles

if [ "$FULL_INSTALL" == true ]; then
    # Install Homebrew
    if [ ! $(which brew) ]; then
        echo "Installing homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # Update homebrew recipes
    brew update

    # Install brew packages
    PACKAGES=(git nvim fzf)
    echo "Installing packages..."
    brew install ${PACKAGES[@]}

    # Install brew casks
    CASKS=(kitty hammerspoon)
    echo "Installing casks..."
    brew install --cask ${CASKS[@]}

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

# Setup nvim config
mkdir -p $HOME/.config/nvim
ln -s $BASEDIR/init.vim $HOME/.config/nvim

#Symlink configs
ln -s $BASEDIR/.zshrc $HOME

# Link kitty terminal config
mkdir -p $HOME/.config/kitty
mkdir -p $HOME/.config/nvim/ftplugin
ln -s $BASEDIR/kitty.conf $HOME/.config/kitty
ln -s $BASEDIR/one-dark.conf $HOME/.config/kitty
ln -s $BASEDIR/pass_keys.py $HOME/.config/kitty
ln -s $BASEDIR/neighboring_window.py $HOME/.config/kitty
ln -s $BASEDIR/personal-kitty.conf $HOME/.config/kitty
ln -s $BASEDIR/javascript.vim $HOME/.config/nvim/ftplugin
ln -s $BASEDIR/typescript.vim $HOME/.config/nvim/ftplugin
ln -s $BASEDIR/typescriptreact.vim $HOME/.config/nvim/ftplugin
ln -s $BASEDIR/.hammerspoon $HOME
