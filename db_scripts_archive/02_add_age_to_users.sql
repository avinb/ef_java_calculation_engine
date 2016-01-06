WHENEVER SQLERROR EXIT SQL.SQLCODE
alter table "E-FINANCE".USERS add age int;
update "E-FINANCE".USERS set age = 39 where last_name like 'Bartholomeus%';
COMMIT;

QUIT;
