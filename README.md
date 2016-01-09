# E-Finance Calculation Engine

The E-Finance Calculation Engine is a demo application used for demonstrating release and deployment or continuous delivery scenarios

## Architecture

![alt text](https://github.com/BMC-RLM/ef_java_calculation_engine/blob/master/architecture.png "architecture")

## Continuous Delivery with Docker

The repository contains a number of Dockerfiles and scripts that allow to deploy the application with Docker.

The management of state (i.e. the data from the database) is an interesting topic in Docker and we will consider the following use cases here:

### 1] the "ephemeral database" use case targeted at automated testing environments

![alt text](https://github.com/BMC-RLM/ef_java_calculation_engine/blob/master/ephemeral_db.png "ephemeral db")


In this use case the database is always installed with the initial data at each deployment and can be safely deleted after the tests have finished. This approach is ideal in an environment where automated tests run as its inputs are highly deterministic. 

Following the Docker mindset the deployment of the application should be done as much as possible during build time to reduce the risk of anything going wrong during the deployments later on as well as to increase the speed of these deployments. The deployment itself then simply consists of the low-risk act of transferring files and content. We will adopt exactly this approach for our use case here and install the whole database at build time. The deployment then simply consists of starting up the database. 

Note that the reduced risk and increased speed at deploy time may come with a price of having to transfer and store big files. As an example: an Oracle XE database that contains one table with a couple of records in it will still produce data files of 1.14 GB! This is mainly due to huge default sizes of the SYSAUX and SYSTEM tablespaces. When transferred over the wire to the Docker Hub this comes down to about 150MB.

#### Docker commands

Step 1 - See the following scripts to build the docker images:
- Calculation Engine:
    - [docker_build.sh](https://github.com/BMC-RLM/ef_java_calculation_engine/blob/master/docker/ef_java_calculation_engine/docker_build.sh)
- Database - init:
    - [docker_build.sh](https://github.com/BMC-RLM/ef_java_calculation_engine/blob/master/docker/ef_oracle_database-init/docker_build.sh)
- Database - migrate
    - [docker_build.sh](https://github.com/BMC-RLM/ef_java_calculation_engine/blob/master/docker/ef_oracle_database-migrate/docker_build.sh)

```bash
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
```

### 2] the "persistent database" use case targeted at manual testing environments

![alt text](https://github.com/BMC-RLM/ef_java_calculation_engine/blob/master/persistent_db.png "persistent db")


In this use case the database is kept between the subsequent deployments, because testers may have manually entered their test data, or even worse, it's the production environment ;-) The execution of the migration scripts that come with this release therefore has to be done at deploy time, contrary to the first use case.
 
Therefore, we will create a data volume container the first time, when the environment is set up (step 0.1). During deployment we will pass this container's volume to a database container (step 3.1) and link that container in its turn to a data migration container (step 3.2) in order to execute the migration scripts on it. After the tests only the data volume container will remain.

#### Docker commands

```bash
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
```

### 3] the "database server upgrade" use case (e.g. migrate Oracle 11g to 12g)

The data volume container as explained in the previous use case only contains the data, not the database product itself, i.e. the logic. When the time comes to upgrade the database product we can simply (well, nothing is "simple" in Oracle land if you're not a fully certified Oracle DBA) pass the data volume container to the new version of the database container.
