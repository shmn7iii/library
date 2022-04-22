#!/bin/bash

echo -n "Tapyrus Core version? > "
read TAPYRUS_CORE_VERSION

echo -e "\n=== preparing... ==="
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git vim curl wget

echo -e "\n=== downloading... ==="
wget https://github.com/chaintope/tapyrus-core/releases/download/v${TAPYRUS_CORE_VERSION}/tapyrus-core-${TAPYRUS_CORE_VERSION}-x86_64-linux-gnu.tar.gz -O tapyrus-core-${TAPYRUS_CORE_VERSION}.tar.gz
tar -xzvf tapyrus-core-${TAPYRUS_CORE_VERSION}.tar.gz
sudo rm -rf tapyrus-core-${TAPYRUS_CORE_VERSION}.tar.gz
sudo mv tapyrus-core-${TAPYRUS_CORE_VERSION}/bin/* /usr/local/bin
sudo rm -rf tapyrus-core-${TAPYRUS_CORE_VERSION}

echo -e "\n=== set up data dir... ==="
mkdir ~/.tapyrus
cd ~/.tapyrus

cat <<EOF > tapyrus.conf
networkid=1939510133
txindex=1
server=1
rest=1
rpcuser=user
rpcpassword=pass
rpcbind=0.0.0.0
rpcallowip=127.0.0.1
addseeder=static-seed.tapyrus.dev.chaintope.com
fallbackfee=0.0002
EOF

cat <<EOF > genesis.1939510133
01000000000000000000000000000000000000000000000000000000000000000000000044cc181bd0e95c5b999a13d1fc0d193fa8223af97511ad2098217555a841b3518f18ec2536f0bb9d6d4834fcc712e9563840fe9f089db9e8fe890bffb82165849f52ba5e01210366262690cbdf648132ce0c088962c6361112582364ede120f3780ab73438fc4b402b1ed9996920f57a425f6f9797557c0e73d0c9fbafdebcaa796b136e0946ffa98d928f8130b6a572f83da39530b13784eeb7007465b673aa95091619e7ee208501010000000100000000000000000000000000000000000000000000000000000000000000000000000000ffffffff0100f2052a010000002776a92231415132437447336a686f37385372457a4b6533766636647863456b4a74356e7a4188ac00000000
EOF

echo -e "\n=== setup systemd... ==="
cat <<EOF > tapyrusd.service
[Unit]
Description=Tapyrus daemon
After=network.target

[Service]
ExecStart=/usr/local/bin/tapyrusd
User=yamalabo
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo mv tapyrusd.service /etc/systemd/system/tapyrusd.service
sudo systemctl daemon-reload
sudo systemctl enable tapyrusd

echo -e "\n=============================================================="
echo "  Setup for Tapyrus testnet is complete."
echo "  To start Tapyrus Core, run \`sudo systemctl restart tapyrusd\`"
echo "  To watch logs, run \`sudo journalctl -f -u tapyrusd\`"
echo "=============================================================="