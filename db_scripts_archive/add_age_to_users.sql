WHENEVER SQLERROR EXIT SQL.SQLCODE
alter table users add age int;
update users set age = 39 where last_name like 'Bartholomeus%';

