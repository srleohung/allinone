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

# Select
```sql
select ListOfAttributesOrExpressions
from ListOfTables
[ where ConditionsOnTuples ]
[ group by ListOfGroupingAttributes ]
[ having ConditionsOnAggregates ]
[ order by ListOfOrderingAttributes ]
```
## Rename column name use "as"
```sql
select name as personName from person;
```
## Where something and / or
```sql
select * from person where income > 25 and (age < 30 or age > 60);
```
## Value like something
- '_'matches a single letter
- '%' matches a string
```sql
-- Target like AXdXXX
select * from person where name like 'A_d%';
```
## Select multiple tables
```sql
select t1.A1, t2.A4 from Table1 t1, Table2 t2 where t1.A2 = t2.A3;
-- or
select t1.A1, t2.A4 from Table1 t1 join Table2 t2 on t1.A2 = t2.A3;
```
## Join same table, Self-Join
```sql
select t1.A1, t2.A4 from Table1 t1, Table1 t2 where t1.A2 = t2.A3;
-- or
select t1.A1, t2.A4 from Table1 t1 join Table1 t2 on t1.A2 = t2.A3;
```
## Natural join
```sql
```
## Left join
```sql
```
## Right join
```sql
```
## Union
```sql
-- with union, duplicates are eliminated (filter duplicates)
select A1, A2 from Table1 union select A3, A4 from Table2;
-- or with union all duplicates are kept (only duplicates)
select A1, A2 from Table1 union all select A3, A4 from Table2;
```
## Subquery
```sql
select count(*) from city where countrycode=(select code from country where name = 'China');
```

# Aggregate Operators
## Count
```sql
select count(*) from person;
-- or
select count(income) from person;
-- or count different value
select count(distinct income) from person;
```
## Minimum
```sql
select min(age) from person;
```
## Maximum
```sql
select max(age) from person;
```
## Average
```sql
select avg(age) from person;
```
## Sum
```sql
select sum(age) from person;
```
## Grouping
```sql
-- output number of same age 
select age, count(*) from person group by age;
-- select columns must be group by target or aggregate operators
```
## Having
```sql
-- filter aggregate column
select age, count(*) from person group by age having avg(age) > 25;
```
