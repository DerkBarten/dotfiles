#!/bin/bash

VPN_FOLDER=/home/daniel/VPN/mullvad

USERNAME=$(head -n 1 "$VPN_FOLDER/mullvad_userpass.txt")
PASSWORD=$(tail -n 1 "$VPN_FOLDER/mullvad_userpass.txt")

FILES=$(ls $VPN_FOLDER | grep "mullvad.*\.conf")


function init() {
    echo $FILES
    for f in $FILES; do
        id=$(echo $f | sed 's/\.conf//g')
        nmcli connection import type openvpn file "$VPN_FOLDER/$f"
        nmcli connection modify $id vpn.secrets "password=$PASSWORD"
        nmcli connection modify $id vpn.user-name $USERNAME

        # Change the password flag and add the vpn secrets to the nmconnection files. This requires root priviledge
        nm_file="/etc/NetworkManager/system-connections/$id.nmconnection"
        echo -e "\n[vpn-secrets]\npassword=m" >> $nm_file
        sed -i "s/password-flags=1/password-flags=0/g" $nm_file
    done
    # NetworkManager needs to be restarted in order to re-read the nmconnection files. Havent found a different method yet.
    systemctl restart NetworkManager
}

function remove() {
    for f in $FILES; do
        id=$(echo $f | sed 's/\.conf//g')
        nmcli connection delete $id
    done
}


if [ "$1" = "init" ]; then
    if [ "$UID" != "0" ]; then
        echo "This script requires root priviledge (to edit NetworkManager files under /etc/NetworkManager)"
        exit 1
    fi
    init
    exit 0
fi

if [ "$1" = "remove" ]; then
    remove
    exit 0
fi

echo "./vpn_nmcli.sh [init|remove]"
