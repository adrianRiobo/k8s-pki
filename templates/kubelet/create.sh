#!/bin/bash

mkdir -p out

#Uncommment if IP verification on addition to hostname
#export SAN="DNS:fqdn, IP:X.X.X.X"
openssl req -config kubelet.cnf -new -nodes \
            -keyout out/kubelet.key \
            -out out/kubelet.csr \
            -subj '/CN=localhost.localdomain'
