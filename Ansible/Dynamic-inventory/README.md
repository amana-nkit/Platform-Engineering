# Ansible Dynamic Inventory

## Pre-requisites:
1. Ansible Server

## Setup
1. Download ec2.py and ec2.ini from official document
2. Create IAM Programatic access user with EC2 full access on AWS console
    IAM -> users -> Add user
3. Export IAM user credential on Ansible server
    export AWS_ACCESS_KEY_ID='1bc124'
    export AWS_SECRET_KEY_ID='abc123'
4. To export keys permanently make sure that you have installed pip and boto and add credential ~/.boto file
5. Add executing permission to ec2.py script
    chmod 755 ec2.py
6. Test the script

