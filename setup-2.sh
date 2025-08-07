#!/bin/bash
set -e

# 1. Install snapd
sudo apt install snapd -y

# 2. Install MicroK8s
sudo snap install microk8s --classic

# 3. Wait for MicroK8s to be ready
microk8s status --wait-ready


# Add current user to microk8s group
sudo usermod -a -G microk8s $USER

# Set correct permissions
sudo chown -f -R $USER ~/.kube



# Enable necessary add-ons
microk8s enable dashboard dns storage

# Optional: enable Prometheus for monitoring
microk8s enable prometheus

# Verify enabled add-ons
microk8s status

# Apply changes (requires new login)
newgrp microk8s