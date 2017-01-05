
# IP information about master/node/etcd/lb/infra
export hosts=$(grep "example.com" /etc/ansible/hosts |grep -v subdomain| awk '{print $1}'|sort|uniq)

 
#ssh-copy-id to each hosts
echo -e "Type password : \c"
read password
echo "~/.ssh/id_rsa.pub file will be copyed to : "
echo " $hosts"
for host in $hosts; do
            sshpass -p $passwordword ssh-copy-id -i  ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@$host
done


ansible-playbook  /usr/share/ansible/openshift-ansible/playbooks/byo/config.yml -vvvvv

