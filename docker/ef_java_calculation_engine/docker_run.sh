#!/usr/bin/env bash
docker run -d --link ef_oracle_database_${ENVIRONMENT}:db -e DB_USERNAME=${DB_USERNAME} -e DB_PASSWORD=${DB_PASSWORD} -e TOMCAT_ADMIN_PASSWORD=${TOMCAT_ADMIN_PASSWORD} --name ef_java_calculation_engine_${ENVIRONMENT} -p ${PORT}:8080 bmcrlm/ef_java_calculation_engine:${COMPONENT_VERSION}

