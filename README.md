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

# Flow

## Kubelet config files

* kubelet.conf: one per node should include node naming information.
* kubelet-client cert: shared added as base64 on kubelet.conf
* kubelet cert: one per node should include fqdn

# TODOs

* change ownership: chwon -R root:root . for target / out_crt folders..all files should be owned by root


