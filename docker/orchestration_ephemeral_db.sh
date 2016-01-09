#!/usr/bin/env bash
echo "Step 2.1 - Run database container with fresh data"
docker run -d --name ef_oracle_database_${ENVIRONMENT} -p ${DB_PORT}:1521 bmcrlm/ef_oracle_database-init:${COMPONENT_VERSION}

echo "Step 2.2 - Run application container"
docker run -d --name ef_java_calculation_engine_${ENVIRONMENT} -p ${APP_PORT}:8080 --link ef_oracle_database_${ENVIRONMENT}:db -e DB_USERNAME=${DB_USERNAME} -e DB_PASSWORD=${DB_PASSWORD} -e TOMCAT_ADMIN_PASSWORD=${TOMCAT_ADMIN_PASSWORD} bmcrlm/ef_java_calculation_engine:${COMPONENT_VERSION}

echo "Step 2.3 - Execute tests (the application is available on $HOSTNAME:$APP_PORT/ef_java_calculation_engine)"

read -p "Press a key to stop the application" KEY

echo "Step 2.4 - Stop and remove the application container"
docker rm -f ef_java_calculation_engine_${ENVIRONMENT}

echo "Step 2.5 - Stop and remove the database container"
docker rm -f ef_oracle_database_${ENVIRONMENT}
