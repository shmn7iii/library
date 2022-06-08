docker run -d --name 'tapyrus_testnet_v051' -v tapyrus_testnet_v051_data:/root/.tapyrus -e CONF_DIR="/root/.tapyrus" -e DATA_DIR="/root/.tapyrus" -e GENESIS_BLOCK_WITH_SIG='01000000000000000000000000000000000000000000000000000000000000000000000044cc181bd0e95c5b999a13d1fc0d193fa8223af97511ad2098217555a841b3518f18ec2536f0bb9d6d4834fcc712e9563840fe9f089db9e8fe890bffb82165849f52ba5e01210366262690cbdf648132ce0c088962c6361112582364ede120f3780ab73438fc4b402b1ed9996920f57a425f6f9797557c0e73d0c9fbafdebcaa796b136e0946ffa98d928f8130b6a572f83da39530b13784eeb7007465b673aa95091619e7ee208501010000000100000000000000000000000000000000000000000000000000000000000000000000000000ffffffff0100f2052a010000002776a92231415132437447336a686f37385372457a4b6533766636647863456b4a74356e7a4188ac00000000' tapyrus/tapyrusd:v0.5.1

docker exec tapyrus_testnet_v051 bash -c 'cat << EOF > /root/.tapyrus/tapyrus.conf
networkid=1939510133
txindex=1
server=1
rest=1
rpcuser=rpcuser
rpcpassword=rpcpassword
rpcbind=0.0.0.0
rpcallowip=127.0.0.1
addseeder=static-seed.tapyrus.dev.chaintope.com
fallbackfee=0.0002
EOF'

docker restart tapyrus_testnet_v051
