#!/bin/bash

# Define folders
CSR_FOLDER=target/csr
CSR_ETCD_FOLDER=$CSR_FOLDER/etcd
PKI_FOLDER=target/kubernetes/pki
ETCD_FOLDER=$PKI_FOLDER/etcd

# Import functions
source scripts/functions-kubelet.sh
source scripts/functions-etcd.sh
source scripts/functions-apiserver.sh          
source scripts/functions-configfiles.sh

# Main

if [ ! -d $CSR_FOLDER ]; then 
  mkdir -p $CSR_FOLDER 
fi

if [ ! -d $PKI_FOLDER ]; then 
  mkdir -p $PKI_FOLDER 
fi

if [ ! -d $CSR_ETCD_FOLDER ]; then 
  mkdir -p $CSR_ETCD_FOLDER 
fi

if [ ! -d $ETCD_FOLDER ]; then
  mkdir -p $ETCD_FOLDER
fi


# Kubelet
# TODO change to for with node list..
create_kubelet_server localhost.localdomain
create_kubelet_client localhost.localdomain

# Apiserver
# Check if apiserver LB ..this should be updated at kubeadm config file.... find 10.0.2.15 at samples
create_apiserver_server localhost.localdomain 10.0.2.15
create_apiserver_etcd_client
create_apiserver_kubelet_client

# Etcd
create_etcd_healthcheck_client
create_etcd_peer localhost.localdomain 10.0.2.15
create_etcd_server localhost.localdomain 10.0.2.15

# Conf files
create_admin_certificate
create_controller-manager_certificate
create_scheduler_certificate
