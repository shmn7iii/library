#!/bin/sh
export CLUSTER_SECRET=$(od -vN 32 -An -tx1 /dev/urandom | tr -d ' \n')
echo $CLUSTER_SECRET
echo 'CLUSTER_SECRET='$CLUSTER_SECRET >> ~/.bashrc
source ~/.bashrc