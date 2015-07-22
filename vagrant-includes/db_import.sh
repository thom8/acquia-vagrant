#!/bin/bash

# Import database during initial vagrant up.

import_type="$1"
source="$2"

if [ ! -f /home/vagrant/dbimported ] ; then

    if [ "$import_type" == "file" ] ; then

        echo "Importing database file - $source"
        drush --root=/drupal sql-cli < /home/vagrant/db.sql

        echo "Database import complete."

    elif [ "$import_type" == "sql-sync" ] ; then

        echo "Syncing database from $source"

        mkdir -p "/mnt/tmp/$source/"
        drush --root=/drupal sql-sync @$source @self --no-cache --dump-dir="/mnt/tmp/$source" -y >/dev/null

        echo "Database import complete."

    else

    echo "No $import_type import type found."

    fi

    # Create dbimported file.
    touch /home/vagrant/dbimported

fi