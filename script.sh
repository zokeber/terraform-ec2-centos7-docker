#!/bin/bash

sudo yum update -y
sudo yum upgrade -y
sudo yum remove docker docker-common docker-selinux docker-engine -y
sudo yum install vim epel-release yum-utils device-mapper-persistent-data lvm2 -y
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo -y
sudo yum install docker-ce -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo systemctl enable docker.service
sudo systemctl start docker.service
echo "alias docker='sudo docker'" >> ~/.bashrc
echo "alias docker-compose='sudo docker-compose'" >> ~/.bashrc
sudo hostnamectl set-hostname docker
