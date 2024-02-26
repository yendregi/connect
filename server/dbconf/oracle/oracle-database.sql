CREATE TABLE SCHEMA_INFO (VERSION VARCHAR(40));

CREATE SEQUENCE EVENT_SEQUENCE START WITH 1 INCREMENT BY 1;

CREATE TABLE EVENT
	(ID NUMBER(10) NOT NULL PRIMARY KEY,
	DATE_CREATED TIMESTAMP WITH LOCAL TIME ZONE DEFAULT NULL,
	NAME CLOB NOT NULL,
	EVENT_LEVEL VARCHAR(40) NOT NULL,
	OUTCOME VARCHAR(40) NOT NULL,
	ATTRIBUTES CLOB,
	USER_ID NUMBER(10) NOT NULL,
	IP_ADDRESS VARCHAR(40),
	SERVER_ID NVARCHAR2(36));
	
CREATE TABLE CHANNEL
	(ID CHAR(36) NOT NULL PRIMARY KEY,
	NAME VARCHAR(40) NOT NULL,
	REVISION NUMBER(10),
	CHANNEL CLOB);

CREATE TABLE SCRIPT
	(GROUP_ID VARCHAR(40) NOT NULL,
	ID VARCHAR(40) NOT NULL,
	SCRIPT CLOB,
	PRIMARY KEY(GROUP_ID, ID));

CREATE SEQUENCE PERSON_SEQUENCE START WITH 1 INCREMENT BY 1;

CREATE TABLE PERSON
	(ID NUMBER(10) NOT NULL PRIMARY KEY,
	USERNAME VARCHAR(40) NOT NULL,
	FIRSTNAME VARCHAR(40),
	LASTNAME VARCHAR(40),
	ORGANIZATION VARCHAR(255),
	INDUSTRY VARCHAR(255),
	EMAIL VARCHAR(255),
	PHONENUMBER VARCHAR(40),
	DESCRIPTION VARCHAR(255),
	LAST_LOGIN TIMESTAMP WITH LOCAL TIME ZONE DEFAULT NULL,
	GRACE_PERIOD_START TIMESTAMP WITH LOCAL TIME ZONE DEFAULT NULL,
	STRIKE_COUNT NUMBER(10),
	LAST_STRIKE_TIME TIMESTAMP WITH LOCAL TIME ZONE DEFAULT NULL,
	LOGGED_IN CHAR(1) NOT NULL,
	ROLE VARCHAR(40),
	COUNTRY VARCHAR(40),
	STATETERRITORY VARCHAR(40));

ALTER TABLE PERSON ADD USERCONSENT CHAR(1) DEFAULT '0' NOT NULL;
	
CREATE TABLE PERSON_PREFERENCE
	(PERSON_ID NUMBER(10) NOT NULL REFERENCES PERSON(ID) ON DELETE CASCADE,
	NAME VARCHAR(255) NOT NULL,
	VALUE CLOB);

CREATE TABLE PERSON_PASSWORD
	(PERSON_ID NUMBER(10) NOT NULL REFERENCES PERSON(ID) ON DELETE CASCADE,
	PASSWORD VARCHAR(255) NOT NULL,
	PASSWORD_DATE TIMESTAMP WITH LOCAL TIME ZONE DEFAULT NULL);

CREATE INDEX PERSON_PREFERENCE_INDEX1 ON PERSON_PREFERENCE(PERSON_ID);

CREATE TABLE ALERT (
	ID VARCHAR(36) NOT NULL PRIMARY KEY,
	NAME VARCHAR(255) NOT NULL UNIQUE,
	ALERT CLOB NOT NULL
);

CREATE TABLE CODE_TEMPLATE_LIBRARY
	(ID VARCHAR(255) NOT NULL PRIMARY KEY,
	NAME VARCHAR(255) NOT NULL UNIQUE,
	REVISION NUMBER(10),
	LIBRARY CLOB);

CREATE TABLE CODE_TEMPLATE
	(ID VARCHAR(255) NOT NULL PRIMARY KEY,
	NAME VARCHAR(255) NOT NULL,
	REVISION NUMBER(10),
	CODE_TEMPLATE CLOB);

CREATE SEQUENCE CONFIGURATION_SEQUENCE START WITH 1 INCREMENT BY 1;

CREATE TABLE CONFIGURATION
	(CATEGORY VARCHAR(255) NOT NULL,
	NAME VARCHAR(255) NOT NULL,
	VALUE CLOB,
	PRIMARY KEY(CATEGORY, NAME));
	
CREATE TABLE CHANNEL_GROUP
	(ID VARCHAR(255) NOT NULL PRIMARY KEY,
	NAME VARCHAR(255) NOT NULL UNIQUE,
	REVISION NUMBER(10),
	CHANNEL_GROUP CLOB);

CREATE SEQUENCE DEBUG_USAGE_SEQUENCE START WITH 1 INCREMENT BY 1;

CREATE TABLE DEBUGGER_USAGE
    (ID NUMBER(38) DEFAULT DEBUG_USAGE_SEQUENCE.NEXTVAL NOT NULL PRIMARY KEY,
    SERVER_ID VARCHAR(50) NOT NULL,
    DUPP_COUNT NUMBER(38),
    ATTACH_BATCH_COUNT NUMBER(38),
    SOURCE_CONNECTOR_COUNT NUMBER(38),
    SOURCE_FILTER_TRANS_COUNT NUMBER(38),
    DESTINATION_FILTER_TRANS_COUNT NUMBER(38),
    DESTINATION_CONNECTOR_COUNT NUMBER(38),
    RESPONSE_COUNT NUMBER(38),
    INVOCATION_COUNT NUMBER(38));

INSERT INTO PERSON (ID, USERNAME, LOGGED_IN, USERCONSENT) VALUES (PERSON_SEQUENCE.NEXTVAL, 'admin', '0', '0');

INSERT INTO PERSON_PASSWORD (PERSON_ID, PASSWORD) VALUES(PERSON_SEQUENCE.CURRVAL, 'b8cA3mDkavInMc2JBYa6/C3EGxDp7ppqh7FsoXx0x8+3LWK3Ed3ELg==');

INSERT INTO SCHEMA_INFO (VERSION) VALUES ('4.6.0');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'stats.enabled', '1');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'server.resetglobalvariables', '1');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'smtp.timeout', '5000');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'smtp.auth', '0');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'smtp.secure', '0');

INSERT INTO CONFIGURATION (CATEGORY, NAME, VALUE) VALUES ('core', 'server.queuebuffersize', '1000');

COMMIT;
