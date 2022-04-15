FILE=/tmp/password
if [ ! -f "$FILE" ]; then
    read -r -p "please provide grafana admin user password :- " password
else 
  password=$(cat /tmp/password) ;
fi
yum install openssl nfs-utils wget -y
mkdir /data
chmod -R 755 /data
chown nfsnobody:nfsnobody /data
systemctl enable nfs-server
systemctl start nfs-server
echo "/data *(rw,sync,no_subtree_check,no_root_squash,insecure)" >> /etc/exports
systemctl restart nfs-server
exportfs -arv
export PATH=$PATH:/usr/local/bin
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
export KUBECONFIG=/etc/kubernetes/admin.conf
helm repo add stable https://charts.helm.sh/stable
wget https://raw.githubusercontent.com/mayank4t/prometheus-grafanaK8setup/main/prometheus.values
kubectl create ns prometheus
wget https://raw.githubusercontent.com/mayank4t/prometheus-grafanaK8setup/main/prometheuspv.yaml
kubectl create -f prometheuspv.yaml --namespace prometheus
wget https://raw.githubusercontent.com/mayank4t/prometheus-grafanaK8setup/main/prometheus-alertmanager.yaml
kubectl create -f prometheus-alertmanager.yaml --namespace prometheus
helm install prometheus stable/prometheus --values prometheus.values --namespace prometheus
kubectl create ns grafana
wget https://raw.githubusercontent.com/mayank4t/prometheus-grafanaK8setup/main/grafana.values
sed -i "s/strongpassword/$password/gi" grafana.values
helm install grafana stable/grafana --values grafana.values --namespace grafana
wget https://raw.githubusercontent.com/mayank4t/prometheus-grafanaK8setup/main/grafanapv.yaml
kubectl create -f grafanapv.yaml --namespace grafana
