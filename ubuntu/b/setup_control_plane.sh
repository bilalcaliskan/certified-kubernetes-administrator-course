#!/bin/bash

# LOADBALANCER_IP=192.168.5.30

# Run below command on the first master, rest of the commands will be output from below# command
# sudo kubeadm init --control-plane-endpoint ${LOADBALANCER_IP}:6443 --apiserver-advertise-address=192.168.5.11 --upload-certs --pod-network-cidr 10.244.0.0/16
sudo kubeadm init --apiserver-advertise-address=192.168.5.11 --upload-certs --pod-network-cidr 10.244.0.0/16

# Deploy pod network
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# Run below command on the second master
# sudo kubeadm join 192.168.5.30:6443 --token n9rcka.lzuw43vpixqcjpzh --discovery-token-ca-cert-hash sha256:7812075a5037c4cef90212b77cebd2dd56ff8b5e8db642f295c1828b5daaabec --control-plane --certificate-key 76e7212f4c8f278b6e6eaf7c29240237ba26f0c815d76b96598cb587c9f1a53e --apiserver-advertise-address 192.168.5.12

# Run below command on the third master
# sudo kubeadm join 192.168.5.30:6443 --token n9rcka.lzuw43vpixqcjpzh --discovery-token-ca-cert-hash sha256:7812075a5037c4cef90212b77cebd2dd56ff8b5e8db642f295c1828b5daaabec --control-plane --certificate-key 76e7212f4c8f278b6e6eaf7c29240237ba26f0c815d76b96598cb587c9f1a53e --apiserver-advertise-address 192.168.5.13

# Run below command on worker nodes
# sudo kubeadm join 192.168.5.30:6443 --token n9rcka.lzuw43vpixqcjpzh --discovery-token-ca-cert-hash sha256:7812075a5037c4cef90212b77cebd2dd56ff8b5e8db642f295c1828b5daaabec
