# nodejs

# Bug Fix
## 415 Unsupported Media Type
### Bug
```bash
# Add Header Content-Encoding: UTF-8
curl -X POST $url -H 'Content-Encoding: UTF-8'

# Output 
unsupported content encoding utf-8
```
###  Fix
```bash
# NGINX configuration 
proxy_set_header Content-Encoding "";
```

## Error: /lib/x86_64-linux-gnu/libc.so.6: version 'GLIBC_2.28' not found

### Bug
The libc.so version does not support the old version of glibc

### Fix
Downgrade ubuntu version to build application