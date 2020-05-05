HOME_FILES=".xinitrc .zshenv"
XDG_FOLDERS="cmus dunst i3 irssi mpd ncmpcpp newsboat picom polybar qutebrowser radare2 ranger vim zsh env Xresources Xresources-themes"

STORAGE_FOLDER="$HOME/.local/backup/dotfiles"

function gather(){
    echo "Gathering config files to $STORAGE_FOLDER"
    mkdir -p "$STORAGE_FOLDER/$CONFIG_FOLDER"

    for FILE in $HOME_FILES; do
        cp -r "$HOME/$FILE" $STORAGE_FOLDER
    done

    for FOLDER in $XDG_FOLDERS; do
        cp -r "$XDG_CONFIG_HOME/$FOLDER" "$STORAGE_FOLDER"
    done
    
    cp -r ~/.local/src "$STORAGE_FOLDER"
    cp -r ~/.local/bin "$STORAGE_FOLDER"
}

case $1 in
    "-g") gather;;
    *) exit 1;;
esac
