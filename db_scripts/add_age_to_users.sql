WHENEVER SQLERROR EXIT SQL.SQLCODE
BEGIN
    alter table users add age int;
    update users set age = 39 where last_name = 'Bartholomeus';
END;

