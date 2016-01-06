#!/bin/bash
echo "Starting the database..."
/etc/init.d/oracle-xe start

echo "Deploying the db scrips..."
for i in $( ls -d /db_scripts/* | sort -n ); do
    echo "sqlplus -S system/oracle @$i";
    cat $i | sqlplus -S sys/oracle as sysdba
done;

echo "Stopping the database..."
/etc/init.d/oracle-xe stop