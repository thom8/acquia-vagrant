# Simple Acquia Vagrant Box
A super simple Vagrantfile to setup a vagrant box for your Acquia project.

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

  3. In you Acquia project root run `$ vagrant init 8thom/acquia-php_5.5; vagrant up`

  **-or-**

  `$ vagrant init 8thom/acquia-php_5.4; vagrant up` for **PHP 5.4**

  `$ vagrant init 8thom/acquia-php_5.6; vagrant up` for **PHP 5.6**
