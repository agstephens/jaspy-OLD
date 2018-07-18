#!/bin/bash

source ./set-defaults.sh

env_name=$1

ERR_MSG="ERROR: Please provide valid conda environment name as the only argument."

if [ ! $env_name ] ; then
    echo $ERR_MSG
    exit
fi

yaml=${env_name}.yml
yaml_path=$(find ../environments -name $yaml)

py_version=$(echo $yaml_path | rev | cut -d/ -f3 | rev)
bin_dir=${JASPY_BASE_DIR}/${py_version}/bin
export PATH=${bin_dir}:$PATH

echo "Activating conda environment: $env_name"
source activate $env_name

