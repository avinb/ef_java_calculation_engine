#!/usr/bin/env bash
docker run -d --name ef_oracle_database_${request_environment} -p ${DB_PORT}:1521 bmcrlm/ef_oracle_database-init:${component_version}
