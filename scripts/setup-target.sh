#!/bin/bash

CURRENT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TARGET=$CURRENT/../target
NODENAME=localhost.localdomain

# kubelet
sudo cp $CURRENT/../target/kubernetes/kubelet-$NODENAME.conf /etc/kubernetes/kubelet.conf
sudo cp $CURRENT/../target/kubernetes/pki/kubelet-client-$NODENAME.crt /etc/kubernetes/pki/kubelet-client.crt
sudo cp $CURRENT/../target/kubernetes/pki/kubelet-client-$NODENAME.key /etc/kubernetes/pki/kubelet-client.key
sudo cp $CURRENT/../target/kubernetes/pki/kubelet-server-$NODENAME.crt /etc/kubernetes/pki/kubelet-server.crt
sudo cp $CURRENT/../target/kubernetes/pki/kubelet-server-$NODENAME.key /etc/kubernetes/pki/kubelet-server.key

# apiserver

sudo cp $CURRENT/../target/kubernetes/pki/apiserver-$NODENAME.crt /etc/kubernetes/pki/apiserver.crt
sudo cp $CURRENT/../target/kubernetes/pki/apiserver-$NODENAME.key /etc/kubernetes/pki/apiserver.key

# etcd

sudo cp $TARGET/kubernetes/pki/etcd/healthcheck-client.crt /etc/kubernetes/pki/etcd/healthcheck-client.crt
sudo cp $TARGET/kubernetes/pki/etcd/peer-$NODENAME.crt /etc/kubernetes/pki/etcd/peer.crt
sudo cp $TARGET/kubernetes/pki/etcd/server-$NODENAME.crt /etc/kubernetes/pki/etcd/server.crt
sudo cp $TARGET/kubernetes/pki/etcd/healthcheck-client.key /etc/kubernetes/pki/etcd/healthcheck-client.key
sudo cp $TARGET/kubernetes/pki/etcd/peer-$NODENAME.key /etc/kubernetes/pki/etcd/peer.key
sudo cp $TARGET/kubernetes/pki/etcd/server-$NODENAME.key /etc/kubernetes/pki/etcd/server.key


# Check if required
sudo chown -R root:root /etc/kubernetes/pki
