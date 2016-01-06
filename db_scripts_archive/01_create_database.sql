CREATE USER "E-FINANCE_TEST" IDENTIFIED BY VALUES 'S:A05B197E10766B4358B44E159386ED8EA1252CB895B41A12B10DB2C4F6D2;776020FF9C17D3A3'
  DEFAULT TABLESPACE "USERS"
  TEMPORARY TABLESPACE "TEMP";

GRANT "CONNECT" TO "E-FINANCE_TEST" WITH ADMIN OPTION;
GRANT "RESOURCE" TO "E-FINANCE_TEST" WITH ADMIN OPTION;
GRANT "DBA" TO "E-FINANCE_TEST" WITH ADMIN OPTION;

GRANT UNLIMITED TABLESPACE TO "E-FINANCE_TEST" WITH ADMIN OPTION;

ALTER USER "E-FINANCE_TEST" DEFAULT ROLE ALL;

CREATE TABLE USERS
(
   ID           NUMBER (10),
   FIRST_NAME   VARCHAR2 (255),
   LAST_NAME    VARCHAR2 (255)
)
NOCACHE
LOGGING;

CREATE UNIQUE INDEX IDX_USERS
   ON USERS (ID)
   LOGGING;

ALTER TABLE users
   MODIFY id CONSTRAINT cnt_id_not_null NOT NULL VALIDATE;

ALTER TABLE users
   ADD CONSTRAINT cnt_id_pk PRIMARY KEY (id) VALIDATE;

CREATE SEQUENCE SEQ_USERS_ID START WITH 1
                             INCREMENT BY 1
                             MAXVALUE 9999999999999999999999999999
                             NOMINVALUE
                             NOORDER
                             NOCYCLE
                             CACHE 20;

CREATE OR REPLACE TRIGGER TR_USERS_ID
   BEFORE INSERT
   ON "E-FINANCE_TEST".USERS
   REFERENCING NEW AS new OLD AS old
   FOR EACH ROW
BEGIN
   SELECT "E-FINANCE_TEST".SEQ_USERS_ID.NEXTVAL INTO :new.ID FROM DUAL;
END;

QUIT;
/
