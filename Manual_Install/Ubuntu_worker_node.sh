#Switch to root user and execute this shell script
#!/bin/bash

# Check if the ansible user already exists
if ! id "ansible" &>/dev/null; then
    # If the user doesn't exist, create it
    sudo useradd -m ansible
    echo 'ansible:1234' | sudo chpasswd
fi

# Add ansible user to sudoers file
sudo echo "ansible   ALL=(ALL)    NOPASSWD:ALL" >> /etc/sudoers

# Create .ssh directory if it doesn't exist
if [ ! -d "/home/ansible/.ssh" ]; then
    sudo mkdir /home/ansible/.ssh
fi

# Set permissions for .ssh directory
sudo chmod 700 /home/ansible/.ssh

# Copy authorized_keys file if it exists
if [ -f "/home/ubuntu/.ssh/authorized_keys" ]; then
    sudo cp /home/ubuntu/.ssh/authorized_keys /home/ansible/.ssh/
fi

# Set permissions for authorized_keys file
sudo chmod 600 /home/ansible/.ssh/*

# Set ownership for .ssh directory
sudo chown -R ansible:ansible /home/ansible/.ssh

# Restart SSH service
sudo systemctl restart sshd
