#!/bin/bash
sudo yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
yum update -y

yum install -y git jq yum-utils device-mapper-persistent-data lvm2 epel-release python-devel gcc

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce docker-ce-cli containerd.io python-pip

systemctl enable docker.service
systemctl start docker.service

yum upgrade -y python*

pip install --upgrade pip
pip install docker-compose --upgrade
chmod 666 /var/run/docker.sock
