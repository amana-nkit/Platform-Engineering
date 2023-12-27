import os 

#filename = "playbook.yml"
filename = input("The file name is:")
#location = "C:\\git\\Platform-Engineering\\Ansible\\Deployment\\playbook"
location = input("The path is:")

# ----------------------------------
# Check if path and directory exists
# ----------------------------------

valid_path = os.path.exists(location)
print(valid_path)

if  valid_path == True:
    print("The path is:", location)
else:
    print("Not a valid path")

# os.chdir(location)
# print(os.cwr)
    
#--------------------------------------
# Check the path exist in the directory
#--------------------------------------

fileexist = os.path.join(location, filename)
valid_file = os.path.isfile(fileexist)
print(valid_file)

if valid_file == True:
    print("The file is:", fileexist)
else:
    print("File not found")

#---------------------------------------
# Run Ansible Playbook from defined path
#---------------------------------------
    
ansible-playbook filename -i inventory 