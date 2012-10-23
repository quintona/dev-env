# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  
  ######################################
  #basic settings
  ######################################
  config.vm.box = "ubuntu12"
  config.vm.host_name = "dev-tools"
  #config.vm.network :hostonly, "192.168.33.10"
  config.vm.network :bridged
  #Uncomment the next line if you want the GUI, otherwise use vagrant ssh
  #config.vm.boot_mode = :gui
  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://dl.dropbox.com/u/1537815/precise64.box"

  #shared folders, used to fetch the deployments or other items
  config.vm.share_folder "v-data", "/vagrant_data", "./data"
  
  ######################################
  #host machine/network specific settings!
  ######################################
  #if you are behind a proxy then you need to tell apt about it, add apt.conf to the data directory with the following line:
  #Acquire::http::Proxy "http://user:pass001@host:port/";
  if File.exist?("./data/apt.conf") then
    config.vm.provision :shell, :inline => "cp /vagrant_data/apt.conf /etc/apt/"
  end
  
  
  ######################################
  #Provisioning
  ######################################
  #install java
  config.vm.provision :shell, :path => "scripts/installJdk.sh"
  
  config.vm.provision :shell, :inline => "apt-get install git"
  
  #modify system configurations
  config.vm.customize ["modifyvm", :id,
                       "--name", "Development Tools",
                       "--memory", "1024"]
  
  #setup GIT
  #clone provisioning repo
  #puppet apply
  
  #GitBlit install
  #config.vm.provision :puppet do |puppet|
  #  puppet.manifests_path = "manifests"
  #  puppet.manifest_file = "init.pp"
  #end


  
  #Trac Install, including agilo
  
  #setup backups

 
end
