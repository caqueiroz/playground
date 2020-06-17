# project1 puppet/puppet_apply challenge

The goal here is achieving puppet4 server being installed using puppet manifests.

module name: *my puppet*
dependencies:
  * apt
  * augeas
  * augeas_core
  * augeasproviders_core
  * firewalld
  * hiera
  * hieradata
  * inifile
  * manifests
  * modules
  * puppetbuild
  * puppetserver
  * puppetserver_gem
  * selinux
  * stdlib
  * translate
  * vcsrepo
module location: * modules/mypuppet *
Installing dependencies: > puppet module install \<module name\>
                        > copy from whenever it has been downloaded to the modules/ folder.


# Enhancements:
* NGINX or HAPROXY loadbalancer when the scenario is multi site.
  * Changing the headers to skip the ssl from the lb to puppetserver. the handshake will be taken up by the loadbalancer. *Edit* master.conf
    ```
    master: {
      allow-header-cert-info: false
    }
   ```




## Pre requirements

> *Vagrant: bootstrap-scripts/centos7_puppetserver.sh*
```#!/bin/bash
yum update -y
rpm -i https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-12.noarch.rpm
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum update -y
yum install -y puppet-agent
```
