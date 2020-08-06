apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: CA_BASE64
    server: https://KUBE-APISERVER
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: ADMIN_CRT_BASE64
    client-key-data: ADMIN_KEY_BASE64
