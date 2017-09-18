### はじめに

1. denvをインストール
2. `wget http://downloads.dlang.org/releases/2.x/2.070.1/dmd.2.070.1.zip`
3. `unzip dmd.2.070.1.zip`
4. `mv dmd2 ~/.denv/versions/2.070.1`
5. 2.070にはdubが入ってないのでどっかからインストール
6. `ln -s /usr/bin/dub ~/.denv/versions/dmd-2.070.1/linux/bin64/dub`
5. `denv rehash`


### 実行

`cat input.txt | dub run --single app.d`