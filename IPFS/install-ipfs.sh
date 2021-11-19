#!/bin/sh

# this script requires root privilege
if [ "`whoami`" != "root" ]; then
  echo "ERROR: Require root privilege. Run it with sudo."
  exit 1
fi

# install dependencies
sudo apt-get update -y
sudo apt-get upgrade -y

# install ipfs
wget https://dist.ipfs.io/go-ipfs/v0.10.0/go-ipfs_v0.10.0_linux-amd64.tar.gz
tar -xvzf go-ipfs_v0.10.0_linux-amd64.tar.gz
cd go-ipfs
sudo bash install.sh
cd /home/yamalabo
ipfs init

# remove dirs
sudo rm -f go-ipfs_v0.10.0_linux-amd64.tar.gz
sudo rm -rf go-ipfs

# setup systemd
sudo cat <<EOF > /etc/systemd/system/ipfs.service
[Unit]
Description=IPFS daemon
After=network.target

[Service]
User=yamalabo
WorkingDirectory=/home/yamalabo/
ExecStart=/usr/local/bin/ipfs daemon
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable ipfs
sudo systemctl start ipfs

echo ""
echo "IPFS daemon is started. To watch logs, run 'journalctl -f -u ipfs'"