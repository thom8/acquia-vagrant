#!/bin/bash

# Force update of ansible roles.

echo "Updating ansible roles."
ansible-galaxy install --force -r /etc/ansible/staging/requirements.txt
