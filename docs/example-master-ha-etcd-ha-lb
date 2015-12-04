##Example 

###Environment :

```
* Master x 3 
	* master1.example.com
		* internal ip: 172.20.20.161
		* public ip: no configured (will set to 10.64.168.130 through ansible script)
		* hostname: master1.example.local
	* master2.example.com
		* internal ip: 172.20.20.172
		* public ip: no configured (will set to 10.64.168.131 through ansible script)
		* hostname: master2.example.local
	* master3.example.com
		* internal ip: 172.20.20.163
		* public ip: no configured (will set to 10.64.168.132 through ansible script)
		* hostname: master3.example.local
```
```
* Node x 2 
	* node1.example.com
		* internal ip: 172.20.20.152
		* public ip: no configured (will set to 10.64.168.133 through ansible script)
		* hostname: node1.example.local
	* node2.example.com
		* internal ip: 172.20.20.153
		* public ip: no configured (will set to 10.64.168.134 through ansible script)
		* hostname: node2.example.local
```
``` 
* ETCD x 3 
	* etcd1.example.com
		* internal ip: 172.20.20.175
		* public ip: no configured (will set to 10.64.168.145 through ansible script)
		* hostname: etcd1.example.local
	* etcd2.example.com
		* internal ip: 172.20.20.165
		* public ip: no configured (will set to 10.64.168.146 through ansible script)
		* hostname: etcd2.example.local
	* etcd3.example.com
		* internal ip: 172.20.20.174
		* public ip: no configured (will set to 10.64.168.147 through ansible script)
		* hostname: etcd3.example.local
```
``` 
* LB
	* lb.example.com
		* internal ip: 172.20.20.166
		* public ip: no configured (will set to 10.64.168.135 through ansible script)
		* hostname: lb.example.local
```
```		
* Infra
	* infra.example.com
		* internal ip: 172.20.20.173
		* public ip: no configured (will set to 10.64.168.136 through ansible script)
		* hostname: infra.example.local
```
```
* Common
	* docker storage block device name: vdb
	* docker optinos: "--insecure-registry 172.30.0.0/16 " (add)
    * mgmt_network_dev_name: eth0 (internal network)
    * public_network_dev_name: eth1		
```
```
* Condition
	* internet_connected=false
	* internal_repo_install=true
```


### Step 1
** Copy iso files & ansible-ose3-install folder & setup.sh to /root/ose folder on Master **

~~
# ls -al /root/ose
total 4036880
drwxr-xr-x. 3 root root       4096 Dec  3 10:59 .
dr-xr-x---. 6 root root       4096 Dec  3 18:05 ..
drwxr-xr-x. 8 root root       4096 Dec  3 10:57 ansible-ose3-install
-rw-r--r--. 1 root root  227151872 Dec  3 10:28 ose-3.1-x86_64-151125.iso
-rw-r--r--. 1 root root 3906584576 Dec  3 10:34 rhel-server-7.1-x86_64-151125.iso
-rwxr-xr-x. 1 root root       2784 Dec  3 10:59 setup.sh 
~~

### Step 2
** Modify inventory file :** 
~~
[root@master1 /root/ose]# vi ansible-ose3-install/inventories/production-master-ha-etcd-ha-lb.yaml
~~

[production-master-ha-etcd-ha-lb.yaml](https://github.com/Jooho/ansible-ose3-install/blob/master/inventories/production-master-ha-etcd-ha-lb.yaml)


### Step 3 
** Execute setup.sh **

~~
[root@master1 /root/ose]# ./setup.sh  ansible-ose3-installer/inventories/production-master-ha-etcd-ha-lb.yaml
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
/root/.ssh/id_rsa already exists.
Overwrite (y/n)?
[root@master1 ose]# rm /root/.ssh/id_rsaid_rsa.pub file to all machines with 1 password?(y/n) ^C[root@master1 ose]#
rm: remove regular file ‘/root/.ssh/id_rsa’? y
[root@master1 ose]# clear
[root@master1 ose]# ./setup.sh  ./production-master-ha-etcd-ha-lb-small.yaml
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
8c:99:7e:ad:b5:e6:5f:dd:3e:fb:b2:72:3b:a0:90:da root@master1.example.local
The key's randomart image is:
+--[ RSA 2048]----+
|                 |
|                 |
|                 |
|       =         |
|      + S.       |
|     .  o.  .  ..|
|      .o..o. .. o|
|      ..Eoo...+o |
|        .oo..oo**|
+-----------------+
Do you want to copy id_rsa.pub file to all machines with 1 password?(y/n) y
Type password : redhat
~/.ssh/id_rsa.pub file will be copyed to :
172.20.20.161
172.20.20.172
172.20.20.163
172.20.20.152
172.20.20.153
172.20.20.175
172.20.20.165
172.20.20.174
172.20.20.166
172.20.20.173
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
.....

Loaded plugins: product-id, subscription-manager
This system is not registered to Red Hat Subscription Management. You can use subscription-manager to register.
ose                                                                                                                                                                                                                                                    | 2.9 kB  00:00:00
rhel                                                                                                                                                                                                                                                   | 2.9 kB  00:00:00
Package atomic-openshift-utils-3.0.13-1.git.0.5e8c5c7.el7aos.noarch already installed and latest version
Package sshpass-1.05-5.el7aos.x86_64 already installed and latest version
Package git-1.8.3.1-5.el7.x86_64 already installed and latest version
Nothing to do
~~


###Step 4

**Execuate ansible playbook**

~~
[root@master1 /root/ose]# cd ./ansible-ose3-install/playbook/rhel
[root@master1 /root/ose/ansible-ose3-install/playbook/rhel]# ansible-playbook -i ../../inventories/production-master-ha-etcd-ha-lb.yaml config.yaml -vvvv
..
..

PLAY RECAP ********************************************************************
etcd1.example.com          : ok=147  changed=38   unreachable=0    failed=0
etcd2.example.com          : ok=57   changed=18   unreachable=0    failed=0
etcd3.example.com          : ok=57   changed=18   unreachable=0    failed=0
infra.example.com          : ok=31   changed=14   unreachable=0    failed=0
lb.example.com             : ok=38   changed=8    unreachable=0    failed=0
localhost                  : ok=32   changed=5    unreachable=0    failed=0
master1.example.com        : ok=180  changed=57   unreachable=0    failed=0
master2.example.com        : ok=94   changed=32   unreachable=0    failed=0
master3.example.com        : ok=94   changed=32   unreachable=0    failed=0
node1.example.com          : ok=71   changed=22   unreachable=0    failed=0
node2.example.com          : ok=71   changed=22   unreachable=0    failed=0
~~



