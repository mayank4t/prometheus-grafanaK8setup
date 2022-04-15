yum install nfs-utils -y
systemctl restart nfs-server
mount -t nfs  master:/data /data
