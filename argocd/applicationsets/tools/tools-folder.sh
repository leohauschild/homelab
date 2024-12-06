#!/bin/bash

TOOL_NAME=$1

if [ ! -d $TOOL_NAME ]; then
  mkdir -p \
    $TOOL_NAME/manifests/ &&
    touch $TOOL_NAME/manifests/.gitkeep &&
    touch $TOOL_NAME/values.yaml

  tree $TOOL_NAME
else
  command echo "Folder already exists"
fi
