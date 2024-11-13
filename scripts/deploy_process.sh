#!/bin/bash
SECRET_NAME="prod/tutorial-app-be-configs"
REGION="ap-southeast-1"

SECRET=$(aws secretsmanager get-secret-value --secret-id $SECRET_NAME --region $REGION --query SecretString --output text)

DOCKER_USERNAME=$(echo $SECRET | jq -r .DockerUsername)
DOCKER_PASSWORD=$(echo $SECRET | jq -r .DockerPassword)
BACKEND_IMAGE_NAME=$(echo $SECRET | jq -r .BackendImageName)

docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

docker compose down || docker rm -f $(docker ps -q -a)

docker rmi -f $(docker images -q)

BACKEND_IMAGE_NAME=$BACKEND_IMAGE_NAME docker compose up -d