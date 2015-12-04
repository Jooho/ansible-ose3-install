
function mount_temp_repository(){
     mkdir -p /var/iso_images/rhel
     mkdir -p /var/iso_images/ose
     mount -o loop,ro ./$rhel_iso_file /var/iso_images/rhel
     mount -o loop,ro ./$ose_iso_file /var/iso_images/ose

if [ -f /etc/yum.repos.d/ose.repo ]
then
  rm -rf /etc/yum.repos.d/ose.repo
fi

     cat <<'EOF' >> /etc/yum.repos.d/ose.repo
[ose]
name=Openshift v3
baseurl=file:///var/iso_images/ose/rhel-7-server-ose-3.1-rpms
enabled=1
gpgcheck=0
[rhel]
name=RHEL 7.1
baseurl=file:///var/iso_images/rhel
enabled=1
gpgcheck=0
EOF

}


function umount_temp_repository(){
     umount /var/iso_images/rhel
     umount /var/iso_images/ose
     rm -rf /var/iso_images
}

function usage(){
# Usage : 
# Condition: internet_connected=true and rhel-7-ose-3.1 repository must be registered and subscription-manager as  well.
#export ose_repo=$(yum repolist |grep ose)
#echo ose_repo=""
#internet = true  => subscription 등록이 되어 있어야한다.
#internet = false => temp repository
test
}
if [[ $1 == "" ]]
then 
  echo "please specify inventory file"
  exit 1
else
  inventory_file=$1
fi

export inventory_file
export internet_connected=$(grep  "internet_connected=" $1 |grep -v ^# |cut -d"=" -f2)
echo $internet_connected
export rhel_iso_file=$(grep -i rhel_iso_long ./$inventory_file  |cut -d"=" -f2|awk '{gsub( "\"","" ); print}')
export ose_iso_file=$(grep -i ose_iso_long ./$inventory_file  |cut -d"=" -f2|awk '{gsub( "\"","" ); print}')
export mount_temp_repo_statue="unmounted"


if [ $internet_connected == false ]; 
then 
  mount_temp_repository
  mount_temp_repo_statue=mounted
  echo $mount_temp_repo_statue
fi

yum install -y atomic-openshift-utils sshpass git

if [ $mount_temp_repo_statue == mounted ]; 
then
  umount_temp_repository
  mount_temp_repo_statue=umounted
  echo $mount_temp_repo_statue
  rm /etc/yum.repos.d/ose.repo
fi

export domain=$(grep ^master ./$inventory_file |sed -n '2p' |cut -d" " -f1 |awk -F . {'print $2 "." $3'};)
export hosts=$(grep "example.com" ./$inventory_file | awk -F "ansible_ssh_host=" '{print $2}'|cut -d" " -f1|grep -v "^$" |awk '{print  $1 " \\"  }')

ssh-keygen
echo -e "Do you want to copy id_rsa.pub file to all machines with 1 password?(y/n) \c"
read copy_pub_file_with_one_password

if [ $copy_pub_file_with_one_password == "y" ]
then 
   echo -e "Type password : \c"
   read password
   echo "for host in $hosts ;do sshpass -p $password ssh-copy-id -i  ~/.ssh/id_rsa.pub  $host; \ done"
   echo `for host in $hosts ;do sshpass -p $password ssh-copy-id -i  ~/.ssh/id_rsa.pub  $host;  done`
else
   echo "for host in $hosts ;do ssh-copy-id -i ~/.ssh/id_rsa.pub $host;  done"
   echo `for host in $hosts ;do ssh-copy-id -i ~/.ssh/id_rsa.pub $host;  done`
fi


  
