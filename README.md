# 共同開発手順

## 環境構築

- 環境構築はDockerという仮想環境を使用します。
- dockerをインストールしておいてください。

### リポジトリをクローン

以下コマンドでローカルにリポジトリをクローンします。

`$ git clone -b ブランチ名(develop-neko) https://github.com/masakichi-eng/NekoPro-Tsubuyaki.git`

### データベースを作成する

`$ docker-compose run web rake db:create`

### ビルド&コンテナ起動

ルートディレクトリで以下のコマンドを実行してビルド&コンテナ起動します。

`$ docker-compose up -d --build`

以下のコマンドで2つのコンテナ(web,db)が起動（Up）しているのを確認できたらOKです。

`$ docker-compose ps`

ブラウザで`localhost:3000`にアクセスしてRailsの画面が表示されたら成功です。

今後、rails コマンドを使う時には以下のコマンドでコンテナの中に入ってから実行してください。

### web packer のインストール

`$ docker-compose run --rm web bundle install`
`$ docker-compose run --rm web yarn install`

gemファイルを更新するときは
`$ docker-compose run --rm web bundle install`
を行ってください

`$ docker-compose exec web bash`

以上で環境構築は終了です。

以下のワイヤーフレームを参考にして作業を進めてください

`https://www.figma.com/file/GaYgj7VyjCXTAYBY105E6a/%E3%81%AD%E3%81%93%E3%83%97%E3%83%AD%E5%85%B1%E5%90%8C%E9%96%8B%E7%99%BA?node-id=0%3A1`

#### 各エイリアス

Make fileにエイリアスを設定しました。以下のコマンドでも代用可能です

- サーバーの起動 `make up`
- サーバーの終了 `make down`
- bundle install `make install`
- rails c        `make console`
- rubocop        `make lint`

その他詳しくは Makefileを参照ください
