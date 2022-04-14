yum install nfs-utils -y
mkdir /data
mount -t nfs  master:/data /data
