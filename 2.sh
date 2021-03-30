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
