# #!/bin/bash
# sudo yum install -y ansible
# sudo useradd -m -s /bin/bash -G $(whoami) ansible
# sudo echo "${ansible_user_password }" | sudo passwd --stdin ansible
# sudo echo "ansible   ALL=(ALL)    NOPASSWD:ALL" >> /etc/sudoers
# sudo cp /home/ec2-user/my-key.pem /home/ansible/
# sleep 5
# sudo chown -R ansible:ansible /home/ansible/my-key.pem
# sudo chmod 400 /home/ansible/my-key.pem
# sudo -u "ansible" ssh-keygen -f /home/ansible/.ssh/id_rsa -N "" 
# sleep 5
# sudo cp /home/ec2-user/host-ips /home/ansible/host-ips
# sudo -u ansible bash << EOF
# while IFS= read -r ip_address; do
#     echo "Copying SSH key to $ip_address"
#     ssh-copy-id -f '-o IdentityFile /home/ansible/my-key.pem' ansible@${ip_address}
# done < /home/ansible/host-ips
# EOF


#!/bin/bash
sudo yum install -y ansible
sudo useradd -m -s /bin/bash -G $(whoami) ansible
sudo echo "1234" | sudo passwd --stdin ansible
sudo echo "ansible   ALL=(ALL)    NOPASSWD:ALL" >> /etc/sudoers
sudo cp /home/ec2-user/my-key.pem /home/ansible/
sleep 5
sudo chown -R ansible:ansible /home/ansible/my-key.pem
sudo chmod 400 /home/ansible/my-key.pem
sudo -u "ansible" ssh-keygen -f /home/ansible/.ssh/id_rsa -N ""
sleep 5
sudo cp /home/ec2-user/host-ips /home/ansible/host-ips
sudo dos2unix /home/ec2-user/host-ips
sudo dos2unix /home/ansible/host-ips
sudo -u ansible bash << EOF
xargs -I {} ssh-copy-id -o "StrictHostKeyChecking no" -f '-o IdentityFile=/home/ansible/my-key.pem' ansible@{} < /home/ansible/host-ips
EOF
sudo cp /home/ec2-user/hosts /etc/ansible/hosts