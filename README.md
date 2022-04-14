# prometheus-grafanaK8setup

This repo will help with the configuration of prometheus and grafana in the Kubernetes cluster, 

Prerequisite: -
Considering Cluster is already configured with masternode hostname as "master"
To configure check:- https://github.com/mayank4t/kubernetessetup

NFS mount :- /data

Download master.sh in cloudshell or on kubernetes master instance
from cloud shell:-

"gcloud compute ssh --zone $zone "$instance"  --project $project --command "sudo sh master.sh" 

from kubernetes master node:-
chmomd +x master.sh
./master.sh

Download worker.sh in cloudshell or on all expected workernodes
from Cloud shell :-

"gcloud compute ssh --zone $zone "$instance"  --project $project --command "sudo sh worker.sh" 

from Workernodes
chmomd +x worker.sh
./worker.sh

