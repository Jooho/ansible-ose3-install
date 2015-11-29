export hosts=$(grep "example.com" ../inventories/production-master-ha-etcd-ha-lb.yaml | awk -F "mgmt_network_ip=" '{print $2}'|cut -d" " -f1|grep -v "^$" |awk '{print  $1 " \\"  }')
echo $hosts
for host in $hosts ; do ssh $host "rm -rf /etc/yum.repos.d/r*.repo" ; done
