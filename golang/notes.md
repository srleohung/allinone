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

# [Dep](https://github.com/golang/dep)
- dep init
- dep ensure

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

## cannot find package "github.com/influxdata/influxdb/client/v2"
### Bug
```bash
# go get github.com/influxdata/influxdb/client/v2
package github.com/influxdata/influxdb/client/v2: cannot find package "github.com/influxdata/influxdb/client/v2" in any of:
...
```
### Fix
```bash
go get github.com/influxdata/influxdb
cd $GOPATH/src/github.com/influxdata/influxdb
git checkout 1.8
```

## json cannot unmarshal certain type into Go struct field
### Bug
```bash
json: cannot unmarshal $TYPE into Go struct field $FIELD of type $TYPE
```

### Fix
```go
// Field appears in JSON as key "myName".
Field int `json:"myName"`

// Field appears in JSON as key "myName" and
// the field is omitted from the object if its value is empty,
// as defined above.
Field int `json:"myName,omitempty"`

// Field appears in JSON as key "Field" (the default), but
// the field is skipped if empty.
// Note the leading comma.
Field int `json:",omitempty"`

// Field is ignored by this package.
Field int `json:"-"`

// Field appears in JSON as key "-".
Field int `json:"-,"`

// Field appears in JSON as key "bool".
// bool, for JSON booleans
Field int `json:"bool"`

// Field appears in JSON as key "float64".
// float64, for JSON numbers
Field int `json:"float64"`

// Field appears in JSON as key "string".
// string, for JSON strings
Field int `json:"string"`

// Field appears in JSON as key "[]interface{}".
// []interface{}, for JSON arrays
Field int `json:"[]interface{}"`

// Field appears in JSON as key "map[string]interface{}".
// map[string]interface{}, for JSON objects
Field int `json:"map[string]interface{}"`

// Field appears in JSON as key "nil".
// nil for JSON null
Field int `json:"nil"`
```

```go
type Float64 float64

func (f *Float64) UnmarshalJSON(bytes []byte) error {
	str := string(bytes)
	if bytes[0] == '"' && bytes[len(bytes)-1] == '"' {
		str = string(bytes[1 : len(bytes)-1])
	}
	o, err := strconv.ParseFloat(str, 64)
	if err != nil {
		return err
	}
	*f = Float64(o)
	return nil
}
```