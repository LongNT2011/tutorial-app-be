#!/bin/bash
SECRET_NAME="prod/tutorial-app-be-configs"
REGION="ap-southeast-1"

SECRET=$(aws secretsmanager get-secret-value --secret-id $SECRET_NAME --region $REGION --query SecretString --output text)

DOCKER_USERNAME=$(echo $SECRET | jq -r .DockerUsername)
DOCKER_PASSWORD=$(echo $SECRET | jq -r .DockerPassword)

echo "your-docker-password" | docker login -u $DockerUsername -p $DockerPassword"

docker rm -f $(docker ps -q -a)

docker rmi -f $(docker images -q)

sleep 3

docker pull /aws-codepipeline-project:latest

if [[ $? != 0 ]]; then
    docker pull your-dockerhub-username/aws-codepipeline-project:latest
fi

docker run -d -p 80:3000 --name aws-codepipeline-project your-dockerhub-username/aws-codepipeline-project:latest
