# k8s-pki

k8s provisioned PKI

# Structure

* target sample files expected at /etc/kubernetes to manage an installation within kubeadm external CA mode on    
* pki-mock: resources to emulate an external PKI to sign the required certificates
* templates: template files to create certificates

# Extensions on certificates

This project relies on openssl to sign requests. 

## x509 option

Sing with x509 option will not translate extensions from csr to certificates, in this case specific information   
based on ext files should be provided. As this information will be included during the signing phase included   
that information as req_extension on csr creation is redundant.  

## ca option

Sign with ca option will require ca configuration, among the configuration there is an option to copy_extensions  
in this case extensions included in the csr are copied to the certificate. So no extensions file should be provided
to the issuer.    

For etcd cluster communication two types of certificates are generated: peer and server. They both have same information, even 
same CN, this may lead to errors. This should be take into account. In this solution ca conf includes: unique_subject = no which
allows certificates with equal CN. 

# Execution

First create all required csrs (at this point only for one server...functions should be used to integrate with inventories)  

./csr-create.sh: This tool will create target/csr folder with all the required csrs  

In case of mocked system sign the images based on mock-pki   

./csr-sign.sh: This tool will sign all csrs within the mocked CA

Create specific k8s conf resources based on certificates  

./k8s-prepare.sh  

Move all required certificates and files to default location: /etc/kubernetes

./scripts/setup-target.sh  

Run kubeadm with specific config (kubelet certs pointint to the generated ones)

sudo kubeadm --config templates/kubeadm/k8s/k8s-cluster-configuration.yaml  

Enjoy your mocked corporate PKI integration :smirk:  


# TODOs

* change ownership: chwon -R root:root . for target / out_crt folders..all files should be owned by root

* In case of external OIDC provider does the initial configuration includes an admin within the admin.conf

# Troubleshooting

Test exact phase within kubeadm with log level:

```
kubeadm init phase upload-config kubelet -v 10
```
