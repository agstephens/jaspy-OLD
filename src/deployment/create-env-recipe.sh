#!/bin/bash

source ./set-defaults.sh

initial_yaml_path=$1

if [ ! $initial_yaml_path ] || [ ! -f $initial_yaml_path ]; then
    echo "ERROR: Please provide valid YAML environment file as only argument."
    exit
fi

initial_yaml=$(basename $initial_yaml_path)

if [ $initial_yaml != 'initial.yml' ]; then
    echo "ERROR: Input YAML file must be called: 'initial.yml'."
    exit
fi

spec_dir=$(dirname $initial_yaml_path)

# Get the env_name from the directory
env_name=$(basename $spec_dir)

# Get the python version from the next directory up
py_version=$(echo $spec_dir | rev | cut -d/ -f3 | rev)
bin_dir=${JASPY_BASE_DIR}/${py_version}/bin

export PATH=${bin_dir}:$PATH

cmd="${bin_dir}/conda env create -n $env_name -f $initial_yaml_path"
#echo "Running: $cmd"
$cmd

echo "Created conda environment: $env_name"
source ./activate-jaspy-env.sh $env_name

spec_file=${spec_dir}/_explicit.txt
echo "Generating explicit spec file (excluding pip): $spec_file"
conda list --explicit > $spec_file 

urls_file=${spec_dir}/_urls.txt
echo "Generating URLs file (excluding pip): $urls_file"
cat $spec_file | sed -n -e '/^@EXPLICIT/,$p' | grep -v @EXPLICIT | sed -e 's/^/    - /' > $urls_file

pip_spec_file=${spec_dir}/_pip.txt
echo "Generating pip component of yaml file: $pip_spec_file"
conda-env export | sed -n -e '/- pip:/,$p' | grep -v "^prefix:" | sed -e 's/^/  /'  > $pip_spec_file

spec_head=${spec_dir}/_head.yml
echo "Generating header for explicit yaml file: $spec_head"
cat $yaml_path | sed '/dependencies:/q' > $spec_head

complete_yaml=${spec_dir}/complete.yml
echo "Generating complete explicit yaml file: $complete_yaml"
cat $spec_head $urls_file $pip_spec_file > $complete_yaml 

