#!/bin/bash

if [ ! $JASPY_BASE_DIR ]; then
    export JASPY_BASE_DIR=/apps/contrib
    echo "Setting default base directory: JASPY_BASE_DIR=$JASPY_BASE_DIR"
fi

if [ ! -d $JASPY_BASE_DIR ]; then
    mkdir -p $JASPY_BASE_DIR
    echo "Created base directory: $JASPY_BASE_DIR"
fi

if [ ! $JASPY_CHANNEL_URL ]; then
    export JASPY_CHANNEL_URL=http://dist.ceda.ac.uk/jaspy
    echo "Setting default for JASPY channel: JASPY_CHANNEL_URL=$JASPY_CHANNEL_URL"
fi

