#!/bin/bash

HEIGHT=30
WIDTH=60
CHOICE_HEIGHT=4
BACKTITLE="Written by: Alan Newingham"
TITLE="Ubuntu Server Setup Script"
MENU="Choose one of the following options:"

OPTIONS=(1 "Install Updates"
         2 "Install Docker"
         3 "Install Portainer")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "Setting Up Server"
            wget $url https://raw.githubusercontent.com/01000001-01001110/server_scripts/main/1.sh -O - | sh
            
            ;;
        2)
            echo "Installing Docker"
            wget $url https://raw.githubusercontent.com/01000001-01001110/server_scripts/main/2.sh -O - | sh
            
            ;;
        3)
            echo "Installing Portainer"
            wget $url https://raw.githubusercontent.com/01000001-01001110/server_scripts/main/3.sh -O - | sh
            
            ;;
esac
