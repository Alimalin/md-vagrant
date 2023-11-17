#!/bin/bash

# Generate an RSA SSH key pair without a passphrase.
# -q: Quiet mode (no prompts).
# -t rsa: Specifies the type of key to create (RSA).
# -N '': Provides an empty passphrase.
# -f ~/.ssh/id_rsa: Specifies the file name of the key pair.
# <<<y: Answers 'yes' to the key generation prompt.
# >/dev/null 2>&1: Redirects standard output and standard error to /dev/null.
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<< y 

# Update the Package List
apt update

# Install sshpass tool  and git
apt install sshpass git -y 

# Install software-properties-common package 
apt install software-properties-common -y 
 

# Install Ansible
apt install ansible -y 

# Check if /etc/ansible directory exists; create it if not.
if [ ! -d "/etc/ansible" ]; then
    mkdir -p "/etc/ansible"
    echo "Directory created: /etc/ansible"
else
    echo "/etc/ansible directory already exists"
fi

# Check if /etc/ansible/hosts file exists; create it if not.
if [ ! -f "/etc/ansible/hosts" ]; then
    touch /etc/ansible/hosts
    echo "/etc/ansible/hosts file created"
    echo "[servers]" >> /etc/ansible/hosts
    echo "worker1.example.com" >> /etc/ansible/hosts
    echo "worker2.example.com" >> /etc/ansible/hosts
else
    echo "/etc/ansible/hosts already exists"
fi

# Use sshpass to copy the SSH key to worker1 with a 'yes' response.
echo "yes \n" | sshpass -p "miner" ssh-copy-id -i /root/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@worker1

# Use sshpass to copy the SSH key to worker2 with a 'yes' response.
echo "yes \n" | sshpass -p "miner" ssh-copy-id -i /root/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@worker2

# Change directory to /root.
cd /root

# Check if /root/projectmd-vagrant directory exists; clone the repository if not.
if [ ! -d "/root/md-vagrant" ]; then
    git clone https://github.com/Alimalin/md-vagrant.git
else
    echo "Running the playbook"
fi

# Run an Ansible playbook with host key checking disabled.
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook md-vagrant/playbook.yml

