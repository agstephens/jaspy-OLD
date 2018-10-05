#!/bin/bash

mkdir -p cache

source ./set-defaults.sh

complete_yaml_path=$1

if [ ! $complete_yaml_path ] || [ ! -f $complete_yaml_path ]; then
    echo "ERROR: Please provide valid YAML environment file as only argument."
    exit
fi

complete_yaml=$(basename $complete_yaml_path)

if [ $complete_yaml != 'complete-jaspy-channel.yml' ]; then
    echo "ERROR: Input YAML file must be called: 'complete-jaspy-channel.yml'."
    exit
fi

spec_dir=$(dirname $complete_yaml_path)

# Get the env_name from the directory
env_name=$(basename $spec_dir)

# Get the python version from the next directory up
path_comps=$(echo $spec_dir | rev | cut -d/ -f2-3 | rev)

jaspy_version=$(echo $env_name | cut -d\- -f1)
miniconda_version=$(echo $env_name | cut -d\- -f2-3)

miniconda_env_dir=${JASPY_BASE_DIR}/jaspy/miniconda_envs/jas${path_comps}
pkgs_dir=${miniconda_env_dir}/pkgs

echo "[INFO] Checking existence of all binaries before caching."

for binary in $(cat ${complete_yaml_path} | grep http | sed 's|.*/||g'); do 
    pkg=${pkgs_dir}/$binary
    if [ ! -f $pkg ]; then
        echo "[ERROR] Package binary not found at: $pkg"
        echo "[ERROR] Fatal error so exiting."
        exit
    fi
done

echo "[INFO] Copying binaries to 'cache/'"

for binary in $(cat ${complete_yaml_path} | grep http | sed 's|.*/||g'); do
    pkg=${pkgs_dir}/$binary
    cp ${pkg} cache/
done

echo "[INFO] All binaries copied"
