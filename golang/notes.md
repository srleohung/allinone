# golang

# Install
## Linux
```bash
# Download golang installation file
$ wget https://dl.google.com/go/go1.9.4.linux-amd64.tar.gz

# Set user permissions for installation
$ sudo chown $(whoami):$(whoami) -R /usr/local
$ tar -C /usr/local -xzf go1.9.4.linux-amd64.tar.gz

# Set the go command for the user
$ export PATH=$PATH:/usr/local/go/bin

# Set the gopath of the installation package
$ mkdir $HOME/go
$ export GOPATH=$HOME/go
```

## Check if the installation is complete
### Check if the go command can be used
#### Input
```bash
# Use go command to check go version
$ go version
```
#### Output
```bash
# Can display go version
go version go1.9.4 linux/amd64
```
### Check if the GOPATH setting is complete
#### Input
```bash
# Install the package "serialnetwork" to gopath
$ go get github.com/srleohung/serialnetwork
# Check if the package "serialnetwork" exists
$ ls $GOPATH/src/github.com/srleohung
```
#### Output
```bash
# File exists
serialnetwork
```