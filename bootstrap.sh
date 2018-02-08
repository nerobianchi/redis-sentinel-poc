#!/usr/bin/env bash

sudo apt-get update
# sudo apt-get install -y python-software-properties
# sudo add-apt-repository -y ppa:rwky/redis
sudo apt-get install -y redis-server


# cp -u /vagrant/redis.conf /etc/redis/redis.conf
# sudo service redis-server restart