#!/bin/bash

#Update all installed packages.
sudo apt update -y

#if you get an error similar to
#'[ERROR Swap]: running with swap on is not supported. Please disable swap', disable swap:
sudo swapoff -a

# install some utils
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

#Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

if [ $UBUNTU_VERSION == "16.04" ]; then
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
elif [ $UBUNTU_VERSION == "18.04" ]; then
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
else
    #default tested version
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
fi
sudo apt-get update
sudo apt-get install -y docker.io

#Install NFS client
sudo apt-get install -y nfs-common

#Enable docker service
sudo systemctl start docker
sudo systemctl enable docker

sudo groupadd docker

sudo usermod -aG docker $USER

echo "Next Follow the Instructions as per the labguide or ask instructor"