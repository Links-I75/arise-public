#!/bin/bash
set -ex

echo
echo === Aggiorno e installo pacchetti essenziali ===
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git nano vim snapd


echo
echo
echo === Installazione Docker ===
# Docker is required on all machines for container management and login
# into github registry to pull the images.


# Import Docker's official GPG key to ensure the downloaded software is authentic
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg --yes
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


echo Install MicroK8s
sudo snap install microk8s --classic

echo "Wait for MicroK8s to be ready"
sudo microk8s status --wait-ready

echo === Enable necessary add-ons ===
sudo microk8s enable dashboard dns storage

# Optional: enable Prometheus for monitoring
sudo microk8s enable prometheus

# Verify enabled add-ons
sudo microk8s status

echo Add current user to microk8s group
sudo usermod -a -G microk8s $USER

# Set correct permissions
sudo chown -f -R $USER ~/.kube

# Set timezone (example: Europe/Rome)
sudo timedatectl set-timezone Europe/Rome

# Configure hostname (replace peer-X with appropriate name)
sudo hostnamectl set-hostname peer-1

# Add hostname to hosts file
echo "127.0.0.1 $(hostname)" | sudo tee -a /etc/hosts


echo === Create alias for kubectl ===
echo "alias kubectl='microk8s kubectl'" >> ~/.bashrc
source ~/.bashrc

# Verify kubectl
# kubectl version # Todo: Fix this produce error