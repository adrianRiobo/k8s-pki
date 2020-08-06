apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: CA_BASE64
    server: https://KUBE-APISERVER
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: system:kube-scheduler
  name: system:kube-scheduler@kubernetes
current-context: system:kube-scheduler@kubernetes
kind: Config
preferences: {}
users:
- name: system:kube-scheduler
  user:
    client-certificate-data: SCHEDULER_CRT_BASE64
    client-key-data: SCHEDULER_KEY_BASE64
