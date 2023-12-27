import os

location = "C:\\tempdir"

# size = os.path.getsize(location)
# print(size)

def get_file_size(directory):
    files = os.listdir(directory)

    for file in files:
        path = os.path.join(directory, file)
        if os.path.isfile(path):
            size = os.path.getsize(path)
            print(f"{file}: {size} bytes")

get_file_size(location)