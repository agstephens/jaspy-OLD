#!/bin/bash

# 1. Creates a directory:
#    ${JASPY_BASE_DIR}/channels/${py_version}/linux-64/
#
# 2. Symlinks all "*.tar.bz" files from: ${JASPY_BASE_DIR}/${py_version}/pkgs/
#    into the above directory
#
# 3. Installs conda-build
# 4. Indexes the channel
# 5. Runs a test search
#

source ./set-defaults.sh

py_version=$1

ERR_MSG="ERROR: Please provide valid python version as the only argument."

if [ ! $py_version ] ; then
    echo $ERR_MSG
    exit
fi

bin_dir=${JASPY_BASE_DIR}/${py_version}/bin

if [ ! -d $bin_dir ] ; then
    echo "ERROR: Cannot find 'bin' directory at: $bin_dir"
    exit
fi

export PATH=${bin_dir}:$PATH

echo "Install conda-build"
cmd="${bin_dir}/conda install -y conda-build"
echo "Running: $cmd"
#$cmd

echo "Create channels directory and symlink packages"
channels_base_dir=${JASPY_BASE_DIR}/channels
channel_dir=${channels_base_dir}/${py_version}/linux-64
mkdir -p $channel_dir

pkg_dir=${JASPY_BASE_DIR}/${py_version}/pkgs
cd $pkg_dir/
echo $pkg_dir

count=0
for pkg in *.tar.bz2 ; do
    cd ${channel_dir}
    ln -f -s $pkg_dir/$pkg
    let count+=1
done

echo "Added $count packages to local channel." 

echo "Index the new channel: $channel_dir"
cmd="${bin_dir}/conda index $channel_dir"
echo "Running: $cmd"
#$cmd

echo "Test it with conda search."
cmd="${bin_dir}/conda search -c file://${channels_base_dir}/${py_version}/ --platform linux-64 --override-channels"
echo "Running: $cmd"
$cmd

