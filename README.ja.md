# phx-vagrant

Vagrant を用いて Elixir/Phoenix アプリケーションの開発・学習を始めるための設定ファイル等のセット

## 構築される環境

* Debian 10 (Buster)
* Erlang/OTP 22.1.8
* Elixir 1.9.4
* Phoenix 1.4.11
* Node.js 10.18
* npm 6.13
* PostgreSQL 12 (on Alpine)

## 必要なソフトウェア

* Oracle VM VirtualBox 6.0
* Vagrant 2.2 以上
* Git 2.7 以上

2020年1月12日現在、Vagrant は VirtualBox 6.1 に対応していません。

## 対応OS

* macOS 10.14 Mojave
* Windows 10

## 環境構築手順

```
% git config --global core.autocrlf input
% git clone https://github.com/oiax/phx-vagrant.git
% cd phx-vagrant
% vagrant plugin install vagrant-disksize
% vagrant up
% vagrant ssh
$ bin/setup.sh
```

初めてこの環境を構築する場合、2時間以上かかることがあります。

## Phoenixアプリケーションの新規作成

```
$ bin/login.sh
> mix phx.new my_app
> cd my_app
```

## データベース接続設定の変更

テキストエディタで `config/dev.exs` を開き、`hostname` の値を `"localhost"` から `"db"` に変更してください。

ホストマシンまたはDockerコンテナのテキストエディタを使用して編集できます。

## データベースの作成

```
> mix ecto.create
```

## サーバーの起動

```
> exit
$ bin/start.sh
> cd my_app
> mix phx.server
```

ホストマシンのブラウザで `http://localhost:4000` を開いてください。

ターミナル上で `Ctrl-C` を入力すればサーバーを停止できます。

## Dockerコンテナ内での作業

```
$ bin/login.sh
> cd my_app
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

## ソースコードの同期について

ホストPCの `projects` ディレクトリと `web` コンテナ内の `/projects` ディレクトリは双方向に同期されています。一方のディレクトリ内で作成または更新されたファイルやディレクトリは、短時間のうちに他方のディレクトリでも作成または更新されます。

ただし、ファイルおよびディレクトリの削除は同期されません。また、ファイルやディレクトリの移動または名前変更が行われた場合、元のパスにファイルやパスが残ります。手動で削除してください。
