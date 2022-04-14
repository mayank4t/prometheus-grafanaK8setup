yum install nfs-utils -y
mkdir /data
systemctl restart nfs-server
mount -t nfs  master:/data /data
systemctl restart nfs-server
