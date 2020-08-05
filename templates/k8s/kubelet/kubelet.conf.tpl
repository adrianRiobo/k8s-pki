apiVersion: v1
clusters:
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
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
    client-certificate: /etc/kubernetes/kubelet-client.crt
    client-key: /etc/kubernetes/pki/kubelet-client.key
