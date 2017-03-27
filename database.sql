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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

/*Data for the table `sys_nav` */

insert  into `sys_nav`(`id`,`pid`,`name`,`icon`,`path`,`status`,`type`,`sort`,`remark`) values (27,0,'系统管理',8,'/nav/index',1,'module',0,'333'),(28,27,'菜单管理',5,'/nav/index',1,'view',0,'单独的'),(42,0,'后台用户',6,'/user/index',1,'module',0,'后台用户管理'),(43,42,'用户列表',1,'/user/index',1,'view',0,'用户列表'),(52,27,'权限管理',1,'/rbac/index',1,'view',3,'权限管理'),(59,52,'添加权限',1,'/rbac/add',1,'action',0,'添加权限'),(60,42,'用户分组',1,'/usergroup/index',1,'view',0,'用户分组'),(64,28,'菜单列表',1,'/nav/index',1,'action',0,'菜单列表'),(65,28,'添加菜单',1,'/nav/add',1,'action',0,'添加菜单'),(66,28,'编辑菜单',1,'/nav/edit',1,'action',0,'编辑菜单'),(67,28,'删除菜单',1,'/nav/delete',1,'action',0,'删除菜单'),(68,52,'权限列表',1,'/rbac/index',1,'action',0,'权限列表'),(69,52,'编辑权限',1,'/rbac/edit',1,'action',0,'编辑权限'),(70,52,'删除权限',1,'/rbac/delete',1,'action',0,'删除权限'),(71,43,'用户列表',1,'/user/index',1,'action',0,'用户列表'),(72,43,'添加用户',1,'/user/add',1,'action',0,'添加用户'),(73,43,'编辑用户',1,'/user/edit',1,'action',0,'编辑用户'),(74,43,'删除用户',1,'/user/delete',1,'action',0,'编辑用户'),(75,43,'用户详情',1,'/user/userinfo',1,'action',0,'用户详情'),(76,43,'更新状态',1,'/user/updatestatus',1,'action',0,'更新状态'),(77,60,'分组列表',1,'/usergroup/index',1,'action',0,'分组列表'),(78,60,'添加分组',1,'/usergroup/add',1,'action',0,'添加分组'),(79,60,'编辑分组',1,'/usergroup/edit',1,'action',0,'编辑分组'),(80,60,'删除分组',1,'/usergroup/delete',1,'action',0,'删除分组');

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
  KEY `NINDEX` (`nickname`) USING BTREE,
  KEY `ROLE` (`role`),
  CONSTRAINT `ROLE` FOREIGN KEY (`role`) REFERENCES `sys_user_group` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`username`,`password`,`nickname`,`sex`,`mobile`,`email`,`role`,`createtime`,`status`,`remark`,`access_token`,`auth_key`,`login_time`,`login_ip`,`login_num`) values (1,'admin','e10adc3949ba59abbe56e057f20f883e','后台管理员','男','13333913340','459947807@qq.com','admin','2017-03-07 11:33:53',1,'1333',NULL,'','2017-03-27 09:53:08','127.0.0.1',12),(3,'wy375195711','b7793ea1b62e32f6c821b4da4a63b513','小汪','男','18739178207','459947807@qq.com','普通用户','2017-03-22 11:03:01',1,'6666',NULL,NULL,NULL,NULL,0),(12,'wy375195711','b7793ea1b62e32f6c821b4da4a63b513','小明','男','133567566544','sfs@qq.com','普通用户','2017-03-24 16:42:04',1,'小明小明',NULL,NULL,NULL,NULL,0),(13,'yl375195711','b7793ea1b62e32f6c821b4da4a63b513','小王','男','13333545543','afdfdf@163.com','admin','2017-03-24 17:24:57',1,'我是小王',NULL,NULL,NULL,NULL,0);

/*Table structure for table `sys_user_group` */

DROP TABLE IF EXISTS `sys_user_group`;

CREATE TABLE `sys_user_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT '0' COMMENT '父ID',
  `name` varchar(255) DEFAULT NULL COMMENT '分组名',
  `sort` tinyint(4) DEFAULT NULL COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `NAME` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

/*Data for the table `sys_user_group` */

insert  into `sys_user_group`(`id`,`pid`,`name`,`sort`,`remark`) values (43,0,'admin',NULL,'后台管理员'),(47,0,'普通用户',NULL,'普通用户');

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

insert  into `web_auth_assignment`(`item_name`,`user_id`,`created_at`) values ('admin','1',1490347541),('admin','13',1490347525),('普通用户','12',1490347429),('普通用户','3',1490347551);

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

insert  into `web_auth_item`(`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) values ('/nav/add',2,'添加菜单',NULL,NULL,1490577259,1490577259),('/nav/delete',2,'删除菜单',NULL,NULL,1490577355,1490577355),('/nav/edit',2,'编辑菜单',NULL,NULL,1490577306,1490577306),('/nav/index',2,'菜单列表',NULL,NULL,1490577229,1490577229),('/rbac/add',2,'添加权限',NULL,NULL,1490254432,1490261052),('/rbac/delete',2,'删除权限',NULL,NULL,1490577442,1490577442),('/rbac/edit',2,'编辑权限',NULL,NULL,1490577418,1490577418),('/rbac/index',2,'权限列表',NULL,NULL,1490577388,1490577388),('/user/add',2,'添加用户',NULL,NULL,1490577880,1490577880),('/user/delete',2,'编辑用户',NULL,NULL,1490577923,1490577923),('/user/edit',2,'编辑用户',NULL,NULL,1490577901,1490577901),('/user/index',2,'用户列表',NULL,NULL,1490577769,1490577800),('/user/updatestatus',2,'更新状态',NULL,NULL,1490578000,1490578000),('/user/userinfo',2,'用户详情',NULL,NULL,1490577977,1490577977),('/usergroup/add',2,'添加分组',NULL,NULL,1490578147,1490578147),('/usergroup/delete',2,'删除分组',NULL,NULL,1490578205,1490578205),('/usergroup/edit',2,'编辑分组',NULL,NULL,1490578171,1490578171),('/usergroup/index',2,'分组列表',NULL,NULL,1490578124,1490578124),('admin',1,'后台管理员',NULL,NULL,1488445854,1490582120),('后台用户',2,'后台用户管理',NULL,NULL,NULL,1490338528),('普通用户',1,'普通用户',NULL,NULL,1490342020,1490349180),('权限管理',2,'权限管理',NULL,NULL,1490237646,1490338542),('用户分组',2,'用户分组',NULL,NULL,1490263639,1490338517),('用户列表',2,'用户列表',NULL,NULL,NULL,1490338522),('系统管理',2,'333',NULL,NULL,NULL,1490338554),('菜单管理',2,'单独的',NULL,NULL,NULL,1490338569);

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

insert  into `web_auth_item_child`(`parent`,`child`) values ('admin','/nav/add'),('admin','/nav/delete'),('admin','/nav/edit'),('admin','/nav/index'),('admin','/rbac/add'),('普通用户','/rbac/add'),('admin','/rbac/delete'),('admin','/rbac/edit'),('admin','/rbac/index'),('admin','/user/add'),('admin','/user/delete'),('admin','/user/edit'),('admin','/user/index'),('admin','/user/updatestatus'),('admin','/user/userinfo'),('admin','/usergroup/add'),('admin','/usergroup/delete'),('admin','/usergroup/edit'),('admin','/usergroup/index'),('admin','后台用户'),('普通用户','后台用户'),('admin','权限管理'),('普通用户','权限管理'),('admin','用户分组'),('普通用户','用户分组'),('admin','用户列表'),('普通用户','用户列表'),('admin','系统管理'),('普通用户','系统管理'),('admin','菜单管理'),('普通用户','菜单管理');

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
