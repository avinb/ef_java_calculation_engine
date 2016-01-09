#!/usr/bin/env bash
echo "Step 0.1 (first time only) - Create data volume container with fresh data"
docker create --name ef_oracle_data_${ENVIRONMENT} -v /u01/app/oracle/admin -v /u01/app/oracle/diag -v /u01/app/oracle/fast_recovery_area -v /u01/app/oracle/oradata -v /u01/app/oracle/oradiag_oracle bmcrlm/ef_oracle_database-init:${COMPONENT_VERSION}

echo "Step 3.1 - Run database container from data volume"
docker run -d --name ef_oracle_database_${ENVIRONMENT} --volumes-from ef_oracle_data_${ENVIRONMENT} -p ${DB_PORT}:1521 wnameless/oracle-xe-11g

echo "Step 3.2 - Migrate database"
docker run --rm --link ef_oracle_database_${ENVIRONMENT}:db -e DB_USERNAME=${DB_USERNAME} -e DB_PASSWORD=${DB_PASSWORD} bmcrlm/ef_oracle_database-migrate:${COMPONENT_VERSION}

echo "Step 3.3 - Run application container"
docker run -d --name ef_java_calculation_engine_${ENVIRONMENT} -p ${APP_PORT}:8080 --link ef_oracle_database_${ENVIRONMENT}:db -e DB_USERNAME=${DB_USERNAME} -e DB_PASSWORD=${DB_PASSWORD} -e TOMCAT_ADMIN_PASSWORD=${TOMCAT_ADMIN_PASSWORD} bmcrlm/ef_java_calculation_engine:${COMPONENT_VERSION}

echo "Step 3.4 - Execute tests (the application is available on $HOSTNAME:$APP_PORT/ef_java_calculation_engine)"

read -p "Press a key to stop the application" KEY

echo "Step 3.5 - Stop and remove the application container"
docker rm -f ef_java_calculation_engine_${ENVIRONMENT}

echo "Step 3.6 - Stop and remove the database container"
docker rm -f ef_oracle_database_${ENVIRONMENT}
