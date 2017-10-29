# otif-ansible

#### This Ansible project is meant to ease InfoFsuion "headless" deployement on CentOS. 

WORKING on it ...


#### You can call a specific role from the devops playbook using a command like the following.

* This command will generate a hosts file according to the Ansible inventory
This Ansible role expects that IP addresses have been provided in the Ansible inventory file.
By default the /etc/hots file is nor replaced but a file /etc/ansible-hosts is created. 
```
$ ansible-playbook devops-tasks.yml -t "set-hosts-file" -K
```

* To create a hosts file with a custom domain
```
$ ansible-playbook devops-tasks.yml -t "set-hosts-file" -e "domain=magellan.net" -K
```

* To create a host file with a custom domain with provided network adaper. Overwrite /etc/host and restsrt network.
Use '$ ip ad' to know which network adapter is providing access you need. Default is "enp0s3"
```
$ ansible-playbook devops-tasks.yml -t "set-hosts-file" -e "domain=magellan.net adapter=enp0s3 overwrite=yes" -K -k
```

* This command will create a new user with default password (if not exists already) and will rotate public key on all nodes to provide passwordless ssh
```
$ ansible-playbook devops-tasks.yml -t "set-ssh-key" -e "username=otif-admin passwrd=magellan" -k
```

* Get information about processor, os and resources on all hosts
```
$ ansible-playbook devops-tasks.yml -t "get-host-info" -k
```

* Examples using ad-hoc commands

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
