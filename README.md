# Red Hat Openshift Installer

![Openshift icon](https://upload.wikimedia.org/wikipedia/en/3/3a/OpenShift-LogoType.svg)

### Overview

**Openshift v3 installer**, this is for Red Hat engineer or consultant.
Basically, Red Hat provide ansible script to install openshift v3 but it is not enough for who don't know well about platform. Sometimes, it needs DNS, NFS and so on for testing properly but it is not easy to install without knowledge of platform side.
Therefore, this ansible script will help you to install those nessecery packages and also openshift itself


## How to use this script?



### Prerequites


**1.Inventory file.**

* production-*.yaml 

**2.ISO files**

* rhel-server-7.1-x86_64.iso
* ose-3.1-x86_64.iso

If you want to set up Internal repository for openshift and rhel, those ISO files have to be prepared.
(You can use [this script](https://github.com/Jooho/rhep_tools/blob/master/backup_ose3_repos.sh) for backup specific version of *OSE* and *RHEL*.)


**3.Setup script**

* [setup.sh](https://github.com/Jooho/ansible-ose3-install/blob/master/shell/setup.sh)

**4.ansible-ose3-install github source**

* If internet is connected, this will be downloaded through executing setup.sh
* If internet is *NOT* connected, you should copy it to Master server.

**Options:**	

* Check docker storage device is attached to each node (master/node/etcd/lb) - Default==> using loop back device.
	
All files should be under **/root/ose**. As you see this output, you are ready to install ose 3 now. 

```
# ls -al /root/ose
total 4036880
drwxr-xr-x. 3 root root       4096 Dec  3 10:59 .
dr-xr-x---. 6 root root       4096 Dec  3 18:05 ..
drwxr-xr-x. 8 root root       4096 Dec  3 10:57 ansible-ose3-install
-rw-r--r--. 1 root root  227151872 Dec  3 10:28 ose-3.1-x86_64-151125.iso
-rw-r--r--. 1 root root       9854 Dec  3 10:58 production-master-ha-etcd-ha-lb-small.yaml
-rw-r--r--. 1 root root 3906584576 Dec  3 10:34 rhel-server-7.1-x86_64-151125.iso
-rwxr-xr-x. 1 root root       2784 Dec  3 10:59 setup.sh 

```



### Configure inventory file

#### Infra variable :
* Internet 

~~~
# Check if it is possible to reach to internet. If it is not, internal repository using apache will be installed by default but you can overwrite it with 'internal_repo_install'.
internet_connected=false 
..
~~~

* overwrite host file

~~~
# This variable allow you to overwrite hosts file forcely. Once hosts file is updated, it never try to update the file even though you execute this script again by default. 
overriwrite_hosts_file=true
..
~~~

* dns 

~~~
# This DNS server using bind will be installed and the wildcard card entry configuration will be applied.
dns_install=true
dns_wildcard_domain="cloudapps.example.com"
dns_routers_ip="10.64.168.133"
dns_host_ip="10.64.168.136"
external_dns_ip="10.64.255.25"
~~~

* internal repository

~~~
# This internal_repository using apache is useful if the site is not available to use internet. If 'internet_connected' set false, internal repository will be installed by default.
internal_repo_install=true
internal_repo_host_ip="10.64.168.168.136"
internal_repo_host_name="internal-repo.example.com"
internal_repo_iso_src_path=/root/ose
#internal_repo_iso_dest_path=/root/iso
internal_repo_rhel_iso_long="rhel-server-7.1-x86_64-151125.iso"
internal_repo_rhel_iso_short="rhel71"
internal_repo_ose_iso_long="ose-3.1-x86_64-151125.iso"
internal_repo_ose_iso_short="ose31"
internal_repo_apache_repo_path="/var/www/html/repo"
~~~

* nfs

~~~
# This NFS/iscsi server is for testing PV and docker-registory-storage hence I strongly disagee that you use it in Production. Only use it for Test environment.
nfs_iscsi_install=false
nfs_iscsi_host_ip="192.168.20.60"     #default:infra
~~~

* docker

~~~
# Docker setup 
#         docker_storage_block_dev_name - docker use loop back device but it does not recommend in production so this value will allow docker use block device.
#                                         Note) It needs you to attach block device to each node before executing this script.
#         docker_options - This is for docker option in /etc/sysconfig/docker file
docker_setup=true
docker_storage_block_dev_name="vdb"
docker_options="--insecure-registry 172.30.0.0/16"
~~~

* subscription

~~~
# If you would like to register your server to system, you should provide Red Hat id/password.
#      Condition(this must be set) -> internet_connected=true, internal_repo_install=false
subscription_register=false
subscription_register_name=test
subscription_register_password=test
subscription_register_pool_id=8a85f9813cf493fe013d028b6cf75b5a
~~~

* development

~~~

# If you use this script for testing environment, please set this true. Then you can set more infra environment using ansible.
# This varible will effect -> network
development=true
~~~

 - Production-master-ha-etcd-ha-lb.yaml

### Network Check

* eth0 - internal network
* eth1 - external network

```
[root@master1 /root/ose]# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 00:1a:4a:36:66:93 brd ff:ff:ff:ff:ff:ff
    inet 172.20.20.x/24 brd 172.20.20.255 scope global dynamic eth0
       valid_lft 490sec preferred_lft 490sec
    inet6 fe80::21a:4aff:fe36:6693/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 00:1a:4a:36:66:94 brd ff:ff:ff:ff:ff:ff
```


### Docker Storage Check

* vdb - This device will be used for docker storage.

```
[root@master1 /root/ose]# lsblk
NAME                         MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sr0                           11:0    1 1024M  0 rom
vda                          252:0    0   50G  0 disk
├─vda1                       252:1    0  500M  0 part /boot
└─vda2                       252:2    0 49.5G  0 part
  ├─rhel-swap                253:0    0    2G  0 lvm  [SWAP]
  └─rhel-root                253:1    0 47.5G  0 lvm  /
vdb                          252:16   0   20G  0 disk     <===== docker block device
....
```





### Initiate Setup.sh 
```
[root@master1 /root/ose]# ./setup.sh ./production-master-ha-etcd-ha-lb.yaml
```

### Execute ansible playbook
```
[root@master1 /root/ose]# cd ./ansible-ose3-install/playbook/rhel
[root@master1 /root/ose/ansible-ose3-install/playbook/rhel]# ansible-playbook -i ../production-master-ha-etcd-ha-lb.yaml config.yaml -vvvv
```

License
---
---
Licensed under the Apache License, Version 2.0

*Free Software*
