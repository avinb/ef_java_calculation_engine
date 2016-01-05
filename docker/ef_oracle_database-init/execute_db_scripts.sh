#!/bin/bash
echo "Starting the database..."
/etc/init.d/oracle-xe start

sleep 10

echo "Deploying the db scrips..."
for i in $( ls -d /db_scripts/* | sort -n ); do
    echo "sqlplus $i";
    sqlplus sys/oracle as sysdba @$1
done;

echo "Stopping the database..."
/etc/init.d/oracle-xe stop
