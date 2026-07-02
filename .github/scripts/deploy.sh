#!/bin/bash

IMAGE_NAME=$1
TAG=$2
EC2_HOST=$3
EC2_USER=$4
ENV_NAME=$5

echo "Deploying ${IMAGE_NAME}:${TAG} to ${EC2_HOST}"

ssh -i ~/.ssh/deploy_key -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_HOST} << EOF
docker pull ${IMAGE_NAME}:${TAG}

docker stop the_button_app || true
docker rm the_button_app || true

docker run -d \
  --name the_button_app \
  -p 8000:8000 \
  ${IMAGE_NAME}:${TAG}
EOF

echo "Deployment completed."
