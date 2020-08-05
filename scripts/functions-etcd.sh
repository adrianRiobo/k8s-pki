#!/bin/bash

function create_etcd_healthcheck_client {
  openssl req -config templates/etcd/x509req-healthcheck-client.cnf \
              -new -nodes \
              -keyout $ETCD_FOLDER/healthcheck-client.key \
              -out $CSR_ETCD_FOLDER/healthcheck-client.csr
}

# $1 ETCD-DNS
# $2 ETCD-IP (optional)
function create_etcd_peer {

  # Create cnf from tpl with values
  sed "s/ETCD-DNS/DNS.2 = $1/g; s/ETCD-IP/IP.2 = $2/g" \
       templates/etcd/x509req-peer.cnf.tpl \
       > templates/etcd/x509req-peer-$1.cnf

  # Create csr 
  openssl req -config templates/etcd/x509req-peer-$1.cnf \
              -new -nodes \
              -keyout $ETCD_FOLDER/peer-$1.key \
              -out $CSR_ETCD_FOLDER/peer-$1.csr \
              -subj "/CN=$1"

  # Remove temporary files
  rm templates/etcd/x509req-peer-$1.cnf
}

# $1 ETCD-DNS
# $2 ETCD-IP (optional)
function create_etcd_server {

  # Create cnf from tpl with values
  sed "s/ETCD-DNS/DNS.2 = $1/g; s/ETCD-IP/IP.2 = $2/g" \
       templates/etcd/x509req-server.cnf.tpl \
       > templates/etcd/x509req-server-$1.cnf

  # Create csr
  openssl req -config templates/etcd/x509req-server-$1.cnf \
              -new -nodes \
              -keyout $ETCD_FOLDER/server-$1.key \
              -out $CSR_ETCD_FOLDER/server-$1.csr \
              -subj "/CN=$1"

  # Remove temporary files
  rm templates/etcd/x509req-server-$1.cnf
}

