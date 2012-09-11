--
-- Uncomment the following block if you want to drop existing CSM database objects
--
begin execute immediate 'DROP TABLE CSM_PASSWORD_HISTORY'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_CONFIGURATION_PROPERTIES'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_PASSWORD_HISTORY_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_APPLICATI_APPLICATION__SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_APPLICATION CASCADE CONSTRAINTS'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_GROUP_GROUP_ID_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_GROUP CASCADE CONSTRAINTS'; exception when others then null; end;
/
begin execute immediate 'DROP TRIGGER SET_CSM_PG_PE_PG_PE_ID'; exception when others then null; end;
/
begin execute immediate 'DROP TRIGGER SET_CSM_PG_PE_UPDATE_DATE'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_PG_PE_PG_PE_ID_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_PG_PE CASCADE CONSTRAINTS'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_PRIVILEGE_PRIVILEGE_ID_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_PRIVILEGE CASCADE CONSTRAINTS'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_FILTER_CLAUSE_FILTE_ID_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_FILTER_CLAUSE CASCADE CONSTRAINTS'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_PROTECTION_ELEMENT CASCADE CONSTRAINTS'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_PROTECTIO_PROTECTION_E_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_PROTECTIO_PROTECTION_G_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_PROTECTION_GROUP CASCADE CONSTRAINTS'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_ROLE_ROLE_ID_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_ROLE CASCADE CONSTRAINTS'; exception when others then null; end;
/
begin execute immediate 'DROP TRIGGER SET_CSM_ROLE_PRIV_ROLE_PRIVILE'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_ROLE_PRIV_ROLE_PRIVILE_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_ROLE_PRIVILEGE CASCADE CONSTRAINTS'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_USER_USER_ID_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_USER CASCADE CONSTRAINTS'; exception when others then null; end;
/
begin execute immediate 'DROP TRIGGER SET_CSM_USER_GROU_USER_GROUP_I'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_USER_GROU_USER_GROUP_I_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_USER_GROUP CASCADE CONSTRAINTS'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_USER_GROU_USER_GROUP_R_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_USER_GROUP_ROLE_PG CASCADE CONSTRAINTS'; exception when others then null; end;
/
begin execute immediate 'DROP TRIGGER SET_CSM_USER_PE_USER_PROTECTIO'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_USER_PE_USER_PROTECTIO_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_USER_PE CASCADE CONSTRAINTS'; exception when others then null; end;
/
begin execute immediate 'DROP SEQUENCE CSM_MAPPING_SEQ'; exception when others then null; end;
/
begin execute immediate 'DROP TABLE CSM_MAPPING CASCADE CONSTRAINTS'; exception when others then null; end;
/


CREATE TABLE CSM_APPLICATION ( 
	APPLICATION_ID NUMBER(38) NOT NULL,
	APPLICATION_NAME VARCHAR2(255) NOT NULL,
	APPLICATION_DESCRIPTION VARCHAR2(200) NOT NULL,
	DECLARATIVE_FLAG NUMBER(1) NOT NULL,
	ACTIVE_FLAG NUMBER(1) DEFAULT '0' NOT NULL ,
	UPDATE_DATE DATE NOT NULL,
	DATABASE_URL VARCHAR2(100),
	DATABASE_USER_NAME VARCHAR2(100),
	DATABASE_PASSWORD VARCHAR2(100),
	DATABASE_DIALECT VARCHAR2(100),
	DATABASE_DRIVER VARCHAR2(100)
) 
/

CREATE SEQUENCE CSM_APPLICATI_APPLICATION__SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/

CREATE TABLE CSM_GROUP ( 
	GROUP_ID NUMBER(38) NOT NULL,
	GROUP_NAME VARCHAR2(255) NOT NULL,
	GROUP_DESC VARCHAR2(200),
	UPDATE_DATE DATE NOT NULL,
	APPLICATION_ID NUMBER(38) NOT NULL
) 
/

CREATE SEQUENCE CSM_GROUP_GROUP_ID_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/


CREATE TABLE CSM_PG_PE ( 
	PG_PE_ID NUMBER(38) NOT NULL,
	PROTECTION_GROUP_ID NUMBER(38) NOT NULL,
	PROTECTION_ELEMENT_ID NUMBER(38) NOT NULL,
	UPDATE_DATE DATE DEFAULT sysdate NOT NULL
) 
/

CREATE SEQUENCE CSM_PG_PE_PG_PE_ID_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/

CREATE OR REPLACE TRIGGER SET_CSM_PG_PE_PG_PE_ID
BEFORE INSERT
ON CSM_PG_PE
FOR EACH ROW
BEGIN
  SELECT CSM_PG_PE_PG_PE_ID_SEQ.NEXTVAL
  INTO :NEW.PG_PE_ID
  FROM DUAL;
END;
/


CREATE OR REPLACE TRIGGER SET_CSM_PG_PE_UPDATE_DATE
BEFORE UPDATE
ON CSM_PG_PE
FOR EACH ROW
BEGIN
  SELECT SYSDATE
  INTO :NEW.UPDATE_DATE
  FROM DUAL;
END;
/


CREATE TABLE CSM_PRIVILEGE ( 
	PRIVILEGE_ID NUMBER(38) NOT NULL,
	PRIVILEGE_NAME VARCHAR2(100) NOT NULL,
	PRIVILEGE_DESCRIPTION VARCHAR2(200),
	UPDATE_DATE DATE NOT NULL
) 
/

CREATE SEQUENCE CSM_PRIVILEGE_PRIVILEGE_ID_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/

CREATE TABLE CSM_FILTER_CLAUSE ( 
	FILTER_CLAUSE_ID NUMBER(38) NOT NULL,
	CLASS_NAME VARCHAR2(100) NOT NULL,
	FILTER_CHAIN VARCHAR2(2000) NOT NULL,
	TARGET_CLASS_NAME VARCHAR2 (100) NOT NULL,
	TARGET_CLASS_ATTRIBUTE_NAME VARCHAR2 (100) NOT NULL,
	TARGET_CLASS_ATTRIBUTE_TYPE VARCHAR2 (100) NOT NULL,
	TARGET_CLASS_ALIAS VARCHAR2 (100),
	TARGET_CLASS_ATTRIBUTE_ALIAS VARCHAR2 (100),
	GENERATED_SQL_USER VARCHAR (4000) NOT NULL,
	GENERATED_SQL_GROUP VARCHAR (4000) NOT NULL,
	APPLICATION_ID NUMBER(38) NOT NULL,
	UPDATE_DATE DATE NOT NULL	
) 
/

CREATE SEQUENCE CSM_FILTER_CLAUSE_FILTE_ID_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/


CREATE TABLE CSM_PROTECTION_ELEMENT ( 
	PROTECTION_ELEMENT_ID NUMBER(38) NOT NULL,
	PROTECTION_ELEMENT_NAME VARCHAR2(100) NOT NULL,
	PROTECTION_ELEMENT_DESCRIPTION VARCHAR2(200),
	OBJECT_ID VARCHAR2(100) NOT NULL,
	ATTRIBUTE VARCHAR2(100),
	ATTRIBUTE_VALUE VARCHAR2(100),
	PROTECTION_ELEMENT_TYPE VARCHAR2(100),
	APPLICATION_ID NUMBER(38) NOT NULL,
	UPDATE_DATE DATE NOT NULL
) 
/

CREATE SEQUENCE CSM_PROTECTIO_PROTECTION_E_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/

CREATE TABLE CSM_PROTECTION_GROUP ( 
	PROTECTION_GROUP_ID NUMBER(38) NOT NULL,
	PROTECTION_GROUP_NAME VARCHAR2(100) NOT NULL,
	PROTECTION_GROUP_DESCRIPTION VARCHAR2(200),
	APPLICATION_ID NUMBER(38) NOT NULL,
	LARGE_ELEMENT_COUNT_FLAG NUMBER(1) NOT NULL,
	UPDATE_DATE DATE NOT NULL,
	PARENT_PROTECTION_GROUP_ID NUMBER(38)
) 
/

CREATE SEQUENCE CSM_PROTECTIO_PROTECTION_G_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/


CREATE TABLE CSM_ROLE ( 
	ROLE_ID NUMBER(38) NOT NULL,
	ROLE_NAME VARCHAR2(100) NOT NULL,
	ROLE_DESCRIPTION VARCHAR2(200),
	APPLICATION_ID NUMBER(38) NOT NULL,
	ACTIVE_FLAG NUMBER(1) NOT NULL,
	UPDATE_DATE DATE NOT NULL
) 
/

CREATE SEQUENCE CSM_ROLE_ROLE_ID_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/


CREATE TABLE CSM_ROLE_PRIVILEGE ( 
	ROLE_PRIVILEGE_ID NUMBER(38) NOT NULL,
	ROLE_ID NUMBER(38) NOT NULL,
	PRIVILEGE_ID NUMBER(38) NOT NULL
) 
/

CREATE SEQUENCE CSM_ROLE_PRIV_ROLE_PRIVILE_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/

CREATE OR REPLACE TRIGGER SET_CSM_ROLE_PRIV_ROLE_PRIVILE
BEFORE INSERT
ON CSM_ROLE_PRIVILEGE
FOR EACH ROW
BEGIN
  SELECT CSM_ROLE_PRIV_ROLE_PRIVILE_SEQ.NEXTVAL
  INTO :NEW.ROLE_PRIVILEGE_ID
  FROM DUAL;
END;
/

CREATE TABLE CSM_USER ( 
	USER_ID NUMBER(38) NOT NULL,
	LOGIN_NAME VARCHAR2(500) NOT NULL,
	FIRST_NAME VARCHAR2(100) NOT NULL,
	MIGRATED_FLAG NUMBER(1) DEFAULT '0' NOT NULL ,
	LAST_NAME VARCHAR2(100) NOT NULL,
	ORGANIZATION VARCHAR2(100),
	DEPARTMENT VARCHAR2(100),
	TITLE VARCHAR2(100),
	PHONE_NUMBER VARCHAR2(100),
	PASSWORD VARCHAR2(100),
	EMAIL_ID VARCHAR2(100),
	START_DATE DATE,
	END_DATE DATE,
	UPDATE_DATE DATE NOT NULL,
	PREMGRT_LOGIN_NAME VARCHAR2(100),
  PASSWORD_EXPIRED NUMBER(1),
  PASSWORD_EXPIRY_DATE DATE ,
  FIRST_TIME_LOGIN NUMBER(1),
  ACTIVE_FLAG NUMBER(1)
) 
/

CREATE SEQUENCE CSM_USER_USER_ID_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/

CREATE TABLE CSM_USER_GROUP ( 
	USER_GROUP_ID NUMBER(38) NOT NULL,
	USER_ID NUMBER(38) NOT NULL,
	GROUP_ID NUMBER(38) NOT NULL
) 
/

CREATE SEQUENCE CSM_USER_GROU_USER_GROUP_I_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/

CREATE OR REPLACE TRIGGER SET_CSM_USER_GROU_USER_GROUP_I
BEFORE INSERT
ON CSM_USER_GROUP
FOR EACH ROW
BEGIN
  SELECT CSM_USER_GROU_USER_GROUP_I_SEQ.NEXTVAL
  INTO :NEW.USER_GROUP_ID
  FROM DUAL;
END;
/


CREATE TABLE CSM_USER_GROUP_ROLE_PG ( 
	USER_GROUP_ROLE_PG_ID NUMBER(38) NOT NULL,
	USER_ID NUMBER(38),
	GROUP_ID NUMBER(38),
	ROLE_ID NUMBER(38) NOT NULL,
	PROTECTION_GROUP_ID NUMBER(38) NOT NULL,
	UPDATE_DATE DATE NOT NULL
) 
/

CREATE SEQUENCE CSM_USER_GROU_USER_GROUP_R_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/

CREATE TABLE CSM_USER_PE ( 
	USER_PROTECTION_ELEMENT_ID NUMBER(38) NOT NULL,
	PROTECTION_ELEMENT_ID NUMBER(38) NOT NULL,
	USER_ID NUMBER(38) NOT NULL
) 
/

CREATE SEQUENCE CSM_USER_PE_USER_PROTECTIO_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/

CREATE TABLE CSM_MAPPING (
  MAPPING_ID NUMBER(38) NOT NULL ,
  APPLICATION_ID NUMBER(38) NOT NULL,
  OBJECT_NAME VARCHAR2(100) NOT NULL,
  ATTRIBUTE_NAME VARCHAR2(100) NOT NULL,
  OBJECT_PACKAGE_NAME VARCHAR2(100),
  TABLE_NAME VARCHAR2(100),
  TABLE_NAME_GROUP VARCHAR2(100),
  TABLE_NAME_USER VARCHAR2(100),
  VIEW_NAME_GROUP VARCHAR2(100),
  VIEW_NAME_USER VARCHAR2(100),
  ACTIVE_FLAG NUMBER(1) default '0' NOT NULL,
  MAINTAINED_FLAG NUMBER(1) default '0' NOT NULL,    
  UPDATE_DATE DATE
)
/

CREATE SEQUENCE CSM_MAPPING_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/

CREATE TABLE CSM_PASSWORD_HISTORY (
	CSM_PASSWORD_HISTORY_ID NUMBER(38) NOT NULL,
	LOGIN_NAME VARCHAR2(100),
	PASSWORD VARCHAR2(255)
)
/

CREATE SEQUENCE CSM_PASSWORD_HISTORY_SEQ
increment by 1
start with 1
NOMAXVALUE
minvalue 1
nocycle
nocache
noorder
/


CREATE OR REPLACE TRIGGER SET_CSM_PASSWORD_HISTORY
BEFORE INSERT
ON CSM_PASSWORD_HISTORY
FOR EACH ROW
BEGIN
  SELECT CSM_PASSWORD_HISTORY_SEQ.NEXTVAL
  INTO :NEW.CSM_PASSWORD_HISTORY_ID
  FROM DUAL;
END;
/

CREATE TABLE CSM_CONFIGURATION_PROPERTIES (
  PROPERTY_KEY VARCHAR(300) NOT NULL,
  PROPERTY_VALUE VARCHAR(3000)
) 
/

CREATE OR REPLACE TRIGGER SET_CSM_USER_PE_USER_PROTECTIO
BEFORE INSERT
ON CSM_USER_PE
FOR EACH ROW
BEGIN
  SELECT CSM_USER_PE_USER_PROTECTIO_SEQ.NEXTVAL
  INTO :NEW.USER_PROTECTION_ELEMENT_ID
  FROM DUAL;
END;
/

ALTER TABLE CSM_APPLICATION ADD CONSTRAINT PK_APPLICATION 
PRIMARY KEY (APPLICATION_ID) 
/

ALTER TABLE CSM_GROUP ADD CONSTRAINT PK_GROUP 
PRIMARY KEY (GROUP_ID) 
/

ALTER TABLE CSM_PG_PE ADD CONSTRAINT PK_PG_PE 
PRIMARY KEY (PG_PE_ID) 
/

ALTER TABLE CSM_PRIVILEGE ADD CONSTRAINT PK_PRIVILEGE 
PRIMARY KEY (PRIVILEGE_ID) 
/

ALTER TABLE CSM_PROTECTION_ELEMENT ADD CONSTRAINT PK_PROTECTION_ELEMENT 
PRIMARY KEY (PROTECTION_ELEMENT_ID) 
/

ALTER TABLE CSM_PROTECTION_GROUP ADD CONSTRAINT PK_PROTECTION_GROUP 
PRIMARY KEY (PROTECTION_GROUP_ID) 
/

ALTER TABLE CSM_ROLE ADD CONSTRAINT PK_ROLE 
PRIMARY KEY (ROLE_ID) 
/

ALTER TABLE CSM_FILTER_CLAUSE ADD CONSTRAINT PK_FILTER_CLAUSE 
PRIMARY KEY (FILTER_CLAUSE_ID) 
/

ALTER TABLE CSM_ROLE_PRIVILEGE ADD CONSTRAINT PK_ROLE_PRIVILEGE 
PRIMARY KEY (ROLE_PRIVILEGE_ID) 
/

ALTER TABLE CSM_USER ADD CONSTRAINT PK_USER 
PRIMARY KEY (USER_ID) 
/

ALTER TABLE CSM_USER_GROUP ADD CONSTRAINT PK_USER_GROUP 
PRIMARY KEY (USER_GROUP_ID) 
/

ALTER TABLE CSM_USER_GROUP_ROLE_PG ADD CONSTRAINT PK_USER_GROUP_ROLE_PG 
PRIMARY KEY (USER_GROUP_ROLE_PG_ID) 
/

ALTER TABLE CSM_USER_PE ADD CONSTRAINT PK_USER_PROTECTION_ELEMENT 
PRIMARY KEY (USER_PROTECTION_ELEMENT_ID) 
/

ALTER TABLE CSM_CONFIGURATION_PROPERTIES ADD CONSTRAINT PK_CSM_CONFIGURATION_PROPERTIES
PRIMARY KEY (PROPERTY_KEY) 
/


ALTER TABLE CSM_APPLICATION
ADD CONSTRAINT UQ_APPLICATION_NAME UNIQUE (APPLICATION_NAME)
/
ALTER TABLE CSM_GROUP
ADD CONSTRAINT UQ_GROUP_GROUP_NAME UNIQUE (APPLICATION_ID, GROUP_NAME)
/

ALTER TABLE CSM_PG_PE
ADD CONSTRAINT UQ_PG_PE_PG_PE_ID UNIQUE (PROTECTION_ELEMENT_ID, PROTECTION_GROUP_ID)
/

ALTER TABLE CSM_PRIVILEGE
ADD CONSTRAINT UQ_PRIVILEGE_NAME UNIQUE (PRIVILEGE_NAME)
/

ALTER TABLE CSM_PROTECTION_ELEMENT ADD CONSTRAINT UQ_PE_OBJ_ATT_VAL_APP_ID UNIQUE (OBJECT_ID, ATTRIBUTE, ATTRIBUTE_VALUE, APPLICATION_ID)
/

ALTER TABLE CSM_PROTECTION_GROUP
ADD CONSTRAINT UQ_PG_PG_NAME UNIQUE (APPLICATION_ID, PROTECTION_GROUP_NAME)
/

ALTER TABLE CSM_ROLE
ADD CONSTRAINT UQ_ROLE_ROLE_NAME UNIQUE (APPLICATION_ID, ROLE_NAME)
/

ALTER TABLE CSM_ROLE_PRIVILEGE
ADD CONSTRAINT UQ_ROLE_ID_PRIVILEGE_ID UNIQUE (PRIVILEGE_ID, ROLE_ID)
/

ALTER TABLE CSM_USER
ADD CONSTRAINT UQ_LOGIN_NAME UNIQUE (LOGIN_NAME)
/

ALTER TABLE CSM_USER_PE
ADD CONSTRAINT UQ_USER_PE_PE_ID UNIQUE (USER_ID, PROTECTION_ELEMENT_ID)
/

ALTER TABLE CSM_GROUP ADD CONSTRAINT FK_CSM_GROUP_CSM_APPLICATION 
FOREIGN KEY (APPLICATION_ID) REFERENCES CSM_APPLICATION (APPLICATION_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_FILTER_CLAUSE ADD CONSTRAINT FK_CSM_FC_CSM_APPLICATION 
FOREIGN KEY (APPLICATION_ID) REFERENCES CSM_APPLICATION (APPLICATION_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_PG_PE ADD CONSTRAINT FK_PG_PE_PE 
FOREIGN KEY (PROTECTION_ELEMENT_ID) REFERENCES CSM_PROTECTION_ELEMENT (PROTECTION_ELEMENT_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_PG_PE ADD CONSTRAINT FK_PG_PE_PG 
FOREIGN KEY (PROTECTION_GROUP_ID) REFERENCES CSM_PROTECTION_GROUP (PROTECTION_GROUP_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_PROTECTION_ELEMENT ADD CONSTRAINT FK_PE_APPLICATION 
FOREIGN KEY (APPLICATION_ID) REFERENCES CSM_APPLICATION (APPLICATION_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_PROTECTION_GROUP ADD CONSTRAINT FK_PG_APPLICATION 
FOREIGN KEY (APPLICATION_ID) REFERENCES CSM_APPLICATION (APPLICATION_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_PROTECTION_GROUP ADD CONSTRAINT FK_PG_PG 
FOREIGN KEY (PARENT_PROTECTION_GROUP_ID) REFERENCES CSM_PROTECTION_GROUP (PROTECTION_GROUP_ID)
/

ALTER TABLE CSM_ROLE ADD CONSTRAINT FK_ROLE_APPLICATION 
FOREIGN KEY (APPLICATION_ID) REFERENCES CSM_APPLICATION (APPLICATION_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_ROLE_PRIVILEGE ADD CONSTRAINT FK_ROLE_PRIVILEGE_PRIVILEGE 
FOREIGN KEY (PRIVILEGE_ID) REFERENCES CSM_PRIVILEGE (PRIVILEGE_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_ROLE_PRIVILEGE ADD CONSTRAINT FK_ROLE_PRIVILEGE_ROLE 
FOREIGN KEY (ROLE_ID) REFERENCES CSM_ROLE (ROLE_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_USER_GROUP ADD CONSTRAINT FK_USER_GROUP_GROUP 
FOREIGN KEY (GROUP_ID) REFERENCES CSM_GROUP (GROUP_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_USER_GROUP ADD CONSTRAINT FK_USER_GROUP_USER 
FOREIGN KEY (USER_ID) REFERENCES CSM_USER (USER_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_USER_GROUP_ROLE_PG ADD CONSTRAINT FK_USER_GROUP_ROLE_PG_GROUP 
FOREIGN KEY (GROUP_ID) REFERENCES CSM_GROUP (GROUP_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_USER_GROUP_ROLE_PG ADD CONSTRAINT FK_USER_GROUP_ROLE_PG_PG 
FOREIGN KEY (PROTECTION_GROUP_ID) REFERENCES CSM_PROTECTION_GROUP (PROTECTION_GROUP_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_USER_GROUP_ROLE_PG ADD CONSTRAINT FK_USER_GROUP_ROLE_PG_ROLE 
FOREIGN KEY (ROLE_ID) REFERENCES CSM_ROLE (ROLE_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_USER_GROUP_ROLE_PG ADD CONSTRAINT FK_USER_GROUP_ROLE_PG_USER 
FOREIGN KEY (USER_ID) REFERENCES CSM_USER (USER_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_USER_PE ADD CONSTRAINT FK_USER_PE_USER 
FOREIGN KEY (USER_ID) REFERENCES CSM_USER (USER_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_USER_PE ADD CONSTRAINT FK_USER_PE_PE 
FOREIGN KEY (PROTECTION_ELEMENT_ID) REFERENCES CSM_PROTECTION_ELEMENT (PROTECTION_ELEMENT_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_MAPPING ADD CONSTRAINT PK_MAPPING 
PRIMARY KEY (MAPPING_ID) 
/

ALTER TABLE CSM_MAPPING
ADD CONSTRAINT UQ_MP_OBJ_NAME_ATTRNAME_APP_ID UNIQUE (OBJECT_NAME,ATTRIBUTE_NAME,APPLICATION_ID)
/

ALTER TABLE CSM_MAPPING ADD CONSTRAINT FK_MAPPING_APPLICATION  
FOREIGN KEY (APPLICATION_ID) REFERENCES CSM_APPLICATION (APPLICATION_ID)
ON DELETE CASCADE
/

ALTER TABLE CSM_APPLICATION ADD ( CSM_VERSION VARCHAR2(20))
/

COMMIT
/

