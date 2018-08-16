#!/bin/bash

source ./set-defaults.sh

env_name=$1

ERR_MSG="ERROR: Please provide valid conda environment name as the first argument."

if [ ! $env_name ] ; then
    echo $ERR_MSG
    exit
fi

complete_fname=complete.yml

spec_file_dir=$(find ../environments -name $env_name)
spec_file_path=${spec_file_dir}/${complete_fname}

path_comps=$(echo $spec_file_dir | rev | cut -d/ -f2-3 | rev)
bin_dir=${JASPY_BASE_DIR}/jaspy/miniconda_envs/jas${path_comps}/bin
export PATH=${bin_dir}:$PATH

cmd="${bin_dir}/conda env create -n $env_name -f $spec_file_path"
echo "Running: $cmd"
$cmd

echo "Created conda environment: $env_name"

echo "Activate it with:"
echo "  export PATH=${bin_dir}:\$PATH"
echo "  source activate $env_name"

