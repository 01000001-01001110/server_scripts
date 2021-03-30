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
    lsb-release
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
