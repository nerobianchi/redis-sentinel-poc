# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

MASTER_NODE_COUNT=1
SLAVE_NODE_COUNT=2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # config.vm.box = "ubuntu/xenial64"
  (1..MASTER_NODE_COUNT).each do |i|
    config.vm.define "redis-master-#{i}" do |node|
        # node.ssh.username = 'root'
        # node.ssh.password = 'vagrant'
        # node.ssh.insert_key = 'true'
        
        node.vm.box = "ubuntu/xenial64"
        node.vm.hostname = "redis-node-#{i}"
        node.vm.network :private_network, ip: "10.0.0.#{ 10 + i }"
        node.vm.network "forwarded_port", guest:6379, host: "#{6378 + i}"
        node.vm.provision :shell, :path => "bootstrap.sh"
        node.vm.provision "shell", inline: "cp -u /vagrant/redis.conf /etc/redis/redis.conf", privileged: true
        node.vm.provision "shell", inline: "service redis-server restart", privileged: true
        node.vm.provider "virtualbox" do |vb|
            vb.memory = 2024
            vb.cpus = 1
        end
    end
  end

  (1..SLAVE_NODE_COUNT).each do |i|
    config.vm.define "redis-slave-#{i}" do |node|
        # node.ssh.username = 'root'
        # node.ssh.password = 'vagrant'
        # node.ssh.insert_key = 'true'
        
        node.vm.box = "ubuntu/xenial64"
        node.vm.hostname = "redis-node-#{i}"
        node.vm.network :private_network, ip: "10.0.0.#{10 + MASTER_NODE_COUNT + i }"
        node.vm.network "forwarded_port", guest:6379, host: "#{6378 + MASTER_NODE_COUNT + i }"
        node.vm.provision :shell, :path => "bootstrap.sh"
        node.vm.provision "shell", inline: "cp -u /vagrant/redis_slave.conf /etc/redis/redis.conf", privileged: true
        node.vm.provision "shell", inline: "service redis-server restart", privileged: true
        node.vm.provider "virtualbox" do |vb|
            vb.memory = 2024
            vb.cpus = 1
        end
    end
  end
end