# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network :forwarded_port, guest: 4000, host: 4000
  config.disksize.size = "16GB"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = "4096"
  end

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    sudo apt-get update

    if [[ ! -f "/usr/bin/docker" ]]; then
      /vagrant/bin/install_docker_on_ubuntu.sh
      sudo usermod -aG docker vagrant
    fi

    if ! grep -q "fs.inotify.max_user_watches" /etc/sysctl.conf ; then
      echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
      sudo sysctl -p
    fi

    if ! grep -q "COMPOSE_FILE" ~/.bashrc ; then
      echo "export COMPOSE_FILE=docker-compose.vagrant.yml" >> ~/.bashrc
      echo "cd /vagrant" >> ~/.bashrc
    fi

    dirs=(_build deps log assets/node_modules)

    for dir in "${dirs[@]}" ; do
      mkdir -p /home/vagrant/${dir}
    done
  SHELL
end
