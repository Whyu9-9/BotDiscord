/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 8.0.13 : Database - db_bot
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_bot` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;

USE `db_bot`;

/*Table structure for table `tb_inbox` */

DROP TABLE IF EXISTS `tb_inbox`;

CREATE TABLE `tb_inbox` (
  `id_inbox` bigint(20) NOT NULL AUTO_INCREMENT,
  `chat_id` bigint(20) NOT NULL,
  `in_msg` text,
  `flag` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '1',
  `tgl` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pengirim` varchar(255) NOT NULL,
  `type` enum('msg','file','loc','img') DEFAULT 'msg',
  PRIMARY KEY (`id_inbox`),
  KEY `id_chat` (`chat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=360 DEFAULT CHARSET=latin1;

/*Data for the table `tb_inbox` */

insert  into `tb_inbox`(`id_inbox`,`chat_id`,`in_msg`,`flag`,`tgl`,`pengirim`,`type`) values 
(356,703989809533681795,'Cg gg','1','2020-04-26 23:20:59','486047912002846740','msg'),
(357,703993625482100740,'apapun','1','2020-04-26 23:20:59','493397996403425297','msg'),
(358,703993650425626746,'eka ganteng','1','2020-04-26 23:20:59','493397996403425297','msg'),
(359,703994104845172786,'lo kontol','1','2020-04-26 23:20:59','493397996403425297','msg');

/*Table structure for table `tb_outbox` */

DROP TABLE IF EXISTS `tb_outbox`;

CREATE TABLE `tb_outbox` (
  `id_outbox` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_inbox` bigint(20) DEFAULT NULL,
  `chat_id` bigint(20) NOT NULL,
  `out_msg` text,
  `flag` enum('0','1') DEFAULT NULL,
  `tgl` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pengirim` varchar(255) NOT NULL,
  `type` enum('msg','file','loc','img') DEFAULT NULL,
  PRIMARY KEY (`id_outbox`),
  KEY `id_inbox` (`id_inbox`),
  KEY `chat_id` (`chat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=326 DEFAULT CHARSET=latin1;

/*Data for the table `tb_outbox` */

insert  into `tb_outbox`(`id_outbox`,`id_inbox`,`chat_id`,`out_msg`,`flag`,`tgl`,`pengirim`,`type`) values 
(322,356,703989809533681795,'Cg gg','1','2020-04-26 23:20:59','486047912002846740','msg'),
(323,357,703993625482100740,'apapun','1','2020-04-26 23:20:59','493397996403425297','msg'),
(324,358,703993650425626746,'eka ganteng','1','2020-04-26 23:20:59','493397996403425297','msg'),
(325,359,703994104845172786,'lo kontol','1','2020-04-26 23:20:59','493397996403425297','msg');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
