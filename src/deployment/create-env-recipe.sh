#!/bin/bash

source ./set-defaults.sh

yaml_path=$1

if [ ! $yaml_path ] || [ ! -f $yaml_path ]; then
    echo "ERROR: Please provide valid YAML environment file as only argument."
    exit
fi

yaml=$(basename $yaml_path)
env_name=$(echo $yaml | sed 's/\.yml//')

py_version=$(echo $yaml_path | rev | cut -d/ -f3 | rev)
bin_dir=${JASPY_BASE_DIR}/${py_version}/bin

export PATH=${bin_dir}:$PATH

cmd="${bin_dir}/conda env create -n $env_name -f $yaml_path"
echo "Running: $cmd"
$cmd

echo "Created conda environment: $env_name"
source ./activate-jaspy-env.sh $env_name

spec_file=$(dirname $yaml_path)/${env_name}-spec.txt
echo "Generating spec file: $spec_file"
conda list --explicit > $spec_file 

