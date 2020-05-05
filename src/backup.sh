#!/bin/bash
SSH_SERVER=plato
SSH_SERVER_EX=plato_ex


# Gather all important dotfiles in .dotifles
#$HOME/.scripts/dotfiles.sh -g

# TODO
# create list of installed packages
# backup crontab

function create_backup {

    BULK_FOLDERS="mus pix vid"
    FOLDERS=".config/gnucash .local/src .local/bin .local/backup/dotfiles .local/share/gnupg .local/share/gnucash .local/share/keyrings .ssh .config doc"
    BACKUP_FOLDER="$HOME/.local/backup"
    
    CORRECT_FOLDERS=""
    for FOLDER in $FOLDERS; do
        CORRECT_FOLDERS+="$HOME/$FOLDER "
    done
    
    CORRECT_BULK_FOLDERS=""
    for FOLDER in $BULK_FOLDERS; do
        CORRECT_BULK_FOLDERS+="$HOME/$FOLDER "
    done

    if [ "$2" == "bulk" ]; then
        CORRECT_FOLDERS=$CORRECT_BULK_FOLDERS
        ARCHIVE="$BACKUP_FOLDER/lpbk_blk_$(date +'%d-%m-%Y')".tar.gz
    else
        du -h -s --total $CORRECT_FOLDERS
        ARCHIVE="$BACKUP_FOLDER/lpbk_$(date +'%d-%m-%Y')".tar.gz
    fi

    
    if [ ! -f $ARCHIVE ] && [ ! -f $ARCHIVE.gpg ]; then
        echo "Creating archive $ARCHIVE"

        tar -czf $ARCHIVE $CORRECT_FOLDERS
        if [ "$?" -eq "0" ]; then
            echo "Success"
        else
            echo "Failed to creat archive"
            exit 1
        fi
    fi

    if [ ! -f $ARCHIVE.gpg ]; then
        #notify-send -t 10000 -u normal "Backup" "Please enter the archive password"
        echo "Encrypting backup with AES-256"
        gpg --symmetric --cipher-algo AES256 --compress-algo none --batch --passphrase-file "$HOME/.local/share/gnupg/lpbk_pass" $ARCHIVE && rm $ARCHIVE || exit 1
    fi

    if [ "$1" == "remote" ]; then
        # Test if we can create a connection with the local server, otherwise try remote
        ssh -o ConnectTimeout=5 $SSH_SERVER true 2>/dev/null
        if [ "$?" -eq "0" ]; then
            echo "Copying archive to server (local network)"
            rsync --stats --progress "$ARCHIVE.gpg" $SSH_SERVER:/hdd/backup/
        else
            echo "Copying archive to server (remote)"
            rsync --stats --progress "$ARCHIVE.gpg" $SSH_SERVER_EX:/hdd/backup/
        fi
    fi
    exit 0
}


function backup_notification {
    BACKUP_TYPE=$1
    DELAY=$2
    notify-send -t 10000 -u normal "Backup" "Starting $BACKUP_TYPE backup in $2 minutes"
}

function start_backup {
    BACKUP_TYPE=$1
    notify-send -t 10000 -u normal "Backup" "Starting $BACKUP_TYPE backup"


    # rsync uses ssh by default
    rsync -a --bwlimit=5000 --stats --delete --progress $CORRECT_FOLDERS $SSH_SERVER:~/backup/$BACKUP_TYPE

    if [ $? -eq 0 ]; then
        notify-send -t 10000 -u normal "Backup" "Backup $BACKUP_TYPE successful"
    else
        notify-send -t 10000 -u normal "Backup" "Encountered a error during $BACKUP_TYPE backup"
    fi
}


case $1 in
    "create") create_backup $2 $3;;
    "notify") backup_notification $2 $3;;
    "daily") start_backup daily;;
    "weekly") start_backup weekly;;
    "monthly") start_backup monthly;;
    *) exit 1;;
esac
