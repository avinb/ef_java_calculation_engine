WHENEVER SQLERROR EXIT SQL.SQLCODE
alter table users add country varchar2(255);
update users set country = 'Belgium' where first_name = 'Niek';

QUIT;
/