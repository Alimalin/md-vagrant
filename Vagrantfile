
# Set an environment variable to disable parallel execution of Vagrant commands.
ENV['VAGRANT_NO_PARALLEL'] = 'yes'

# Define constants for Vagrant box and node configurations.
VAGRANT_BOX         = "debian-sandbox/bookworm64"
CPUS_CONTROL_NODE   = 1
CPUS_WORKER_NODE    = 1
MEMORY_CONTROL_NODE = 1024
MEMORY_WORKER_NODE  = 1024
WORKER_NODES_COUNT  = 2

# Configure Vagrant with version 2.
Vagrant.configure(2) do |config|

  # Provision the VMs with a shell script (bootstrap.sh).
  config.vm.provision "shell", path: "bootstrap.sh"

  # Iterate over the number of worker nodes specified by WORKER_NODES_COUNT.
  (1..WORKER_NODES_COUNT).each do |i|

    # Define configurations for each worker node.
    config.vm.define "worker#{i}" do |node|
      
      # Set the Vagrant box, disable box update checks, and set the hostname.
      node.vm.box               = VAGRANT_BOX
      node.vm.box_check_update  = false
      node.vm.hostname          = "worker#{i}.node.com"

      # Configure a private network with a specific IP address for each worker node.
      node.vm.network "private_network", ip: "172.20.20.10#{i}"

      # Provider-specific configurations for VirtualBox.
      node.vm.provider :virtualbox do |v|
        v.name    = "worker#{i}"
        v.memory  = MEMORY_WORKER_NODE
        v.cpus    = CPUS_WORKER_NODE
      end

      # Provider-specific configurations for Libvirt.
      node.vm.provider :libvirt do |v|
        v.memory  = MEMORY_WORKER_NODE
        v.nested  = true
        v.cpus    = CPUS_WORKER_NODE
      end

      # Provision worker nodes with a shell script (bootstrap_kworker.sh) if needed.
      # node.vm.provision "shell", path: "bootstrap_kworker.sh"

    end
  end

  # Define configurations for the control node.
  config.vm.define "control-node" do |node|
  
    # Set the Vagrant box, disable box update checks, and set the hostname.
    node.vm.box               = VAGRANT_BOX
    node.vm.box_check_update  = false
    node.vm.hostname          = "control.node.com"

    # Configure a private network with a specific IP address for the control node.
    node.vm.network "private_network", ip: "172.20.20.100"
  
    # Provider-specific configurations for VirtualBox.
    node.vm.provider :virtualbox do |v|
      v.name    = "control-node"
      v.memory  = MEMORY_CONTROL_NODE
      v.cpus    = CPUS_CONTROL_NODE
    end
  
    # Provider-specific configurations for Libvirt.
    node.vm.provider :libvirt do |v|
      v.memory  = MEMORY_CONTROL_NODE
      v.nested  = true
      v.cpus    = CPUS_CONTROL_NODE
    end
  
    # Provision the control node with a shell script (control.sh).
    node.vm.provision "shell", path: "control.sh"

    # Additional provisioning options (e.g., file sync, Ansible playbook execution) can be uncommented here.

  end

end
