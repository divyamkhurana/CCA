CREATE DATABASE famousfinger;

CREATE TABLE famousfinger.analyst ( 
	analyst_id           INT UNSIGNED NOT NULL  AUTO_INCREMENT,
	first_name           VARCHAR(50)  NOT NULL  ,
	last_name            VARCHAR(50)  NOT NULL  ,
	email                VARCHAR(254)  NOT NULL  ,
	mobile_no            VARCHAR(15)    ,
	phone_no             VARCHAR(20)    ,
	city                 VARCHAR(64)    ,
	pincode              VARCHAR(30)    ,
	address              VARCHAR(1024)    ,
	country              VARCHAR(64)    ,
	date_added           TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP ,
	last_activity        DATETIME  NOT NULL  ,
	PASSWORD             VARCHAR(20)    ,
	role                 VARCHAR(50)  NOT NULL  ,
	CONSTRAINT pk_analyst PRIMARY KEY ( analyst_id ),
	CONSTRAINT idx_analyst UNIQUE ( email ) 
 ) ENGINE=INNODB;

CREATE TABLE famousfinger.location ( 
	location_code        CHAR(3)  NOT NULL  ,
	location_name        VARCHAR(64)  NOT NULL  ,
	CONSTRAINT pk_location PRIMARY KEY ( location_code )
 ) ENGINE=INNODB;

CREATE TABLE famousfinger.messages ( 
	message_id           INT UNSIGNED NOT NULL  AUTO_INCREMENT,
	heading              VARCHAR(256)  NOT NULL  ,
	message              VARCHAR(1024)    ,
	date_posted          TIMESTAMP  NOT NULL  ,
	posted_by            INT UNSIGNED NOT NULL  ,
	CONSTRAINT pk_messages PRIMARY KEY ( message_id )
 ) ENGINE=INNODB;

CREATE INDEX idx_messages ON famousfinger.messages ( posted_by );

CREATE TABLE famousfinger.notification_type ( 
	type_id              SMALLINT UNSIGNED NOT NULL  AUTO_INCREMENT,
	type_name            VARCHAR(64)  NOT NULL  ,
	type_desc            VARCHAR(1024)    ,
	CONSTRAINT pk_notification_type PRIMARY KEY ( type_id )
 ) ENGINE=INNODB;

CREATE TABLE famousfinger.pins_request_status ( 
	pins_status_id       SMALLINT UNSIGNED NOT NULL  AUTO_INCREMENT,
	status_desc          VARCHAR(32)    ,
	CONSTRAINT pk_pins_request_status PRIMARY KEY ( pins_status_id )
 ) ENGINE=INNODB;

CREATE TABLE famousfinger.report_status ( 
	report_status_id     SMALLINT UNSIGNED NOT NULL  AUTO_INCREMENT,
	status_desc          VARCHAR(32)    ,
	CONSTRAINT pk_report_status PRIMARY KEY ( report_status_id )
 );

CREATE TABLE famousfinger.consultant ( 
	consultant_id        VARCHAR(10)  NOT NULL  ,
	key_for_id           INT  NOT NULL  AUTO_INCREMENT,
	first_name           VARCHAR(50)  NOT NULL  ,
	last_name            VARCHAR(50)  NOT NULL  ,
	email                VARCHAR(254)  NOT NULL  ,
	mobile_no            VARCHAR(15)    ,
	phone_no             VARCHAR(20)    ,
	city                 VARCHAR(64)    ,
	location             CHAR(3)  NOT NULL  ,
	pin_code             VARCHAR(30)    ,
	address              VARCHAR(1024)    ,
	country              VARCHAR(64)    ,
	date_added           TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP ,
	added_by             VARCHAR(64)  NOT NULL  ,
	added_by_id          VARCHAR(10)  NOT NULL  ,
	last_activity        DATETIME  NOT NULL  ,
	role                 VARCHAR(50)  NOT NULL  ,
	PASSWORD             VARCHAR(20)    ,
	pins_left            INT UNSIGNED   ,
	STATUS               VARCHAR(20)  NOT NULL  ,
	is_disabled          BIT    ,
	CONSTRAINT pk_consultant PRIMARY KEY ( consultant_id ),
	CONSTRAINT idx_consultant_0 UNIQUE ( email ) ,
	CONSTRAINT key_for_id UNIQUE ( key_for_id ) 
 ) ENGINE=INNODB;

CREATE INDEX idx_consultant ON famousfinger.consultant ( location );

CREATE TABLE famousfinger.notification ( 
	notification_id      BIGINT UNSIGNED NOT NULL  ,
	type_id              SMALLINT UNSIGNED NOT NULL  ,
	obj_id               VARCHAR(12)    ,
	subject_id           VARCHAR(12)  NOT NULL  ,
	for_id               VARCHAR(12)  NOT NULL  ,
	date_created         TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP ,
	is_seen              BIT  NOT NULL DEFAULT 0 ,
	CONSTRAINT pk_notification PRIMARY KEY ( notification_id )
 ) ENGINE=INNODB;

CREATE INDEX idx_notification ON famousfinger.notification ( type_id );

CREATE TABLE famousfinger.pins_request ( 
	request_id           BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT,
	requested_by         VARCHAR(10)  NOT NULL  ,
	no_of_pins           INT UNSIGNED NOT NULL  ,
	payment              FLOAT UNSIGNED NOT NULL  ,
	payment_mode         VARCHAR(64)  NOT NULL  ,
	date_of_payment      DATE  NOT NULL  ,
	date_cancelled       DATETIME    ,
	cancellation_reason  VARCHAR(1024)    ,
	date_requested       TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP ,
	pins_status_id       SMALLINT UNSIGNED   ,
	CONSTRAINT pk_pinsrequest PRIMARY KEY ( request_id )
 ) ENGINE=INNODB;

CREATE INDEX idx_pinsrequest ON famousfinger.pins_request ( requested_by );

CREATE INDEX idx_pins_request ON famousfinger.pins_request ( pins_status_id );

CREATE TABLE famousfinger.report ( 
	report_id            BIGINT UNSIGNED NOT NULL  AUTO_INCREMENT,
	created_by           VARCHAR(10)  NOT NULL  ,
	date_created         TIMESTAMP  NOT NULL  ,
	report_of            VARCHAR(64)  NOT NULL  ,
	report_type          VARCHAR(64)  NOT NULL  ,
	analyst              INT UNSIGNED   ,
	date_analysed        DATETIME    ,
	date_cancelled       DATETIME    ,
	date_completed       DATETIME    ,
	special_remarks      VARCHAR(1024)    ,
	fingerprints_file_path VARCHAR(512)  NOT NULL  ,
	analysis_report_file_path VARCHAR(512)    ,
	cancellation_reason  VARCHAR(256)    ,
	report_status_id     SMALLINT UNSIGNED   ,
	CONSTRAINT pk_report PRIMARY KEY ( report_id )
 ) ENGINE=INNODB;

CREATE INDEX idx_report ON famousfinger.report ( created_by );

CREATE INDEX idx_report_0 ON famousfinger.report ( analyst );

CREATE INDEX idx_report_1 ON famousfinger.report ( report_status_id );

CREATE TABLE famousfinger.pins_assigned ( 
	assign_id            INT UNSIGNED NOT NULL  AUTO_INCREMENT,
	assigned_to          VARCHAR(10)  NOT NULL  ,
	request_id           BIGINT UNSIGNED   ,
	pins_assigned        INT UNSIGNED NOT NULL  ,
	date_assigned        TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP ,
	CONSTRAINT pk_pinsassigned PRIMARY KEY ( assign_id )
 ) ENGINE=INNODB;

CREATE INDEX idx_pinsassigned1 ON famousfinger.pins_assigned ( assigned_to );

CREATE INDEX idx_pinsassigned ON famousfinger.pins_assigned ( request_id );

ALTER TABLE famousfinger.consultant ADD CONSTRAINT fk_consultant_location FOREIGN KEY ( location ) REFERENCES famousfinger.location( location_code ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE famousfinger.notification ADD CONSTRAINT fk_notification FOREIGN KEY ( type_id ) REFERENCES famousfinger.notification_type( type_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE famousfinger.pins_assigned ADD CONSTRAINT fk_pins_assigned_consultant FOREIGN KEY ( assigned_to ) REFERENCES famousfinger.consultant( consultant_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE famousfinger.pins_assigned ADD CONSTRAINT fk_pins_assigned_pins_request FOREIGN KEY ( request_id ) REFERENCES famousfinger.pins_request( request_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE famousfinger.pins_request ADD CONSTRAINT fk_pins_request_consultant FOREIGN KEY ( requested_by ) REFERENCES famousfinger.consultant( consultant_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE famousfinger.pins_request ADD CONSTRAINT fk_pins_request FOREIGN KEY ( pins_status_id ) REFERENCES famousfinger.pins_request_status( pins_status_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE famousfinger.report ADD CONSTRAINT fk_report_analyst FOREIGN KEY ( analyst ) REFERENCES famousfinger.analyst( analyst_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE famousfinger.report ADD CONSTRAINT fk_report_consultant FOREIGN KEY ( created_by ) REFERENCES famousfinger.consultant( consultant_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE famousfinger.report ADD CONSTRAINT fk_report_report_status FOREIGN KEY ( report_status_id ) REFERENCES famousfinger.report_status( report_status_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

