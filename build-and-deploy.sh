#!/bin/bash

# Variables - Fixed the tag format
DOCKER_IMAGE_NAME="franklynux/nodejs-app"
DOCKER_IMAGE_TAG="v1.0"
APP_PORT="3000"
CONTAINER_NAME="tech-consulting-app"

# Install dependencies and run tests
cd tech-consulting-app
npm install
npm test

# Build Docker Image (fixed tag format)
docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .

# Login to Docker Hub
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

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