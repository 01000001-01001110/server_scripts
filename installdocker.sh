#!/bin/bash

# Download Docker Compose
echo "Download Docker Compose"
sudo curl -L 'https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)' -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Add Docker GPG key
echo "Add Docker GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "Completed adding the Docker GPG key"

# Add Docker repository
echo "Add Docker repository"
sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable'
echo "Completed adding the Docker repository"

# Update and upgrade packages
echo "Update and upgrade packages"
sudo apt-get update && sudo apt-get upgrade -y
echo "Completed Updates and upgrades of packages"
