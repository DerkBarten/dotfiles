#!/bin/sh
# ~/.xprofile

# sourced at boot by xinit and display managers like lightdm

export XDG_CONFIG_HOME="$HOME/.config"

[ -d /sbin ] && PATH="$PATH:/sbin"
[ -d /usr/sbin ] && PATH="$PATH:/usr/sbin"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# restore the background
nitrogen --restore &

# keyring and polkit daemons
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
gnome-keyring-daemon --start --components=pkcs11 &

# pressing super alone simulates Alt-F1
#ksuperkey -e 'Super_L=Alt_L|F1' &
#ksuperkey -e 'Super_R=Alt_L|F1' &

# display timeout and sleep
#xset s 1200 1300
#xset dpms 1200 1300 1400

# keyboard repeat rate
#xset r rate 350 60

# set lockscreen
# light-locker &

# Start a vpn session in a random country
#nmcli connection up $(nmcli connection show | grep -Po "mullvad.*? " | shuf | head -n 1) &

#autocutsel &
#autocutsel -s PRIMARY &

#pulseaudio &
[ ! -s ~/.config/mpd/pid ] && mpd

xrdb -load $XDG_CONFIG_HOME/Xresources

#[[ -f $XDG_CONFIG_HOME/Xresources ]] && xrdb -merge -I$XDG_CONFIG_HOME/Xresources

exec /usr/bin/i3
