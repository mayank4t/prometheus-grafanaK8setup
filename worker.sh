#!/bin/bash

#---------------------------------------------------------------------------------------------#
# This script is used for the configuration of worker node
# Script will install docker, kubeadm, kubecli for hostname as master 
# Versions kubeadm-1.18.5-0 kubelet-1.18.5-0 kubectl-1.18.5-0
#---------------------------------------------------------------------------------------------#

sudo -s
systemctl disable firewalld; 
systemctl stop firewalld
swapoff -a; sed -i '/swap/d' /etc/fstab
setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce-19.03.12 
systemctl enable --now docker
cat >>/etc/yum.repos.d/kubernetes.repo<<EOF
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubeadm-1.18.5-0 kubelet-1.18.5-0 kubectl-1.18.5-0
systemctl enable --now kubelet
echo "Script execution completed"
echo "------------Worker Node configured ------- "
