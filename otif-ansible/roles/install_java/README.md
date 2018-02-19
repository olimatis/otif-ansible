Role Name
=========

Role name in Ansible Galaxy: **[DovnarAlexander/oracle-java](https://galaxy.ansible.com/DovnarAlexander/oracle-java)**

You can use this role to install any version of JDK from Oracle Site + .
This role could be used on any distributive with YUM or APT package manager.

Role Variables
--------------
### Mandatory variables

```yaml
# If you need to install old version of JDK (less then 8u151), you need specify valid Oracle ID credentials.
oracle_id_username: user
oracle_id_password: password
```

### Optional variables

There are the following variables by default:

```yaml
# file: defaults/main.yml

# Java major version 7 or 8
java_major_version: 8
# Java minor version
java_minor_version: 162

# Parent path to install JDK
java_root_path: /opt/java

# Path to download archives with JDK
java_distr_path: /tmp
# True if you want to use oracle web site to download archive
# False if you have already had downloaded tar archive:
# Just put this file in folder under files folder
# Name should be in format jdk-<major_version>u<minor_version>-linux-x<64_or_86>.tar.gz
java_from_oracle: True

# True if you want to clear download files from java_distr_path folder
java_clear_after: False

# Do you want to set up JAVA_HOME global variable in Linux
java_set_home: True
```

Example Playbook
----------------

### Step 1: add role

Add role name `DovnarAlexander.oracle-java` to your playbook file.

### Step 2: add variables

Set vars in your playbook file.

Simple example:

```yaml
---
# file: simple-playbook.yml

- hosts: all

  roles:
    - DovnarAlexander.oracle-java

  vars:
    java_major_version: 9
    java_minor_version: 1
```

### Step 3: add java group in your inventory file

```ini
---
# file:inventory.ini

[java]
your_host

```