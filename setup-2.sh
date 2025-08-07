#!/bin/bash
set -e

echo Install snapd
sudo apt install snapd -y

echo Install MicroK8s
sudo snap install microk8s --classic

echo Wait for MicroK8s to be ready
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

