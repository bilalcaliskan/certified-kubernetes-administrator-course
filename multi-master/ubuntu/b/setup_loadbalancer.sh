#!/bin/bash

# Run the below commands on the loadbalancer node
sudo apt update && sudo apt full-upgrade -y && sudo apt install -y haproxy
cat <<EOF | sudo tee /etc/haproxy/haproxy.cfg
frontend kubernetes
    bind 192.168.5.30:6443
    option tcplog
    mode tcp
    default_backend kubernetes-master-nodes

frontend etcd
    bind 192.168.5.30:2379
    option tcplog
    mode tcp
    default_backend kubernetes-etcd

backend kubernetes-master-nodes
    mode tcp
    balance roundrobin
    option tcp-check
    server master-1 192.168.5.11:6443 check fall 3 rise 2
    server master-2 192.168.5.12:6443 check fall 3 rise 2
    server master-3 192.168.5.13:6443 check fall 3 rise 2

backend kubernetes-etcd
    mode tcp
    balance roundrobin
    option tcp-check
    server master-1 192.168.5.11:2379 check fall 3 rise 2
    server master-2 192.168.5.12:2379 check fall 3 rise 2
    server master-3 192.168.5.13:2379 check fall 3 rise 2
EOF
sudo systemctl restart haproxy
sudo systemctl enable --now haproxy
