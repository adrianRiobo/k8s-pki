#!/bin/bash

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

function create_apiserver_etcd_client {
  openssl req -config templates/k8s/apiserver/x509req-apiserver-etcd-client.cnf \
              -new -nodes \
              -keyout $PKI_FOLDER/apiserver-etcd-client.key \
              -out $CSR_FOLDER/apiserver-etcd-client.csr
}

function create_apiserver_kubelet_client {
  openssl req -config templates/k8s/apiserver/x509req-apiserver-kubelet-client.cnf \
              -new -nodes \
              -keyout $PKI_FOLDER/apiserver-kubelet-client.key \
              -out $CSR_FOLDER/apiserver-kubelet-client.csr
}


