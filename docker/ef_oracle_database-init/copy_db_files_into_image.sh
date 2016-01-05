#!/bin/bash
echo "Copying the db data files from /u01/app/oracle/oradata to a location inside the Docker image (/u01/app/oracle/oradata/* is set as a volume in the base Dockerfile)..."
cp -R /u01/app/oracle/oradata/* /db_data_files