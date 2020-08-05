#!/bin/bash

# PKI path
PKI_EXTERNAL=pki-external
# PKI required resources: ca.key ca.crt ca.cnf (copy extensions)
PKI_RESOURCES=pki-mock
CSR_FOLDER=target/csr
CRT_FOLDER=target/certs

create_external_pki {
  mkdir $PKI_EXTERNAL
  touch $PKI_EXTERNAL/index.txt
  echo '01' > $PKI_EXTERNAL/serial
  cp $PKI_RESOURCES/ca.* $PKI_EXTERNAL/
}

# $1 csr file name
sign_certificate {
  openssl ca -config $$PKI_EXTERNAL/ca.cnf \
  -keyfile $PKI_EXTERNAL/ca.key \
  -cert $PKI_EXTERNAL/ca.crt \
  -out $CRT_FOLDER/$1.crt -infiles $CSR_FOLDER/$1.csr
}

# Main
if [ ! -d $PKI_EXTERNAL ]; then
  create_external_pki
fi
