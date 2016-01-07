#!/usr/bin/env bash
echo "=========================================================="
echo "CREATE DOCKER IMAGE FOR ef_oracle_database"
echo "=========================================================="
echo "Copying the db scripts to the docker context..."
mkdir -p docker/ef_oracle_database-init/db_scripts
cp -R db_scripts_archive/* docker/ef_oracle_database-init/db_scripts
if [ -d db_scripts ]; then
  cp -R db_scripts/* docker/ef_oracle_database-init/db_scripts
fi

cd docker/ef_oracle_database-init

echo "Building a docker image of the database initializer..."
docker build -t bmcrlm/ef_oracle_database-init:${COMPONENT_VERSION} .

echo "Tagging the created image as 'latest'..."
docker tag -f bmcrlm/ef_oracle_database-init:${COMPONENT_VERSION} bmcrlm/ef_oracle_database-init:latest

echo "Pushing both docker images to the docker hub..."
docker push bmcrlm/ef_oracle_database-init:${COMPONENT_VERSION}
docker push bmcrlm/ef_oracle_database-init:latest

echo "Removing the images from the local repository..."
docker rmi bmcrlm/ef_oracle_database-init:${COMPONENT_VERSION}
docker rmi bmcrlm/ef_oracle_database-init:latest