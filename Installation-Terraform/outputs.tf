//Master node public IP
output "Master-node-public-ip" {
  value = aws_instance.master_node.public_ip
}

// local variable for the extracting the public ips of worker nodes
locals {
   ec2-public-ips = ["${aws_instance.worker_nodes.*.public_ip}"]
}

// Worker Nodes ip 
output "Woker-nodes-public-ip" {
  value = local.ec2-public-ips
}