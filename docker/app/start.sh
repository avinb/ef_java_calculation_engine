#!/usr/bin/env bash
echo TOMCAT_ADMIN_PASSWORD=${TOMCAT_ADMIN_PASSWORD} >> /etc/tomcat/tomcat.conf

echo DB_SERVER=${DB_PORT_5432_TCP_ADDR:-${DB_SERVER}} >> /etc/tomcat/tomcat.conf
echo DB_PORT=${DB_PORT_5432_TCP_PORT:-${DB_PORT}} >> /etc/tomcat/tomcat.conf

echo DB_USERNAME=${DB_USERNAME} >> /etc/tomcat/tomcat.conf
echo DB_PASSWORD=${DB_PASSWORD} >> /etc/tomcat/tomcat.conf

/usr/local/tomcat/catalina.sh run
