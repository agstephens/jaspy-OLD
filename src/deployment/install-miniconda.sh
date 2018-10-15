#!/bin/bash

source ./set-defaults.sh

py_version=$1

if [ ! $py_version ] || [[ ! $py_version =~ ^py[0-9]\.[0-9]$ ]]; then
    echo "ERROR: Please provide a valid python version in the form: py<n>.<m>"
    exit
fi

url=$(./config-get.py $py_version url)
fname=$(basename $url)
md5=$(./config-get.py $py_version md5)
short_id=$(./config-get.py $py_version short_id)

jaspy_dir=${JASPY_BASE_DIR}/jaspy
src_dir=${jaspy_dir}/src
mkdir -p $src_dir

target=$src_dir/$fname
download=1

if [ -f $target ] ; then
    # Get local md5
    local_md5=$(md5sum $target | cut -d' ' -f1)

    if [ $md5 == $local_md5 ]; then
        echo "Up-to-date miniconda script already available locally."
        download=0
    fi
fi

if [ $download -eq 1 ] ; then
   # Download new version
   echo "Found URL for python version: $py_version"
   echo "Downloading: $url"
   wget -O $target $url
fi

echo "Installing miniconda: $fname"
chmod 750 $target

prefix=${JASPY_BASE_DIR}/jaspy/miniconda_envs/jas${py_version}/${short_id}
mkdir -p $(dirname $prefix)
$target -b -p $prefix 
