#!/bin/bash
#Alan's Default Ubuntu Box Setup
#Version 0.0.1
#Date 3/30/2021
#wget $url https://raw.githubusercontent.com/01000001-01001110/server_scripts/main/theone.sh -O - | sh
menu_option_one() {
  echo "Welcome, we are going to start configuring the system."
    echo "                          "
    echo "                          "
    echo "Getting Update List"
    sudo apt-get update
    echo "                          "
    echo "                          "
    echo "Get some applications."
    echo "                          "
    echo "                          "
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        perl \
        net-tools \
        mlocate \
        gnupg-agent \
        fail2ban \
        software-properties-common \
        nano \
    ​    lsb-release
    echo "                          "
    echo "                          "
    echo "Upgrade & Update"
    echo "                          "
    echo "                          "
    #Upgrade & Update 
    sudo apt update && sudo apt upgrade -y
    echo "                          "
    echo "Remove packages that are no longer needed"
    echo "                          "
    #remove packages that are no longer needed
    sudo apt autoremove
}

menu_option_two() {
    #Install Docker Time
    #--------WOOOHOOOOO!!--------
    echo "                          "
    echo "First we need to install Docker Compose"
    echo "                          "
    #Install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    echo "                          "
    echo "Apply executable permissions to the binary"
    echo "                          "
    #Apply executable permissions to the binary:
    sudo chmod +x /usr/local/bin/docker-compose
    echo "                          "
    echo "This is where we would test with command, sudo docker-compose --version"
    echo "                          "
    #Test the installation.
    #docker-compose --version
    echo "                          "
    echo "Next we add the official Docker GPG repository key"
    echo "                          "
    #Add the official Docker GPG repository key.
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    echo "                          "
    echo "Let us not forget to add the Docker upstream repository"
    echo "                          "
    #Add the Docker upstream repository.
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    echo "                          "
    echo "Now to update the apt package cache."
    echo "                          "
    #Update the `apt` package cache.
    sudo apt-get update
    echo "                          "
    echo "Finally, we get to install Docker!"
    echo "                          "
    #Install the required Docker packages.
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    echo "                          "
    echo "Start and enable Docker Daemon."
    echo "                          "
    #Start and enable the `docker` daemon.
    sudo systemctl enable --now docker
    echo "                          "
    echo "                          "
    echo "                          "
    #Confirm  docker
    echo "The following command should return without errors and show zero running containers."
    sudo docker ps
}

menu_option_three() {
  echo "Installing and configuring portainer"
  echo "Running following command to create a docker volume:"
  echo -e "docker volume create portainer_data"
  docker volume create portainer_data
  echo "Inintializing Portainer Container"
  sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
}

menu_option_four() {
    echo "                          "
    echo " User Creation "
    # Am i Root user?
        if [ $(id -u) -eq 0 ]; then
            read -p "Enter username : " username
            read -s -p "Enter password : " password
            egrep "^$username" /etc/passwd >/dev/null
            if [ $? -eq 0 ]; then
                echo "$username exists!"
                exit 1
            else
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                useradd -m -p "$pass" "$username"
                [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
            fi
        else
            echo "Only root may add a user to the system."
            exit 2
        fi
    echo "                          "
    echo "  Add $username to sudoer  "
    usermod -aG sudo $username
}

menu_option_five() {
    echo "                          "
    echo "Some security work, first we disable root SSH access."
    echo "                          "
    sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
    echo "                          "
    echo "Restart the SSH service to load the new configuration."
    echo "                          "
    sudo systemctl restart sshd
}

press_enter() {
  echo ""
  echo -n "	Press Enter to continue "
  read
  clear
}

incorrect_selection() {
  echo "Incorrect selection! Try again."
}

until [ "$selection" = "0" ]; do
  clear
  echo ""
  echo "    	1  -  Update, Upgrade, Install Tools"
  echo "    	2  -  Install Docker and Docker Compose"
  echo "    	3  -  Install Portainer"
  echo "    	4  -  Create new sudoer account"
  echo "    	5  -  Disable root SSH access"
  echo "    	0  -  Exit"
  echo ""
  echo -n "  Enter selection: "
  read selection
  echo ""
  case $selection in
    1 ) clear ; menu_option_one ; press_enter ;;
    2 ) clear ; menu_option_two ; press_enter ;;
    3 ) clear ; menu_option_three ; press_enter ;;
    4 ) clear ; menu_option_four ; press_enter ;;
    5 ) clear ; menu_option_five ; press_enter ;;
    0 ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done
