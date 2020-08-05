[ req ]
default_bits = 2048
distinguished_name = req_distinguished_name
req_extensions     = kube-apiserver_server
prompt             = no

[ req_distinguished_name ]
CN                 = kube-apiserver

[ alt_names ]
DNS.1 = kubernetes
DNS.2 = kubernetes.default
DNS.3 = kubernetes.default.svc
DNS.4 = kubernetes.default.svc.cluster
DNS.5 = kubernetes.default.svc.cluster.local
KUBE-APISERVER-DNS
IP.1 = 127.0.0.1
KUBE-APISERVER-IP

[kube-apiserver_server]
#authorityKeyIdentifier=keyid,issuer:always
keyUsage=digitalSignature, keyEncipherment
extendedKeyUsage=serverAuth
subjectAltName=@alt_names

