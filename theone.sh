#!/bin/bash
#Alan's Default Ubuntu Box Setup
#Version 0.0.1
#Date 3/30/2021
#wget $url https://raw.githubusercontent.com/01000001-01001110/server_scripts/main/theone.sh
#chmod +x theone.sh
#./theone.sh

menu_option_one() {
wget $url https://raw.githubusercontent.com/01000001-01001110/server_scripts/main/1.sh -O - | sh
}

menu_option_two() {
wget $url https://raw.githubusercontent.com/01000001-01001110/server_scripts/main/2.sh -O - | sh
}

menu_option_three() {
  wget $url https://raw.githubusercontent.com/01000001-01001110/server_scripts/main/3.sh -O - | sh
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
