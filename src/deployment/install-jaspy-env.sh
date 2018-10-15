#!/bin/bash

source ./set-defaults.sh

env_name=$1

ERR_MSG="[ERROR] Please provide valid conda environment name as the first argument."

if [ ! $env_name ] ; then
    echo $ERR_MSG
    exit
fi

channel_urls_fname="channel-urls.txt"
pip_fname="pip.txt"

spec_file_dir=$(find ../environments -name $env_name)
spec_file_path=${spec_file_dir}/${channel_urls_fname}
pip_file_path=${spec_file_dir}/${pip_fname}

path_comps=$(echo $spec_file_dir | rev | cut -d/ -f2-3 | rev)
bin_dir=${JASPY_BASE_DIR}/jaspy/miniconda_envs/jas${path_comps}/bin
export PATH=${bin_dir}:$PATH

cmd="${bin_dir}/conda create --name ${env_name} --file ${spec_file_path} -c ${JASPY_CHANNEL_URL}/jas${path_comps} --override-channels"
echo "[INFO] Running: $cmd"
#$cmd

echo "[INFO] Created conda environment: $env_name"

if [ -f $pip_file_path ]; then
    echo "[INFO] Installing additional packages via PIP..."
    source ${bin_dir}/activate $env_name
    ${bin_dir}/conda install pip
    pip install --upgrade pip
    pip install -r ${pip_file_path} 
fi

echo "[INFO] You can activate and use this environment with:"
echo "  export PATH=${bin_dir}:\$PATH"
echo "  source activate $env_name"

