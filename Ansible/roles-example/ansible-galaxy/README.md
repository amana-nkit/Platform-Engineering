# Ansible Galaxy Role

## Help command
ansible-galaxy role -h
ansible-galaxy role search "elasticsearch"
ansible-galaxy role search amanankit.git

## Create a directory and copy the files

mkdir roles
ansible-galaxy install amanankit.git -p roles/

## Update role directory in config file
ansible-galaxy role list

vim ansible.cfg
roles_path = roles
