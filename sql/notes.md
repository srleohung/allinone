# sql

# Constraints on a Relation
## Unique
```sql
-- if _FirstName == FirstName && _LastName == LastName; return false
create table Employee (
    FirstName character(20) not null,
    LastName character(20) not null,
    unique (LastName,FirstName)
)
-- if _FirstName == FirstName || _LastName == LastName; return false
create table Employee (
    FirstName character(20) not null unique,
    LastName character(20) not null unique
)
```
## Primary key
```sql
create table Employee (
    EmpNo character(6) primary key,
)
-- or
create table Employee (
    EmpNo character(6),
    primary key (EmpNo)
)
```
## Check
```sql
create domain EmployeeAge as smallint default null check ( value >=18 and value <= 67 )
```
## Foreign key
```sql
create table Student(
    StudNo character(10) primary key,
    Name character(20),
    Hons character(3),
    Tutor character(20) references Staff(Lecturer),
    Year smallint
)
-- or
create table Staff(
    Lecturer character(20) primary key,
    RoomNo character(4),
    Appraiser character(20),
    foreign key (Appraiser) references Staff(Lecturer) on delete set null on update cascade
)
```