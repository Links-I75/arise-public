#!/bin/bash
set -e

sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y curl wget git nano vim


echo
echo Installazione Docker

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $USER
