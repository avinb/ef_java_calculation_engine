#!/usr/bin/env bash
docker run -d --name ef_java_calculation_engine_${request_environment} -p ${APP_PORT}:8080 --link ef_oracle_database_${request_environment}:db -e DB_USERNAME=${DB_USERNAME} -e DB_PASSWORD=${DB_PASSWORD} -e TOMCAT_ADMIN_PASSWORD=${TOMCAT_ADMIN_PASSWORD} bmcrlm/ef_java_calculation_engine:${component_version}

