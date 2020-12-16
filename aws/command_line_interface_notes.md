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