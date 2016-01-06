#!/usr/bin/env bash
sed -i "s/\${DB_USERNAME}/${DB_USERNAME}/g" $CATALINA_HOME/conf/context.xml
sed -i "s/\${DB_PASSWORD}/${DB_PASSWORD}/g" $CATALINA_HOME/conf/context.xml
sed -i "s/\${DB_SERVER}/${DB_PORT_1521_TCP_ADDR}/g" $CATALINA_HOME/conf/context.xml
sed -i "s/\${DB_PORT}/${DB_PORT_1521_TCP_PORT}/g" $CATALINA_HOME/conf/context.xml

sed -i "s/\${TOMCAT_ADMIN_PASSWORD}/${TOMCAT_ADMIN_PASSWORD}/g" $CATALINA_HOME/conf/tomcat-users.xml

${CATALINA_HOME}/bin/startup.sh
tail -f ${CATALINA_HOME}/logs/catalina.out
