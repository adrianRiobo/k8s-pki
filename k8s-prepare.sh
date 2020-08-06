#!/bin/bash

EXTERNAL_CA=pki-mock/ca.crt
CONF_FOLDER=target/kubernetes
PKI_FOLDER=target/kubernetes/pki

# $1 NODENAME
# $2 KUBE-APISERVER (DNS / IP):PORT Ex. 10.10.10.10:6443 or k8s.proj.domain:433
function create_kubelet_conf {
  CA_BASE64=$(cat $EXTERNAL_CA | base64 -w 0)
  sed "s/NODENAME/$1/g; s/KUBE-APISERVER/$2/g; s/CA_BASE64/$CA_BASE64/g" \
       templates/k8s/kubelet.conf.tpl > $CONF_FOLDER/kubelet-$1.conf
}

# $1 NODENAME
# $2 KUBE-APISERVER (DNS / IP):PORT Ex. 10.10.10.10:6443 or k8s.proj.domain:433
function create_admin_conf {
  CA_BASE64=$(cat $EXTERNAL_CA | base64 -w 0)
  ADMIN_CRT_BASE64=$(cat $PKI_FOLDER/admin.crt | base64 -w 0)
  ADMIN_KEY_BASE64=$(cat $PKI_FOLDER/admin.key | base64 -w 0)
  sed "s/KUBE-APISERVER/$2/g; s/CA_BASE64/$CA_BASE64/g; s/ADMIN_CRT_BASE64/$ADMIN_CRT_BASE64/g; s/ADMIN_KEY_BASE64/$ADMIN_KEY_BASE64/g" \
       templates/k8s/admin.conf.tpl > $CONF_FOLDER/admin-$1.conf
}

# $1 NODENAME
# $2 KUBE-APISERVER (DNS / IP):PORT Ex. 10.10.10.10:6443 or k8s.proj.domain:433
function create_controller-manager_conf {
  CA_BASE64=$(cat $EXTERNAL_CA | base64 -w 0)
  CONTROLLER_MANAGER_CRT_BASE64=$(cat $PKI_FOLDER/controller-manager.crt | base64 -w 0)
  CONTROLLER_MANAGER_KEY_BASE64=$(cat $PKI_FOLDER/controller-manager.key | base64 -w 0)
  sed "s/KUBE-APISERVER/$2/g; s/CA_BASE64/$CA_BASE64/g; s/CONTROLLER_MANAGER_CRT_BASE64/$CONTROLLER_MANAGER_CRT_BASE64/g; s/CONTROLLER_MANAGER_KEY_BASE64/$CONTROLLER_MANAGER_KEY_BASE64/g" \
       templates/k8s/controller-manager.conf.tpl > $CONF_FOLDER/controller-manager-$1.conf
}

# $1 NODENAME
# $2 KUBE-APISERVER (DNS / IP):PORT Ex. 10.10.10.10:6443 or k8s.proj.domain:433
function create_scheduler_conf {
  CA_BASE64=$(cat $EXTERNAL_CA | base64 -w 0)
  SCHEDULER_CRT_BASE64=$(cat $PKI_FOLDER/scheduler.crt | base64 -w 0)
  SCHEDULER_KEY_BASE64=$(cat $PKI_FOLDER/scheduler.key | base64 -w 0)
  sed "s/KUBE-APISERVER/$2/g; s/CA_BASE64/$CA_BASE64/g; s/SCHEDULER_CRT_BASE64/$SCHEDULER_CRT_BASE64/g; s/SCHEDULER_KEY_BASE64/$SCHEDULER_KEY_BASE64/g" \
       templates/k8s/scheduler.conf.tpl > $CONF_FOLDER/scheduler-$1.conf
}



function generate_sa_pair {
  # Generate sa key
  openssl genrsa -out $PKI_FOLDER/sa.key 2048
  # Extract pub 
  openssl rsa -in $PKI_FOLDER/sa.key -outform PEM -pubout -out $PKI_FOLDER/sa.pub
}

# Main

if [ ! -d $CONF_FOLDER ]; then
  mkdir -p $CONF_FOLDER
fi

# Config files
create_kubelet_conf localhost.localdomain 10.0.2.15:6443
create_admin_conf localhost.localdomain 10.0.2.15:6443
create_controller-manager_conf localhost.localdomain 10.0.2.15:6443
create_scheduler_conf localhost.localdomain 10.0.2.15:6443

# SA key pair
generate_sa_pair
