/*
 Navicat Premium Data Transfer

 Source Server         : syslog_sql
 Source Server Type    : MySQL
 Source Server Version : 80024
 Source Host           : 192.168.20.19:3306
 Source Schema         : syslog

 Target Server Type    : MySQL
 Target Server Version : 80024
 File Encoding         : 65001

 Date: 22/11/2022 11:28:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for log_base
-- ----------------------------
DROP TABLE IF EXISTS `log_base`;
CREATE TABLE `log_base` (
  `sid` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `client_ip` int unsigned NOT NULL COMMENT '客户端IP',
  `pri` int DEFAULT NULL COMMENT '日志等级int',
  `levinfo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '日志等级',
  `msg` longtext COMMENT '日志信息',
  `input_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  PRIMARY KEY (`sid`),
  KEY `levinfo_key` (`levinfo`) USING BTREE,
  KEY `client_ip_key` (`client_ip`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=42531112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for office_ac_file_transfer_log
-- ----------------------------
DROP TABLE IF EXISTS `office_ac_file_transfer_log`;
CREATE TABLE `office_ac_file_transfer_log` (
  `sid` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户名',
  `ugname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户分组',
  `term_platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '系统平台',
  `term_device` varchar(255) DEFAULT NULL COMMENT '设备类型',
  `pid` int DEFAULT NULL COMMENT 'pid',
  `src_mac` varchar(255) DEFAULT NULL COMMENT '访问源mac',
  `src_ip` int unsigned DEFAULT NULL COMMENT '访问源ip',
  `dst_ip` int unsigned DEFAULT NULL COMMENT '访问到ip',
  `dst_port` int DEFAULT NULL COMMENT '访问到端口',
  `app_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '程序名',
  `app_cat_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '程序类型',
  `handle_action` int DEFAULT NULL COMMENT '句柄',
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `action_name` varchar(255) DEFAULT NULL COMMENT '接收、发送',
  `file_name` text COMMENT '文件名',
  `msg` text COMMENT '信息',
  `input_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  `log_base_ook` int unsigned DEFAULT NULL COMMENT '对应原始日志id',
  PRIMARY KEY (`sid`),
  KEY `log_base_ook_s` (`log_base_ook`),
  KEY `src_ip_key` (`src_ip`) USING BTREE,
  KEY `dst_ip_key` (`dst_ip`) USING BTREE,
  KEY `action_name_key` (`action_name`) USING BTREE,
  KEY `app_cat_name_key` (`app_cat_name`) USING BTREE,
  KEY `app_name_key` (`app_name`) USING BTREE,
  KEY `file_name_key` (`file_name`(500)) USING BTREE,
  KEY `src_mac_key` (`src_mac`) USING BTREE,
  KEY `term_device_key` (`term_device`) USING BTREE,
  KEY `ugname_key` (`ugname`) USING BTREE,
  KEY `user_name_key` (`user_name`) USING BTREE,
  KEY `term_platform_key` (`term_platform`) USING BTREE,
  KEY `sid_key` (`sid` DESC) USING BTREE,
  CONSTRAINT `office_ac_file_transfer_log_ibfk_1` FOREIGN KEY (`log_base_ook`) REFERENCES `log_base` (`sid`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=279352 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='办公网wifi_ac文件流量表';

-- ----------------------------
-- Table structure for office_ac_mail
-- ----------------------------
DROP TABLE IF EXISTS `office_ac_mail`;
CREATE TABLE `office_ac_mail` (
  `sid` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户名',
  `ugname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户分组',
  `term_platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '系统平台',
  `term_device` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '设备类型',
  `pid` int DEFAULT NULL COMMENT 'pid',
  `src_mac` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '访问源mac',
  `src_ip` int unsigned DEFAULT NULL COMMENT '访问源ip',
  `dst_ip` int unsigned DEFAULT NULL COMMENT '访问到ip',
  `dst_port` int DEFAULT NULL COMMENT '访问到端口',
  `app_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '程序名',
  `app_cat_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '程序类型',
  `handle_action` int DEFAULT NULL COMMENT '句柄',
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `action_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '接收、发送',
  `send_addr` varchar(255) DEFAULT NULL COMMENT '发件地址',
  `receive_addr` varchar(255) DEFAULT NULL COMMENT '接收地址',
  `subject` text COMMENT '邮件内容',
  `content` varchar(255) DEFAULT NULL,
  `file_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '文件名',
  `file_size` int DEFAULT NULL,
  `msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '信息',
  `input_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  `log_base_ook` int unsigned DEFAULT NULL COMMENT '对应原始日志id',
  PRIMARY KEY (`sid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for office_ac_other_app
-- ----------------------------
DROP TABLE IF EXISTS `office_ac_other_app`;
CREATE TABLE `office_ac_other_app` (
  `sid` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户名',
  `ugname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户分组',
  `term_platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '系统平台',
  `term_device` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '设备类型',
  `pid` int DEFAULT NULL COMMENT 'pid',
  `src_mac` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '访问源mac',
  `src_ip` int unsigned DEFAULT NULL COMMENT '访问源ip',
  `dst_ip` int unsigned DEFAULT NULL COMMENT '访问到ip',
  `dst_port` int DEFAULT NULL COMMENT '访问到端口',
  `app_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '程序名',
  `app_cat_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '程序类型',
  `handle_action` int DEFAULT NULL COMMENT '句柄',
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `action_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '接收、发送',
  `content` varchar(255) DEFAULT NULL,
  `msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '信息',
  `input_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  `log_base_ook` int unsigned DEFAULT NULL COMMENT '对应原始日志id',
  PRIMARY KEY (`sid`),
  KEY `office_ac_other_app_log_base_ook_s` (`log_base_ook`),
  KEY `user_name_key` (`user_name`) USING BTREE,
  KEY `app_cat_name_key` (`app_cat_name`) USING BTREE,
  KEY `app_name_key` (`app_name`) USING BTREE,
  KEY `content_key` (`content`) USING BTREE,
  KEY `src_mac_key` (`src_mac`) USING BTREE,
  KEY `term_device_key` (`term_device`) USING BTREE,
  KEY `ugname_key` (`ugname`) USING BTREE,
  KEY `term_platform_key` (`term_platform`) USING BTREE,
  KEY `sid_key` (`sid` DESC) USING BTREE,
  CONSTRAINT `office_ac_other_app_log_base_ook_s` FOREIGN KEY (`log_base_ook`) REFERENCES `log_base` (`sid`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=116001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='其它app日志表';

-- ----------------------------
-- Table structure for office_ac_statistic_traffic_log
-- ----------------------------
DROP TABLE IF EXISTS `office_ac_statistic_traffic_log`;
CREATE TABLE `office_ac_statistic_traffic_log` (
  `sid` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户名',
  `ugname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户分组',
  `umac` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户mac',
  `uip` int unsigned DEFAULT NULL COMMENT '用户IP',
  `appname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '协议类型',
  `appgname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '访问类型',
  `up` int unsigned DEFAULT NULL COMMENT '上传流量',
  `down` int unsigned DEFAULT NULL COMMENT '下载流量',
  `create_time` int DEFAULT NULL COMMENT '上传时间戳',
  `end_time` int DEFAULT NULL COMMENT '下载时间戳',
  `input_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  `log_base_ook` int unsigned DEFAULT NULL COMMENT '对应原始日志id',
  PRIMARY KEY (`sid`),
  KEY `log_base_ook_s` (`log_base_ook`),
  KEY `appgname_key` (`appgname`) USING BTREE,
  KEY `appname_key` (`appname`) USING BTREE,
  KEY `ugname_key` (`ugname`) USING BTREE,
  KEY `umac_key` (`umac`) USING BTREE,
  KEY `user_name_key` (`user_name`) USING BTREE,
  KEY `uip_key` (`uip`) USING BTREE,
  KEY `sid_key` (`sid` DESC) USING BTREE,
  CONSTRAINT `log_base_ook_s` FOREIGN KEY (`log_base_ook`) REFERENCES `log_base` (`sid`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=26208563 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='办公网wifi_ac流量日志表';

-- ----------------------------
-- Table structure for office_ac_web_access_log
-- ----------------------------
DROP TABLE IF EXISTS `office_ac_web_access_log`;
CREATE TABLE `office_ac_web_access_log` (
  `sid` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户名',
  `ugname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户分组',
  `term_platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '系统平台',
  `term_device` varchar(255) DEFAULT NULL COMMENT '设备类型',
  `src_ip` int unsigned DEFAULT NULL COMMENT '访问源ip',
  `dst_ip` int unsigned DEFAULT NULL COMMENT '访问到ip',
  `url_domain` varchar(255) DEFAULT NULL COMMENT '访问域名',
  `url` varchar(255) DEFAULT NULL COMMENT '访问url',
  `url_cate_name` varchar(255) DEFAULT NULL COMMENT 'url类型',
  `handle_action` int DEFAULT NULL COMMENT '句柄',
  `msg` text COMMENT '信息',
  `input_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  `log_base_ook` int unsigned DEFAULT NULL COMMENT '对应原始日志id',
  PRIMARY KEY (`sid`),
  KEY `log_base_ook_s` (`log_base_ook`),
  KEY `sid_key` (`sid` DESC) USING BTREE,
  KEY `src_ip_key` (`src_ip`) USING BTREE,
  KEY `dst_ip_key` (`dst_ip`) USING BTREE,
  KEY `term_device_key` (`term_device`) USING BTREE,
  KEY `term_platform_key` (`term_platform`) USING BTREE,
  KEY `ugname_key` (`ugname`) USING BTREE,
  KEY `url_key` (`url`) USING BTREE,
  KEY `url_cate_name_key` (`url_cate_name`) USING BTREE,
  KEY `url_domain_key` (`url_domain`) USING BTREE,
  KEY `user_name_key` (`user_name`) USING BTREE,
  CONSTRAINT `office_ac_web_access_log_ibfk_1` FOREIGN KEY (`log_base_ook`) REFERENCES `log_base` (`sid`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12577753 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='办公网wifi_ac，web访问日志表';

-- ----------------------------
-- Table structure for office_ip_mac_user
-- ----------------------------
DROP TABLE IF EXISTS `office_ip_mac_user`;
CREATE TABLE `office_ip_mac_user` (
  `sid` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `ugname` varchar(255) DEFAULT NULL COMMENT '用户分组',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '匿名' COMMENT '名称',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `ip` int unsigned DEFAULT NULL COMMENT 'IP',
  `mac` varchar(255) DEFAULT NULL COMMENT 'mac',
  `input_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始活跃时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近活跃时间',
  PRIMARY KEY (`sid`) USING BTREE,
  KEY `update_time_key` (`update_time` DESC) USING BTREE,
  KEY `ip_key` (`ip`) USING BTREE,
  KEY `mac_key` (`mac`) USING BTREE,
  KEY `user_name_key` (`user_name`) USING BTREE,
  KEY `name_key` (`name`) USING BTREE,
  KEY `ugname_key` (`ugname`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4029 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='办公网ip对应mac地址以及用户名数据库';

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password_hash` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱号',
  `role` tinyint unsigned DEFAULT '1' COMMENT '用户角色，1管理员，2普通用户，3其他',
  `registration_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `is_valid` tinyint unsigned DEFAULT '1' COMMENT '数据是否有效，0无效，1有效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb3 COMMENT='用户注册信息';

SET FOREIGN_KEY_CHECKS = 1;
