# phx-vagrant

Vagrant を用いて Elixir/Phoenix アプリケーションの開発・学習を始めるための設定ファイル等のセット

## 構築される環境

* Debian 10 (Buster)
* Erlang/OTP 22.1.8
* Elixir 1.9.4
* Phoenix 1.4.11
* Node.js 10.18
* npm 6.13

## 必要なソフトウェア

* Oracle VM VirtualBox 6.1 以上
* Vagrant 2.2 以上
* Git 2.7 以上

## 対応OS

* macOS 10.14 Mojave

## 環境構築手順

```
% git clone https://github.com/oiax/phx-vagrant.git
% cd phx-vagrant
% vagrant up
% vagrant ssh
$ bin/setup.sh
```

初めてこの環境を構築する場合、2時間以上かかることがあります。

## Phoenixアプリケーションの新規作成

```
$ bin/login.sh
> mix phx.new . --module MyApp
```

## データベース接続設定の変更

テキストエディタで `config/dev.exs` を開き、`hostname` の値を `"localhost"` から `"db"` に変更してください。

## phoenix_live_reload の設定

以下の記述を `config/dev.exs` の `MyApp.Endpoint` に関する設定の前に追加してください。

```
if System.get_env("COMPOSE_FILE") == "docker-compose.vagrant.yml" do
  config :phoenix_live_reload,
    backend: :fs_poll,
    backend_opts: [
      interval: 500
    ],
    dirs: [
      "priv/static",
      "priv/gettext",
      "lib/my_app_web/live",
      "lib/my_app_web/templates",
      "lib/my_app_web/views"
    ]
end
```

## webpack の設定

`assets/webpack.config.js` の末尾の `});` の前に以下の記述を追加してください。

```
  watchOptions: {
    aggregateTimeout: 300,
    poll: 1000,
    ignored: /node_modules/
  }
```

直前の `]` の後にコンマがなければ、追加してください。

## データベースの作成

```
> mix ecto.create
```

## サーバーの起動

```
> exit
$ bin/start.sh
```

`Ctrl-C` を入力すればサーバーを停止できます。

## Dockerコンテナ内での作業

```
$ bin/login.sh
> mix phx.gen.schema Blog.Post blog_posts title:string
> exit
```

## Dockerコンテナの停止

```
$ bin/stop.sh
```

## VirtualBoxゲストマシンの停止

```
$ exit
% vagrant halt
```
