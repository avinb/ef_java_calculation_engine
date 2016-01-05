#!/bin/bash

# Prevent owner issues on mounted folders
chown -R oracle:dba /u01/app/oracle
rm -f /u01/app/oracle/product
ln -s /u01/app/oracle-product /u01/app/oracle/product
# Update hostname
sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
sed -i -E "s/PORT = [^)]+/PORT = 1521/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
echo "export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe" > /etc/profile.d/oracle-xe.sh
echo "export PATH=\$ORACLE_HOME/bin:\$PATH" >> /etc/profile.d/oracle-xe.sh
echo "export ORACLE_SID=XE" >> /etc/profile.d/oracle-xe.sh
. /etc/profile

echo "Initializing the database..."

printf "Setting up:\nprocesses=$processes\nsessions=$sessions\ntransactions=$transactions\n"
echo "If you want to use different parameters set processes, sessions, transactions env variables and consider this formula:"
printf "processes=x\nsessions=x*1.1+5\ntransactions=sessions*1.1\n"

mv /u01/app/oracle-product/11.2.0/xe/dbs /u01/app/oracle/dbs
ln -s /u01/app/oracle/dbs /u01/app/oracle-product/11.2.0/xe/dbs

#Setting up processes, sessions, transactions.
sed -i -E "s/processes=[^)]+/processes=$processes/g" /u01/app/oracle/product/11.2.0/xe/config/scripts/init.ora
sed -i -E "s/processes=[^)]+/processes=$processes/g" /u01/app/oracle/product/11.2.0/xe/config/scripts/initXETemp.ora

sed -i -E "s/sessions=[^)]+/sessions=$sessions/g" /u01/app/oracle/product/11.2.0/xe/config/scripts/init.ora
sed -i -E "s/sessions=[^)]+/sessions=$sessions/g" /u01/app/oracle/product/11.2.0/xe/config/scripts/initXETemp.ora

sed -i -E "s/transactions=[^)]+/transactions=$transactions/g" /u01/app/oracle/product/11.2.0/xe/config/scripts/init.ora
sed -i -E "s/transactions=[^)]+/transactions=$transactions/g" /u01/app/oracle/product/11.2.0/xe/config/scripts/initXETemp.ora

printf 8080\\n1521\\noracle\\noracle\\ny\\n | /etc/init.d/oracle-xe configure

echo "Database initialized. Please visit http://#container:8080/apex to proceed with configuration"

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

echo "Copying the db data files from /u01/app/oracle/oradata to a location inside the Docker image (/u01/app/oracle/oradata/* is set as a volume in the base Dockerfile)..."
cp -R /u01/app/oracle/oradata/* /db_data_files