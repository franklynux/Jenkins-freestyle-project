#!/bin/bash
# Save this as build-and-deploy.sh in your repository

# Variables
DOCKER_IMAGE_NAME="your-dockerhub-username/webapp"
DOCKER_IMAGE_TAG="latest"
APP_PORT="8080"
CONTAINER_NAME="web-application"

# Build Application (Uncomment/modify based on your application type)
# For Node.js:
npm install
npm run build

# For Java:
# mvn clean package

# Build Docker Image
docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .
docker tag ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}

# Login to Docker Hub (credentials will be injected by Jenkins)
echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin

# Push to Docker Hub
docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
docker push ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}

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