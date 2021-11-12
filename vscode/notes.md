# vscode

# Golang
macOS - $HOME/Library/Application\ Support/Code/User/settings.json
## Add Test Flags
![add_test_flags](./add_test_flags.jpg "add_test_flags")
```json
{
    "go.testFlags": ["-v"]
}
```

## Add Gopath
```json
{
   "go.gopath": "enter your gopath"
}
```

## Disable Go Mod
```json
{
    "go.toolsEnvVars": {
       "GO111MODULE": "off"
   }
}
```