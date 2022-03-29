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
    curl \
    perl \
    apt-transport-https \
    net-tools \
    fail2ban \
    sysstat \
    vnstat \
    iotop \
    iftop \
    bwm-ng \
    htop \
    munin \
    rkhunter \
    chkrootkit \
    nano \
    lsb-release \ 
    webmin
echo "                          "
echo "                          "
echo "Upgrade & Update"
echo "                          "
echo "                          "
#Upgrade & Update 
sudo apt update && sudo apt upgrade -y
echo "                          "
rkhunter --update
rkhunter --propupd
echo "Remove packages that are no longer needed"
echo "                          "
#remove packages that are no longer needed
sudo apt autoremove
echo "Checking for Rootkits"
rkhunter --check
