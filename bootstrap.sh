# Add entries to the /etc/hosts file to map IP addresses to hostnames.
echo "172.20.20.100 control.node.com control" >> /etc/hosts

# Add entry for the first worker node.
echo "172.20.20.101 worker1.example.com worker1" >> /etc/hosts

# Add entry for the second worker node.
echo "172.20.20.102 worker2.example.com worker2" >> /etc/hosts

# Use 'chpasswd' to change the password of the 'root' user to 'miner'.
echo "root:miner" | chpasswd

#PermitRootLogin prohibit-password
#PubkeyAuthentication yes
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

systemctl restart sshd 
