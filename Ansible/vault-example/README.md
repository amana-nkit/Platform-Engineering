# Ansible vault

ansible-vault encrypt user-passwd.yml

vim ~/.myvault
-> Enter password

ansible-playbook site.yaml --vault-password-file ~/.myvault 

## Machine credential from Ansible Tower

vars:
    machine:
        username: '{{ ansible_user }}'
        password: '{{ ansible_password }}'