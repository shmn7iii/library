#!/bin/sh

# this script requires root privilege
if [ "`whoami`" != "root" ]; then
  echo "ERROR: Require root privilege. Run it with sudo."
  exit 1
fi

# download
wget https://dist.ipfs.io/ipfs-cluster-service/v0.14.1/ipfs-cluster-service_v0.14.1_linux-amd64.tar.gz
wget https://dist.ipfs.io/ipfs-cluster-ctl/v0.14.1/ipfs-cluster-ctl_v0.14.1_linux-amd64.tar.gz

# install
tar -xvzf ipfs-cluster-service_v0.14.1_linux-amd64.tar.gz
sudo mv ipfs-cluster-service/ipfs-cluster-service /usr/local/bin
tar -xvzf ipfs-cluster-ctl_v0.14.1_linux-amd64.tar.gz
sudo mv ipfs-cluster-ctl/ipfs-cluster-ctl /usr/local/bin

sudo rm -f ipfs-cluster-service_v0.14.1_linux-amd64.tar.gz
sudo rm -rf ipfs-cluster-service
sudo rm -f ipfs-cluster-ctl_v0.14.1_linux-amd64.tar.gz
sudo rm -rf ipfs-cluster-ctl

# 確認
ipfs-cluster-service version