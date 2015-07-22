#!/bin/bash

# Provision the box.
# Skip if vagrantup_provision is false.

vagrantup_provision="$1"

if [ ! -f /home/vagrant/vagrantup ] ; then

  if [ "$vagrantup_provision" == "false" ] ; then

    # Create vagrantup file.
    touch /home/vagrant/vagrantup

    # Skip provisioning
    skip_provision="true"

    echo "Skipped provisioning on vagrant up."

  fi

fi

if [ ! "$skip_provision" ] ; then

  echo "Provisioning box."
  ANSIBLE_FORCE_COLOR=1 PYTHONUNBUFFERED=1 ansible-playbook /etc/ansible/staging/playbook.yml --sudo -c local -i "127.0.0.1vagrant,"

fi