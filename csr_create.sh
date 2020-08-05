#!/bin/bash

CSR_FOLDER=target/csr
KEY_FOLDER=target/private

# Using as input list of fqdns for kubelet (all masters + workers) generate n csr
# Create an extesion file with all extensions as they should inclide SAN

# $1 kubelet node fqdn (dns record)
# $2 optional IP 
function create_kubelet_server {
  #export SAN="DNS:fqdn, IP:X.X.X.X"
  export SAN="DNS:$1"
  openssl req -config templates/k8s/kubelet/x509req-kubelet-server.cnf \
              -new -nodes \
              -keyout $KEY_FOLDER/kubelet-server-$1.key \
              -out $CSR_FOLDER/kubelet-server-$1.csr \
              -subj "/CN=kubelet-server-$1"
}

# Main

if [ ! -d $CSR_FOLDER ]; then
  mkdir -p $CSR_FOLDER
fi

if [ ! -d $KEY_FOLDER ]; then
  mkdir -p $KEY_FOLDER
fi

# Kubelet
# TODO change to for with node list..
create_kubelet_server localhost.localdomain
