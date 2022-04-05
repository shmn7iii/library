# Install Tapyrus core

バイナリからインストールする

## spec

Ubuntu 18.10

Tapyrus core v0.5.0

## install

```bash
# tapyrus core version
TAPYRUS_CORE_VERSION='0.5.0'

# dependency
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y wget curl git vim 

# download
wget https://github.com/chaintope/tapyrus-core/releases/download/v${TAPYRUS_CORE_VERSION}/tapyrus-core-${TAPYRUS_CORE_VERSION}-x86_64-linux-gnu.tar.gz -O tapyrus-core-${TAPYRUS_CORE_VERSION}.tar.gz
tar -xzvf tapyrus-core-${TAPYRUS_CORE_VERSION}.tar.gz
sudo rm -rf tapyrus-core-${TAPYRUS_CORE_VERSION}.tar.gz

# path
echo 'export PATH="$HOME/tapyrus-core-$TAPYRUS_CORE_VERSION/bin:$PATH"' >> ~/.bashrc

# reload
source .bashrc
```