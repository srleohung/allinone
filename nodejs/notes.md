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