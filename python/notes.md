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
- Setup virtualenv specific python version
```bash
virtualenv venv --python=$python_execute_path
# example: virtualenv venv --python=/usr/bin/python
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

# Lookup
- Dictionary lookup (e.g., foo["bar"])
- Attribute lookup (e.g., foo.bar)
- Method call (e.g., foo.bar())
- List-index lookup (e.g., foo[2])

## Fix API server not working (React Hook)
```
from flask_cors import CORS
```
