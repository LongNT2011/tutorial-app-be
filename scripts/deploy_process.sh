#!/bin/bash
SECRET_NAME="prod/tutorial-app-be-configs"
REGION="ap-southeast-1"
SECRET=$(aws secretsmanager get-secret-value --secret-id $SECRET_NAME --region $REGION --query SecretString --output text)
DOCKER_USERNAME=$(echo $SECRET | jq -r .DockerUsername)
DOCKER_PASSWORD=$(echo $SECRET | jq -r .DockerPassword)
BE_IMAGE_NAME=$(echo $SECRET | jq -r .BackendImageName)
export BACKEND_IMAGE=$BE_IMAGE_NAME
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin || exit 1
# Stop and remove containers if they are running
echo "Checking for running containers..."
if docker ps -q | grep -q .; then
  echo "Stopping running containers..."
  docker compose -f /home/ubuntu/tutorial-be/docker-compose.yml down || { echo "Failed to stop containers"; exit 1; }
else
  echo "No running containers to stop."
fi
# Remove old images if they exist
echo "Checking for existing Docker images..."
IMAGES=$(docker images -q)
if [ -n "$IMAGES" ]; then
  echo "Removing old Docker images..."
  docker rmi -f $IMAGES || { echo "Failed to remove Docker images"; exit 1; }
else
  echo "No Docker images to remove."
fi
# Bring up new containers
echo "Starting up new containers..."
docker compose -f /home/ubuntu/tutorial-be/docker-compose.yml up -d || { echo "Failed to start containers"; exit 1; }
echo "Deployment complete!"