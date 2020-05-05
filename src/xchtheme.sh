#!/usr/bin/zsh
TH_FOLDER="$XDG_CONFIG_HOME/Xresources-themes"
[ ! -d $TH_FOLDER ] && exit 1


#TH=$TH_FOLDER/$(ls $TH_FOLDER | grep .Xresources | dmenu -i -l 20)
TH=$TH_FOLDER/$(ls $TH_FOLDER | grep .Xresources | shuf | head -n 1)
echo "Changing theme to $TH"

xrdb -merge $TH

