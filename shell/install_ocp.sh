
# IP information about master/node/etcd/lb/infra
export hosts=$(grep "example.com" /etc/ansible/hosts | awk -F "public_network_ip=" '{print $2}'|cut -d" " -f1|grep -v "^$" |awk '{print  $1 " "  }')

 
#ssh-copy-id to each hosts
echo -e "Type password : \c"
read password
echo "~/.ssh/id_rsa.pub file will be copyed to : "
echo " $hosts"
for host in $hosts; do
 	 sshpass -p $password ssh-copy-id -i  ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@$host



ansible-playbook  /usr/share/ansible/openshift-ansible/playbooks/byo/config.yml -vvvvv
