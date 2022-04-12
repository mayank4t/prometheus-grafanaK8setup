sudo -s
yum install nfs-utils -y
mkdir /data
chmod -R 755 /data
chown nfsnobody:nfsnobody /data
systemctl enable nfs-server
systemctl start nfs-server
/data *(rw,sync,no_subtree_check,no_root_squash,insecure)
yum install openssl -y
export PATH=$PATH:/usr/local/bin
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
export KUBECONFIG=/etc/kubernetes/admin.conf
helm repo add stable https //charts.helm.sh/stable
yum install wget -y
wget https://raw.githubusercontent.com/mayank4t/prometheus-grafanaK8setup/main/prometheus.values
kubectl create ns prometheus
helm install prometheus stable/prometheus --values prometheus.values --namespace prometheus


