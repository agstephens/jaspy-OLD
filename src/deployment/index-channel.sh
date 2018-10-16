#!/bin/bash

source ./set-defaults.sh

channel_path=$1

if [ ! $channel_path ] ; then
    echo "[ERROR] Directory not found for channel: $channel_path"
    exit
fi

path_comps=$(echo $channel_path | rev | cut -d/ -f1-2 | rev)
bin_dir=${JASPY_BASE_DIR}/jaspy/miniconda_envs/${path_comps}/bin
export PATH=${bin_dir}:$PATH

echo "[INFO] Installing 'conda-build' - required to index channel"
${bin_dir}/conda install conda-build

echo "[INFO] Indexing channel: $channel_path"
${bin_dir}/conda index $channel_path

echo "[INFO] Indexing complete"
