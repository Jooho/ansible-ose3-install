for host in $hosts ; do ssh $host;rm -rf /etc/yum.repos.d/r*.repo;exit ; done
