# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  
  ######################################
  #basic settings
  ######################################
  use_proxy="true"
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
  config.vm.share_folder "v-data", "/vagrant_data", "./data", :owner => "root", :transient => false
  
  #modify system configurations
  config.vm.customize ["modifyvm", :id,
                       "--name", "Development Tools",
                       "--memory", "1024"]
  
  ######################################
  #host machine/network specific settings!
  ######################################
  #if you are behind a proxy then you need to tell apt, git about it and set the environment variables
  #Acquire::http::Proxy "http://user:pass001@host:port/";
  if File.exist?("./data/apt.conf") && (use_proxy=="true") then
    config.vm.provision :shell, :inline => "cp /vagrant_data/apt.conf /etc/apt/"
  end
  if File.exist?("./data/.gitconfig") && (use_proxy=="true") then
    config.vm.provision :shell, :inline => "cp /vagrant_data/.gitconfig /home/vagrant/"
  end
  if File.exist?("./scripts/exportProxy.sh") && (use_proxy=="true") then
    config.vm.provision :shell, :path => "scripts/exportProxy.sh"
  end
  
  
  ######################################
  #Provisioning
  ######################################
  #you must have downloaded java first!
  if File.exist?("./data/jdk-6u35-linux-x64.bin") then
  	config.vm.provision :shell, :path => "scripts/installJdk.sh"
  	
  	#make sure we update the package cache!
  	config.vm.provision :shell, :inline => "apt-get update"
  
  	#don't download unless we have to
  	if File.exist?("./data/agilo_source.tar.gz") then
    	config.vm.provision :shell, :inline => "cp /vagrant_data/agilo_source.tar.gz /var/tmp"
  	end
  	#don't download unless we have to
  	if File.exist?("./data/gitblit-1.1.0.zip") then
    	config.vm.provision :shell, :inline => "cp /vagrant_data/gitblit-1.1.0.zip /var/tmp"
  	end
  	#get git installed and the repo cloned
  	config.vm.provision :puppet do |puppet|
    	puppet.manifests_path = "manifests"
    	puppet.manifest_file = "provisioningInit.pp"
  	end
  	#do the rest of the provisioning (apply basically)
  	config.vm.provision :shell, :path => "scripts/initProvisioning.sh"
  	
  	#the folder that will hold all the git repos, important!
  	config.vm.share_folder "git-repos", "/media/git", "./repos", :owner => "gitblit", :transient => false
  end

 
end
