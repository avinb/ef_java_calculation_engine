WHENEVER SQLERROR EXIT SQL.SQLCODE
alter table "E-FINANCE".USERS add country varchar2(255);
update "E-FINANCE".USERS set country = 'Belgium' where first_name = 'Niek';
COMMIT;

QUIT;
