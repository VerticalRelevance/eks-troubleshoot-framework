## Temporary script file to run containerized framework service

#docker run -v troubleshoot-framework

# Get true file path in order to set volume on the docker container
provided_file_path=$(dirname "$1")
current_directory=$(pwd)

cd $provided_file_path || exit
file_path=$(pwd)
cd $current_directory || exit


echo "file is at path $file_path"
echo "Provided path $provided_file_path"


docker run -v "$file_path":"/app/$file_path" \
troubleshoot_framework /container/path/to/file1.txt
