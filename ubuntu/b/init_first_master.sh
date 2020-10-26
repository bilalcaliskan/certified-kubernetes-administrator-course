#!/bin/bash

LOADBALANCER_IP=192.168.5.30

# Run below command on the first master, rest of the commands will be output from below
# command
sudo kubeadm init --control-plane-endpoint ${LOADBALANCER_IP}:6443 --upload-certs
