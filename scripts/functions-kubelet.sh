#!/bin/bash

# Using as input list of fqdns for kubelet (all masters + workers) generate n csr
# Create an extesion file with all extensions as they should inclide SAN

# $1 kubelet node fqdn (dns record)
# $2 optional IP 
function create_kubelet_server {
  #export SAN="DNS:fqdn, IP:X.X.X.X"
  export SAN="DNS:$1"
  openssl req -config templates/k8s/kubelet/x509req-kubelet-server.cnf \
              -new -nodes \
              -keyout $PKI_FOLDER/kubelet-server-$1.key \
              -out $CSR_FOLDER/kubelet-server-$1.csr \
              -subj "/CN=kubelet-server-$1"
}

# $1 kubelet node name
function create_kubelet_client {
  #export SAN="DNS:fqdn, IP:X.X.X.X"
  export NODENAME=$1
  openssl req -config templates/k8s/kubelet/x509req-kubelet-client.cnf \
              -new -nodes \
              -keyout $PKI_FOLDER/kubelet-client-$1.key \
              -out $CSR_FOLDER/kubelet-client-$1.csr 
}

# $1 kubelet node name
function create_kubelet_client {
  #export SAN="DNS:fqdn, IP:X.X.X.X"
  export NODENAME=$1
  openssl req -config templates/k8s/kubelet/x509req-kubelet-client.cnf \
              -new -nodes \
              -keyout $PKI_FOLDER/kubelet-client-$1.key \
              -out $CSR_FOLDER/kubelet-client-$1.csr
}

