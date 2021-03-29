#Alan's Default Ubuntu Box Setup

echo "Welcome, we are going to start configuring the system."
echo "                          "
echo "                          "
echo "Getting Update List"
#Get Updates
sudo apt-get update
echo "                          "
echo "Get some applications."
echo "                          "
#Get Applications
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    perl \
    alacarte \
    gnupg-agent \
    software-properties-common \
    nano \
    lsb-release
echo "                          "
echo "                          "

chmod +x add-user-script.sh

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
echo "                          "
echo "Creating new... sudoer"
echo "                          "
#Test, am i Root user?
if [ $(id -u) -eq 0 ]; then
	read -p "Username : " username
	read -s -p "Password : " password
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username already taken!"
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
echo "                          "
echo "Add $username to sudo."
echo "                          "
sudo adduser $username sudo
echo "                          "
echo "                          "
echo "                          "
echo "Some security work, first we disable root login."
echo "                          "
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
echo "                          "
echo "Next we listen to only one protocol."
echo "                          "
sudo sed -i 's/#AddressFamily any/AddressFamily inet/' /etc/ssh/sshd_config
echo "                          "
echo -E "Verify changes have been successful with command: sudo nano /etc/ssh/sshd_config"
echo "                          "
echo "Restart the SSH service to load the new configuration."
echo "                          "
sudo systemctl restart sshd
echo "                          "
echo "Install Fail2ban. Fail2ban is a log-parsing application that monitors system logs for symptoms of an automated attack on your server."
echo "                          "
sudo apt-get install fail2ban
echo "                          "
echo "Install Email Support for fail2ban"
echo "                          "
apt-get install sendmail
echo "                          "
echo "Allow SSH access through UFW."
echo "                          "
ufw allow ssh
echo "                          "
echo "Enable Firewall"
echo "                          "
ufw enable
echo "                          "
echo "                          "
echo "Preparing To Install Docker"
echo "                          "
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
echo "                          "
echo "                          "
echo "                          "
