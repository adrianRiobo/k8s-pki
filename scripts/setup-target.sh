#!/bin/bash

CURRENT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TARGET=$CURRENT/../target
NODENAME=localhost.localdomain
EXTERNAL_CA=$CURRENT/../pki-mock/ca.crt

# kubelet
sudo cp $TARGET/kubernetes/pki/kubelet-client-$NODENAME.crt /etc/kubernetes/pki/kubelet-client.crt
sudo cp $TARGET/kubernetes/pki/kubelet-client-$NODENAME.key /etc/kubernetes/pki/kubelet-client.key
sudo cp $TARGET/kubernetes/pki/kubelet-server-$NODENAME.crt /etc/kubernetes/pki/kubelet-server.crt
sudo cp $TARGET/kubernetes/pki/kubelet-server-$NODENAME.key /etc/kubernetes/pki/kubelet-server.key

# apiserver

sudo cp $TARGET/kubernetes/pki/apiserver-$NODENAME.crt /etc/kubernetes/pki/apiserver.crt
sudo cp $TARGET/kubernetes/pki/apiserver-$NODENAME.key /etc/kubernetes/pki/apiserver.key
sudo cp $TARGET/kubernetes/pki/apiserver-etcd-client.crt /etc/kubernetes/pki/apiserver-etcd-client.crt
sudo cp $TARGET/kubernetes/pki/apiserver-etcd-client.key /etc/kubernetes/pki/apiserver-etcd-client.key
sudo cp $TARGET/kubernetes/pki/apiserver-kubelet-client.crt /etc/kubernetes/pki/apiserver-kubelet-client.crt
sudo cp $TARGET/kubernetes/pki/apiserver-kubelet-client.key /etc/kubernetes/pki/apiserver-kubelet-client.key

# etcd

sudo mkdir -p /etc/kubernetes/pki/etcd 
sudo cp $TARGET/kubernetes/pki/etcd/healthcheck-client.crt /etc/kubernetes/pki/etcd/healthcheck-client.crt
sudo cp $TARGET/kubernetes/pki/etcd/peer-$NODENAME.crt /etc/kubernetes/pki/etcd/peer.crt
sudo cp $TARGET/kubernetes/pki/etcd/server-$NODENAME.crt /etc/kubernetes/pki/etcd/server.crt
sudo cp $TARGET/kubernetes/pki/etcd/healthcheck-client.key /etc/kubernetes/pki/etcd/healthcheck-client.key
sudo cp $TARGET/kubernetes/pki/etcd/peer-$NODENAME.key /etc/kubernetes/pki/etcd/peer.key
sudo cp $TARGET/kubernetes/pki/etcd/server-$NODENAME.key /etc/kubernetes/pki/etcd/server.key

# sa

sudo cp $TARGET/kubernetes/pki/sa.key /etc/kubernetes/pki/sa.key
sudo cp $TARGET/kubernetes/pki/sa.pub /etc/kubernetes/pki/sa.pub

# config files

sudo cp $TARGET/kubernetes/kubelet-$NODENAME.conf /etc/kubernetes/kubelet.conf
sudo cp $TARGET/kubernetes/admin-$NODENAME.conf /etc/kubernetes/admin.conf
sudo cp $TARGET/kubernetes/controller-manager-$NODENAME.conf /etc/kubernetes/controller-manager.conf
sudo cp $TARGET/kubernetes/scheduler-$NODENAME.conf /etc/kubernetes/scheduler.conf

# copy external ca

sudo cp $EXTERNAL_CA /etc/kubernetes/pki
sudo cp $EXTERNAL_CA /etc/kubernetes/pki/etcd

# Check if required
sudo chown -R root:root /etc/kubernetes/pki
