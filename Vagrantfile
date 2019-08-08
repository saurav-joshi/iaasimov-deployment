# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  
  # config.vm.box = "darrelchia/terraform-box" 
  # config.vm.version = "1.0.0"
  config.vm.box = "iaasimov-build"
  config.vm.box_url = "file://E:\\VagrantBoxes\\iaasimov-build.box"

  config.vm.synced_folder "D:\\Projects\\[Project]-Iaasimov\\iaasimov-deployment", "/home/vagrant/workspace/"

  config.vm.network "forwarded_port", guest: 9000, host: 9000, "id": "portainer-port"
  config.vm.network "forwarded_port", guest: 8080, host: 8081, "id": "ibcs"  
  config.vm.network "forwarded_port", guest: 8080, host: 8080, "id": "http2"  
  config.vm.network "forwarded_port", guest: 8000, host: 8000, "id": "http"  
  config.vm.network "forwarded_port", guest: 22, host: 2223, "id": "ssh"

  # You may want to install the vagrant proxyconf plugin.
  # At the command line, type : vagrant plugin install vagrant-proxyconf
  if Vagrant.has_plugin?("vagrant-proxyconf")    
    config.proxy.http = "http://www-proxy-sin.sg.oracle.com:80"
    config.proxy.https = "http://www-proxy-sin.sg.oracle.com:80"
    config.proxy.no_proxy = "oracle.com,oraclecorp.com,localhost"
  end

  config.vm.provider "virtualbox" do |vbox|
    vbox.memory = 4096
    vbox.cpus = 1
    vbox.name = "iaasimov-demo"
  end
end
