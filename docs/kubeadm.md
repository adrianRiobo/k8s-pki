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

## Cluster configuration

The cluster extensibility model will be achieved within CRD, so [aggregate APIs](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/apiserver-aggregation) will be disable to do this, cluster custom configuration left blank proxy client attributes on both apiserver and controller-manager:

```
apiServer:
  timeoutForControlPlane: 4m0s
  extraArgs:
    authorization-mode: "Node,RBAC"
    # Disable API aggregator
    proxy-client-cert-file: ""
    proxy-client-key-file: ""
    requestheader-allowed-names: ""
    requestheader-client-ca-file: ""
controllerManager:
  extraArgs:
    # Disable API aggregator
    requestheader-client-ca-file: ""
```

Also kubeadm should skip the front-proxy certificates generation, add:

```
--skip-phases=certs/front-proxy-ca,certs/front-proxy-client
``` 



