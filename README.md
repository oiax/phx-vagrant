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
in the `web` container are automatically synchronized in both directions.
Files created and updated in one directory are created and updated in the other directory almost instantly.

However, there is a delay of a few seconds before files and directories created on **B** are reflected on **A**.

Deletion of files and directories is not automatically synced, but you can sync from **A** to **B** with the following command:

```
$ bin/sync_to_container.sh
```

Think of moving and renaming files and directories as a combination of copying and deleting files and directories. This means that file and directory replicas are automatically synced from **A** to **B**, while file and directory deletions must be synced manually.

Files and directories cannot be deleted in **B**. Even if you try to delete it,
it will be synced immediately from **A**.
