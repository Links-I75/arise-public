#!/bin/bash
set -e

sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y curl wget git nano vim