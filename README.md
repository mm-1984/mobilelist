# Mobile List

スマートフォン端末のレビュー・お気に入り管理アプリ。

- Ruby ~> 3.0 / Rails ~> 7.0
- PostgreSQL
- 画像アップロード: CarrierWave + Cloudinary（本番）
- 開発は GitHub Codespaces、デプロイは Render を想定

## 開発環境 (GitHub Codespaces)

このリポジトリを Codespaces で開く（無料枠の 2-core マシンで動作）と、
`.devcontainer` が Ruby + PostgreSQL のコンテナを自動で立ち上げます。

```bash
bin/rails db:prepare
bin/rails server
```

ローカル(Mac/Linuxに直接PostgreSQLがある場合)でも同様です。

```bash
bundle install
bin/rails db:create db:migrate
bin/rails server
```

## デプロイ (Render)

`render.yaml` に Web サービス（Docker/`Dockerfile`）と PostgreSQL(無料プラン)を定義しています。
Render の Blueprint からこのリポジトリを指定するとまとめて作成されます。

デプロイ前に、以下の環境変数を Render 側で設定してください。

- `RAILS_MASTER_KEY` … `config/master.key` の内容（このファイル自体はコミットしません）
- `CLOUDINARY_URL` … Cloudinary の管理画面から取得できる接続URL
- `DATABASE_URL` … Render の PostgreSQL を接続すると自動で設定されます

Render の無料プランはディスクが永続化されないため、アップロード画像は Cloudinary 側に保存する構成にしています。
