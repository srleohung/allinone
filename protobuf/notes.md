# protobuf

# Install
## Download protoc
https://github.com/protocolbuffers/protobuf/releases

## Use go get to install grpc
```bash
# Install grpc
go get google.golang.org/grpc
# Install protoc-gen-go
go get github.com/golang/protobuf/protoc-gen-go
# Add protoc-gen-go command
PATH=$PATH:$GOPATH/bin
```

## Use pip to install grpc
```bash
python -m pip install grpcio
python -m pip install grpcio-tools
```

# Usage
## Generate pb.go
```bash
protoc -I . *.proto --go_out=plugins=grpc:.
# If this error is displayed, please confirm that your protoc-gen-go command exists.
protoc-gen-go: program not found or is not executable
Please specify a program using absolute path or make sure the program is available in your PATH system variable
--go_out: protoc-gen-go: Plugin failed with status code 1.
```
## Generate pb.python
```bash
python -m grpc_tools.protoc --proto_path=$proto_path --python_out=. --grpc_python_out=. $proto_path/*.proto
```

# Protocol format (.proto)
## Protocol version
```go
syntax = "proto2"; // or "proto3"
```
## Package name
```go
package service;
```
## Service function input(Empty) and output(ServiceStatus)
```go
service Service {
  rpc GetServiceStatus (Empty) returns (ServiceStatus) {}
}
```
## Message structure
```go
message Empty {}

message ServiceStatus {
	Status status = 1;
}
```
## Data type
```go
enum Status {
	DISABLE = 0;
	ENABLE = 1;
}
```