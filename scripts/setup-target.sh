#!/bin/bash

CURRENT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
NODENAME=localhost.localdomain

sudo cp $CURRENT/../target/kubernetes/kubelet-$NODENAME.conf /etc/kubernetes/kubelet.conf
sudo cp $CURRENT/../target/kubernetes/pki/kubelet-client-$NODENAME.crt /etc/kubernetes/pki/kubelet-client.crt
sudo cp $CURRENT/../target/kubernetes/pki/kubelet-client-$NODENAME.key /etc/kubernetes/pki/kubelet-client.key
sudo cp $CURRENT/../target/kubernetes/pki/kubelet-server-$NODENAME.crt /etc/kubernetes/pki/kubelet-server.crt
sudo cp $CURRENT/../target/kubernetes/pki/kubelet-server-$NODENAME.key /etc/kubernetes/pki/kubelet-server.key

# Check if required
sudo chown -R root:root /etc/kubernetes/pki
