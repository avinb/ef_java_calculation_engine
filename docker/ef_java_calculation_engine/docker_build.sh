#!/usr/bin/env bash
echo "=========================================================="
echo "CREATE DOCKER IMAGE FOR ef_java_calculation_engine"
echo "=========================================================="
echo "Unzipping the war file..."
mkdir docker/ef_java_calculation_engine/to_be_deployed
unzip -d docker/ef_java_calculation_engine/to_be_deployed dist/ef_java_calculation_engine.war

cd docker/ef_java_calculation_engine

echo "Building a docker image of the app..."
docker build -t bmcrlm/ef_java_calculation_engine:${COMPONENT_VERSION} .

#echo "Pushing the docker image to the docker hub..."
#docker push bmcrlm/ef_java_calculation_engine:${COMPONENT_VERSION}

echo "Removing the image from the local repository..."
#docker rmi bmcrlm/ef_java_calculation_engine:${COMPONENT_VERSION}


