yum install nfs-utils -y
systemctl restart nfs-server
mkdir /data
mount -t nfs  master:/data /data
