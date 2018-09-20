
import os
from skimage.external.tifffile import _tifffile


# each website you crawl is a separate project (folder)
def create_project_directory(directory):
    if not os.path.exists(directory):
        print("Creating project : " , directory)
        os.makedirs(directory)
        

create_project_directory('thenewboston')

# Create queue and crawled files
def create_data_files(project_name, base_url):
    queue = project_name + '/queue.txt'
    crawled = project_name + '/crawled.txt'
    if not os.path.isfile(queue):
        write_file(queue, base_url)
    if not os.path.isfile(crawled):
        write_file(crawled, '')
     

# Create a new file
def write_file(path, data):
    f = open(path, 'w')
    f.write(data)
    f.close()

# Add data to existing file
def append_to_file(path, data):
    with open(path, 'a') as file:
        file.write(data + '\n')
    
# Delete file contents
def delete_file_contents(path):
    with open(path, 'w'):
        pass

# Read a file and convert each line to a set item
def file_to_set(file_name):
    results = set()
    with open(file_name, 'b') as f:
        for line in f:
            results.add(line.replace('\n', ''))
    return results

# Iterate through a set and each item will become a new line to a file
def set_to_file(links, file):
    delete_file_contents(file)
    for link in sorted(links):
        append_to_file(file, link)
        
     
create_data_files('thenewboston', 'https://thenewboston.com/')