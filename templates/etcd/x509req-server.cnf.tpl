[ req ]
default_bits = 2048
distinguished_name = req_distinguished_name
req_extensions     = etcd_peer

[ req_distinguished_name ]
CN                 = FQDN

[ alt_names ]
DNS.1 = localhost
ETCD-DNS
IP.1 = 127.0.0.1
ETCD-IP

[etcd_peer]
keyUsage=digitalSignature, keyEncipherment
extendedKeyUsage=serverAuth, clientAuth
subjectAltName=@alt_names


