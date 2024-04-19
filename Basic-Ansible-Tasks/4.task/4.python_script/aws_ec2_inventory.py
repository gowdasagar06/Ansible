#!/usr/bin/env python
import boto3

def get_ec2_inventory():
    ec2 = boto3.client('ec2')
    response = ec2.describe_instances()
    
    ip_addresses = []
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            ip_addresses.append(instance['PrivateIpAddress'])

    return ip_addresses

if __name__ == '__main__':
    inventory = get_ec2_inventory()
    for ip_address in inventory:
        print(ip_address)

