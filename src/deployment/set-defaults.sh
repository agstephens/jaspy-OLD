#!/bin/bash

if [ ! $JASPY_BASE_DIR ]; then
    export JASPY_BASE_DIR=$HOME/jaspy
    echo "Setting default base directory: JASPY_BASE_DIR=$JASPY_BASE_DIR"
fi

if [ ! -d $JASPY_BASE_DIR ]; then
    mkdir -p $JASPY_BASE_DIR
    echo "Created base directory: $JASPY_BASE_DIR"
fi

