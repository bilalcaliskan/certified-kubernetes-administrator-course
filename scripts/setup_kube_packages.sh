#!/bin/bash

K8S_VERSION=1.18.0-00

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet=${K8S_VERSION} kubeadm=${K8S_VERSION} kubectl=${K8S_VERSION}
sudo apt-mark hold kubelet kubeadm kubectl
