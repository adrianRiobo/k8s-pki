#!/bin/bash

CSR_FOLDER=target/csr
CRT_FOLDER=target/certs

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

verify_crt $CRT_FOLDER/$1.crt


