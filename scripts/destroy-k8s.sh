#!/bin/bash

# Destroy resources installed by kubeadm to test new installations

sudo systemctl stop kubelet
sudo systemctl disable kubelet
docker stop $(docker ps -q)
docker rm $(docker ps -q -a)
sudo rm -rf /var/lib/etcd
sudo rm -rf /var/lib/kubelet
sudo rm -f /etc/kubernetes/manifests/*
