#!/bin/bash

if [ "$(ls -A /db_data_files)" ]; then
  if [ "$OVERWRITE_EXISTING_DATA" == "1" ]; then
    echo "Data directory is not empty but OVERWRITE_EXISTING_DATA flag is activated so deleting the existing files"
    rm -rf /db_data_files/*
  else
    echo "Data directory is not empty, leaving it as it is."
    exit
  fi
fi

cp -R /db_data_files /db_data_files_destination