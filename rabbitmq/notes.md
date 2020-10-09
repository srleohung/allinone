# rabbitmq

## Installing on Debian and Ubuntu
- Add Repository Signing Key
```bash
curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | sudo apt-key add -
```
- Enable apt HTTPS Transport
```bash
sudo apt-get install apt-transport-https
```

- Add a Source List File
```bash
sudo nano /etc/apt/sources.list.d/bintray.erlang.list
```
```bash
# /etc/apt/sources.list.d/bintray.erlang.list

# Distribution
# - focal for Ubuntu 20.04
# - bionic for Ubuntu 18.04
# - xenial for Ubuntu 16.04
# - buster for Debian Buster
# - stretch for Debian Stretch

# Component (Erlang/OTP Version)
# - erlang
# - erlang-22.x

# This repository provides Erlang packages produced by the RabbitMQ team
# See below for supported distribution and component values
deb https://dl.bintray.com/rabbitmq-erlang/debian $distribution $component
```

- Install Erlang Packages
```bash
sudo apt-get update -y
# This is recommended. Metapackages such as erlang and erlang-nox must only be used
# with apt version pinning. They do not pin their dependency versions.
sudo apt-get install -y erlang-base \
                        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                        erlang-runtime-tools erlang-snmp erlang-ssl \
                        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl
```

- Package Version and Repository Pinning
```bash
sudo nano /etc/apt/preferences.d/erlang
```
```bash
# /etc/apt/preferences.d/erlang
Package: erlang*
Pin: release o=Bintray
Pin-Priority: 1000
```
```
sudo nano /etc/apt/preferences.d/rabbitmq
```
```bash
# /etc/apt/preferences.d/rabbitmq
Package: rabbitmq-server
Pin: version 1:3.8.9
Pin-Priority: 1000
```
```bash
sudo apt-cache policy
```

- Using RabbitMQ Apt Repository on PackageCloud
```bash
# import PackageCloud signing key
wget -O - "https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey" | sudo apt-key add -
```

- Quick Start Example
```bash
#!/bin/sh

## If sudo is not available on the system,
## uncomment the line below to install it
# apt-get install -y sudo

sudo apt-get update -y

## Install prerequisites
sudo apt-get install curl gnupg -y

## Install RabbitMQ signing key
curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | sudo apt-key add -

## Install apt HTTPS transport
sudo apt-get install apt-transport-https

## Add Bintray repositories that provision latest RabbitMQ and Erlang 23.x releases
sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list <<EOF
## Installs the latest Erlang 23.x release.
## Change component to "erlang-22.x" to install the latest 22.x version.
## "bionic" as distribution name should work for any later Ubuntu or Debian release.
## See the release to distribution mapping table in RabbitMQ doc guides to learn more.
deb https://dl.bintray.com/rabbitmq-erlang/debian bionic erlang
## Installs latest RabbitMQ release
deb https://dl.bintray.com/rabbitmq/debian bionic main
EOF

## Update package indices
sudo apt-get update -y

## Install rabbitmq-server and its dependencies
sudo apt-get install rabbitmq-server -y --fix-missing
```

- Add a Source List File
```
sudo nano /etc/apt/sources.list.d/bintray.rabbitmq.list
```
```bash
# /etc/apt/sources.list.d/bintray.rabbitmq.list

# Distribution
# - focal for Ubuntu 20.04
# - bionic for Ubuntu 18.04
# - xenial for Ubuntu 16.04
# - buster for Debian Buster
# - stretch for Debian Stretch
# Component (Erlang/OTP Version)

# Source repository definition example.
# See below for supported distribution and component values

# Use this line to install the latest Erlang 22.3.x package available
deb https://dl.bintray.com/rabbitmq-erlang/debian $distribution erlang-22.x

# Or use this line to install the latest Erlang 23.x package available
# deb https://dl.bintray.com/rabbitmq-erlang/debian $distribution erlang

# This repository provides RabbitMQ packages
deb https://dl.bintray.com/rabbitmq/debian $distribution main
```

- Install RabbitMQ Package
```bash
sudo apt-get update -y
sudo apt-get install -y rabbitmq-server
```

- Manual Installation with Dpkg
```bash
# sync package metadata
sudo apt-get update
# install dependencies manually
sudo apt-get -y install socat logrotate init-system-helpers adduser

# download the package
sudo apt-get -y install wget
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.9/rabbitmq-server_3.8.9-1_all.deb

# install the package with dpkg
sudo dpkg -i rabbitmq-server_3.8.9-1_all.deb

rm rabbitmq-server_3.8.9-1_all.deb
```

- Run RabbitMQ Server
```bash
sudo service rabbitmq-server start
```

## Managing the Service
```bash
# checks if the local node is running and CLI tools can successfully authenticate with it
sudo rabbitmq-diagnostics ping

# prints enabled components (applications), TCP listeners, memory usage breakdown, alarms
# and so on
sudo rabbitmq-diagnostics status

# prints effective node configuration
sudo rabbitmq-diagnostics environment

# performs a more extensive health check of the local node
sudo rabbitmq-diagnostics node_health_check
```

## Log Files and Management
```bash
journalctl --system
sudo journalctl --system | grep rabbitmq
```

## RabbitMQ Enable Web Management Plugin
```bash
sudo rabbitmq-plugins enable rabbitmq_management
# Now you can open web management plugin in the browser for that enter the following URL in browser and click enter.
# http://localhost:15672
# After opening the localhost URL in browser, it will ask you for credentials to access web management plugin.
# To access rabbitmq web management dashboard, the default Username and password of  is “guest” (Username: “guest” | Password: “guest”).
```