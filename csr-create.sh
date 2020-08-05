#!/bin/bash

CSR_FOLDER=target/csr
CONF_FOLDER=target/kubernetes
PKI_FOLDER=target/kubernetes/pki
EXTERNAL_CA=pki-mock/ca.crt

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

# $1 NODENAME
# $2 KUBE-APISERVER (DNS / IP):PORT Ex. 10.10.10.10:6443 or k8s.proj.domain:433 
function create_kubelet_conf {
  CA_BASE64=$(cat $EXTERNAL_CA | base64 -w 0)
  sed "s/NODENAME/$1/g; s/KUBE-APISERVER/$2/g; s/CA_BASE64/$CA_BASE64/g" \
       templates/k8s/kubelet/kubelet.conf.tpl > $CONF_FOLDER/kubelet-$1.conf
}

# $1 KUBE-APISERVER-DNS
# $2 KUBE-APISERVER-IP 
function create_apiserver_server {
  # Substitue required information on host veritification
  sed "s/KUBE-APISERVER-DNS/DNS.5 = $1/g; s/KUBE-APISERVER-IP/IP.2 = $2/g" \
       templates/k8s/apiserver/x509req-apiserver-server.cnf.tpl \
       > templates/k8s/apiserver/x509req-apiserver-server-$1.cnf

  # Generate key + csr with ext attributes
  openssl req -config templates/k8s/apiserver/x509req-apiserver-server-$1.cnf \
              -new -nodes \
              -keyout $PKI_FOLDER/apiserver-$1.key \
              -out $CSR_FOLDER/apiserver-$1.csr

 
  # Remove temporary cnf 
  rm templates/k8s/apiserver/x509req-apiserver-server-$1.cnf
}



# Main

if [ ! -d $CSR_FOLDER ]; then
  mkdir -p $CSR_FOLDER
fi

if [ ! -d $CONF_FOLDER ]; then
  mkdir -p $CONF_FOLDER
fi

if [ ! -d $PKI_FOLDER ]; then
  mkdir -p $PKI_FOLDER
fi

# Kubelet
# TODO change to for with node list..
create_kubelet_server localhost.localdomain
create_kubelet_client localhost.localdomain
create_kubelet_conf localhost.localdomain 10.0.2.15:6443
create_apiserver_server localhost.localdomain 10.0.2.15
