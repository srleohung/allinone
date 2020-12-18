# elastic_container_service

## Create and upload Docker Repositories
- Amazon ECR -> Repositories -> Private/Public repositories -> Create repository
- Amazon ECR -> Repositories -> Images -> View push commands

## Getting Started with Amazon Elastic Container Service (Amazon ECS) using Fargate
- Amazon ECS -> Clusters -> Get Started
- Step 1: Container and Task
Container definition -> Configure -> Edit container -> Container name & Image(Copy from ECR) & Port mappings -> Update -> Next
- Step 2: Service
Define your service -> Load balancer type -> Application Load Balancer -> Next
- Step 3: Cluster
Configure your cluster -> Cluster name -> Next
- Step 4: Review
Create

## Deploy new docker image version to service
- Push new docker image to ECR
```bash
docker push $aws_account_id.dkr.ecr.$region.amazonaws.com/$docker_image_name:$docker_image_tag
```
- Clusters -> Service -> Update -> Force new deployment: True -> Update Service