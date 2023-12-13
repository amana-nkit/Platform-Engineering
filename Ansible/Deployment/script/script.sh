#!/usr/bin/bash

#------------------------------
# Define log file and variable
#------------------------------

RFC=$1
PRODUCT=$2
PROJECT_NAME=$3
ENV=$4
TAG=$5
DC=$6
Git_Instance=$7
filepathname=$8

BASE_DIR="/home/aman"
logfile="${}/log/ansible_deployment_`date "+%y-%m-%d-%H-%M-%S-%3N"`_${DC}_${TAG}_{RFC}.log"
Requestlog="${BASE_DIR}/log/${RFC}_${DC}_LOG.txt"
deploymentlog="${BASE_DIR}/FC/${SCCB}_${DC}_STATUS.txt"
echo $logfile>$Requestlog

config_file="${BASE_DIR}/config/config_file.txt"
inventory_DIR="${BASE_DIR}/config"
ANSIBLE_SOURCE_PATH="${BASE_DIR}/config"
ANSIBLE_SOURCE_DIRECTORY=`grep "${PRODUCT}_${PROJECT_NAME}_ANSIBLE_SOURCE_PATH" $config_file | cut -f2 -d"="
ANSIBLE_DEST_DIRECTORY=`grep "${PRODUCT}_${PROJECT_NAME}_ANSIBLE_DEST_PATH" $config_file | cut -f2 -d"="
HOST=`grep "${PRODUCT}_${PROJECT_NAME}_${DC}_HOST" $config_file | cut -f2 -d"="
ANSIBLE_SOURCE="${ANSIBLE_SOURCE_PATH}/${TAG}/${ANSIBLE_SOURCE_DIRECTORY}"
tempdir="${RFC}_`date "+%y-%m-%d-%H-%M-%S-%3N"`"

echo "${config_file}"
echo "${BASE_DIR}"
echo "${ANSIBLE_SOURCE_DIRECTORY}"
echo "${ANSIBLE_DEST_DIRECTORY}"
echo "${logfile}"
echo "${ANSIBLE_SOURCE}"

#------------------------------
# Nexus Package Download
#------------------------------

wget -P "${BASE_DIR}/temp/${tempdir}/" $filepathname
returncode=$?

if [ $returncode -ne 0 ]
then 
    echo "Error in downloading process"

    exit 1
else
    echo "File downloaded successfully from nexus"

ls -lrt | tee -a ${logfile}


#------------------------------
# Extract Nexus download file
#------------------------------

cd "${BASE_DIR}/temp/${tempdir}/"
filename=`basename $filepathname`
unzip -q $filename -d ./extracted
returncode=$?

if [ $returncode -ne 0 ]
then 
    echo "Error occured in unzipping so removing directory"

    cd "${BASE_DIR}/temp"
    rm -rf ${tempdir}

    exit 1
else
    echo "File unzipped"

fi
fi

#------------------------------
# Run Ansible Playbook
#------------------------------

echo "Now Running Ansible Playbook"
cd "${BASE_DIR}/Playbook"

ansible-playbook playbook.yml -i "${inventory_DIR}/ansible_host_inventory.txt" -e "variable_host=$HOST file_path=$ANSIBLE_SOURCE_DIRECTORY dest_path=$ANSIBLE_DEST_DIRECTORY"
returncode2=$?

if [ $returncode2 -ne 0 ]
then 
    echo "Error occured in running playbook so removing directory"

    cd "${BASE_DIR}/temp"
    rm -rf ${tempdir}

    exit 1
else
    echo "Playbook ran successfully"

fi

#------------------------------
# Removing Directory
#------------------------------

echo "Now Removing file from directory"
cd "${BASE_DIR}/temp"
rm -rf ${tempdir}
returncode3=$?

if [ $returncode3 -ne 0 ]
then 
    echo "Error occured in removing file"
    exit 1
else
    echo "Directory removed successfully"

fi

