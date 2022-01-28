

#!/bin/bash

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Backtitle here"
TITLE="Title here"
MENU="Choose one of the following options:"

OPTIONS=(1 "Install Kubernetes Master"
         2 "Install Kubernetes Worker")

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
                        #Update
            sudo apt-get update

            #Install some applications to make life easier
            sudo apt-get install -y \
                curl \
                gnupg \
                perl \
                net-tools \
                fail2ban \
                software-properties-common \
                nano \
                lsb-release

            #Upgrade & Update 
            sudo apt update && sudo apt upgrade -y

            #remove packages that are no longer needed
            sudo apt autoremove

            #Install Docker Time
            #--------WOOOHOOOOO!!--------

            #Install Docker Compose
            sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

            #Apply executable permissions to the binary:
            sudo chmod +x /usr/local/bin/docker-compose

            #Add the official Docker GPG repository key.
            sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

            #Add the Docker upstream repository.
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

            #Update the `apt` package cache.
            sudo apt-get update

            #Install the required Docker packages.
            sudo apt-get install -y docker-ce docker-ce-cli containerd.io

            #Start and enable the `docker` daemon.
            sudo systemctl enable --now docker

            #Confirm  docker
            echo "The following command should return without errors and show zero running containers."
            sudo docker ps

            sudo docker run -d --restart=unless-stopped \
            -p 80:80 -p 443:443 \
            --privileged \
            rancher/rancher:latest
            echo " Installation Completed."
            ;;
        2)
            #Update
            sudo apt-get update

            #Install some applications to make life easier
            sudo apt-get install -y \
                curl \
                gnupg \
                perl \
                net-tools \
                fail2ban \
                software-properties-common \
                nano \
                lsb-release

            #Upgrade & Update 
            sudo apt update && sudo apt upgrade -y

            #remove packages that are no longer needed
            sudo apt autoremove

            #Install k3s 
            wget -O - https://get.k3s.io/ | bash
            echo " Installation Completed."
            ;;
esac
