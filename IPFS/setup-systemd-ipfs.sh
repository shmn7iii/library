#!/bin/sh

# this script requires root privilege
if [ "`whoami`" != "root" ]; then
  echo "ERROR: Require root privilege. Run it with sudo."
  exit 1
fi

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