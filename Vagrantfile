# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  require 'yaml'
  if !File.exist?('./config.yml')

    # set default config.
    vconfig['vagrant_hostname'] = local.cloudvm.com
    vconfig['vagrant_ip'] = 192.168.4.40
    vconfig['vagrant_memory'] = 1024
    vconfig['vagrant_cpus'] = 2

    # PHP version.
    #vconfig['vagrant_box'] = "8thom/acquia-php_5.3"
    #vconfig['vagrant_box'] = "8thom/acquia-php_5.5"
    vconfig['vagrant_box'] = "8thom/acquia-php_5.6"

    # Synced folders.
    config.vm.synced_folder "docroot", "/drupal",
      type: "nfs",
      id: "drupal"

  else

    # load config.yml
    vconfig = YAML::load_file("./config.yml")

    for synced_folder in vconfig['vagrant_synced_folders'];
      config.vm.synced_folder synced_folder['local_path'], synced_folder['destination'],
        type: synced_folder['type'],
        rsync__auto: "true",
        rsync__exclude: synced_folder['excluded_paths'],
        rsync__args: ["--verbose", "--archive", "--delete", "-z", "--chmod=ugo=rwX"],
        id: synced_folder['id']
    end
  end

  config.vm.hostname = vconfig['vagrant_hostname']
  config.vm.network :private_network, ip: vconfig['vagrant_ip']
  config.ssh.insert_key = false
  config.ssh.forward_agent = true

  config.vm.box = vconfig['vagrant_box']

  # Provision box
  config.vm.provision "ansible", type: "shell" do |s|
     s.privileged = true
     s.inline = "/bin/bash /home/vagrant/provision.sh"
  end

  # VirtualBox.
  config.vm.provider :virtualbox do |v|
    v.name = vconfig['vagrant_hostname']
    v.memory = vconfig['vagrant_memory']
    v.cpus = vconfig['vagrant_cpus']
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  # Set the name of the VM. See: http://stackoverflow.com/a/17864388/100134
  config.vm.define :cloudvm do |cloudvm_config|
  end

end
