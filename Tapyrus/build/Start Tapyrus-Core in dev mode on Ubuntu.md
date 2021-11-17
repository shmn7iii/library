# Start Tapyrus-Core in dev mode on Ubuntu

w/o docker

Docker無しでTapyrusCoreのdevモードをUbuntuで構築する方法を書きます。

公式ドキュメントは以下です。

https://github.com/chaintope/tapyrus-core/blob/master/doc/tapyrus/getting_started.md#how-to-start-tapyrus-in-dev-mode

## 前提

Ubuntu v18.06.4

Tapyrus Core v0.5.0 rc1

(v0.4.1でやってるものだと思ってたのですが気付いたらv0.5.0になってました。2021/11/10時点で本リリースではなさそうです。なんなら9日にrc2が出てました。v0.5.0でのアップデート内容等公式からアナウンスがあったらまとめたいです(願望))

## Build Tapyrus Core

### 依存関係をインストール

```bash
$ sudo apt-get install build-essential libtool autotools-dev automake pkg-config libevent-dev bsdmainutils python3 libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev software-properties-common
$ sudo add-apt-repository ppa:bitcoin/bitcoin
$ sudo apt-get update
$ sudo apt-get install libdb4.8-dev libdb4.8++-dev
```

## ビルド

```bash
$ git clone https://github.com/chaintope/tapyrus-core.git
$ cd tapyrus-core
$ ./autogen.sh
$ ./configure --without-gui
$ make
$ sudo make install
```

## データディレクトリを作成

ブロックチェーンのデータを保存するディレクトリを作成します。このディレクトリは各ネットワークおよびモードで異なるものを利用することが推奨されます。

```bash
$ sudo mkdir /var/lib/tapyrus-dev
```

## tapyrus.confを作成

etc/tapyrus配下に作成します。

```bash
$ sudo mkdir /etc/tapyrus
$ cd /etc/tapyrus
$ sudo vim tapyrus.conf
```

内容は以下とします。

```
networkid=1905960821
dev=1
[dev]
server=1
keypool=1
discover=0
bind=127.0.0.1

rpcuser=rpcuser
rpcpassword=rpcpassword
rpcbind=0.0.0.0
rpcallowip=127.0.0.1
```

## 鍵を生成

rubyで鍵を生成していきます。入ってなければ以下の手順で入れてください。

```bash
# aptのRubyをアンインストール
$ sudo apt purge ruby rbenv ruby-build
$ rm -rf ~/.rbenv

# rbenv, ruby-buildをクローン
$ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
$ git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# bashrcを更新
$ echo '# ruby' >> ~/.bashrc
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
$ echo 'eval "$(rbenv init - )"' >> ~/.bashrc
$ source ~/.bashrc

# ruby 3.0.1 をインストール
$ rbenv install 3.0.1

# デフォルトを3.0.1に設定
$ rbenv global 3.0.1

# 確認
$ ruby -v
```

### 1. tapyrusrbを用意する

TapyrusのRuby用ライブラリ、tapyrusrbをgemでインストールします。

```bash
$ gem install tapyrus
```

この先はirbで操作していきます。irbとはRubyの対話型シェルです。

次のコマンドでirbを起動します。

```bash
$ irb
```

irbでは `>` 以降に入力、 `=>` 以降に返答が返ってきます。

irbでtapyrusrbを有効にします。`>` 以降を入力してください。`=>` 以降が返って来れば成功です。

```ruby
> require 'tapyrus'
=> true
```

tapyrusrbをdevモードに設定します。

```ruby
> Tapyrus.chain_params = :dev
=> true
```

### 2. 拡張鍵のseedを取得

SHA-256で16進数表示の拡張鍵のseedを取得します。

拡張鍵とは公開鍵や秘密鍵などを保持した単一の鍵です。

```ruby
> OpenSSL::Digest::SHA256.hexdigest(SecureRandom.hex(32))
=> "拡張鍵"
```

返答をメモしておきます。

### 3. 拡張鍵をインスタンス化

一つ前で取得した拡張鍵を引数にインスタンスを生成します。

```ruby
> ext_key = Tapyrus::ExtKey.generate_master("拡張鍵")
=> #<Tapyrus::ExtKey:0x00007fb299041c00...
```

インスタンスは `ext_key` に格納されるので返答は無視で大丈夫です。

### 4. 鍵の強化導出

安全性向上のために強化導出を行います。拡張鍵インスタンスに `.derive` 関数を実行し、`ext_key1`に格納します。

```ruby
> ext_key1 = ext_key.derive(1)
=> #<Tapyrus::ExtKey:0x00007fb29c92b7c8...
```

強化導出後の拡張鍵インスタンスは `ext_key1` に格納されます。

### 5. 公開鍵を取得

拡張鍵から公開鍵を取得します。強化導出後の拡張鍵インスタンス `ext_key1` の `pub` を参照します。

```ruby
> pub = ext_key1.pub
=> "公開鍵(hex)"
```

hex表示の公開鍵が返ってきます。返答をメモしておきます。

### 6. 秘密鍵を取得

拡張鍵から秘密鍵を取得します。公開鍵同様の手順で `priv` を参照します。

```ruby
> priv = ext_key1.priv
=> "秘密鍵(hex)"
```

hex表示の秘密鍵が返ってきます。返答をメモしておきます。

### 7. 秘密鍵をWIF形式で取得

拡張鍵からWIF形式で秘密鍵を取得します。

WIFとは Wallet Import Format の略でBitcoinのwalletを扱うために開発された鍵の表示形式です。

```ruby
> wif = ext_key1.key.to_wif
=> "秘密鍵(WIF)"
```

WIF表示の秘密鍵が返ってきます。返答をメモしておきます。

## genesis-blockを作成

以下のコマンドでジェネシスブロックを作成します。公開鍵・秘密鍵は先ほど生成したものを利用してください。公式では-time引数と-address引数はオプショナルなので今回は指定しません。指定がなければ-timeには現在のUnix時間が入ります。

```bash
$ tapyrus-genesis -dev -signblockpubkey=公開鍵 -signblockprivatekey=秘密鍵(WIF)
```

16進数で表示されたgenesis-blockが返ってきます。その内容をコピーして `genesis.1905960821` という名前で保存します。

```bash
$ cd /var/lib/tapyrus-dev
$ sudo vim genesis.1905960821
```

## Coreを起動

以上で起動準備は完了です。以下のコマンドでCoreが立ち上がります。

```bash
$ sudo tapyrusd -dev -datadir=/var/lib/tapyrus-dev -conf=/etc/tapyrus/tapyrus.conf
```

## おまけ：ちょっと使ってみる

せっかくなので少し使ってみましょう。

### アドレスを作成する

````bash
$ sudo tapyrus-cli -conf=/etc/tapyrus/tapyrus.conf getnewaddress
````

アドレスが作成され返ってきます。

### ブロックを作成する

```bash
$ sudo tapyrus-cli -conf=/etc/tapyrus/tapyrus.conf generatetoaddress 1 "アドレス" "秘密鍵(WIF)"
```

秘密鍵について、TapyrusCoreのバージョンが0.4.1より古い場合はhex、より新しい場合はWIFのものを指定します。

### UTXOのリストを表示する

```bash
$ sudo tapyrus-cli -conf=/etc/tapyrus/tapyrus.conf listunspent
```

UTXOのリストが表示されます。
