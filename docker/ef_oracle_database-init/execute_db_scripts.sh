#!/bin/bash
#echo "Copying the db data files from /db_data_files (inside the image) to /u01/app/oracle/oradata (volume)..."
#cp -R /u01/app/oracle/oradata/* /db_data_files

echo "Starting the database..."
/etc/init.d/oracle-xe start

echo "Deploying the db scrips..."
for i in $( ls -d /db_scripts/* | sort -n ); do
    echo "sqlplus $i";
    sqlplus -S system/oracle@localhost @$1"
done;

echo "Stopping the database..."
/etc/init.d/oracle-xe stop

#echo "Copying the db data files from /u01/app/oracle/oradata (volume) to /db_data_files (inside the image)..."
#cp -R /u01/app/oracle/oradata/* /db_data_files