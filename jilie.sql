/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.6.17 : Database - jilie
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`jilie` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `jilie`;

/*Table structure for table `migration` */

DROP TABLE IF EXISTS `migration`;

CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `migration` */

insert  into `migration`(`version`,`apply_time`) values ('m000000_000000_base',1488436314),('m140506_102106_rbac_init',1488436319);

/*Table structure for table `sys_nav` */

DROP TABLE IF EXISTS `sys_nav`;

CREATE TABLE `sys_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL COMMENT '父ID',
  `name` varchar(255) DEFAULT NULL COMMENT '导航名称',
  `icon` tinyint(4) DEFAULT '1' COMMENT '图标id',
  `path` varchar(255) DEFAULT NULL COMMENT '路径',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态(1:正常,2:隐藏)',
  `type` enum('view','action','module') DEFAULT 'view' COMMENT '类型(system:系统,module:模块,view:页面,action:操作)',
  `sort` tinyint(4) DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

/*Data for the table `sys_nav` */

insert  into `sys_nav`(`id`,`pid`,`name`,`icon`,`path`,`status`,`type`,`sort`,`remark`) values (27,0,'系统管理',8,'/nav/index',1,'module',0,'333'),(28,27,'菜单管理',5,'/nav/index',1,'view',0,'单独的'),(42,0,'后台用户',6,'/user/index',1,'module',0,'后台用户管理'),(43,42,'用户列表',1,'/user/index',1,'view',0,''),(52,27,'权限管理',1,'/rbac/index',1,'view',3,'权限管理'),(59,52,'添加权限',1,'/rbac/addyyy',1,'action',0,'添加权限');

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL COMMENT '账户',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `sex` enum('男','女') DEFAULT '男' COMMENT '性别',
  `mobile` varchar(255) DEFAULT NULL COMMENT '手机',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `role` varchar(255) DEFAULT NULL COMMENT '角色',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态（1:正常,2:禁用）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `access_token` varchar(255) DEFAULT NULL,
  `auth_key` varchar(255) DEFAULT NULL,
  `login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `login_ip` varchar(255) DEFAULT NULL COMMENT '最后登录ip',
  `login_num` int(11) DEFAULT '0' COMMENT '登录次数',
  PRIMARY KEY (`id`),
  KEY `UNAME` (`username`) USING BTREE,
  KEY `PWD` (`password`) USING BTREE,
  KEY `MINDEX` (`mobile`) USING BTREE,
  KEY `EINDEX` (`email`) USING BTREE,
  KEY `NINDEX` (`nickname`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`username`,`password`,`nickname`,`sex`,`mobile`,`email`,`role`,`createtime`,`status`,`remark`,`access_token`,`auth_key`,`login_time`,`login_ip`,`login_num`) values (1,'admin','e10adc3949ba59abbe56e057f20f883e','后台管理员','男','13333913340','459947807@qq.com','管理员','2017-03-07 11:33:53',1,'1333',NULL,'','2017-03-23 09:22:11','127.0.0.1',7),(3,'wy375195711','b7793ea1b62e32f6c821b4da4a63b513','小汪','男','18739178207','459947807@qq.com','2','2017-03-22 11:03:01',1,'6666',NULL,NULL,NULL,NULL,0);

/*Table structure for table `web_auth_assignment` */

DROP TABLE IF EXISTS `web_auth_assignment`;

CREATE TABLE `web_auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  CONSTRAINT `web_auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `web_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `web_auth_assignment` */

insert  into `web_auth_assignment`(`item_name`,`user_id`,`created_at`) values ('admin','1',1488445966);

/*Table structure for table `web_auth_item` */

DROP TABLE IF EXISTS `web_auth_item`;

CREATE TABLE `web_auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` smallint(6) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`),
  CONSTRAINT `web_auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `web_auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `web_auth_item` */

insert  into `web_auth_item`(`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) values ('/rbac/addyyy',2,'添加权限',NULL,NULL,1490254432,1490254693),('/site/test',2,'创建了 index 许可',NULL,NULL,1488445828,1488445828),('admin',1,'后台管理员',NULL,NULL,1488445854,1488445854),('权限管理',2,'权限管理',NULL,NULL,1490237646,1490252002);

/*Table structure for table `web_auth_item_child` */

DROP TABLE IF EXISTS `web_auth_item_child`;

CREATE TABLE `web_auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `web_auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `web_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `web_auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `web_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `web_auth_item_child` */

insert  into `web_auth_item_child`(`parent`,`child`) values ('admin','/site/test');

/*Table structure for table `web_auth_rule` */

DROP TABLE IF EXISTS `web_auth_rule`;

CREATE TABLE `web_auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` blob,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `web_auth_rule` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
