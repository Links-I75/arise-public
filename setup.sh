#!/bin/bash
set -e

echo
echo === Aggiorno e installo pacchetti essenziali ===
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git nano vim


echo
echo
echo === Installazione Docker ===
# Docker is required on all machines for container management and login
# into github registry to pull the images.


# Import Docker's official GPG key to ensure the downloaded software is authentic
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# Add the official Docker repository to the APT repository list:
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine, which includes Docker CLI and containerd:
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io


# Ensure the Docker service is started and enabled for automatic startup at boot
sudo systemctl start docker
sudo systemctl enable docker

# Allow the current user to run Docker commands without needing sudo
sudo usermod -aG docker $USER


echo === Test Docker installation
sudo docker --version

echo === Run a test container after re-login ===
sudo docker run hello-world