# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# the box URL
# centos 6.4
BOX_URL="http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130731.box"

# the root for the sources
SOURCES_ROOT='.'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos-6.4"

  # hostname (it will be used for puppet for doing the right provisioning)  
  config.vm.hostname  = "vagrant-web-devel-01"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = BOX_URL

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".",              "/vagrant", type: "nfs"
  config.vm.synced_folder "vagrant/extras", "/extras",  type: "nfs"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb|
    # Don't boot with headless mode
    # vb.gui = true

    vb.customize [
      "modifyvm", :id,
      "--cpus", "2",
      "--memory", "1024"
    ]
  end

  config.vm.provision :puppet do |puppet|

     puppet.manifests_path  = "vagrant/manifests"
     puppet.manifest_file   = "init.pp"
     puppet.options         = "--verbose --debug"
     puppet.module_path     = "vagrant/modules"

     ## we can specify a HTTP propxy with the "http_proxy" environment variable
     if ENV['http_proxy']
        require 'uri'
        proxy = URI(ENV['http_proxy'])
        puppet.options     += " --http_proxy_host=" + proxy.host
        puppet.options     += " --http_proxy_port=" + proxy.port.to_s 
     end     
  end

end


