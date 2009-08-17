CREATE TABLE CSM_APPLICATION ( 
	APPLICATION_ID BIGINT AUTO_INCREMENT  NOT NULL,
	APPLICATION_NAME VARCHAR(100) NOT NULL,
	APPLICATION_DESCRIPTION VARCHAR(200) NOT NULL,
	DECLARATIVE_FLAG BOOL,
	ACTIVE_FLAG BOOL NOT NULL,
	UPDATE_DATE DATE NOT NULL,
	PRIMARY KEY(APPLICATION_ID)
)Type=InnoDB
;

CREATE TABLE CSM_GROUP ( 
	GROUP_ID BIGINT AUTO_INCREMENT  NOT NULL,
	GROUP_NAME VARCHAR(100) NOT NULL,
	GROUP_DESC VARCHAR(200),
	UPDATE_DATE DATE NOT NULL,
	APPLICATION_ID BIGINT NOT NULL,
	PRIMARY KEY(GROUP_ID)
)Type=InnoDB
;

CREATE TABLE CSM_PRIVILEGE ( 
	PRIVILEGE_ID BIGINT AUTO_INCREMENT  NOT NULL,
	PRIVILEGE_NAME VARCHAR(100) NOT NULL,
	PRIVILEGE_DESCRIPTION VARCHAR(200),
	UPDATE_DATE DATE NOT NULL,
	PRIMARY KEY(PRIVILEGE_ID)
)Type=InnoDB
;

CREATE TABLE CSM_PROTECTION_ELEMENT ( 
	PROTECTION_ELEMENT_ID BIGINT AUTO_INCREMENT  NOT NULL,
	PROTECTION_ELEMENT_NAME VARCHAR(100) NOT NULL,
	PROTECTION_ELEMENT_DESCRIPTION VARCHAR(200),
	OBJECT_ID VARCHAR(100) NOT NULL,
	ATTRIBUTE VARCHAR(100) ,
	PROTECTION_ELEMENT_TYPE_ID NUMERIC(10),
	APPLICATION_ID BIGINT NOT NULL,
	UPDATE_DATE DATE NOT NULL,
	PRIMARY KEY(PROTECTION_ELEMENT_ID)
)Type=InnoDB
;

CREATE TABLE CSM_PROTECTION_GROUP ( 
	PROTECTION_GROUP_ID BIGINT AUTO_INCREMENT  NOT NULL,
	PROTECTION_GROUP_NAME VARCHAR(100) NOT NULL,
	PROTECTION_GROUP_DESCRIPTION VARCHAR(200),
	APPLICATION_ID BIGINT NOT NULL,
	LARGE_ELEMENT_COUNT_FLAG BOOL NOT NULL,
	UPDATE_DATE DATE NOT NULL,
	PARENT_PROTECTION_GROUP_ID BIGINT,
	PRIMARY KEY(PROTECTION_GROUP_ID)
)Type=InnoDB
;

CREATE TABLE CSM_PG_PE ( 
	PG_PE_ID BIGINT AUTO_INCREMENT  NOT NULL,
	PROTECTION_GROUP_ID BIGINT NOT NULL,
	PROTECTION_ELEMENT_ID BIGINT NOT NULL,
	UPDATE_DATE DATE NOT NULL,
	PRIMARY KEY(PG_PE_ID)
)Type=InnoDB
;

CREATE TABLE CSM_ROLE ( 
	ROLE_ID BIGINT AUTO_INCREMENT  NOT NULL,
	ROLE_NAME VARCHAR(100) NOT NULL,
	ROLE_DESCRIPTION VARCHAR(200),
	APPLICATION_ID BIGINT NOT NULL,
	ACTIVE_FLAG BOOL NOT NULL,
	UPDATE_DATE DATE NOT NULL,
	PRIMARY KEY(ROLE_ID)
)Type=InnoDB
;

CREATE TABLE CSM_ROLE_PRIVILEGE ( 
	ROLE_PRIVILEGE_ID BIGINT AUTO_INCREMENT  NOT NULL,
	ROLE_ID BIGINT NOT NULL,
	PRIVILEGE_ID BIGINT NOT NULL,
	UPDATE_DATE DATE NOT NULL,
	PRIMARY KEY(ROLE_PRIVILEGE_ID)
)Type=InnoDB
;

CREATE TABLE CSM_USER ( 
	USER_ID BIGINT AUTO_INCREMENT  NOT NULL,
	LOGIN_NAME VARCHAR(100) NOT NULL,
	FIRST_NAME VARCHAR(100) NOT NULL,
	LAST_NAME VARCHAR(100) NOT NULL,
	ORGANIZATION VARCHAR(100),
	DEPARTMENT VARCHAR(100),
	TITLE VARCHAR(100),
	PHONE_NUMBER VARCHAR(15),
	PASSWORD VARCHAR(100),
	EMAIL_ID VARCHAR(100),
	START_DATE DATE,
	END_DATE DATE,
	UPDATE_DATE DATE NOT NULL,
	PRIMARY KEY(USER_ID)
)Type=InnoDB
;

CREATE TABLE CSM_USER_GROUP ( 
	USER_GROUP_ID BIGINT AUTO_INCREMENT  NOT NULL,
	USER_ID BIGINT NOT NULL,
	GROUP_ID BIGINT NOT NULL,
	PRIMARY KEY(USER_GROUP_ID)
)Type=InnoDB
;

CREATE TABLE CSM_USER_GROUP_ROLE_PG ( 
	USER_GROUP_ROLE_PG_ID BIGINT AUTO_INCREMENT  NOT NULL,
	USER_ID BIGINT,
	GROUP_ID BIGINT,
	ROLE_ID BIGINT NOT NULL,
	PROTECTION_GROUP_ID BIGINT NOT NULL,
	UPDATE_DATE DATE NOT NULL,
	PRIMARY KEY(USER_GROUP_ROLE_PG_ID)
)Type=InnoDB
;

CREATE TABLE CSM_USER_PE ( 
	USER_PROTECTION_ELEMENT_ID BIGINT AUTO_INCREMENT  NOT NULL,
	PROTECTION_ELEMENT_ID BIGINT NOT NULL,
	USER_ID BIGINT NOT NULL,
	UPDATE_DATE DATE NOT NULL,
	PRIMARY KEY(USER_PROTECTION_ELEMENT_ID)
)Type=InnoDB
;



ALTER TABLE CSM_APPLICATION
ADD CONSTRAINT UQ_APPLICATION_NAME UNIQUE (APPLICATION_NAME)
;
CREATE INDEX idx_APPLICATION_ID ON CSM_GROUP(APPLICATION_ID)
;
ALTER TABLE CSM_GROUP
ADD CONSTRAINT UQ_GROUP_GROUP_NAME UNIQUE (APPLICATION_ID, GROUP_NAME)
;
ALTER TABLE CSM_PRIVILEGE
ADD CONSTRAINT UQ_PRIVILEGE_NAME UNIQUE (PRIVILEGE_NAME)
;
CREATE INDEX idx_APPLICATION_ID ON CSM_PROTECTION_ELEMENT(APPLICATION_ID)
;
ALTER TABLE CSM_PROTECTION_ELEMENT
ADD CONSTRAINT UQ_PE_PE_NAME_ATTRIBUTE_APP_ID UNIQUE (OBJECT_ID, ATTRIBUTE, APPLICATION_ID)
;
CREATE INDEX idx_APPLICATION_ID ON CSM_PROTECTION_GROUP(APPLICATION_ID)
;
ALTER TABLE CSM_PROTECTION_GROUP
ADD CONSTRAINT UQ_PROTECTION_GROUP_PROTECTION_GROUP_NAME UNIQUE (APPLICATION_ID, PROTECTION_GROUP_NAME)
;
CREATE INDEX idx_PARENT_PROTECTION_GROUP_ID ON CSM_PROTECTION_GROUP(PARENT_PROTECTION_GROUP_ID)
;
CREATE INDEX idx_PROTECTION_ELEMENT_ID ON CSM_PG_PE(PROTECTION_ELEMENT_ID)
;
CREATE INDEX idx_PROTECTION_GROUP_ID ON CSM_PG_PE(PROTECTION_GROUP_ID)
;
ALTER TABLE CSM_PG_PE
ADD CONSTRAINT UQ_PROTECTION_GROUP_PROTECTION_ELEMENT_PROTECTION_GROUP_ID UNIQUE (PROTECTION_ELEMENT_ID, PROTECTION_GROUP_ID)
;
CREATE INDEX idx_APPLICATION_ID ON CSM_ROLE(APPLICATION_ID)
;
ALTER TABLE CSM_ROLE
ADD CONSTRAINT UQ_ROLE_ROLE_NAME UNIQUE (APPLICATION_ID, ROLE_NAME)
;
CREATE INDEX idx_PRIVILEGE_ID ON CSM_ROLE_PRIVILEGE(PRIVILEGE_ID)
;
ALTER TABLE CSM_ROLE_PRIVILEGE
ADD CONSTRAINT UQ_ROLE_PRIVILEGE_ROLE_ID UNIQUE (PRIVILEGE_ID, ROLE_ID)
;
CREATE INDEX idx_ROLE_ID ON CSM_ROLE_PRIVILEGE(ROLE_ID)
;
ALTER TABLE CSM_USER
ADD CONSTRAINT UQ_LOGIN_NAME UNIQUE (LOGIN_NAME)
;
CREATE INDEX idx_USER_ID ON CSM_USER_GROUP(USER_ID)
;
CREATE INDEX idx_GROUP_ID ON CSM_USER_GROUP(GROUP_ID)
;
CREATE INDEX idx_GROUP_ID ON CSM_USER_GROUP_ROLE_PG(GROUP_ID)
;
CREATE INDEX idx_ROLE_ID ON CSM_USER_GROUP_ROLE_PG(ROLE_ID)
;
CREATE INDEX idx_PROTECTION_GROUP_ID ON CSM_USER_GROUP_ROLE_PG(PROTECTION_GROUP_ID)
;
CREATE INDEX idx_USER_ID ON CSM_USER_GROUP_ROLE_PG(USER_ID)
;
CREATE INDEX idx_USER_ID ON CSM_USER_PE(USER_ID)
;
CREATE INDEX idx_PROTECTION_ELEMENT_ID ON CSM_USER_PE(PROTECTION_ELEMENT_ID)
;
ALTER TABLE CSM_USER_PE
ADD CONSTRAINT UQ_USER_PROTECTION_ELEMENT_PROTECTION_ELEMENT_ID UNIQUE (USER_ID, PROTECTION_ELEMENT_ID)
;


ALTER TABLE CSM_GROUP ADD CONSTRAINT FK_APPLICATION_GROUP 
FOREIGN KEY (APPLICATION_ID) REFERENCES CSM_APPLICATION (APPLICATION_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_PROTECTION_ELEMENT ADD CONSTRAINT FK_PE_APPLICATION 
FOREIGN KEY (APPLICATION_ID) REFERENCES CSM_APPLICATION (APPLICATION_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_PROTECTION_GROUP ADD CONSTRAINT FK_PG_APPLICATION 
FOREIGN KEY (APPLICATION_ID) REFERENCES CSM_APPLICATION (APPLICATION_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_PROTECTION_GROUP ADD CONSTRAINT FK_PROTECTION_GROUP 
FOREIGN KEY (PARENT_PROTECTION_GROUP_ID) REFERENCES CSM_PROTECTION_GROUP (PROTECTION_GROUP_ID)
;

ALTER TABLE CSM_PG_PE ADD CONSTRAINT FK_PROTECTION_ELEMENT_PROTECTION_GROUP 
FOREIGN KEY (PROTECTION_ELEMENT_ID) REFERENCES CSM_PROTECTION_ELEMENT (PROTECTION_ELEMENT_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_PG_PE ADD CONSTRAINT FK_PROTECTION_GROUP_PROTECTION_ELEMENT 
FOREIGN KEY (PROTECTION_GROUP_ID) REFERENCES CSM_PROTECTION_GROUP (PROTECTION_GROUP_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_ROLE ADD CONSTRAINT FK_APPLICATION_ROLE 
FOREIGN KEY (APPLICATION_ID) REFERENCES CSM_APPLICATION (APPLICATION_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_ROLE_PRIVILEGE ADD CONSTRAINT FK_PRIVILEGE_ROLE 
FOREIGN KEY (PRIVILEGE_ID) REFERENCES CSM_PRIVILEGE (PRIVILEGE_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_ROLE_PRIVILEGE ADD CONSTRAINT FK_ROLE 
FOREIGN KEY (ROLE_ID) REFERENCES CSM_ROLE (ROLE_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_USER_GROUP ADD CONSTRAINT FK_USER_GROUP 
FOREIGN KEY (USER_ID) REFERENCES CSM_USER (USER_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_USER_GROUP ADD CONSTRAINT FK_UG_GROUP 
FOREIGN KEY (GROUP_ID) REFERENCES CSM_GROUP (GROUP_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_USER_GROUP_ROLE_PG ADD CONSTRAINT FK_USER_GROUP_ROLE_PROTECTION_GROUP_GROUPS 
FOREIGN KEY (GROUP_ID) REFERENCES CSM_GROUP (GROUP_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_USER_GROUP_ROLE_PG ADD CONSTRAINT FK_USER_GROUP_ROLE_PROTECTION_GROUP_ROLE 
FOREIGN KEY (ROLE_ID) REFERENCES CSM_ROLE (ROLE_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_USER_GROUP_ROLE_PG ADD CONSTRAINT FK_USER_GROUP_ROLE_PROTECTION_GROUP_PROTECTION_GROUP 
FOREIGN KEY (PROTECTION_GROUP_ID) REFERENCES CSM_PROTECTION_GROUP (PROTECTION_GROUP_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_USER_GROUP_ROLE_PG ADD CONSTRAINT FK_USER_GROUP_ROLE_PROTECTION_GROUP_USER 
FOREIGN KEY (USER_ID) REFERENCES CSM_USER (USER_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_USER_PE ADD CONSTRAINT FK_PE_USER 
FOREIGN KEY (USER_ID) REFERENCES CSM_USER (USER_ID)
ON DELETE CASCADE
;

ALTER TABLE CSM_USER_PE ADD CONSTRAINT FK_PROTECTION_ELEMENT_USER 
FOREIGN KEY (PROTECTION_ELEMENT_ID) REFERENCES CSM_PROTECTION_ELEMENT (PROTECTION_ELEMENT_ID)
ON DELETE CASCADE
;