--
--  Comment Meta Language Constructs:
--
--  #IfNotTable
--    argument: table_name
--    behavior: if the table_name does not exist,  the block will be executed

--  #IfTable
--    argument: table_name
--    behavior: if the table_name does exist, the block will be executed

--  #IfColumn
--    arguments: table_name colname
--    behavior:  if the table and column exist,  the block will be executed

--  #IfMissingColumn
--    arguments: table_name colname
--    behavior:  if the table exists but the column does not,  the block will be executed

--  #IfNotColumnType
--    arguments: table_name colname value
--    behavior:  If the table table_name does not have a column colname with a data type equal to value, then the block will be executed

--  #IfNotColumnTypeDefault
--    arguments: table_name colname value value2
--    behavior:  If the table table_name does not have a column colname with a data type equal to value and a default equal to value2, then the block will be executed

--  #IfNotRow
--    arguments: table_name colname value
--    behavior:  If the table table_name does not have a row where colname = value, the block will be executed.

--  #IfNotRow2D
--    arguments: table_name colname value colname2 value2
--    behavior:  If the table table_name does not have a row where colname = value AND colname2 = value2, the block will be executed.

--  #IfNotRow3D
--    arguments: table_name colname value colname2 value2 colname3 value3
--    behavior:  If the table table_name does not have a row where colname = value AND colname2 = value2 AND colname3 = value3, the block will be executed.

--  #IfNotRow4D
--    arguments: table_name colname value colname2 value2 colname3 value3 colname4 value4
--    behavior:  If the table table_name does not have a row where colname = value AND colname2 = value2 AND colname3 = value3 AND colname4 = value4, the block will be executed.

--  #IfNotRow2Dx2
--    desc:      This is a very specialized function to allow adding items to the list_options table to avoid both redundant option_id and title in each element.
--    arguments: table_name colname value colname2 value2 colname3 value3
--    behavior:  The block will be executed if both statements below are true:
--               1) The table table_name does not have a row where colname = value AND colname2 = value2.
--               2) The table table_name does not have a row where colname = value AND colname3 = value3.

--  #IfRow
--    arguments: table_name colname value
--    behavior:  If the table table_name does have a row where colname = value, the block will be executed.

--  #IfRow2D
--    arguments: table_name colname value colname2 value2
--    behavior:  If the table table_name does have a row where colname = value AND colname2 = value2, the block will be executed.

--  #IfRow3D
--        arguments: table_name colname value colname2 value2 colname3 value3
--        behavior:  If the table table_name does have a row where colname = value AND colname2 = value2 AND colname3 = value3, the block will be executed.

--  #IfIndex
--    desc:      This function is most often used for dropping of indexes/keys.
--    arguments: table_name colname
--    behavior:  If the table and index exist the relevant statements are executed, otherwise not.

--  #IfNotIndex
--    desc:      This function will allow adding of indexes/keys.
--    arguments: table_name colname
--    behavior:  If the index does not exist, it will be created

--  #IfUuidNeedUpdate
--    argument: table_name
--    behavior: this will add and populate a uuid column into table

--  #IfUuidNeedUpdateId
--    argument: table_name primary_id
--    behavior: this will add and populate a uuid column into table

--  #IfUuidNeedUpdateVertical
--    argument: table_name table_columns
--    behavior: this will add and populate a uuid column into vertical table for combinations of table_columns given

--  #EndIf
--    all blocks are terminated with a #EndIf statement.

--  #IfNotListReaction
--    Custom function for creating Reaction List

--  #IfNotListOccupation
--    Custom function for creating Occupation List

--  #IfTextNullFixNeeded
--    desc: convert all text fields without default null to have default null.
--    arguments: none

--  #IfTableEngine
--    desc:      Execute SQL if the table has been created with given engine specified.
--    arguments: table_name engine
--    behavior:  Use when engine conversion requires more than one ALTER TABLE

--  #IfInnoDBMigrationNeeded
--    desc: find all MyISAM tables and convert them to InnoDB.
--    arguments: none
--    behavior: can take a long time.

--  #IfDocumentNamingNeeded
--    desc: populate name field with document names.
--    arguments: none

#IfUuidNeedUpdate patient_data
#EndIf

#IfUuidNeedUpdate form_encounter
#EndIf

#IfUuidNeedUpdate users
#EndIf

#IfUuidNeedUpdateVertical facility_user_ids uid:facility_id
#EndIf

#IfUuidNeedUpdate facility
#EndIf

#IfUuidNeedUpdate immunizations
#EndIf

#IfUuidNeedUpdate lists
#EndIf

#IfUuidNeedUpdateId procedure_order procedure_order_id
#EndIf

#IfUuidNeedUpdateId drugs drug_id
#EndIf

#IfUuidNeedUpdate prescriptions
#EndIf

#IfUuidNeedUpdateId procedure_result procedure_result_id
#EndIf

#IfUuidNeedUpdate ccda
#EndIf

#IfMissingColumn insurance_companies uuid
ALTER TABLE `insurance_companies` ADD `uuid` binary(16) DEFAULT NULL;
#EndIf

#IfUuidNeedUpdate insurance_companies
#EndIf

#IfNotIndex insurance_companies uuid
CREATE UNIQUE INDEX `uuid` ON `insurance_companies` (`uuid`);
#EndIf

#IfMissingColumn insurance_data uuid
ALTER TABLE `insurance_data` ADD `uuid` binary(16) DEFAULT NULL;
#EndIf

#IfNotIndex insurance_data uuid
CREATE UNIQUE INDEX `uuid` ON `insurance_data` (`uuid`);
#EndIf

#IfUuidNeedUpdate insurance_data
#EndIf

#IfMissingColumn facility weno_id
ALTER TABLE `facility` ADD `weno_id` VARCHAR(10) DEFAULT NULL;
#EndIf

#IfMissingColumn x12_partners x12_gs03
ALTER TABLE `x12_partners` ADD COLUMN `x12_gs03` varchar(15) DEFAULT NULL;
#EndIf

#IfMissingColumn x12_partners x12_submitter_name
ALTER TABLE `x12_partners` ADD COLUMN `x12_submitter_name` varchar(255) DEFAULT NULL;
#EndIf

#IfMissingColumn x12_partners x12_sftp_login
ALTER TABLE `x12_partners` ADD COLUMN `x12_sftp_login` varchar(255) DEFAULT NULL;
#EndIf

#IfMissingColumn x12_partners x12_sftp_pass
ALTER TABLE `x12_partners` ADD COLUMN `x12_sftp_pass` varchar(255) DEFAULT NULL;
#EndIf

#IfMissingColumn x12_partners x12_sftp_host
ALTER TABLE `x12_partners` ADD COLUMN `x12_sftp_host` varchar(255) DEFAULT NULL;
#EndIf

#IfMissingColumn x12_partners x12_sftp_port
ALTER TABLE `x12_partners` ADD COLUMN `x12_sftp_port` varchar(255) DEFAULT NULL;
#EndIf

#IfMissingColumn x12_partners x12_sftp_local_dir
ALTER TABLE `x12_partners` ADD COLUMN `x12_sftp_local_dir` varchar(255) DEFAULT NULL;
#EndIf

#IfMissingColumn x12_partners x12_sftp_remote_dir
ALTER TABLE `x12_partners` ADD COLUMN `x12_sftp_remote_dir` varchar(255) DEFAULT NULL;
#EndIf

#IfNotRow background_services name X12_SFTP
INSERT INTO `background_services` (`name`, `title`, `active`, `running`, `next_run`, `execute_interval`, `function`, `require_once`, `sort_order`) VALUES
('X12_SFTP', 'SFTP Claims to X12 Partner Service', 0, 0, '2021-01-18 11:25:10', 1, 'start_X12_SFTP', '/library/billing_sftp_service.php', 100);
#EndIf

#IfNotTable x12_remote_tracker
CREATE TABLE `x12_remote_tracker` (
`id` bigint(20) NOT NULL AUTO_INCREMENT,
`x12_partner_id` int(11) NOT NULL,
`x12_filename` varchar(255) NOT NULL,
`status` varchar(255) NOT NULL,
`claims` text,
`messages` text,
`created_at` datetime DEFAULT NULL,
`updated_at` datetime DEFAULT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB;

#IfNotRow2D list_options list_id lists option_id Procedure_Billing
INSERT INTO list_options (list_id,option_id,title, seq, is_default, option_value) VALUES ('lists','Procedure_Billing','Procedure Billing',0, 1, 0);
INSERT INTO list_options (list_id,option_id,title,seq,is_default,activity) VALUES ('Procedure_Billing','T','Third-Party',10,1,1);
INSERT INTO list_options (list_id,option_id,title,seq,is_default,activity) VALUES ('Procedure_Billing','P','Self Pay',20,0,1);
INSERT INTO list_options (list_id,option_id,title,seq,is_default,activity) VALUES ('Procedure_Billing','C','Bill Clinic',30,0,1);
#EndIf

#IfMissingColumn procedure_order billing_type
ALTER TABLE `procedure_order` ADD `billing_type` VARCHAR(4) DEFAULT NULL;
#EndIf

#IfMissingColumn procedure_order specimen_fasting
ALTER TABLE `procedure_order` ADD `specimen_fasting` VARCHAR(31) DEFAULT NULL;
#EndIf

#IfMissingColumn procedure_order order_psc
ALTER TABLE `procedure_order` ADD `order_psc` TINYINT(4) DEFAULT NULL;
#EndIf

#IfMissingColumn procedure_order order_abn
ALTER TABLE `procedure_order` ADD `order_abn` VARCHAR(31) NOT NULL DEFAULT 'not_required';
#EndIf

#IfMissingColumn procedure_order collector_id
ALTER TABLE `procedure_order` ADD `collector_id` BIGINT(11) NOT NULL DEFAULT '0';
#EndIf

#IfMissingColumn procedure_order account
ALTER TABLE `procedure_order` ADD `account` VARCHAR(60) DEFAULT NULL;
#EndIf

#IfMissingColumn procedure_order account_facility
ALTER TABLE `procedure_order` ADD `account_facility` int(11) DEFAULT NULL;
#EndIf

#IfMissingColumn procedure_order provider_number
ALTER TABLE `procedure_order` ADD `provider_number` VARCHAR(30) DEFAULT NULL;
#EndIf

#IfMissingColumn procedure_order procedure_order_type
ALTER TABLE `procedure_order` ADD `procedure_order_type` varchar(32) NOT NULL DEFAULT 'laboratory_test';
#EndIf

#IfMissingColumn procedure_order_code procedure_type
ALTER TABLE `procedure_order_code` ADD `procedure_type` VARCHAR(31) DEFAULT NULL;
#EndIf

#IfMissingColumn procedure_order_code transport
ALTER TABLE `procedure_order_code` ADD `transport` VARCHAR(31) DEFAULT NULL;
#EndIf

#IfMissingColumn procedure_type transport
ALTER TABLE `procedure_type` ADD `transport` VARCHAR(31) DEFAULT NULL;
#EndIf

#IfMissingColumn procedure_providers type
ALTER TABLE `procedure_providers` ADD `type` VARCHAR(31) DEFAULT NULL;
#EndIf

#IfMissingColumn procedure_answers procedure_code
ALTER TABLE `procedure_answers` ADD `procedure_code` VARCHAR(31) DEFAULT NULL;
#EndIf

#IfNotRow users username oe-system
INSERT INTO `users`(`username`,`password`,`lname`,`authorized`,`active`) VALUES ('oe-system','NoLogin','System Operation User',0,0);
INSERT INTO `gacl_aro`(`id`, `section_value`, `value`, `order_value`, `name`, `hidden`)
    SELECT max(`id`)+1,'users','oe-system',10,'System Operation User', 0 FROM `gacl_aro`;
INSERT INTO `gacl_groups_aro_map`(`group_id`, `aro_id`)
    VALUES (
        (SELECT `id` FROM `gacl_aro_groups` WHERE parent_id=10 AND value='admin')
        ,(SELECT `id` FROM `gacl_aro` WHERE `section_value` = 'users' AND `value` = 'oe-system')
    );
#EndIf

#IfNotTable export_job
CREATE TABLE `export_job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL ,
  `user_id` varchar(40) NOT NULL,
  `client_id` varchar(80) NOT NULL,
  `status` varchar(40) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `resource_include_time` datetime DEFAULT NULL,
  `output_format` varchar(128) NOT NULL,
  `request_uri` varchar(128) NOT NULL,
  `resources` text,
  `output` text,
  `errors` text,
  `access_token_id` text,
  PRIMARY KEY  (`id`),
  UNIQUE (`uuid`)
) ENGINE=InnoDB COMMENT='fhir export jobs';
#EndIf

#IfNotRow categories name FHIR Export Document
SET @max_rght = (SELECT MAX(rght) FROM categories);
INSERT INTO categories(`id`,`name`, `value`, `parent`, `lft`, `rght`, `aco_spec`) select (select MAX(id) from categories) + 1, 'FHIR Export Document', '', 1, @max_rght, @max_rght + 1, 'admin|super' from categories where name = 'Categories';
UPDATE categories SET rght = rght + 2 WHERE name = 'Categories';
UPDATE categories_seq SET id = (select MAX(id) from categories);
#EndIf

#IfMissingColumn documents date_expires
ALTER TABLE `documents` ADD COLUMN `date_expires` DATETIME DEFAULT NULL;
#EndIf

#IfMissingColumn documents foreign_reference_id
ALTER TABLE `documents` ADD COLUMN `foreign_reference_id` bigint(20) default NULL,
                        ADD COLUMN `foreign_reference_table` VARCHAR(40) default NULL;
ALTER TABLE `documents` ADD KEY `foreign_reference` (`foreign_reference_id`, `foreign_reference_table`);

#IfNotRow background_services name WenoExchange
INSERT INTO `background_services` (`name`, `title`, `active`, `running`, `next_run`, `execute_interval`, `function`, `require_once`, `sort_order`) VALUES
('WenoExchange', 'Weno Log Sync', 0, 0, '2021-01-18 11:25:10', 0, 'start_weno', '/library/weno_log_sync.php', 100);
#EndIf
