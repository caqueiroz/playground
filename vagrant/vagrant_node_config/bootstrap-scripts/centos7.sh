#!/bin/bash
yum install http://yum.puppetlabs.com/el/7/PC1/x86_64/puppetlabs-release-pc1-1.1.0-5.el7.noarch.rpm -y
yum install unzip git telnet nc puppet epel-release -y
yum update -y
yum install -y java-1.8.0-openjdk
