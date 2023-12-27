import os

#location = input("The path is: ")
location = "C:\\git\\Platform-Engineering\\Ansible\\Deployment\\playbook"
extension = ".yml"
valid_path = os.path.exists(location)
print(valid_path)

os.chdir(location)

file_list = os.listdir()
print(file_list)

for filename in os.listdir(location):
    if filename.endswith('.yml'):
        with open(os.path.join(location, filename)) as f:
            print(f.read())