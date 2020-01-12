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
% git clone https://github.com/oiax/phx-vagrant.git
% cd phx-vagrant
% vagrant up
% vagrant ssh
$ bin/setup.sh
```

Building this environment for the first time can take over two hours.

## Creating a new Phoenix Application

```
$ bin/login.sh
> mix phx.new . --app my_app --module MyApp
```

## Changing Database Connection Settings

Open `config/dev.exs` with a text editor and change the value of `hostname` from `"localhost"` to `"db"`.

## Configuration of phoenix_live_reload

Add these lines after the settings of `MyApp.Repo` in `config/dev.exs`.

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
      "lib/my_app_web/templates",
      "lib/my_app_web/views"
    ]
end
```

## Configuration of webpack

Add the following description before `});` at the end of `assets/webpack.config.js`.

```
  watchOptions: {
    aggregateTimeout: 300,
    poll: 1000,
    ignored: /node_modules/
  }
```

Add a comma after `]` of the previous line.

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
