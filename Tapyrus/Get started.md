# Get started

Taprusのスタートドキュメント

## Introduction

Tapyrusにおいては、各用途に対しそれぞれのネットワークが構築されオンラインになります。ネットワークは `genesis block`, `aggregate public key`, `network magic bytes`, により識別されます。(ver 0.3.0まで)

## Components of a Tapyrus network

Tapyrusネットワークは三種類のノードから成り立ちます。

| Node Type      | How many?      | Purpose                   |
| :------------- | -------------- | ------------------------- |
| Tapyrus Signer | min3, max 15   | Signerネットワークを構成  |
| Tapyrus Core   | min1, 上限なし | フルノード                |
| Tapyrus Seeder | min1, 上限なし | ネットワークのDNSシーダー |

## Tapyrus network parameters

それぞれのTapyrusネットワークを識別するために用いられ、各ネットワークで固有となります。

### Network ID

**ネットワークID** - Tapyrusネットワークを開始するのに必要な番号です。各ネットー枠で独自である必要があり、衝突を避けることが望ましいです。

### Network magic bytes

**ネットワークマジックバイト** - マジックバイトはノード間通信時に識別子として用いられます。具体的には送受信メッセージの接頭辞になります。マジックバイトはネットワークIDから計算され、16進数で表示されます。

### Genesis block

**ジェネシスブロック** - Tapyrusのジェネシスブロックはソフトウェアには組み込まれず、tapyrus-genesisというユーティリティを用いて生成されます。ジェネシスブロックはSignerネットワークにより署名を受ける必要があり、外部ファイルとして保存されます。各ネットワークで独自である必要があります。

### Aggregate public key

**集約公開鍵** - 前述のジェネシスブロックにはこの集約公開鍵が含まれます。集約公開鍵は字の如く公開鍵を集約したもので、ネットワークの起動時に検証可能な秘密分散スキームによって生成されます。これは各Tapyrus Coreノードがブロックを検証しブロックを受け付ける際に使用されます。