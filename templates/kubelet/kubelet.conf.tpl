apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: CA_BASE64
    server: https://KUBE-APISERVER:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: system:node:NODE_NAME
  name: system:node:NODE_NAME@kubernetes
current-context: system:node:NODE_NAME@kubernetes
kind: Config
preferences: {}
users:
- name: system:node:localhost.localdomain
  user:
    client-certificate-data: KUBELET_CLIENT_CERT_BASE64
    client-key-data: KUBELET_CLIENT_KEY_BASE64
