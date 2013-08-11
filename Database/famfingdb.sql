/*
SQLyog Community v9.63 
MySQL - 5.1.65-community : Database - famousfinger
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`famousfinger` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `famousfinger`;

/*Table structure for table `analyst` */

DROP TABLE IF EXISTS `analyst`;

CREATE TABLE `analyst` (
  `analyst_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  `mobile_no` varchar(15) DEFAULT NULL,
  `phone_no` varchar(20) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `pincode` varchar(30) DEFAULT NULL,
  `address` varchar(1024) DEFAULT NULL,
  `country` varchar(64) DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_activity` datetime NOT NULL,
  `password` varchar(20) DEFAULT NULL,
  `role` varchar(50) NOT NULL,
  PRIMARY KEY (`analyst_id`),
  UNIQUE KEY `idx_analyst` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `analyst` */

insert  into `analyst`(`analyst_id`,`first_name`,`last_name`,`email`,`mobile_no`,`phone_no`,`city`,`pincode`,`address`,`country`,`date_added`,`last_activity`,`password`,`role`) values (1,'goria','mehta','gm@jk.com','23434242343','3243242234','gfg','214545','fgsdfsd','india','2013-05-01 19:09:40','2013-01-13 00:00:00','fff','fsf');

/*Table structure for table `consultant` */

DROP TABLE IF EXISTS `consultant`;

CREATE TABLE `consultant` (
  `consultant_id` varchar(10) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  `mobile_no` varchar(15) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `pin_code` varchar(30) DEFAULT NULL,
  `address` varchar(1024) DEFAULT NULL,
  `country` varchar(64) DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `added_by` varchar(64) NOT NULL,
  `added_by_id` varchar(10) NOT NULL,
  `last_activity` datetime NOT NULL,
  `role` varchar(50) NOT NULL,
  `password` varchar(20) DEFAULT NULL,
  `pins_left` int(10) unsigned DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `phone_no` varchar(20) DEFAULT NULL,
  `location` char(3) NOT NULL,
  `is_disabled` tinyint(1) DEFAULT NULL,
  `key_for_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`consultant_id`),
  UNIQUE KEY `idx_consultant_0` (`email`),
  UNIQUE KEY `key_for_id` (`key_for_id`),
  KEY `idx_consultant` (`location`),
  CONSTRAINT `fk_consultant_location` FOREIGN KEY (`location`) REFERENCES `location` (`location_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `consultant` */

/*Table structure for table `location` */

DROP TABLE IF EXISTS `location`;

CREATE TABLE `location` (
  `location_code` char(3) NOT NULL,
  `location_name` varchar(64) NOT NULL,
  PRIMARY KEY (`location_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `location` */

/*Table structure for table `messages` */

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `heading` varchar(256) NOT NULL,
  `message` varchar(1024) DEFAULT NULL,
  `date_posted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `posted_by` int(11) NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `idx_messages` (`posted_by`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `messages` */

/*Table structure for table `notification` */

DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
  `notification_id` bigint(20) unsigned NOT NULL,
  `type_id` smallint(5) unsigned NOT NULL,
  `obj_id` varchar(12) DEFAULT NULL,
  `subject_id` varchar(12) NOT NULL,
  `for_id` varchar(12) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_seen` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`notification_id`),
  KEY `idx_notification` (`type_id`),
  CONSTRAINT `fk_notification` FOREIGN KEY (`type_id`) REFERENCES `notification_type` (`type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `notification` */

/*Table structure for table `notification_type` */

DROP TABLE IF EXISTS `notification_type`;

CREATE TABLE `notification_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `type_name` varchar(64) NOT NULL,
  `type_desc` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `notification_type` */

/*Table structure for table `pins_assigned` */

DROP TABLE IF EXISTS `pins_assigned`;

CREATE TABLE `pins_assigned` (
  `assign_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `assigned_to` varchar(10) NOT NULL,
  `request_id` bigint(20) unsigned DEFAULT NULL,
  `pins_assigned` int(10) unsigned NOT NULL,
  `date_assigned` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`assign_id`),
  KEY `idx_pinsassigned1` (`assigned_to`),
  KEY `idx_pinsassigned` (`request_id`),
  CONSTRAINT `fk_pins_assigned_consultant` FOREIGN KEY (`assigned_to`) REFERENCES `consultant` (`consultant_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pins_assigned_pins_request` FOREIGN KEY (`request_id`) REFERENCES `pins_request` (`request_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pins_assigned` */

/*Table structure for table `pins_request` */

DROP TABLE IF EXISTS `pins_request`;

CREATE TABLE `pins_request` (
  `request_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `requested_by` varchar(10) NOT NULL,
  `no_of_pins` int(10) unsigned NOT NULL,
  `status` varchar(32) NOT NULL,
  `payment` float unsigned NOT NULL,
  `payment_mode` varchar(64) NOT NULL,
  `date_of_payment` date NOT NULL,
  `date_cancelled` datetime DEFAULT NULL,
  `cancellation_reason` varchar(1024) DEFAULT NULL,
  `date_requested` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`request_id`),
  KEY `idx_pinsrequest` (`requested_by`),
  CONSTRAINT `fk_pins_request_consultant` FOREIGN KEY (`requested_by`) REFERENCES `consultant` (`consultant_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pins_request` */

/*Table structure for table `report` */

DROP TABLE IF EXISTS `report`;

CREATE TABLE `report` (
  `report_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_by` varchar(10) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `report_of` varchar(64) NOT NULL,
  `report_type` varchar(64) NOT NULL,
  `analyst` int(10) unsigned DEFAULT NULL,
  `date_analysed` datetime DEFAULT NULL,
  `date_cancelled` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `status` varchar(32) NOT NULL,
  `special_remarks` varchar(1024) DEFAULT NULL,
  `fingerprints_file_path` varchar(512) NOT NULL,
  `analysis_report_file_path` varchar(512) DEFAULT NULL,
  `cancellation_reason` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `idx_report` (`created_by`),
  KEY `idx_report_0` (`analyst`),
  CONSTRAINT `fk_report_analyst` FOREIGN KEY (`analyst`) REFERENCES `analyst` (`analyst_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_consultant` FOREIGN KEY (`created_by`) REFERENCES `consultant` (`consultant_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `report` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
