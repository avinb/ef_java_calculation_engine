#!/usr/bin/env bash
docker run --rm --link ef_oracle_database_${request_environment}:db -e DB_USERNAME=${DB_USERNAME} -e DB_PASSWORD=${DB_PASSWORD} bmcrlm/ef_oracle_database-migrate:${component_version}
