WHENEVER SQLERROR EXIT SQL.SQLCODE
update "E-FINANCE".users set age = age + 1;
COMMIT;

QUIT;
