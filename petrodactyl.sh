#!/bin/bash
echo -e "Updating & Upgrading"
sleep 1
apt-get update
apt upgrade -y
sleep 1
echo "Initiating Pterodactyl Install Script"
bash <(curl -s https://pterodactyl-installer.se)
sleep 1
echo -1 "Pterodactyl Installed."
