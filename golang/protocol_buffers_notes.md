# golang protocol buffers

# Install
## MacOS
```bash
# Install protoc
brew install protobuf

# Install protoc-gen-go
go get github.com/golang/protobuf/protoc-gen-go
go install google.golang.org/protobuf/cmd/protoc-gen-go

# Install protoc-gen-go-grpc
go get google.golang.org/grpc/cmd/protoc-gen-go-grpc
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc
```

# Bug Fix
## protoc-gen-go-grpc: program not found or is not executable
### Bug
```bash
# protoc --go-grpc_out=:. *.proto
protoc-gen-go-grpc: program not found or is not executable
Please specify a program using absolute path or make sure the program is available in your PATH system variable
--go-grpc_out: protoc-gen-go-grpc: Plugin failed with status code 1.
```
### Fix
- Install protoc-gen-go-grpc
```bash
go get google.golang.org/grpc/cmd/protoc-gen-go-grpc
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc
```