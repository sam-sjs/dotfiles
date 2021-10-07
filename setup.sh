# Current issues - leaning scripts is fun!
# Need 'SF Mono' font installed
# Add qmk into .dotfiles
# Update 'kitty' (and other software) when running script

#!/bin/zsh

# Runtime flags
helpme=false
full_install=false
update=false

base_dir=$HOME/.dotfiles

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

link_nvim() {
    mkdir -p $HOME/.config/nvim
    ln -sf $base_dir/nvim/autoload/ $HOME/.config/nvim
    ln -sf $base_dir/nvim/colors/ $HOME/.config/nvim
    ln -sf $base_dir/nvim/ftplugin/ $HOME/.config/nvim
    ln -sf $base_dir/nvim/init.vim $HOME/.config/nvim
}

brew_setup() {
    if [[ "$full_install" = true ]]; then
        if [[ ! $(which brew) ]]; then
            echo "Installing homebrew..."
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi

        echo "Tapping kegs..."
        kegs=(homebrew/cask-fonts)
        brew tap ${kegs[@]}

        echo "Installing casks..."
        casks=(kitty hammerspoon font-iosevka)
        brew install --cask ${casks[@]}

        echo "Installing brew packages..."
        packages=(git nvim fzf python fd ripgrep)
        brew install ${packages[@]}

        # Setup fzf
        /usr/local/opt/fzf/install --all

        # Setup python3 for nvim
        python3 -m pip install --user pynvim
        
        # Setup nvim
        link_nvim
        vim +'PlugInstall --sync' +qa
    fi

    if [[ "$update" = true ]]; then
        brew update
        python3 -m pip install --user --uprade pynvim
    fi

    ln -sf $base_dir/.hammerspoon $HOME
    link_nvim
}

sdkman_setup() {
    if [[ "$full_install" = true ]]; then
        if ! command -v sdk &> /dev/null; then # This is the proper way but not working, see https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
            echo "Installing SDKMAN..."
            curl -s "https://get.sdkman.io" | bash
        fi
    fi

    if [[ "$update" = true ]]; then
        sdk selfupdate
    fi
}

omz_setup() {
    if [[ "$full_install" = true ]]; then
        if [ ! -f $HOME/.oh-my-zsh/oh-my-zsh.sh ]; then
            echo "Installing Oh My Zsh!..."
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
    
    if [[ "$update" = true ]]; then
        omz update
    fi
}

brew_setup
sdkman_setup
omz_setup

#Symlink configs
ln -sf $base_dir/.zshrc $HOME
ln -s $base_dir/kitty/ $HOME/.config # break up this directory to allow seperate terminal themes without having to be pushed up
