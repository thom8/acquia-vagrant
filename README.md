# Simple Acquia Vagrant Box
A super simple Vagrantfile to setup a vagrant box for your [Acquia](https://www.acquia.com/) project.

**NOTE:** You only need to download the project files if you want to customise the configuration.

## Usage

  1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) & [Vagrant](https://www.vagrantup.com/downloads.html)

  2. Add the following to your settings.php file:

  ```
  /**
   * Include vagrant settings.
   */
  $vagrant_settings = '/home/vagrant/vagrant.settings.php';
  if (file_exists($vagrant_settings)) {
    include $vagrant_settings;
  }
  ```

  **IMPORTANT:** You must add these lines to settings.php after the
  $databases. Normally, you add these lines to the end of your
  settings.php file.

  3. In your Acquia project root run `$ vagrant init 8thom/acquia-php_5.5; vagrant up`

  **-or-**

  `$ vagrant init 8thom/acquia-php_5.6; vagrant up` for **PHP 5.6**

  All available boxes -- [https://atlas.hashicorp.com/boxes/search?q=8thom](https://atlas.hashicorp.com/boxes/search?q=8thom)

Default configuration can be found in [config.yml](https://github.com/thom8/acquia-vagrant/blob/master/config.yml)

## Thanks

This would not be possible without [geerlingguy's](https://github.com/geerlingguy) awesome project [Acquia Cloud VM](https://github.com/geerlingguy/acquia-cloud-vm).

If you like this I encourage you to support him by buying his book [Ansible for DevOps](http://ansiblefordevops.com/).

## Customi(s|z)ation

Copy [config.yml](https://raw.githubusercontent.com/thom8/acquia-vagrant/master/config.yml) to your Acquia project root.

`$ wget https://raw.githubusercontent.com/thom8/acquia-vagrant/master/config.yml`

If you modify any config used by Ansible provisioning you may also want to update "vagrantup_provision" to true so these modifications are applied during vagrant up.

As the base boxes are a preprovisioned version of [Acquia Cloud VM](https://github.com/geerlingguy/acquia-cloud-vm) customisation is the same.
Please follow instructions on the project page [https://github.com/geerlingguy/acquia-cloud-vm](https://github.com/geerlingguy/acquia-cloud-vm)
There are only a few minor differences which I'll detail below.

## Database importing

A database import can be configured to run on vagrant up.

### File import

Update config.yml to include --

```
db_import_type: file
db_import_source: [path to sql dump]
```

The path is relative to the Acquia project root.

### drush sql-sync

  **Requires**
  - [Setting up SSH agent forwarding](https://developer.github.com/guides/using-ssh-agent-forwarding/#setting-up-ssh-agent-forwarding)
  - Adding drush aliases to your project

  1. Update ~/.ssh/config to include the following.

  ```
  Host 127.0.0.1
    ForwardAgent          yes
  ```

  *Run `ssh-add -L` inside the vagrant box to test.

  2. Add your Acquia drush aliases to your project.

  Download your aliases -- https://docs.acquia.com/cloud/drush-aliases
  Copy `[site].aliases.drushrc.php` to docroot/sites/all/drush/

  3. Update config.yml to include --

  ```
  db_import_type: sql-sync
  db_import_source: [site].[env]
  ```

## hosts file configuration (DNS)

**Requires**
- [Vagrant Host Manager](https://github.com/smdahlen/vagrant-hostmanager) plugin.
- custom config.yml file

Installation

`$ vagrant plugin install vagrant-hostmanager`

Copy [Vagrantfile](https://raw.githubusercontent.com/thom8/acquia-vagrant/master/Vagrantfile) to your Acquia project root.

`$ wget https://raw.githubusercontent.com/thom8/acquia-vagrant/master/Vagrantfile`

The hostname & vhost servername settings in config.yml will be automatically added to `/etc/hosts` of the host machine.

## What's an Acquia project root?

This the the top level directory of an [Acquia](https://www.acquia.com/) project which contains the docroot directory.
