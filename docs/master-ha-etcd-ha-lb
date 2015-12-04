
### Master variables :

~~~
# Host group for master
# ansible_ssh_host : this is for initial connection of ansible playbook. ex) RHEV gives floating ip to VM automatically, it is the only ip that ansible can connect to execute playbook
# public_network_ip : if you want to fix public ip which can be reached from outside, you set this value. Then, it will change network script.
# mgmt_network_ip : if you want to fix mgmt ip for communication among systems(masters/nodes/etcds) , you set this value. Then, it will change network script.
#                   However, I don't recommand that you change mgmt ip because it is same as ansible_ssh_host, which means that it can be disconnected.
# is_node: master can be node as well so please set it to true in that case.
# openshift_hostname : for deployer pods to deploy other pods. These (containers) will contact the master via its name (openshift_hostname) - and this will _not_ be in their /etc/hosts file
# openshift_public_hostname : oc login or browser’s URL (normally, it is same as openshift_hostname)
# openshift_ip : internal ip (it is normally same as openshift_public_ip)
# openshift_public_ip : external ip
#
[masters]
master1.example.com ansible_ssh_host=172.20.20.161 mgmt_network_ip=172.20.20.161 public_network_ip=10.64.168.130 public_network_gw=10.64.168.254 is_node=false openshift_public_hostname=master1.example.com openshift_hostname=master1.example.com openshift_ip=10.64.168.130 openshift_public_ip=10.64.168.130
master2.example.com ansible_ssh_host=172.20.20.172 mgmt_network_ip=172.20.20.172 public_network_ip=10.64.168.131 public_network_gw=10.64.168.254 is_node=false openshift_public_hostname=master2.example.com openshift_hostname=master2.example.com openshift_ip=10.64.168.131 openshift_public_ip=10.64.168.131
master3.example.com ansible_ssh_host=172.20.20.163 mgmt_network_ip=172.20.20.163 public_network_ip=10.64.168.132 public_network_gw=10.64.168.254 is_node=false openshift_public_hostname=master3.example.com openshift_hostname=master3.example.com openshift_ip=10.64.168.132 openshift_public_ip=10.64.168.132

[masters:vars]
# It will help change hostname of each master system.
set_hostname=true

# It will help set up network configuration of each master system.
set_network=true
# Note!! It is important variable. If you misconfigure it, the master systems' network could be broken. Hence, please double-check the device is for master_mgmt_network
mgmt_network_dev_name=eth0
# Note!! It is important variable. If you misconfigure it, the master systems' network could be broken. Hence, please double-check the device is for master_public_network
public_network_dev_name=eth1
~~~

### Node variables :

~~~
[nodes]
node1.example.com ansible_ssh_host=172.20.20.152 mgmt_network_ip=172.20.20.152 public_network_ip=10.64.168.133 public_network_gw=10.64.168.254 openshift_node_labels="{'region': 'primary', 'zone': 'east'}" openshift_public_hostname=node1.example.com openshift_hostname=node1.example.com openshift_ip=10.64.168.133 openshift_public_ip=10.64.168.133
node2.example.com ansible_ssh_host=172.20.20.153 mgmt_network_ip=172.20.20.153 public_network_ip=10.64.168.134 public_network_gw=10.64.168.254 openshift_node_labels="{'region': 'primary', 'zone': 'west'}" openshift_public_hostname=node2.example.com openshift_hostname=node2.example.com openshift_ip=10.64.168.134 openshift_public_ip=10.64.168.134


[nodes:vars]
# It will help change hostname of each node system.
set_hostname=true

# It will help set up network configuration of each node system.
set_network=true
# Note!! It is important variable. If you misconfigure it, the node systems' network could be broken. Hence, please double-check the device is for node_mgmt_network
mgmt_network_dev_name=eth0
# Note!! It is important variable. If you misconfigure it, the node systems' network could be broken. Hence, please double-check the device is for node_public_network
public_network_dev_name=eth1

~~~



### ETCD variables :

~~~
[etcd]
etcd1.example.com ansible_ssh_host=172.20.20.175  mgmt_network_ip=172.20.20.175 public_network_ip=10.64.168.145 public_network_gw=10.64.168.254 openshift_public_hostname=etcd1.example.com openshift_hostname=etcd1.example.com openshift_ip=10.64.168.145 openshift_public_ip=10.64.168.145
etcd2.example.com ansible_ssh_host=172.20.20.165  mgmt_network_ip=172.20.20.165 public_network_ip=10.64.168.146 public_network_gw=10.64.168.254 openshift_public_hostname=etcd2.example.com openshift_hostname=etcd2.example.com openshift_ip=10.64.168.146 openshift_public_ip=10.64.168.146
etcd3.example.com ansible_ssh_host=172.20.20.174  mgmt_network_ip=172.20.20.174 public_network_ip=10.64.168.147 public_network_gw=10.64.168.254 openshift_public_hostname=etcd3.example.com openshift_hostname=etcd3.example.com openshift_ip=10.64.168.147 openshift_public_ip=10.64.168.147


[etcd:vars]
# It will help change hostname of each etcd system.
set_hostname=true

# It will help set up network configuration of each etcd system.
set_network=true
# Note!! It is important variable. If you misconfigure it, the etcd systems' network could be broken. Hence, please double-check the device is for etcd_mgmt_network
mgmt_network_dev_name=eth0
# Note!! It is important variable. If you misconfigure it, the node systems' network could be broken. Hence, please double-check the device is for etcd_public_network
public_network_dev_name=eth1
~~~


### LB variables :

~~~
# Specify load balancer host
[lb]
lb.example.com ansible_ssh_host=172.20.20.166  mgmt_network_ip=172.20.20.166 public_network_ip=10.64.168.135 public_network_gw=10.64.168.254 openshift_public_hostname=lb.example.com openshift_hostname=lb.example.com openshift_ip=10.64.168.135 openshift_public_ip=10.64.168.135

[lb:vars]
# It will help change hostname of each etcd system.
set_hostname=true

# It will help set up network configuration of each etcd system.
set_network=true
# Note!! It is important variable. If you misconfigure it, the etcd systems' network could be broken. Hence, please double-check the device is for etcd_mgmt_network
mgmt_network_dev_name=eth0
# Note!! It is important variable. If you misconfigure it, the node systems' network could be broken. Hence, please double-check the device is for node_public_network
public_network_dev_name=eth1
~~~

### Infra variables :
~~~
[infra]
infra.example.com ansible_ssh_host=172.20.20.173  mgmt_network_ip=172.20.20.173 public_network_ip=10.64.168.136 public_network_gw=10.64.168.254

[infra:vars]
# It will help change hostname of each infra system.
set_hostname=true

# It will help set up network configuration of each infra system.
set_network=true
# Note!! It is important variable. If you misconfigure it, the infra systems' network could be broken. Hence, please double-check the device is for infra_mgmt_network
mgmt_network_dev_name=eth0
# Note!! It is important variable. If you misconfigure it, the infra systems' network could be broken. Hence, please double-check the device is for infra_public_network
public_network_dev_name=eth1
~~~



