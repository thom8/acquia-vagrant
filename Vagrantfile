# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  require 'yaml'
  if !File.exist?('./config.yml')
    raise 'Configuration file not found! Please copy config.yml to your Acquia project root. - https://raw.githubusercontent.com/thom8/acquia-Vagrantfile/master/config.yml'
  end

  # load config.yml
  vconfig = YAML::load_file("./config.yml")

  config.vm.box = vconfig['vagrant_box']

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
      config.hostmanager.aliases = aliases
    end

  end

end

# Load Vagrantfile.local
# If you make a 'Vagrantfile.local' you can over-ride anything in this file.
include_vagrantfile = 'Vagrantfile.local'
load include_vagrantfile if File.exist?(include_vagrantfile)
