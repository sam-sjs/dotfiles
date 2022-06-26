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

        echo "Installing casks..."
        casks=(kitty hammerspoon)
        brew install --cask ${casks[@]}

        echo "Installing brew packages..."
        packages=(git nvim fzf python fd ripgrep maven awscli cabal-install jq fontconfig)
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

install_fonts() {
    fonts=$(fc-list)
    iosevka=$(echo "$fonts" | grep "Iosevka" | grep -v "Term")
    iosevka_term=$(echo "$fonts" | grep "Iosevka Term")
    nerd_symbols=$(echo "$fonts" | grep "Symbols Nerd")

    if [[ -z $iosevka ]]; then
        echo "Installing Iosevka Font..."
        curl -L https://github.com/be5invis/Iosevka/releases/download/v15.5.2/ttf-iosevka-15.5.2.zip > iosevka.zip
        unzip -q -d $HOME/Library/Fonts iosevka.zip
        rm -f iosevka.zip
    fi

    if [[ -z $iosevka_term ]]; then
        echo "Installing Iosevka Term Font..."
        curl -L https://github.com/be5invis/Iosevka/releases/download/v15.5.2/ttf-iosevka-term-15.5.2.zip > iosevka_term.zip
        unzip -q -d $HOME/Library/Fonts iosevka_term.zip
        rm -f iosevka_term.zip
    fi

    if [[ -z $nerd_symbols ]]; then
        echo "Installing Nerd Font Symbols..."
        curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/2.2.0-RC/NerdFontsSymbolsOnly.zip > nerd_symbols.zip
        unzip -q nerd_symbols.zip
        mv Symbols-2048-em\ Nerd\ Font\ Complete.ttf $HOME/Library/Fonts/Symbols-2048-em\ Nerd\ Font\ Complete.ttf
        rm -f nerd_symbols.zip Symbols* readme.md
    fi
}

sdk_setup() {
    if [[ "$full_install" = true ]]; then
        if ! command -v sdk &> /dev/null; then # This is the proper way but not working, see https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
            echo "Installing SDKMAN..."
            curl -s "https://get.sdkman.io" | bash
        fi
        sdk install java
    fi

    if [[ "$update" = true ]]; then
        sdk selfupdate
        sdk upgrade
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

p10k_setup() {
    if [[ "$full_install" = true ]]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
        echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
    fi
}

misc_setup() {
    if [[ "$full_install" = true ]]; then
        curl -sSL https://get.haskellstack.org/ | sh
        cabal update
        cabal install dhall-lsp-server
    fi

    if [[ "$update" = true ]]; then
        cabal update
        stack upgrade
    fi
}

brew_setup
install_fonts
sdk_setup
omz_setup
p10k_setup
misc_setup

#Symlink configs
ln -sf $base_dir/.zshrc $HOME
mkdir -p $HOME/.config/kitty/
ln -sf $base_dir/kitty/* $HOME/.config/kitty/ # break up this directory to allow seperate terminal themes without having to be pushed up
ln -sf $base_dir/.p10k.zsh $HOME

ln -sf $base_dir/webstorm /usr/local/bin
