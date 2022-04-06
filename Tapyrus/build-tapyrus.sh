# /bin/sh

# tapyrus core version
TAPYRUS_CORE_VERSION='0.5.0'

# dependency
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y wget curl git vim gcc build-essential libtool autotools-dev automake pkg-config libevent-dev bsdmainutils python3 libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev software-properties-common
sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev

# download
wget https://github.com/chaintope/tapyrus-core/archive/refs/tags/v${TAPYRUS_CORE_VERSION}.tar.gz -O tapyrus-core-${TAPYRUS_CORE_VERSION}.tar.gz
tar -xzvf tapyrus-core-${TAPYRUS_CORE_VERSION}.tar.gz
sudo rm -rf tapyrus-core-${TAPYRUS_CORE_VERSION}.tar.gz

# build
cd tapyrus-core-${TAPYRUS_CORE_VERSION}
./autogen.sh
./configure --without-gui
make
sudo make install
