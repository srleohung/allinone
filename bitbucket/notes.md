# bitbucket

## Use Pipeline
- Enable Pipeline

Repository settings -> Settings -> Pipelines settings -> Enable Pipelines: True
- Use Repository variables

Repository settings -> Repository variables 

## Pipeline Template
- Docker build and deploy to existing AWS Fargate service
```yml
# ${REPOSITORY_NAWE}/bitbucket-pipelines.yml
image: atlassian/default-image:2

# ***** Repository variables *****
# REPOSITORY_NAWE
# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY
# AWS_REGION
# AWS_ACCOUNT_ID
# AWS_ECS_SERVICE_NAME
# AWS_ECS_CLUSTER_NAME
# ***** ! Repository variables *****

pipelines:
  default:
    - step:
        name: 'Docker build and deploy to existing AWS Fargate service'
        services:
          - docker
        script:
          # Installing the AWS CLI
          - apt-get update && apt-get install -y jq
          - curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
          - unzip awscli-bundle.zip
          - ./awscli-bundle/install -b ~/bin/aws
          - export PATH=~/bin:$PATH
          # Configuring the AWS CLI
          - mkdir ~/.aws
          - touch ~/.aws/config
          - touch ~/.aws/credentials
          - echo -e "[default]\nregion = "${AWS_REGION} > ~/.aws/config
          - echo -e "[default]\naws_access_key_id = "${AWS_ACCESS_KEY_ID}"\naws_secret_access_key = "${AWS_SECRET_ACCESS_KEY} > ~/.aws/credentials
          - aws ec2 describe-instances --profile default
          # Push image to created AWS repository
          - aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
          - docker build -t ${REPOSITORY_NAWE} .
          - docker tag ${REPOSITORY_NAWE}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY_NAWE}:latest
          - docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY_NAWE}:latest
          # Update a service's tasks to use a newer Docker image with the same image/tag combination
          - aws ecs update-service --service ${AWS_ECS_SERVICE_NAME} --cluster ${AWS_ECS_CLUSTER_NAME} --force-new-deployment
```