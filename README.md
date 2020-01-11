# phx-vagrant

A set of configuration files etc. to start developing and learning Elixir/Phoenix application using Vagrant

[README.ja.md](README.ja.md)

## Environment to be built

* Debian 10 (Buster)
* Erlang/OTP 22.1.8
* Elixir 1.9.4
* Phoenix 1.4.11
* Node.js 10.18
* npm 6.13

## Required softwares

* Oracle VM VirtualBox 6.1 or above
* Vagrant 2.2 or above
* Git 2.7 or above

## Supported OS

* macOS 10.14 Mojave

## Environment Building Procedure

```
% vagrant up
% vagrant ssh
$ bin/setup.sh
```

Building this environment for the first time can take over two hours.

## Creating a new Phoenix Application

```
$ bin/login.sh
> mix phx.new . --module MyApp
```

## Changing Database Connection Settings

Open `config/dev.exs` with a text editor and change the value of `hostname` from `"localhost"` to `"db"`.

## Creating a Database

```
> mix ecto.create
```

## Starting the Server

```
> exit
$ bin/start.sh
```

You can stop the server by typing `Ctrl-C`.

## Working in the Docker Container

```
$ bin/login.sh
> mix phx.gen.schema Blog.Post blog_posts title:string
> exit
```

## Stopping the Docker Container

```
$ bin/stop.sh
```

## Stopping the VirtualBox Guest Machine

```
$ exit
% vagrant halt
```
