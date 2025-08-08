#!/bin/bash
set -xe


echo "===========  Installazione runner  ============"

# Istruzioni da GitHub nella creazione di runner
# Create a folder
mkdir actions-runner && cd actions-runner
# Copied! # Download the latest runner package
curl -o actions-runner-linux-x64-2.327.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.327.1/actions-runner-linux-x64-2.327.1.tar.gz
# Copied! # Optional: Validate the hash
echo "d68ac1f500b747d1271d9e52661c408d56cffd226974f68b7dc813e30b9e0575  actions-runner-linux-x64-2.327.1.tar.gz" | shasum -a 256 -c
# Copied! # Extract the installer
tar xzf ./actions-runner-linux-x64-2.327.1.tar.gz

# Qui configurare comando con token

sudo curl -L https://raw.githubusercontent.com/Links-I75/arise-public/main/start-actions-runner.sh -o /usr/local/bin/start-actions-runner.sh
sudo chmod +x /usr/local/bin/start-actions-runner.sh

sudo curl -L https://raw.githubusercontent.com/Links-I75/arise-public/main/actions-runner.service -o /etc/systemd/system/actions-runner.service

echo "===========Permessi senza sudo"

echo Add current user to microk8s group
sudo usermod -a -G microk8s $USER

# Set correct permissions
sudo chown -f -R $USER ~/.kube

