# otif-ansible

#### This Ansible project is meant to ease InfoFsuion "headless" deployement on CentOS. 

WORKING on it ...


#### You can call a specific role from the devops playbook using a command like the following.

* This command will generate a hosts file according to the Ansible inventory
```
$ ansible-playbook devops-tasks.yml -t "set-hosts-file" -k
```

* This command will create a new user with default password (if not exists already) and will rotate public key on all nodes to provide passwordless ssh
```
$ ansible-playbook devops-tasks.yml -t "set-ssh-key" -e "username=otif-admin passwrd=magellan" -k
```

* The following command we provide hard drive information for all nodes
```
$ ansible all -a "df -h"
# or this one to extract only info for one specific drive
$ ansible all -a "df -h" | awk '/SUCCESS/,/centos-root/'
```
* Delete a user and home directorty on all nodes
```
$ ansible all -a "userdel -r otif-admin" -k
```
