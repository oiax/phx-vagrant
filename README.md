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
* PostgreSQL 12 (on Alpine)

## Required softwares

* Oracle VM VirtualBox 6.0
* Vagrant 2.2 or above
* Git 2.7 or above

As of January 12, 2020, Vagrant does not support VirtualBox 6.1.

## Supported OS

* macOS 10.14 Mojave
* Windows 10

## Environment Building Procedure

```
% git config --global core.autocrlf input
% git clone https://github.com/oiax/phx-vagrant.git
% cd phx-vagrant
% vagrant plugin install vagrant-disksize
% vagrant up
% vagrant ssh
$ bin/setup.sh
```

Building this environment for the first time can take over two hours.

## Creating a new Phoenix Application

```
$ bin/login.sh
> mix phx.new my_app
> cd my_app
```

## Changing Database Connection Settings

Open `config/dev.exs` with a text editor and change the value of `hostname` from `"localhost"` to `"db"`.

You can use a text editor on the host machine or on the Docker container to edit it.

## Creating a Database

```
> mix ecto.create
```

## Starting the Phoenix Server

```
> exit
$ bin/start.sh
> cd my_app
> mix phx.server
```

Open `http://localhost:4000` with your browser on the host machine.

You can stop the server by typing `Ctrl-C` on the terminal.

## Working in the Docker Container

```
$ bin/login.sh
> cd my_app
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

## About source code synchronization

The `projects` directory (**A**) on the host PC and the `/projects` directory (**B**)
in the `web` container are synchronized in both directions.
A file updated in one directory is quickly updated in the other directory.

However, synchronization of newly created files and directories is a one-way from
**A** to **B**. Also, file and directory deletions are not synchronized in either
direction. If a file or directory is moved or renamed on one side, the file or
directory remains on the original path on the other side.

If you want to create, delete, or rename files and directories in **B** and sync them to **A**, run the following command on the guest machine (Ubuntu)

```
$ bin/sync_from_container.sh
```

If you want to delete and rename files and directories in **A** and sync them to
**B**, execute the following command on the guest machine (Ubuntu).

```
$ bin/sync_to_container.sh
``
