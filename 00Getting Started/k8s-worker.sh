#!/bin/bash

UBUNTU_VERSION=18.04
node_type=worker

echo "Ubuntu version: ${UBUNTU_VERSION}"
echo "K8s node type: ${node_type}"
echo
#Update all installed packages.
sudo apt-get update
sudo apt-get upgrade -y

#if you get an error similar to
#'[ERROR Swap]: running with swap on is not supported. Please disable swap', disable swap:
sudo swapoff -a

# install some utils
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y

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

#Install NFS client
sudo apt-get install -y nfs-common


#Update the apt source list
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] http://apt.kubernetes.io/ kubernetes-xenial main"

#Install K8s components
sudo apt-get update -y

sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni

sudo apt-mark hold kubelet kubeadm kubectl kubernetes-cni


echo "Done."

echo "Installation of Kubernetes Worker has completed"
echo "*************************************************"

echo "You are supposed to copy the join command from master and run on the worker nodes."