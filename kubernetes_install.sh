#!/bin/bash
#Alan's Default Ubuntu Kubernetes Install
#Version 0.0.1
#Date 1/28/2022
#wget $url https://raw.githubusercontent.com/01000001-01001110/server_scripts/main/kubernetes_install.sh
#chmod +x kubernetes_install.sh
#./kubernetes_install.sh

menu_option_one() {
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
}

menu_option_two() {
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
}


press_enter() {
  echo ""
  echo -n "	Press Enter to continue "
  read
  clear
}

menu_leave() {
  echo ""
  echo -n "	Cleaning any configuration files that are left over from this install... "
  find . -name "kubernetes_install.sh" -exec rm -rf {} \;
  read
  clear
}

incorrect_selection() {
  echo "Incorrect selection! Try again."
}

until [ "$selection" = "0" ]; do
  clear
  echo ""
  echo "    	1  -  Setup and Install Rancher Master"
  echo "    	2  -  Setup and Install K3s Client"
  echo "    	0  -  Exit"
  echo ""
  echo -n "  Enter selection: "
  read selection
  echo ""
  case $selection in
    1 ) clear ; menu_option_one ; press_enter ;;
    2 ) clear ; menu_option_two ; press_enter ;;
    0 ) clear ; menu_leave ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done
