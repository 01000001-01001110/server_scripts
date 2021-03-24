#!/bin/bash
#Ubuntu Setup Script. Update, Update Updater, Upgrade, install new applications. 3/25/2021
#Alan Newingham

# System Setup Default Server Applications

#Update apt package index
apt-get update

#Install all the things
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    alacarte \
    gnupg-agent \
    software-properties-common \
    nano \
    lsb-release

#install updates
apt update && sudo apt upgrade -y

#remove packages that are no longer needed
apt autoremove
