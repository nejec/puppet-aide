# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.box_check_update = true
  config.vm.hostname = "puppet.example.com"
  config.vm.provision :shell, :inline => "rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm"
  config.vm.provision :shell, :inline => "yum -y update"
  config.vm.provision :shell, :inline => "yum -y install puppet git"
  config.vm.provision :shell, :inline => "sed -i -e 's#\(secure_path = .*\)$#\1:/opt/puppetlabs/bin#' /etc/sudoers"
  config.vm.provision :shell, :inline => "puppet module install puppetlabs-concat"
  config.vm.provision :shell, :inline => "puppet module install puppetlabs-stdlib"
  config.vm.synced_folder "/home/luke/repos/puppet-modules/puppet-aide", "/etc/puppetlabs/code/environments/production/modules/aide", type: "sshfs"
end
