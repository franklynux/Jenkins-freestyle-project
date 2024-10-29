#!/bin/bash

# Variables - Fixed the tag format
DOCKER_IMAGE_NAME="franklynux/express-app"
DOCKER_IMAGE_TAG="v1.0"
APP_PORT="9000"
CONTAINER_NAME="express-application"

# Install dependencies and run tests
npm install
npm test

# Build Docker Image (fixed tag format)
docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .

# Login to Docker Hub
echo $DOCKER_CREDENTIALS_PSW | docker login -u $DOCKER_CREDENTIALS_PSW --password-stdin

# Push to Docker Hub
docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}

# Stop and remove existing container
if docker ps -a | grep -q ${CONTAINER_NAME}; then
    docker stop ${CONTAINER_NAME}
    docker rm ${CONTAINER_NAME}
fi

# Run new container
docker run -d \
    --name ${CONTAINER_NAME} \
    -p ${APP_PORT}:${APP_PORT} \
    ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}

# Cleanup
docker logout
docker system prune -f

echo "Application deployed! Access it at http://localhost:${APP_PORT}"