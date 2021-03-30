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
wget $url https://raw.githubusercontent.com/01000001-01001110/server_scripts/main/sudoer.sh
chmod +x sudoer.sh
./sudoer.sh
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

menu_option_six() {
wget $url https://raw.githubusercontent.com/01000001-01001110/server_scripts/main/mcbdrk.sh
chmod +x mcbdrk.sh
./mcbdrk.sh
}

menu_option_seven() {
wget $url https://raw.githubusercontent.com/01000001-01001110/server_scripts/main/mcj.sh
chmod +x mcj.sh
./mcj.sh
}

menu_option_eight() {
wget $url https://raw.githubusercontent.com/01000001-01001110/server_scripts/main/prom.sh -O - | sh
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
  echo "    	6  -  Create Minecraft Bedrock Conainter"
  echo "    	7  -  Create Minecraft Java Conainter"
  echo "    	8  -  Configure Docker Prometheus"
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
    6 ) clear ; menu_option_six ; press_enter ;;
    7 ) clear ; menu_option_seven ; press_enter ;;
    8 ) clear ; menu_option_eight ; press_enter ;;
    0 ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done




docker run -d -it -e EULA=TRUE --name $contname -e SERVER_NAME="$servername" -e GAMEMODE=$gamemode -e ONLINE_MODE=$online -e level_seed=$seed -e difficulty=normal -e spawn-npcs=$npc -e spawn-monsters=$monster -e spawn-animals=$animal  -p 25565:$port itzg/minecraft-server --restart always
