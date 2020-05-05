#!/bin/sh
# This scripts puts all config in .dotfiles and create symlinks to this folder. Beware of the
# reset function, this may break stuff; make sure to backup your stuff first

DOTFILES_FOLDER="$HOME/.dotfiles"
HOME_CONFIG=".irssi
     .bashrc .bash_logout
     .profile
     .Xauthority .XCompose .xprofile .Xresources
     .zshrc .zshenv .zprofile
     .vimrc .viminfo
     .inputrc
     .newsboat
     "
DOT_CONF_CONFIG="conky
    i3
    polybar
    ranger
    radare2
    "

#DOT_CONF_CONFIG="Test"
#HOME_CONFIG="testfile"

function create {
    [ ! -d $DOTFILES_FOLDER ] && mkdir $DOTFILES_FOLDER

    for i in $HOME_CONFIG; do
        dest=$DOTFILES_FOLDER/$i
        src=$HOME/$i

        if [ -h $src ]; then
            echo "Skipping $src (already a symbolic link)"
            continue
        fi
        if [ ! -f $src ] && [ ! -d $src ]; then
            echo "Warning: $src is not present"
            continue
        fi
        if [ ! -d $DOTFILES_FOLDER ]; then
            echo "Error: $DOTFILES_FOLDER is not present"
            exit 1
        fi
        cp -r $src $dest && rm -r $src && ln -s $dest $src 2>/dev/null
    done

    for i in $DOT_CONF_CONFIG; do
        dest=$DOTFILES_FOLDER/$i
        src=$HOME/".config"/$i

        if [ -h $src ]; then
            echo "Skipping $src (already a symbolic link)"
            continue
        fi
        if [ ! -f $src ] && [ ! -d $src ]; then
            echo "Warning: $src is not present"
            continue
        fi
        if [ ! -d $DOTFILES_FOLDER ]; then
            echo "Error: $DOTFILES_FOLDER is not present"
            exit 1
        fi
        cp -r $src $dest && rm -r $src && ln -s $dest $src 2>/dev/null
    done
}

# This may be a bit sketchy, please backup first
function reset {
    for i in $HOME_CONFIG; do
        src=$DOTFILES_FOLDER/$i
        dest=$HOME/$i

        if [ ! -f $dest ] && [ ! -d $dest ]; then
            echo "Warning: $dest is not present"
            continue
        fi

        if [ ! -h $dest ]; then
            echo "$dest is not a symlink; Skipping ..."
            continue
        fi

        if [ ! -f $src ] && [ ! -d $src ]; then
            echo "Warning: $src is not present"
            continue
        fi
        if [ ! -d $DOTFILES_FOLDER ]; then
            echo "Error: $DOTFILES_FOLDER is not present"
            exit 1
        fi

        unlink $dest
        # copy then delete to make sure it doesnt fail
        cp -r $src $dest && rm -r $src
    done
    
    for i in $DOT_CONF_CONFIG; do
        src=$DOTFILES_FOLDER/$i
        dest=$HOME/".config"/$i

        if [ ! -f $dest ] && [ ! -d $dest ]; then
            echo "Warning: $dest is not present"
            continue
        fi

        if [ ! -h $dest ]; then
            echo "$dest is not a symlink; Skipping ..."
            continue
        fi

        if [ ! -f $src ] && [ ! -d $src ]; then
            echo "Warning: $src is not present"
            continue
        fi
        if [ ! -d $DOTFILES_FOLDER ]; then
            echo "Error: $DOTFILES_FOLDER is not present"
            exit 1
        fi

        unlink $dest
        # copy then delete to make sure it doesnt fail
        cp -r $src $dest && rm -r $src
    done
}
reset
