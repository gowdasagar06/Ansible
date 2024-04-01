#!/bin/bash
sudo useradd -m -s /bin/bash -G `whoami` ansible
sudo echo "${ansible_user_password}" | sudo passwd --stdin ansible
sudo echo "ansible   ALL=(ALL)    NOPASSWD:ALL" >> /etc/sudoers
sudo mkdir /home/ansible/.ssh
#sudo chown -R ansible:ansible /home/ansible/.ssh
sudo chmod 700 /home/ansible/.ssh
sudo cp /home/ec2-user/.ssh/authorized_keys /home/ansible/.ssh/
sudo chmod 600 /home/ansible/.ssh/*
sudo chown -R ansible:ansible /home/ansible/.ssh
sudo systemctl restart sshd
