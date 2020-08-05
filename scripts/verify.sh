#!/bin/bash

CURRENT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
CSR_FOLDER=$CURRENT/../target/csr
PKI_FOLDER=$CURRENT/../target/kubernetes/pki

# $1 csr file path
function verify_csr() {
  openssl req -text -noout -verify -in $1
}

#$1 crt file path
function verify_crt() {
  openssl x509 -in $1 -noout -text
}

# Main

verify_csr $CSR_FOLDER/$1.csr

verify_crt $PKI_FOLDER/$1.crt


