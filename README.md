## Overview

This project facilitates the installation of Docker on remote hosts using Ansible. The setup consists of three virtual machines created with Vagrant, where one serves as the control node and the other two act as worker nodes. Ansible is installed on the control node and uses SSH connections to interact with the worker nodes. The Ansible playbook includes all the necessary modules for Docker installation.

# Prerequisites

Before running the project, ensure the following prerequisites are met:

VirtualBox is installed (preferred provider).
Vagrant is installed.

## INSTRUCTIONS
# Clone project files
Clone the repository into your environment where Vagrant and VirtualBox are already installed.

git clone https://github.com/Alimalin/md-vagrant.git

# Change directory into the cloned repository.

cd md-vagrant

# Run the following command to start the virtual machines:

vagrant up

# Project Structure
Vagrantfile: Defines the configuration for the virtual machines.
ansible-playbook.yml: Ansible playbook containing Docker installation tasks.

# Usage
Clone the repository.
Navigate to the cloned directory.
Run vagrant up to start the virtual machines.
Ansible will use SSH connections to install Docker on the remote hosts.

# Additional Notes
Ensure that SSH keys are properly configured for passwordless authentication.
Modify the inventory file (/etc/ansible/hosts) on the control node to customize the remote host details.

