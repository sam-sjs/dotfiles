if [[ "$EUID" -ne 0 ]]; then
    echo "Must run as sudo"
    exit
fi

if ! command -v git &> /dev/null; then
    echo "'git' could not be found"
    exit
fi

if ! command -v stack &> /dev/null; then
    echo "'stack' could not be found"
    exit
fi

if ! command -v kmonad &> /dev/null; then
    git clone git@github.com:kmonad/kmonad.git && cd kmonad
    stack install
    cd ..
    rm -rf kmonad
fi

uinputconf=/etc/modules-load.d/uinput.conf
if [[ ! -f $uinputconf ]]; then
    echo "# Load uinput at boot" > $uinputconf
    echo "uinput" >> $uinputconf
fi

groupadd uinput &> /dev/null
usermod -aG input $SUDO_USER
usermod -aG uinput $SUDO_USER

uinputfile=/lib/udev/rules.d/75-uinput.rules
uinputrule='KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"'
if [[ ! -f $uinputfile ]]; then
    echo $uinputrule > $uinputfile
else
    if ! grep "$uinputrule" $uinputfile > /dev/null; then
        echo $uinputrule >> $uinputfile
    fi
fi

if [[ ! -e $HOME/.config/kmonad ]]; then
    ln -s /home/$SUDO_USER/dotfiles/linux/kmonad /home/$SUDO_USER/.config
fi
