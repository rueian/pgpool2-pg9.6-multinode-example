#!/bin/bash
mkdir -p files/ssh
echo -e  'y\n' | ssh-keygen -q -t rsa -N "" -f files/ssh/postgres_id_rsa
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i vagrant.ini main.yml
