#!/bin/bash

source ./set-defaults.sh
src_dir=$JASPY_BASE_DIR/src
mkdir -p $src_dir

py_version=$1

url=$(./config-get.py $py_version source)
fname=$(basename $url)
md5=$(./config-get.py $py_version md5)

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

prefix=${JASPY_BASE_DIR}/${py_version}
$target -b -p $prefix 
