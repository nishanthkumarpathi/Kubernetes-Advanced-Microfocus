#!/bin/bash

#Update all installed packages.
sudo apt update -y

#if you get an error similar to
#'[ERROR Swap]: running with swap on is not supported. Please disable swap', disable swap:
sudo swapoff -a

# install some utils
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y

#Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg


echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

#Install NFS client
sudo apt-get install -y nfs-common

#Enable docker service
sudo systemctl start docker
sudo systemctl enable docker

sudo groupadd docker

sudo usermod -aG docker $USER

echo "Next Follow the Instructions as per the labguide or ask instructor"