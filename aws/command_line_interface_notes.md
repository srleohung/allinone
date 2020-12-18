# command_line_interface

## [Install](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html#cliv2-mac-install-cmd)
```bash
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
sudo installer -pkg ./AWSCLIV2.pkg -target /
```

## Configure
```bash
aws configure

# Example
# AWS Access Key ID [None]: XXXXXXXXXXXXXXXXXXXX
# AWS Secret Access Key [None]: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 
# Default region name [None]: e.g. ap-east-1
# Default output format [None]: 

# Generate AWS Access Key Step
# Identity and Access Management (IAM) -> Users -> User -> Summary -> Security credentials -> Create access key
```

## Push commands for ECR
```bash
# Retrieve an authentication token and authenticate your Docker client to your registry.
aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $aws_account_id.dkr.ecr.$region.amazonaws.com
# Build your Docker image using the following command. You can skip this step if your image is already built.
docker build -t $docker_image_name .
# After the build completes, tag your image so you can push the image to this repository.
docker tag $docker_image_name:$docker_image_tag $aws_account_id.dkr.ecr.$region.amazonaws.com/$docker_image_name:$docker_image_tag
# Run the following command to push this image to your newly created AWS repository.
docker push $aws_account_id.dkr.ecr.$region.amazonaws.com/$docker_image_name:$docker_image_tag
```