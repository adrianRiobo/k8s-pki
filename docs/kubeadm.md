# Overview

This project is intended to generate the certificates required to operate a k8s cluster, full structure of certificates
will be integrated with an installation based on kubeadm.

## Default cluster configuration

To get the default kubeadm config to customize:

```
kubeadm config print init-defaults > k8s-cluster-configuration.yaml
```

## Kubelet customization

Add tls [configuration on kubelet](https://godoc.org/k8s.io/kubelet/config/v1beta1#KubeletConfiguration) to avoid self generated certs:  
* TLSCertFile x509 cert    
* TLSPrivateKeyFile key

```
---
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
TLSCertFile: /etc/kubernetes/pki/kubelet.crt
TLSPrivateKeyFile: /etc/kubernetes/pki/kubelet.key
```

## Execute installation

Certs structure should be copied to /etc/kubernetes/pki (default path could be customized at config file)  

kubeadm init --config k8s-cluster-configuration.yaml 


