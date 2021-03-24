#!/bin/bash
#Docker and Docker Compose Install Script. 3/25/2021
#Alan Newingham

## Install Docker
    sudo apt-get remove docker docker-engine docker.io containerd runc
# Install Docker Compose
   sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# Apply executable permissions to the binary:
   sudo chmod +x /usr/local/bin/docker-compose
# Test the installation.
   docker-compose --version
# Add the official Docker GPG repository key.
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#Add the Docker upstream repository.
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# Update the `apt` package cache.
    sudo apt-get update
# Install the required Docker packages.
    sudo apt-get -y install docker-ce docker-ce-cli containerd.io
# Start and enable the `docker` daemon.
    sudo systemctl enable --now docker

