# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network :forwarded_port, guest: 4000, host: 4000
  config.disksize.size = '16GB'
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "apps", "/home/vagrant/phx-compose/apps", type: "rsync",
    rsync__exclude: [
      "node_modules/",
    ]

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = "4096"
  end

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    sudo apt-get update

    if [ ! -d "/home/vagrant/phx-compose" ]; then
      git clone https://github.com/oiax/phx-compose.git
      cd phx-compose
      bin/install_docker_on_ubuntu.sh
      sudo usermod -aG docker vagrant
    fi

    if ! grep -q "cd /home/vagrant/phx-compose" ~/.bashrc ; then
      echo "cd /home/vagrant/phx-compose" >> ~/.bashrc
    fi
  SHELL
end
