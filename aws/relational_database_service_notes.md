# relational_database_service

## Create PostgreSQL database
- Choose a database creation method
```bash
Standard create
```
- Engine options
```bash
PostgreSQL
```
- Templates
```bash
Production
```
- Settings
```bash
# DB instance identifier
Enter DB instance identifier name
# Credentials Settings
Enter Master username & password
```
- DB instance size
```bash
Burstable classes (includes t classes) - db.t3.micro
```
- Storage
```bash
# Storage type
General Purpose (SSD)
# Allocated storage
20
# Storage autoscaling
Enable storage autoscaling: True
```
- Availability & durability
```bash
# Multi-AZ deployment
Do not create a standby instance
```
- Connectivity
```bash
# Virtual private cloud (VPC)
Create new VPC
# Subnet group
Create new DB Subnet Group
# Public access
Yes
# VPC security group
Create new
# New VPC security group name
Enter VPC security group name
# Additional configuration
Database port - 5432
```

## Connect to RDS PostgreSQL database
- RDS -> Databases -> Connectivity & security -> Endpoint & port -> Endpoint
```bash
psql -h $endpoint -p $port -U $username
```