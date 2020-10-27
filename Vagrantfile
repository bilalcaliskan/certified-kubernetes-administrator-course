# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

# Define the number of master and worker nodes
# If this number is changed, remember to update setup-hosts.sh script with the new hosts IP details in /etc/hosts of each VM.
NUM_MASTER_NODE = 3
NUM_WORKER_NODE = 2

IP_NW = "192.168.5."
MASTER_IP_START = 10
NODE_IP_START = 20
LB_IP_START = 30

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.box_check_update = false

  # Provision Master Nodes
  (1..NUM_MASTER_NODE).each do |i|
      config.vm.define "master-#{i}" do |node|
        # Name shown in the GUI
        node.vm.provider "virtualbox" do |vb|
            vb.name = "master-#{i}"
            vb.memory = 2048
            vb.cpus = 2
        end
        node.vm.hostname = "master-#{i}"
        node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_START + i}"
        node.vm.network "forwarded_port", guest: 22, host: "#{2710 + i}"
        node.vm.provision "setup-hosts", :type => "shell", :path => "ubuntu/vagrant/setup-hosts.sh" do |s|
          s.args = ["enp0s8"]
        end
        node.vm.provision "setup-dns", type: "shell", :path => "ubuntu/update-dns.sh"
        node.vm.provision "file", source: "./ubuntu/cert_verify.sh", destination: "$HOME/"
      end
  end

  # Provision Load Balancer Node
  config.vm.define "loadbalancer" do |node|
    node.vm.provider "virtualbox" do |vb|
        vb.name = "loadbalancer"
        vb.memory = 512
        vb.cpus = 1
    end
    node.vm.hostname = "loadbalancer"
    node.vm.network :private_network, ip: IP_NW + "#{LB_IP_START}"
    node.vm.network "forwarded_port", guest: 22, host: 2730
    node.vm.provision "setup-hosts", :type => "shell", :path => "ubuntu/vagrant/setup-hosts.sh" do |s|
      s.args = ["enp0s8"]
    end
    node.vm.provision "setup-dns", type: "shell", :path => "ubuntu/update-dns.sh"
  end

  # Provision Worker Nodes
  (1..NUM_WORKER_NODE).each do |i|
    config.vm.define "worker-#{i}" do |node|
        node.vm.provider "virtualbox" do |vb|
            vb.name = "worker-#{i}"
            vb.memory = 512
            vb.cpus = 1
        end
        node.vm.hostname = "worker-#{i}"
        node.vm.network :private_network, ip: IP_NW + "#{NODE_IP_START + i}"
	node.vm.network "forwarded_port", guest: 22, host: "#{2720 + i}"
        node.vm.provision "setup-hosts", :type => "shell", :path => "ubuntu/vagrant/setup-hosts.sh" do |s|
          s.args = ["enp0s8"]
        end
        node.vm.provision "setup-dns", type: "shell", :path => "ubuntu/update-dns.sh"
        node.vm.provision "install-docker", type: "shell", :path => "ubuntu/install-docker-2.sh"
        node.vm.provision "allow-bridge-nf-traffic", :type => "shell", :path => "ubuntu/allow-bridge-nf-traffic.sh"
        node.vm.provision "file", source: "./ubuntu/cert_verify.sh", destination: "$HOME/"
    end
  end
end
