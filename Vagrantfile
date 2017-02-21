# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "puppet.example.com"
  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "modules"
  end
end
