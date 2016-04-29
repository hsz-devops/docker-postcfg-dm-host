#!/bin/bash

# based on:
# - https://github.com/nathanleclaire/dockerfiles/tree/master/ansible

# abort on error
set -e

if [[ ! -d /hostssh ]]; then
    echo "Must mount the host SSH directory at /hostssh, e.g. 'docker run --net host -v /root/.ssh:/hostssh nathanleclaire/ansible"
    exit 1
fi

# Generate temporary SSH key to allow access to the host machine.
mkdir -p /root/.ssh
ssh-keygen -f /root/.ssh/id_rsa -P ""

# backup the host's authorized key and write our own (ideally we should add our own instead... someday maybe...)
cp /hostssh/authorized_keys /hostssh/authorized_keys.bak
cat /root/.ssh/id_rsa.pub >>/hostssh/authorized_keys

# since we are running in the hosts networking stack (!!!) localhost is the host (!!!)
ansible all -i "localhost," -m raw -a "apt-get install -y python-minimal"
ansible-playbook -i "localhost," "$@"

mv /hostssh/authorized_keys.bak /hostssh/authorized_keys
