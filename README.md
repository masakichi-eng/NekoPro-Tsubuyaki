# 共同開発手順

## 環境構築

- 環境構築を楽に行うため、Docker、Docker Composeを使用します。
- dockerをインストールしておいてください。

### リポジトリをクローン

以下コマンドでローカルにリポジトリをクローンします。

`$ git clone -b ブランチ名(develop-neko1) https://github.com/masakichi-eng/NekoPro-Tsubuyaki.git`

### データベースを作成する

`$ docker-compose run web rake db:create`

### ビルド&コンテナ起動

ルートディレクトリで以下のコマンドを実行してビルド&コンテナ起動します。

`$ docker-compose up -d --build`

以下のコマンドで2つのコンテナ(web,db)が起動（Up）しているのを確認できたらOKです。

`$ docker-compose ps`

今後、rails コマンドを使う時には以下のコマンドでコンテナの中に入ってから実行してください。

`$ docker-compose exec web bash`

以上で環境構築は終了です。
