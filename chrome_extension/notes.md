# chrome_extension

# React Chrome Extension
```bash
# Install create-react-app
npm install -g create-react-app
# Create extension example
create-react-app my-extension
# Build extension
npm run build
```

# Errors
* Refused to execute inline script error
    ```
    Refused to execute inline script because it violates the following Content Security Policy directive: "script-src 'self' blob: filesystem:". Either the 'unsafe-inline' keyword, a hash ('sha256-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'), or a nonce ('nonce-...') is required to enable inline execution.
    ```
    1. Create `.env.production` and enter `INLINE_RUNTIME_CHUNK=false`
    2. Build the extension again
