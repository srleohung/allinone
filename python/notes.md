# python

# Virtualenv
## Installation
```
pip install virtualenv
```
# Usage
- Setup virtualenv
```bash
cd $project_name
virtualenv venv
```
- Activate virtualenv
```bash
source venv/bin/activate
```
- Install package
```bash
pip install $package_name
```
- Backup packages you use
```bash
pip freeze -l > requirements.txt
```
- Install packages
```bash
pip install -r requirements.txt
```

## Fix API server not working (React Hook)
```
from flask_cors import CORS
```
