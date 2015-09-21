alter table testdata add column bar2 varchar(25);
insert into testdata (bar2) values ("hi") where id = 1;