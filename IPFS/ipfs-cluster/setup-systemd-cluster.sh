#!/bin/sh

# this script requires root privilege
if [ "`whoami`" != "root" ]; then
  echo "ERROR: Require root privilege. Run it with sudo."
  exit 1
fi

# setup systemd
sudo cat <<EOF > /etc/systemd/system/ipfs-cluster.service
[Unit]
Description=IPFS-Cluster daemon
After=network.target ipfs
[Service]
User=yamalabo
WorkingDirectory=/home/yamalabo/
ExecStart=/usr/local/bin/ipfs-cluster-service daemon
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable ipfs-cluster
sudo systemctl start ipfs-cluster

echo ""
echo "IPFS-Cluster daemon is started. To watch logs, run 'journalctl -f -u ipfs'"