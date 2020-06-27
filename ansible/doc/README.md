# Ansible cookbook

## configurations

**1) disabling host key checking from ansible controller machine **

* Inventory:
> ansible_ssh_common_args='-o StrictHostKeyChecking=no'
* Hosts
> ansible_ssh_extra_args='-o StrictHostKeyChecking=no'
* ansible.cfg
> [defaults]
> host_key_checking = False
* export variable
> export ANSIBLE_HOST_KEY_CHECKING=False

 
