#!/bin/bash
sed -i "s/\${DB_USERNAME}/${DB_USERNAME}/g" $CATALINA_HOME/conf/context.xml
sed -i "s/\${DB_PASSWORD}/${DB_PASSWORD}/g" $CATALINA_HOME/conf/context.xml
sed -i "s/\${DB_SERVER}/${DB_PORT_1521_TCP_ADDR}/g" $CATALINA_HOME/conf/context.xml
sed -i "s/\${DB_PORT}/${DB_PORT_1521_TCP_PORT}/g" $CATALINA_HOME/conf/context.xml

echo "Deploying the db scrips..."
for i in $( ls -d /db_scripts/* | sort -n ); do
    echo "sqlplus -S ${DB_USERNAME}/********@${DB_PORT_1521_TCP_ADDR}:${DB_PORT_1521_TCP_PORT}/XE @$i";
    cat $i | sqlplus -S ${DB_USERNAME}/${DB_PASSWORD}@${DB_PORT_1521_TCP_ADDR}:${DB_PORT_1521_TCP_PORT}/XE
done;
