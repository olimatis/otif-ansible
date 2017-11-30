# otif-ansible

#### This Ansible project is meant to ease OpenText InfoFusion "headless" deployement on CentOS. 

##### Warning: some roles are not implemented yet or incomplete: install_wsm_crawler, install_pipeline, Install_ecm_crawler,
##### install_conversion_service, install_search. All other roles are fully functional but could require minor adjustments
##### from one environment to another. In all cased, the inventry file needs to be updated for every deployement.

Note: Ansible module ```expect``` is current considered to be used to run installers in console mode wuth automated answers bropided by Ansible instead of the user.
http://docs.ansible.com/ansible/latest/expect_module.html


## Prerequisite: Ansible & Git

* Become root ...
```
$ su -
```

* See if EPEL repository is already available
```
$ yum repolist | grep epel
```

* If there is no results, then:
```
$ yum -y install epel-release
```

* Then install Ansible
```
$ yum -y install ansible
```

* Once Ansible is installed, make sure it’s working properly
```
$ ansible --version
ansible x.y.z
```

* Install git
```
$ yum -y install git-all
```

* Clone this Ansible project on the host used to orchestrate deployment
```
$ cd ~
$ git clone https://github.com/olimatis/otif-ansible
...
$ cd otif-ansible/otif-ansible
```

* Modify the inventory file according to your cluster
Host name (box1, ...) and ip most probably need to be updated.
```
$ nano inventory/hosts
```

* Modify the network adapter to use to get proper ip
Take not of the adapter to use using 'ip ad' command.
```
$ nano inventory/group_vars/all.yml
...

network_interface= ????
...
```

* Set up SSH
This command will enable create a user otif-admin on all node and rotate key for SSH access
```
$ sudo ./ansible-role all set_ssh 
```

* Set hosts file
This will add new entries to /etc/hosts file on each node.
Set 'overwrite' to false (default value) if you want to create a file /etc/ansible-hosts for validation before to overwrite the existing hosts file and restart network service.
```
sudo .ansible-role all set_hosts -e "overwrite=true"
```
## "Auto-pilot" mode

```
$ ansible-playbook deploy-otif.yml
```

## Assisted mode

1. Check that all system requirements are met
* Get information about processor, os and resources on all hosts
```
$ ansible-playbook init-nodes.yml -t "get-node-info"
```

2. Modify Linux PAM limits on all nodes
```
$ ansible-playbook init-nodes.yml -t "set-limits"
```

3. Create and 'otif-admin' user on all nodes and enable passwordless ssh with public key for this user
```
$ ansible-playbook init-nodes.yml -t "set-ssh"
```

4. Update the hosts file according to the Ansible invetory (inventory/hosts)
* To create a host file with a custom domain with provided network adaper. Overwrite /etc/host and restart network service
* Use '$ ip ad' to know which network adapter is providing access you need. Default is "enp0s3"
```
$ ansible-playbook init-nodes.yml -t "set-hosts-file" -e "domain=magellan.net network_interface=enp0s3 overwrite=true"
```

5. Install InfoFusion dependencies
* This playbook  (Oracle Java 8, PostgreSQL, MongoDB, Kafka) on nodes where with need according to our inventory.
```
$ ansible-playbook deploy-otif.yml -t "dependencies"
```

6. Install InfoFusion Text Mining
```
$ ansible-role all install_text_mining
```

7. Install InfoFusion Crawler for Web & Social Media (including PostgreSQL)
```
$ ansible-role all install_wsm_crawler
```

8. Install InfoFusion Ingestion Pipeline (including PostgreSQL)
```
$ TODO
```



#### You can call a specific role from the devops playbook using a command like the following.

## This command will generate a hosts file according to the Ansible inventory
This Ansible role expects that IP addresses have been provided in the Ansible inventory file.
By default the /etc/hots file is nor replaced but a file /etc/ansible-hosts is created. 
```
$ ansible-playbook devops-tasks.yml -t "set-hosts-file" -K
```

## To create a hosts file with a custom domain
```
$ ansible-playbook deploy-otif.yml -t "set-hosts-file" -e "domain=magellan.net" -K -k
```

## To create a host file with a custom domain with provided network adaper. Overwrite /etc/host and restsrt network.
Use '$ ip ad' to know which network adapter is providing access you need. Default is "enp0s3"
```
$ ansible-playbook deploy-otif.yml -t "set-hosts-file" -e "domain=magellan.net adapter=enp0s3 overwrite=yes" -K -k
```

## This command will create a new user with default password (if not exists already) and will rotate public key on all nodes to provide passwordless ssh
```
$ ansible-playbook deploy-otif.yml -t "set-ssh" -e "username=otif-admin passwrd=magellan" -k
```

## Get information about processor, os and resources on all hosts
```
$ ansible-playbook deploy-otif.yml -t "get-node-info" -k
```
or more directly:
```
$ ansible-playbook init-nodes.yml -t "get-node-info" -k
```

## Examples using ad-hoc commands

* Free momory on all hosts
```
$  ansible all -m setup -a "filter=ansible_memfree_mb"  -k
```
* Date & Time ...
```
$  ansible all -m setup -a "filter=ansible_date_time"  -k
```

* Linux distribution ... and processor.
```
$ otif-ansible]$ ansible all -m setup -a "filter=ansible_distribution"  -k
$ otif-ansible]$ ansible all -m setup -a "filter=ansible_processor" -k
```

* The following command provides all variable that can be read ...
```
$ ansible all -m setup -k
```

* The following command shows how you can send a shell command to all hosts
```
$ ansible all -a "df -h"
# or this one to extract only info for one specific drive
$ ansible all -a "df -h" | awk '/SUCCESS/,/centos-root/'
```

* Delete a user and home directorty on all nodes
```
$ sudo ansible all -a "userdel -r otif-admin" -k
```
