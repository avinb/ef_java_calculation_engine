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

Following the Docker mindset the deployment of the application should be done as much as possible during build time to reduce the risk of anything going wrong during the deployments later on as well as to increase the speed of these deployments. The deployment itself then simply consists of the low-risk act of transferring files and content. We will adopt exactly this approach for our use case here and install the whole database at build time. The deployment then simply consists of starting up the database. Note that the reduced risk and increased speed at deploy time may come with a price of having to transfer and store big files. As an example: an Oracle XE database that contains one table with a couple of records in it will still produce data files of 1.14 GB! This is mainly due to huge default sizes of the SYSAUX and SYSTEM tablespaces. When transferred over the wire to the Docker Hub this comes down to about 150MB.

### 2] the "persistent database" use case targeted at manual testing environments

![alt text](https://github.com/BMC-RLM/ef_java_calculation_engine/blob/master/persistent_db.png "persistent db")

In this use case the database is kept between the subsequent deployments, because testers may have manually entered their test data, or even worse, it's the production environment ;-) The execution of the migration scripts that come with this release therefore has to be done at deploy time, contrary to the first use case.
 
Therefore, we will create a data volume container the first time. During deployment we will pass this container's volume to a database container and link that container on its turn to a data migration container in order to execute the migration scripts on it. After the tests only the data volume container will remain.

### 3] the "database server upgrade" use case (e.g. migrate Oracle 11g to 12g)

We can simply use the data volume container as explained in the previous use case to upgrade our database server. 

### Docker commands

See the following scripts for the exact docker commands:
- Calculation Engine:
    - [docker_build.sh](https://github.com/BMC-RLM/ef_java_calculation_engine/blob/master/docker/ef_java_calculation_engine/docker_build.sh)
    - [docker_run.sh](https://github.com/BMC-RLM/ef_java_calculation_engine/blob/master/docker/ef_java_calculation_engine/docker_run.sh)
- Database - init:
    - [docker_build.sh](https://github.com/BMC-RLM/ef_java_calculation_engine/blob/master/docker/ef_oracle_database-init/docker_build.sh)
    - [docker_run.sh](https://github.com/BMC-RLM/ef_java_calculation_engine/blob/master/docker/ef_oracle_database-init/docker_run.sh)
- Database - migrate
    - [docker_build.sh](https://github.com/BMC-RLM/ef_java_calculation_engine/blob/master/docker/ef_oracle_database-migrate/docker_build.sh)
    - [docker_run.sh](https://github.com/BMC-RLM/ef_java_calculation_engine/blob/master/docker/ef_oracle_database-migrate/docker_run.sh)

