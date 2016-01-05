#!/usr/bin/env bash
touch /usr/local/tomcat/bin/setenv.sh
echo TOMCAT_ADMIN_PASSWORD=${TOMCAT_ADMIN_PASSWORD} >> ${CATALINA_HOME}/bin/setenv.sh

echo DB_SERVER=${DB_PORT_1521_TCP_ADDR:-${DB_SERVER}} >> ${CATALINA_HOME}/bin/setenv.sh
echo DB_PORT=${DB_PORT_1521_TCP_PORT:-${DB_PORT}} >> /usr/local/tomcat/bin/setenv.sh

echo DB_USERNAME=${DB_USERNAME} >> ${CATALINA_HOME}/bin/setenv.sh
echo DB_PASSWORD=${DB_PASSWORD} >> ${CATALINA_HOME}/bin/setenv.sh

${CATALINA_HOME}/bin/startup.sh
tail -f ${CATALINA_HOME}/logs/catalina.out
