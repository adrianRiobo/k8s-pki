apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: CA_BASE64
    server: https://KUBE-APISERVER
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: system:kube-controller-manager
  name: system:kube-controller-manager@kubernetes
current-context: system:kube-controller-manager@kubernetes
kind: Config
preferences: {}
users:
- name: system:kube-controller-manager
  user:
    client-certificate-data: CONTROLLER_MANAGER_CRT_BASE64
    client-key-data: CONTROLLER_MANAGER_KEY_BASE64
