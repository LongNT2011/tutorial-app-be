#!/bin/bash
SECRET_NAME="prod/tutorial-app-be-configs"
REGION="ap-southeast-1"
SECRET=$(aws secretsmanager get-secret-value --secret-id $SECRET_NAME --region $REGION --query SecretString --output text)
DOCKER_USERNAME=$(echo $SECRET | jq -r .DockerUsername)
DOCKER_PASSWORD=$(echo $SECRET | jq -r .DockerPassword)
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin || exit 1
docker compose -f /home/ubuntu/tutorial-be/docker-compose.yml up -d