#!/bin/sh

# install dependencies
sudo apt-get update -y
sudo apt-get upgrade -y

# install ipfs
wget https://dist.ipfs.io/go-ipfs/v0.10.0/go-ipfs_v0.10.0_linux-amd64.tar.gz
tar -xvzf go-ipfs_v0.10.0_linux-amd64.tar.gz
cd go-ipfs
sudo bash install.sh

# remove dirs
sudo rm -f go-ipfs_v0.10.0_linux-amd64.tar.gz
sudo rm -rf go-ipfs

echo "=================================================================="
echo ""
echo "    go-ipfs is now installed."
echo "    Next, you have to run this in home directory: 'ipfs init'"
echo ""
echo "=================================================================="