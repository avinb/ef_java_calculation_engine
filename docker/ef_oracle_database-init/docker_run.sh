#!/usr/bin/env bash
docker run -d --name ef_oracle_database_${ENVIRONMENT} -p ${PORT}:1521 bmcrlm/ef_oracle_database-init:${COMPONENT_VERSION}
