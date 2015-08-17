#!/bin/bash

dbName="$1"
siteName="$2"
drupalUser="$3"
drupalPass="$4"

if [ ! -f /home/vagrant/siteinstalled ] ; then

  echo "Starting Drupal installation. This takes a few mins."

  # Tidy up
  sudo chmod 775 /drupal/sites/default/ >/dev/null
  sudo rm -rf /drupal/sites/default/services.yml >/dev/null
  sudo rm -rf /drupal/sites/default/settings.php >/dev/null

  # Install Drupal
  drush --root=/drupal site-install -y -q \
  --db-url="mysql://root:root@localhost:3306/$dbName" \
  --account-name="$drupalUser" \
  --account-pass="$drupalPass" \
  --site-name="$siteName" >/dev/null

  echo "Install complete."

  # Create dbimported file.
  touch /home/vagrant/siteinstalled

fi