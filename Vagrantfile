# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "centos/7"
  config.vm.hostname = "tsdb"
  
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3000, host: 3000, protocol: "tcp", id: "grafana"
  config.vm.network "forwarded_port", guest: 8086, host: 8086, protocol: "tcp", id: "influxdb"
  config.vm.network "forwarded_port", guest: 9100, host: 9100, protocol: "udp", id: "kapacitor"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
	
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
     # Customize the amount of memory on the VM:
     vb.memory = "2048"
   end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision :shell, path: "install_kafka.sh"
   config.vm.provision "shell", inline: <<-SHELL
      sudo yum makecache
      sudo yum install java-1.8.0-openjdk -y
	  sudo yum install epel-release -y
      sudo yum install wget -y
	  sudo yum install python -y
	  sudo yum install git -y
	  sudo yum install net-tools -y
	  sudo yum install vim-enhanced -y

	  echo "Installing pip"
	  [[ ! -f get-pip.py ]] && sudo wget --progress=bar:force https://bootstrap.pypa.io/get-pip.py
	  python get-pip.py
          echo "Installing influxdb python API"
          pip install influxdb
          echo "Installing python lib pyymal"
          pip install pyyaml
	  echo "Cloning data generator (contains conf snippets for kapacitor)"
	  [[ ! -d influxdb-sampledata ]] && git clone "https://github.com/phlenoir/influxdb-sampledata.git"
	  sudo chown -R vagrant:vagrant influxdb-sampledata
	  
	  echo "Installing influxdb"
	  [[ ! -f influxdb-1.3.2.x86_64.rpm ]] && wget --progress=bar:force https://dl.influxdata.com/influxdb/releases/influxdb-1.3.2.x86_64.rpm
      sudo yum localinstall influxdb-1.3.2.x86_64.rpm -y
      sudo systemctl restart influxdb
	  
	  echo "Installing kapacitor"
      [[ ! -f kapacitor-1.3.1.x86_64.rpm ]] && wget --progress=bar:force https://dl.influxdata.com/kapacitor/releases/kapacitor-1.3.1.x86_64.rpm
      sudo yum localinstall kapacitor-1.3.1.x86_64.rpm -y
	  [[ -f influxdb-sampledata/kapacitor/conf/kapacitor_conf_snippet ]] && echo "Enabling udp listener in kapacitor.conf" && sudo cat "influxdb-sampledata/kapacitor/conf/kapacitor_conf_snippet" >> /etc/kapacitor/kapacitor.conf
      sudo systemctl start kapacitor
	  
	  echo "Installing grafana"
	  [[ ! -f grafana-4.3.1-1.x86_64.rpm ]] &&  wget --progress=bar:force https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-4.3.1-1.x86_64.rpm 
      sudo yum localinstall grafana-4.3.1-1.x86_64.rpm -y
      sudo systemctl start grafana-server
      echo "You may have to change Grafana http port to match virtualbox forwarded port (e.g. 3000)"
      echo "Do --> sudo vi /etc/grafana/grafana.ini"
      echo "Do --> sudo systemctl restart grafana-server"
	  
	  
      echo "Installation complete!"
   SHELL
end
