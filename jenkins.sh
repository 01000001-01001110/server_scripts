# Jenkins Build Ubuntu 22.04

#Update Upgrade, and Install Applications

#Upgrade & Update 
sudo apt update && sudo apt upgrade -y
reboot

sudo apt-get install curl perl apt-transport-https net-tools default-jdk fail2ban sysstat vnstat docker.io iotop iftop bwm-ng htop munin rkhunter chkrootkit nano lsb-release -y

#Upgrade & Update 
sudo apt update && sudo apt upgrade -y

#Auto Remove Packages no longer needed
sudo apt autoremove

#-----========Jenkins========-----

#Add Jenkins GPG key
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
#Enable Jenkins repository on Bullseye
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
#Update
apt update
#Install Jenkins
apt install jenkins
#Check Services
systemctl status jenkins --no-pager -l
#If Services are not running: systemctl enable --now jenkins
#Find Jenkins Admininstrator
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "Password here ***********************************************"

#Modify Jenkins Default Web Port
sed -i 's/8080/80/g' /etc/default/jenkins
/etc/init.d/jenkins start
#Firewall
ufw allow 80

#-----========Git========-----

#Install Git
add-apt-repository ppa:git-core/ppa 
apt-get update && sudo apt-get -y install git 

#-----========Docker Compose========-----

#Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#Apply executable permissions to the binary:
sudo chmod +x /usr/local/bin/docker-compose
#Add the official Docker GPG repository key.
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#Add the Docker upstream repository.
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#Update the `apt` package cache.
#Upgrade & Update 
sudo apt update && sudo apt upgrade -y

#-----========Docker========-----

#Docker was installed in the initial program install at the top. 
#Enable daemon
systemctl enable --now docker


#Give group permissions to Jenkins can run Docker images
usermod -a -G docker jenkins



#Configure Git
#git config --global user.name "First Last" git config --global user.email "first.last@email.com" 
#Generate Git GPG Key
#gpg --generate-key 
#gpg --list-secret-keys --keyid-format=long 
#git config --global commit.gpgsign true git config --global gpg.program gpg git config --global user.signingkey ABCDEFG 
#Export Key to use in GitHub/DevOps/etc...
#gpg --armor --export ABCDEFG




