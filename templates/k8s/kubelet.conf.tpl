apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: CA_BASE64
    server: https://KUBE-APISERVER
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: system:node:NODENAME
  name: system:node:NODENAME@kubernetes
current-context: system:node:NODENAME@kubernetes
kind: Config
preferences: {}
users:
- name: system:node:NODENAME
  user:
    client-certificate: /etc/kubernetes/pki/kubelet-client.crt
    client-key: /etc/kubernetes/pki/kubelet-client.key
