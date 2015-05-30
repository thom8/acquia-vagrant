# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # Uncomment one of the following boxes.
  #config.vm.box = "8thom/acquia-php_5.3"
  #config.vm.box = "8thom/acquia-php_5.5"
  #config.vm.box = "8thom/acquia-php_5.6"

  require 'yaml'
  if File.exist?('./config.yml')

    # load config.yml
    vconfig = YAML::load_file("./config.yml")

    if Vagrant.has_plugin?('vagrant-hostmanager')

      aliases = Array.new()
      vconfig['apache_vhosts'].each do |vhost|
        aliases.push(vhost['servername'])
      end

      aliases.delete_if { |x| x == vconfig['vagrant_hostname'] }

      if aliases.any?
        config.hostmanager.enabled = true
        config.hostmanager.manage_host = true
        config.hostmanager.ignore_private_ip = false
        config.hostmanager.include_offline = true
        config.vm.define 'cloudvm' do |node|
          node.vm.hostname = vconfig['vagrant_hostname']
          node.vm.network :private_network, ip: vconfig['vagrant_ip']
          node.hostmanager.aliases = aliases
        end

      end

    end

  end

end

# Load Vagrantfile.local
# If you make a 'Vagrantfile.local' you can over-ride anything in this file.
include_vagrantfile = 'Vagrantfile.local'
load include_vagrantfile if File.exist?(include_vagrantfile)
