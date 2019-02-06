#!/bin/bash

# link-external-envs-repo.sh
# --------------------------
#
# - Creates a symbolic link to an external environments repository
#   so the jaspy scripts can use it.
#

repo=$1

if [ ! $repo ] || [ ! -d $repo ] || [ ! -d $repo/environments ]; then
    echo "[ERROR] Must provide a valid repository directory that includes"
    echo "        a sub-directory called: 'environments'."
    exit
fi

# Append repo name on to "environments" for symlink name
symlink=environments-$(basename $repo)

target=$repo/environments
echo "[INFO] Creating sym-link: ../$symlink --> $target"
cd ../

if [ -L $symlink ]; then
    rm $symlink
fi

ln -s $target $symlink
