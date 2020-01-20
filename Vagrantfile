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
    export ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
    export DEBIAN_FRONTEND=noninteractive

    sudo apt-get update
    sudo apt-get upgrade -yq

    if [[ ! -f "/usr/bin/docker" ]]; then
      /vagrant/bin/install_docker_on_ubuntu.sh
      sudo usermod -aG docker vagrant
    fi

    if [[ ! -f "/usr/bin/inotifywatch" ]]; then
      sudo apt-get install -y inotify-tools
    fi

    if ! grep -q "fs.inotify.max_user_watches" /etc/sysctl.conf ; then
      echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
      sudo sysctl -p
    fi

    if [[ ! -d "/work" ]]; then
      sudo mkdir /work
      sudo chown vagrant:vagrant /work
      rsync -a /vagrant/ /work/
    fi

    if ! grep -q "COMPOSE_FILE" ~/.bashrc ; then
      echo "export COMPOSE_FILE=docker-compose.vagrant.yml" >> ~/.bashrc
      echo "cd /work" >> ~/.bashrc
    fi

    if [ ! -f "/etc/systemd/system/sync_vagrant_and_work_dirs.service" ]; then
      sudo cp /vagrant/etc/sync_vagrant_and_work_dirs.service /etc/systemd/system/
      sudo systemctl -q enable sync_vagrant_and_work_dirs
      sudo systemctl -q start sync_vagrant_and_work_dirs
    fi

    if [ ! -f "/etc/systemd/system/sync_new_files_on_work_dir.service" ]; then
      sudo cp /vagrant/etc/sync_new_files_on_work_dir.service /etc/systemd/system/
      sudo systemctl -q enable sync_new_files_on_work_dir
      sudo systemctl -q start sync_new_files_on_work_dir
    fi
  SHELL
end
