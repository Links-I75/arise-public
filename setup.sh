#!/bin/bash
set -e

echo
echo === Aggiorno e installo pacchetti essenziali ===
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git nano vim


echo
echo
echo === Installazione Docker ===

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $USER


echo === Test Docker installation
sudo docker --version

echo === Run a test container (after re-login) ===
sudo docker run hello-world