#!/bin/bash

# admin certificates 
function create_admin_certificate {
  openssl req -config templates/k8s/admin-x509req.cnf \
              -new -nodes \
              -keyout $PKI_FOLDER/admin.key \
              -out $CSR_FOLDER/admin.csr 
}

# controller-manager certificates
function create_controller-manager_certificate {
  openssl req -config templates/k8s/controller-manager-x509req.cnf \
              -new -nodes \
              -keyout $PKI_FOLDER/controller-manager.key \
              -out $CSR_FOLDER/controller-manager.csr
}

# scheduler certificates
function create_scheduler_certificate {
  openssl req -config templates/k8s/scheduler-x509req.cnf \
              -new -nodes \
              -keyout $PKI_FOLDER/scheduler.key \
              -out $CSR_FOLDER/scheduler.csr
}

