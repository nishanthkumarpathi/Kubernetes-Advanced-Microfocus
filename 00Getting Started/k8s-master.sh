#!/bin/bash

echo "Kubernetes Installation"
echo "Ensure before you continue, you are following lab guide"

sleep 10

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