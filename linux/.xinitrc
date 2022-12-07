#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Set key repeat rate
xset r rate 200 25

# Touchpad settings
xinput set-prop "Synaptics TM3512-010" "libinput Tapping Enabled" 1
xinput set-prop "Synaptics TM3512-010" "libinput Natural Scrolling Enabled" 1

cbatticon -i standard &
kmonad ~/.config/kmonad/lenovo_x1.kbd &
exec awesome
