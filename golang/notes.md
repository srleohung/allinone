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

# Issues
How to set the project is not under gopath, but you can run the go command?
- use symbolic link
```bash
cd $your_project
ln -s $(pwd)/$your_project $GOPATH/src/$your_project
```

# Bug Fix
## go get package show undefined things
### Bug
```bash
# github.com/tealeg/xlsx
../../github.com/tealeg/xlsx/diskv.go:195:8: undefined: strings.Builder
```
### Fix
- The new version may lack some variables or functions. You need to check its github branch, what is needed and check out the branch ID.
```bash
cd $GOPATH/src/github.com/tealeg/xlsx
git checkout 5fbeeee
```
## "gcc": executable file not found in $PATH
### Bug
```bash
# zakkaya/vendor/github.com/gvalkov/golang-evdev
exec: "gcc": executable file not found in $PATH
```
### Fix
```bash
sudo apt-get  install  build-essential
```
## json.Unmarshal not working
struct field operatingUnitAisle has json tag but is not exported
### Bug
```go
type Example struct {
    id   string `json:"id"`
    data string `json:"data"`
}
var example Example
json.Unmarshal(data, &example)
```
### Fix
```go
type Example struct {
    ID   string `json:"id"`
    Data string `json:"data"`
}
var example Example
json.Unmarshal(data, &example)
```