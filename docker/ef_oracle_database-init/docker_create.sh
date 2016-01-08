#!/usr/bin/env bash
docker create --name ef_oracle_data_${request_environment} -v /u01/app/oracle/admin -v /u01/app/oracle/diag -v /u01/app/oracle/fast_recovery_area -v /u01/app/oracle/oradata -v /u01/app/oracle/oradiag_oracle bmcrlm/ef_oracle_database-init:${component_version}

##once the data volume container is created, run a database on top of it:
#docker run -d --name ef_oracle_database_${request_environment} --volumes-from ef_oracle_data_${request_environment} -p ${DB_PORT}:1521 wnameless/oracle-xe-11g