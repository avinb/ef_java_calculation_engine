#!/usr/bin/env bash
echo "=========================================================="
echo "CREATE DOCKER IMAGE FOR ef_oracle_database-migrate"
echo "=========================================================="
echo "Copying the db scripts to the docker context..."
mkdir -p docker/ef_oracle_database-migrate/db_scripts
if [ -d db_scripts ]; then
  cp -R db_scripts/* docker/ef_oracle_database-migrate/db_scripts
fi

cd docker/ef_oracle_database-migrate

echo "Building a docker image of the database migrator..."
docker build -t bmcrlm/ef_oracle_database-migrate:${COMPONENT_VERSION} .

echo "Pushing both docker images to the docker hub..."
docker push bmcrlm/ef_oracle_database-migrate:${COMPONENT_VERSION}

echo "Removing the images from the local repository..."
docker rmi bmcrlm/ef_oracle_database-migrate:${COMPONENT_VERSION}
