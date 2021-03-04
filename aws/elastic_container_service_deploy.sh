#!/bin/bash

echo "********************************************"
echo "********** Installing the AWS CLI **********"
echo "********************************************"
sudo apt-get update && sudo apt-get install -y jq
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -b ~/bin/aws
export PATH=~/bin:$PATH
echo "*********************************************"
echo "********** Configuring the AWS CLI **********"
echo "*********************************************"
mkdir ~/.aws
touch ~/.aws/config
touch ~/.aws/credentials
echo -e "[default]\nregion = "${AWS_REGION} > ~/.aws/config
echo -e "[default]\naws_access_key_id = "${AWS_ACCESS_KEY_ID}"\naws_secret_access_key = "${AWS_SECRET_ACCESS_KEY} > ~/.aws/credentials
aws ec2 describe-instances --profile default
echo "**********************************************************"
echo "********** Push image to created AWS repository **********"
echo "**********************************************************"
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
docker build -t ${REPOSITORY_NAWE} .
docker tag ${REPOSITORY_NAWE}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY_NAWE}:${TRAVIS_BRANCH}
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY_NAWE}:${TRAVIS_BRANCH}
echo "**************************************************************************************************************"
echo "********** Update a service's tasks to use a newer Docker image with the same image/tag combination **********"
echo "**************************************************************************************************************"
aws ecs update-service --service ${AWS_ECS_SERVICE_NAME} --cluster ${AWS_ECS_CLUSTER_NAME} --force-new-deployment
echo "*****************************************"
echo "********** Deployment complete **********"
echo "*****************************************"