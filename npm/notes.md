# npm

# Bug Fix
## npm install package timeout
### Bug
```bash
# npm install ${package}
npm ERR! code ETIMEOUT
npm ERR! errno ETIMEOUT
npm ERR! request to https://registry.npmjs.org/${package} failed, reason: A "socket" was not created for HTTP request before 30001ms

# yarn add ${package}
info There appears to be trouble with your network connection. Retrying...
```
### Fix
```bash
$ npm config rm proxy
$ npm config rm https-proxy
```