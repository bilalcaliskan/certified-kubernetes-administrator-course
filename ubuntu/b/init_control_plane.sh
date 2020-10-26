#!/bin/bash

LOADBALANCER_IP=192.168.5.30

# Run below command on the first master, rest of the commands will be output from below# command
sudo kubeadm init --control-plane-endpoint ${LOADBALANCER_IP}:6443 --apiserver-advertise-address=192.168.5.11 --upload-certs --pod-network-cidr 10.244.0.0/16

# Deploy pod network
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# Run below command on the second master
sudo kubeadm join 192.168.5.30:6443 --token ubbeta.fm6v9f7bkf34liyk     --discovery-token-ca-cert-hash sha256:ddadbdebca096b96f34332a0519aaee24941bffd7374f516d9298bae9160eb44     --control-plane --certificate-key 1b90dbf6dc4b547e99a15619c0d93cd84f568904ed87913a9db4502e7fba2b8c --apiserver-advertise-address 192.168.5.12

# Run below command on the third master
sudo kubeadm join 192.168.5.30:6443 --token ubbeta.fm6v9f7bkf34liyk     --discovery-token-ca-cert-hash sha256:ddadbdebca096b96f34332a0519aaee24941bffd7374f516d9298bae9160eb44     --control-plane --certificate-key 1b90dbf6dc4b547e99a15619c0d93cd84f568904ed87913a9db4502e7fba2b8c --apiserver-advertise-address 192.168.5.13
