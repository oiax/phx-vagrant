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

## 動作確認済みのOS

* macOS 10.14 Mojave
* Ubuntu 16.04
* Ubuntu 18.04

## 環境構築手順

```
% vagrant up
% vagrant ssh
$ bin/setup.sh
```

## Phoenixアプリケーションの新規作成

```
$ bin/login.sh
> mix phx.new . --module MyApp
```

## データベース接続設定の変更

テキストエディタで `config/dev.exs` を開き、`hostname` の値を `"localhost"` から `"db"` に変更する。

## データベースの作成

```
> mix ecto.create
```

## サーバーの起動

```
> exit
$ bin/start.sh
```

`Ctrl-C` を入力すればサーバーを停止できる。

## `mix` コマンド等の実行

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
