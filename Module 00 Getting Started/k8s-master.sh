#!/bin/bash

UBUNTU_VERSION=18.04
node_type=master

echo "Ubuntu version: ${UBUNTU_VERSION}"
echo "K8s node type: ${node_type}"
echo
#Update all installed packages.
sudo apt-get update
sudo apt-get upgrade

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

#Update the apt source list
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] http://apt.kubernetes.io/ kubernetes-xenial main"

#Install K8s components
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni

sudo apt-mark hold kubelet kubeadm kubectl kubernetes-cni

#Initialize the k8s cluster
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

sleep 60

#Create .kube file if it does not exists
mkdir -p $HOME/.kube

#Move Kubernetes config file if it exists
if [ -f $HOME/.kube/config ]; then
    mv $HOME/.kube/config $HOME/.kube/config.back
fi

sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#if you are using a single node which acts as both a master and a worker
#untaint the node so that pods will get scheduled:
#kubectl taint nodes --all node-role.kubernetes.io/master-

#Install Flannel network
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml


echo "Done."

echo "Installation of Kubernetes Master has completed"
echo "*************************************************"
echo "Dont Close the Terminal, however observe the last few lines of output"

kubeadm config print join-defaults

echo "You are supposed to copy the join command and run on the worker nodes."