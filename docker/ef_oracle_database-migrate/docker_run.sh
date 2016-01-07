#!/usr/bin/env bash
docker run -d --name ef_oracle_database_${request_environment} --link ef_oracle_database_${request_environment}:db -e DB_USERNAME=${DB_USERNAME} -e DB_PASSWORD=${DB_PASSWORD} bmcrlm/ef_oracle_database-init:${component_version}
