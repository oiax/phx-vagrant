# phx-vagrant

Vagrant を用いて Elixir/Phoenix アプリケーションの開発・学習を始めるための設定ファイル等のセット

## 構築される環境

* Debian 10 (Buster)
* Erlang/OTP 22.2.4
* Elixir 1.10.0
* Phoenix 1.4.12
* Node.js 10.18
* npm 6.13
* PostgreSQL 12 (on Alpine)

## 必要なソフトウェア

* Oracle VM VirtualBox 6.0/6.1
* Vagrant 2.2 以上
* Git 2.7 以上

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
> exit
```

## データベース接続設定の変更

ホストマシンのテキストエディタで `projects/my_app/config/dev.exs` を開き、`hostname` の値を `"localhost"` から `"db"` に変更してください。

## データベースの作成

```
$ bin/login.sh
> cd my_app
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

## ソースツリーの同期について

ホストPCの `projects` ディレクトリ（以下、**A** と呼ぶ）と `web` コンテナ内の `/projects` ディレクトリ（以下、**B** と呼ぶ）は双方向に自動で同期されています。一方のディレクトリ内で作成・更新されたファイルは、ほぼ瞬時に他方のディレクトリで作成・更新されます。

ただし、B で作成されたファイルおよびディレクトリが A に反映されるまでには、数秒の遅れが生じます。

ファイルおよびディレクトリの削除は自動で同期されませんが、次のコマンドにより **A** から **B** へ同期できます。

```
$ bin/sync_to_container.sh
```

ファイルおよびディレクトリの移動（名前変更）は、ファイルおよびディレクトリの複製と削除の組み合わせであると考えてください。つまり、ファイルおよびディレクトリの複製は **A** から **B** へ自動で同期されますが、ファイルおよびディレクトリの削除は手動で同期する必要があります。

なお、**B** の中でファイルおよびディレクトリを削除することはできません。仮に削除しようとしても、すぐに **A** から同期されてしまいます。
