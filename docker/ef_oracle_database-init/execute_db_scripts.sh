#!/bin/bash
echo "Starting the database..."
/etc/init.d/oracle-xe start

echo "Deploying the db scrips..."
for i in $( ls -d /db_scripts/* | sort -n ); do
    echo "sqlplus $i";
    sqlplus -S system/oracle @$1
done;

echo "Stopping the database..."
/etc/init.d/oracle-xe stop
