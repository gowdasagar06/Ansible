#!/bin/bash
# Add ansible user if not exists
sudo useradd -m -s /bin/bash -G `whoami` ansible 2>/dev/null || true

# Set ansible user password
echo "ansible:${ansible_user_password}" | sudo chpasswd

# Add ansible user to sudoers file
echo "ansible   ALL=(ALL)    NOPASSWD:ALL" | sudo tee -a /etc/sudoers > /dev/null

# Copy authorized_keys file to ansible user's .ssh directory
sudo mkdir -p /home/ansible/.ssh
sudo cp /home/ec2-user/.ssh/authorized_keys /home/ansible/.ssh/
sudo chmod 700 /home/ansible/.ssh
sudo chmod 600 /home/ansible/.ssh/*
sudo chown -R ansible:ansible /home/ansible/.ssh

# Restart SSH service
sudo systemctl restart sshd
