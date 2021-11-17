# Build Tapyrus-Core on Ubuntu

## Specifications

Ubuntu 18.04.6 LTS (Bionic Beaver)

## Build requirements

```bash
$ sudo apt-get install build-essential libtool autotools-dev automake pkg-config libevent-dev bsdmainutils python3 libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev software-properties-common
$ sudo add-apt-repository ppa:bitcoin/bitcoin
$ sudo apt-get update
$ sudo apt-get install libdb4.8-dev libdb4.8++-dev
```

<!-- ppa:bitcoin/bitcoinくんがUbuntu 18.10以前のみ対応 -->

## Build

```bash
$ git clone https://github.com/chaintope/tapyrus-core.git
$ cd tapyrus-core
$ ./autogen.sh
$ ./configure --without-gui
$ make
$ sudo make install
```





