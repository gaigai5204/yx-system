/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50556
Source Host           : localhost:3306
Source Database       : ry

Target Server Type    : MYSQL
Target Server Version : 50556
File Encoding         : 65001

Date: 2023-12-13 16:21:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Blob类型的触发器表';

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='日历信息表';

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Cron类型的触发器表';

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(20) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(20) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) NOT NULL COMMENT '状态',
  `job_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='已触发的触发器表';

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) NOT NULL COMMENT '任务组名',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='任务详细信息表';

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='存储的悲观锁信息表';

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='暂停的触发器表';

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(20) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(20) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='调度器状态表';

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(20) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(20) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(20) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='简单触发器的信息表';

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='同步机制的行锁表';

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(20) DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(20) DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(20) NOT NULL COMMENT '开始时间',
  `end_time` bigint(20) DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(6) DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='触发器详细信息表';

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_addr
-- ----------------------------
DROP TABLE IF EXISTS `sys_addr`;
CREATE TABLE `sys_addr` (
  `addr_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `addr_party` varchar(30) NOT NULL COMMENT '地址用户',
  `addr_name` varchar(30) NOT NULL COMMENT '用户姓名',
  `addr_phone` varchar(30) NOT NULL COMMENT '地址簿电话',
  `addr_detail` varchar(400) NOT NULL COMMENT '地址簿地址',
  `addr_default` varchar(30) DEFAULT '1' COMMENT '是否默认地址',
  `addr_type` varchar(30) DEFAULT '1' COMMENT '地址类型',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`addr_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='地址簿信息表';

-- ----------------------------
-- Records of sys_addr
-- ----------------------------
INSERT INTO `sys_addr` VALUES ('1', '1', '小王', '15888888888', '福建省福州市上街镇', '0', '1', '0', '2022-11-01 20:04:06');
INSERT INTO `sys_addr` VALUES ('2', '2', '小余', '15888888888', '福建省厦门市思明区', '0', '2', '0', '2022-11-01 20:04:06');
INSERT INTO `sys_addr` VALUES ('3', '2', '小黄', '11111111111', '福建省莆田市涵江区白沙镇龙东村110号', '1', '1', '0', '2023-12-05 19:54:19');
INSERT INTO `sys_addr` VALUES ('4', '2', '林神', '12222222222', '福建省福州市闽清县青口镇汤臣一品001号', '1', '1', '0', '2023-12-05 19:55:20');
INSERT INTO `sys_addr` VALUES ('5', '2', '宇少', '13333333333', '福建省福州市福清市汤臣一品002号', '1', '1', '0', '2023-12-05 19:56:15');
INSERT INTO `sys_addr` VALUES ('6', '2', '欢欢', '15160665555', '福建省福州市闽侯县福州大学', '1', '1', '0', '2023-12-13 16:09:07');
INSERT INTO `sys_addr` VALUES ('7', '2', '小明', '13333333333', '福建省厦门市集美区集美大学', '1', '1', '0', '2023-12-13 16:09:59');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-09-22 11:09:01', '', null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES ('2', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-09-22 11:09:01', '', null, '初始化密码 123456');
INSERT INTO `sys_config` VALUES ('3', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-09-22 11:09:01', '', null, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES ('4', '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2022-09-22 11:09:01', '', null, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES ('5', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2022-09-22 11:09:01', '', null, '是否开启注册用户功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int(11) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('100', '0', '0', '总网点', '0', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-22 11:09:01', '', null);
INSERT INTO `sys_dept` VALUES ('101', '100', '0,100', '深圳总公司', '1', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-22 11:09:01', '', null);
INSERT INTO `sys_dept` VALUES ('102', '100', '0,100', '长沙分公司', '2', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-22 11:09:01', '', null);
INSERT INTO `sys_dept` VALUES ('103', '101', '0,100,101', '研发部门', '1', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-22 11:09:01', '', null);
INSERT INTO `sys_dept` VALUES ('104', '101', '0,100,101', '市场部门', '2', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-22 11:09:01', '', null);
INSERT INTO `sys_dept` VALUES ('105', '101', '0,100,101', '测试部门', '3', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-22 11:09:01', '', null);
INSERT INTO `sys_dept` VALUES ('106', '101', '0,100,101', '财务部门', '4', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-22 11:09:01', '', null);
INSERT INTO `sys_dept` VALUES ('107', '101', '0,100,101', '运维部门', '5', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-22 11:09:01', '', null);
INSERT INTO `sys_dept` VALUES ('108', '102', '0,100,102', '市场部门', '1', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-22 11:09:01', '', null);
INSERT INTO `sys_dept` VALUES ('109', '102', '0,100,102', '财务部门', '2', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-09-22 11:09:01', '', null);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(11) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES ('1', '1', '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-09-22 11:09:01', '', null, '性别男');
INSERT INTO `sys_dict_data` VALUES ('2', '2', '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '性别女');
INSERT INTO `sys_dict_data` VALUES ('3', '3', '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '性别未知');
INSERT INTO `sys_dict_data` VALUES ('4', '1', '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-09-22 11:09:01', '', null, '显示菜单');
INSERT INTO `sys_dict_data` VALUES ('5', '2', '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES ('6', '1', '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-09-22 11:09:01', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('7', '2', '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('8', '1', '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-09-22 11:09:01', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('9', '2', '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('10', '1', '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-09-22 11:09:01', '', null, '默认分组');
INSERT INTO `sys_dict_data` VALUES ('11', '2', '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '系统分组');
INSERT INTO `sys_dict_data` VALUES ('12', '1', '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-09-22 11:09:01', '', null, '系统默认是');
INSERT INTO `sys_dict_data` VALUES ('13', '2', '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '系统默认否');
INSERT INTO `sys_dict_data` VALUES ('14', '1', '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-09-22 11:09:01', '', null, '通知');
INSERT INTO `sys_dict_data` VALUES ('15', '2', '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '公告');
INSERT INTO `sys_dict_data` VALUES ('16', '1', '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-09-22 11:09:01', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('17', '2', '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '关闭状态');
INSERT INTO `sys_dict_data` VALUES ('18', '99', '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '其他操作');
INSERT INTO `sys_dict_data` VALUES ('19', '1', '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '新增操作');
INSERT INTO `sys_dict_data` VALUES ('20', '2', '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '修改操作');
INSERT INTO `sys_dict_data` VALUES ('21', '3', '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '删除操作');
INSERT INTO `sys_dict_data` VALUES ('22', '4', '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '授权操作');
INSERT INTO `sys_dict_data` VALUES ('23', '5', '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '导出操作');
INSERT INTO `sys_dict_data` VALUES ('24', '6', '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '导入操作');
INSERT INTO `sys_dict_data` VALUES ('25', '7', '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '强退操作');
INSERT INTO `sys_dict_data` VALUES ('26', '8', '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '生成操作');
INSERT INTO `sys_dict_data` VALUES ('27', '9', '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '清空操作');
INSERT INTO `sys_dict_data` VALUES ('28', '1', '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('29', '2', '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-09-22 11:09:01', '', null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('30', '1', '运输中', '0', 'sys_order_status', null, 'primary', 'Y', '0', 'admin', '2022-10-13 10:04:46', '', null, '运输状态');
INSERT INTO `sys_dict_data` VALUES ('31', '2', '派送中', '1', 'sys_order_status', null, 'warning', 'N', '0', 'admin', '2022-10-13 10:06:57', '', null, '派送状态');
INSERT INTO `sys_dict_data` VALUES ('32', '3', '已完成', '2', 'sys_order_status', null, 'success', 'N', '0', 'admin', '2022-10-13 10:07:51', '', null, '完成状态');
INSERT INTO `sys_dict_data` VALUES ('33', '4', '待接单', '3', 'sys_order_status', null, 'danger', 'N', '0', 'admin', '2022-10-14 20:33:28', '', null, '待接状态');
INSERT INTO `sys_dict_data` VALUES ('34', '5', '已接单', '4', 'sys_order_status', null, 'warning', 'N', '0', 'admin', '2022-11-01 14:27:58', '', null, null);
INSERT INTO `sys_dict_data` VALUES ('35', '6', '待取件', '5', 'sys_order_status', null, 'danger', 'N', '0', 'admin', '2022-11-01 14:29:39', '', null, null);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE KEY `dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES ('1', '用户性别', 'sys_user_sex', '0', 'admin', '2022-09-22 11:09:01', '', null, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES ('2', '菜单状态', 'sys_show_hide', '0', 'admin', '2022-09-22 11:09:01', '', null, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES ('3', '系统开关', 'sys_normal_disable', '0', 'admin', '2022-09-22 11:09:01', '', null, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES ('4', '任务状态', 'sys_job_status', '0', 'admin', '2022-09-22 11:09:01', '', null, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES ('5', '任务分组', 'sys_job_group', '0', 'admin', '2022-09-22 11:09:01', '', null, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES ('6', '系统是否', 'sys_yes_no', '0', 'admin', '2022-09-22 11:09:01', '', null, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES ('7', '通知类型', 'sys_notice_type', '0', 'admin', '2022-09-22 11:09:01', '', null, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES ('8', '通知状态', 'sys_notice_status', '0', 'admin', '2022-09-22 11:09:01', '', null, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES ('9', '操作类型', 'sys_oper_type', '0', 'admin', '2022-09-22 11:09:01', '', null, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES ('10', '系统状态', 'sys_common_status', '0', 'admin', '2022-09-22 11:09:01', '', null, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES ('11', '菜单显示', 'new_menu_visible', '0', 'admin', '2023-11-29 16:58:32', '', null, null);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES ('1', '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2022-09-22 11:09:01', '', null, '');
INSERT INTO `sys_job` VALUES ('2', '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2022-09-22 11:09:01', '', null, '');
INSERT INTO `sys_job` VALUES ('3', '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2022-09-22 11:09:01', '', null, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES ('100', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-22 11:15:54');
INSERT INTO `sys_logininfor` VALUES ('101', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '退出成功', '2022-09-22 11:31:25');
INSERT INTO `sys_logininfor` VALUES ('102', 'common', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '1', '登录用户：common 不存在', '2022-09-22 11:31:34');
INSERT INTO `sys_logininfor` VALUES ('103', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-22 11:31:45');
INSERT INTO `sys_logininfor` VALUES ('104', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-22 14:00:27');
INSERT INTO `sys_logininfor` VALUES ('105', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '退出成功', '2022-09-22 14:00:57');
INSERT INTO `sys_logininfor` VALUES ('106', 'ry', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-22 14:01:08');
INSERT INTO `sys_logininfor` VALUES ('107', 'ry', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '退出成功', '2022-09-22 14:01:37');
INSERT INTO `sys_logininfor` VALUES ('108', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-22 14:01:43');
INSERT INTO `sys_logininfor` VALUES ('109', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '退出成功', '2022-09-22 14:03:09');
INSERT INTO `sys_logininfor` VALUES ('110', 'common', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '1', '登录用户：common 不存在', '2022-09-22 14:03:19');
INSERT INTO `sys_logininfor` VALUES ('111', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-09-22 14:03:29');
INSERT INTO `sys_logininfor` VALUES ('112', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '1', '密码输入错误1次', '2022-09-22 14:03:29');
INSERT INTO `sys_logininfor` VALUES ('113', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '1', '密码输入错误2次', '2022-09-22 14:03:37');
INSERT INTO `sys_logininfor` VALUES ('114', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-09-22 14:03:37');
INSERT INTO `sys_logininfor` VALUES ('115', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-22 14:03:59');
INSERT INTO `sys_logininfor` VALUES ('116', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '退出成功', '2022-09-22 14:07:14');
INSERT INTO `sys_logininfor` VALUES ('117', 'Test01', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-22 14:07:34');
INSERT INTO `sys_logininfor` VALUES ('118', 'Test01', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '退出成功', '2022-09-22 14:09:55');
INSERT INTO `sys_logininfor` VALUES ('119', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-22 14:09:59');
INSERT INTO `sys_logininfor` VALUES ('120', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '退出成功', '2022-09-22 14:29:54');
INSERT INTO `sys_logininfor` VALUES ('121', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-22 14:30:02');
INSERT INTO `sys_logininfor` VALUES ('122', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '退出成功', '2022-09-22 14:55:38');
INSERT INTO `sys_logininfor` VALUES ('123', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-22 14:55:50');
INSERT INTO `sys_logininfor` VALUES ('124', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '退出成功', '2022-09-22 15:18:08');
INSERT INTO `sys_logininfor` VALUES ('125', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-22 15:20:24');
INSERT INTO `sys_logininfor` VALUES ('126', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-22 16:41:36');
INSERT INTO `sys_logininfor` VALUES ('127', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-24 16:16:50');
INSERT INTO `sys_logininfor` VALUES ('128', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-24 18:21:20');
INSERT INTO `sys_logininfor` VALUES ('129', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-26 08:28:48');
INSERT INTO `sys_logininfor` VALUES ('130', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-26 09:09:37');
INSERT INTO `sys_logininfor` VALUES ('131', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-26 10:00:46');
INSERT INTO `sys_logininfor` VALUES ('132', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-26 11:13:16');
INSERT INTO `sys_logininfor` VALUES ('133', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-27 20:14:49');
INSERT INTO `sys_logininfor` VALUES ('134', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-09-28 09:15:14');
INSERT INTO `sys_logininfor` VALUES ('135', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-02 14:43:51');
INSERT INTO `sys_logininfor` VALUES ('136', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-02 16:24:15');
INSERT INTO `sys_logininfor` VALUES ('137', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-02 19:02:54');
INSERT INTO `sys_logininfor` VALUES ('138', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '1', '验证码错误', '2022-10-03 10:32:48');
INSERT INTO `sys_logininfor` VALUES ('139', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-03 10:32:52');
INSERT INTO `sys_logininfor` VALUES ('140', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-06 15:31:06');
INSERT INTO `sys_logininfor` VALUES ('141', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-09 08:42:17');
INSERT INTO `sys_logininfor` VALUES ('142', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '1', '验证码已失效', '2022-10-13 09:12:10');
INSERT INTO `sys_logininfor` VALUES ('143', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '1', '验证码错误', '2022-10-13 09:12:14');
INSERT INTO `sys_logininfor` VALUES ('144', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-13 09:12:19');
INSERT INTO `sys_logininfor` VALUES ('145', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-14 08:25:09');
INSERT INTO `sys_logininfor` VALUES ('146', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-14 17:09:44');
INSERT INTO `sys_logininfor` VALUES ('147', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-14 18:21:23');
INSERT INTO `sys_logininfor` VALUES ('148', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-14 21:21:36');
INSERT INTO `sys_logininfor` VALUES ('149', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-15 14:27:41');
INSERT INTO `sys_logininfor` VALUES ('150', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-15 20:27:37');
INSERT INTO `sys_logininfor` VALUES ('151', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-16 16:51:44');
INSERT INTO `sys_logininfor` VALUES ('152', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-16 17:25:31');
INSERT INTO `sys_logininfor` VALUES ('153', 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-10-16 17:28:18');
INSERT INTO `sys_logininfor` VALUES ('154', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-16 17:31:59');
INSERT INTO `sys_logininfor` VALUES ('155', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-16 18:09:23');
INSERT INTO `sys_logininfor` VALUES ('156', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-16 18:40:31');
INSERT INTO `sys_logininfor` VALUES ('157', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-16 19:50:03');
INSERT INTO `sys_logininfor` VALUES ('158', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-17 10:02:21');
INSERT INTO `sys_logininfor` VALUES ('159', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-17 16:45:30');
INSERT INTO `sys_logininfor` VALUES ('160', 'admin', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-10-17 18:39:42');
INSERT INTO `sys_logininfor` VALUES ('161', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-11-11 18:49:15');
INSERT INTO `sys_logininfor` VALUES ('162', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '密码输入错误1次', '2023-11-11 18:49:15');
INSERT INTO `sys_logininfor` VALUES ('163', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '密码输入错误2次', '2023-11-11 18:49:27');
INSERT INTO `sys_logininfor` VALUES ('164', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-11-11 18:49:27');
INSERT INTO `sys_logininfor` VALUES ('165', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-11-11 18:49:42');
INSERT INTO `sys_logininfor` VALUES ('166', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-11-11 18:50:52');
INSERT INTO `sys_logininfor` VALUES ('167', 'ry', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-11-11 18:50:59');
INSERT INTO `sys_logininfor` VALUES ('168', 'ry', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-11-11 18:52:13');
INSERT INTO `sys_logininfor` VALUES ('169', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-11-11 18:52:20');
INSERT INTO `sys_logininfor` VALUES ('170', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-11-11 19:08:59');
INSERT INTO `sys_logininfor` VALUES ('171', 'ry', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-11-11 19:09:10');
INSERT INTO `sys_logininfor` VALUES ('172', 'ry', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-11-11 19:09:28');
INSERT INTO `sys_logininfor` VALUES ('173', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-11-11 19:09:37');
INSERT INTO `sys_logininfor` VALUES ('174', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-11-11 20:53:20');
INSERT INTO `sys_logininfor` VALUES ('175', 'zhuan', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-11-11 20:53:32');
INSERT INTO `sys_logininfor` VALUES ('176', 'zhuan', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-11-11 20:53:37');
INSERT INTO `sys_logininfor` VALUES ('177', 'zhuan', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-11-11 20:55:14');
INSERT INTO `sys_logininfor` VALUES ('178', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '密码输入错误1次', '2023-11-11 20:55:21');
INSERT INTO `sys_logininfor` VALUES ('179', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-11-11 20:55:21');
INSERT INTO `sys_logininfor` VALUES ('180', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-11-11 20:55:35');
INSERT INTO `sys_logininfor` VALUES ('181', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-11-29 15:06:02');
INSERT INTO `sys_logininfor` VALUES ('182', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-11-29 15:09:05');
INSERT INTO `sys_logininfor` VALUES ('183', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '验证码已失效', '2023-11-29 15:13:25');
INSERT INTO `sys_logininfor` VALUES ('184', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-11-29 15:13:28');
INSERT INTO `sys_logininfor` VALUES ('185', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-11-29 15:13:31');
INSERT INTO `sys_logininfor` VALUES ('186', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-11-29 15:13:38');
INSERT INTO `sys_logininfor` VALUES ('187', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-11-29 16:53:14');
INSERT INTO `sys_logininfor` VALUES ('188', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-12-04 10:03:11');
INSERT INTO `sys_logininfor` VALUES ('189', 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-12-05 19:01:56');
INSERT INTO `sys_logininfor` VALUES ('190', 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-05 19:15:31');
INSERT INTO `sys_logininfor` VALUES ('191', '哒哒', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-05 19:15:31');
INSERT INTO `sys_logininfor` VALUES ('192', 'test02', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-05 19:15:55');
INSERT INTO `sys_logininfor` VALUES ('193', 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-05 19:15:55');
INSERT INTO `sys_logininfor` VALUES ('194', 'test02', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-05 19:16:12');
INSERT INTO `sys_logininfor` VALUES ('195', 'test02', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-05 19:18:34');
INSERT INTO `sys_logininfor` VALUES ('196', 'kd_01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '密码输入错误1次', '2023-12-05 19:45:11');
INSERT INTO `sys_logininfor` VALUES ('197', 'kd_01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '用户不存在/密码错误', '2023-12-05 19:45:11');
INSERT INTO `sys_logininfor` VALUES ('198', 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-05 19:45:11');
INSERT INTO `sys_logininfor` VALUES ('199', 'kd_01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-05 19:46:21');
INSERT INTO `sys_logininfor` VALUES ('200', 'kd_01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-05 19:46:26');
INSERT INTO `sys_logininfor` VALUES ('201', 'kd_04', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-05 19:53:10');
INSERT INTO `sys_logininfor` VALUES ('202', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-13 11:29:16');
INSERT INTO `sys_logininfor` VALUES ('203', 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-13 11:42:52');
INSERT INTO `sys_logininfor` VALUES ('204', 'test01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-13 11:42:52');
INSERT INTO `sys_logininfor` VALUES ('205', 'test01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-13 11:43:04');
INSERT INTO `sys_logininfor` VALUES ('206', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-13 13:09:06');
INSERT INTO `sys_logininfor` VALUES ('207', 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-13 13:11:28');
INSERT INTO `sys_logininfor` VALUES ('208', 'test01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-13 13:11:28');
INSERT INTO `sys_logininfor` VALUES ('209', 'test01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-13 13:11:28');
INSERT INTO `sys_logininfor` VALUES ('210', 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-13 13:11:28');
INSERT INTO `sys_logininfor` VALUES ('211', 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-13 13:11:29');
INSERT INTO `sys_logininfor` VALUES ('212', 'test01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-13 13:11:29');
INSERT INTO `sys_logininfor` VALUES ('213', 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-13 13:11:30');
INSERT INTO `sys_logininfor` VALUES ('214', 'test01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-13 13:11:30');
INSERT INTO `sys_logininfor` VALUES ('215', 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-13 13:11:43');
INSERT INTO `sys_logininfor` VALUES ('216', 'test01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-13 13:11:43');
INSERT INTO `sys_logininfor` VALUES ('217', 'test01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-13 13:12:13');
INSERT INTO `sys_logininfor` VALUES ('218', 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-13 13:12:13');
INSERT INTO `sys_logininfor` VALUES ('219', 'test01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-13 13:12:44');
INSERT INTO `sys_logininfor` VALUES ('220', 'test02', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-13 13:13:55');
INSERT INTO `sys_logininfor` VALUES ('221', 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-13 16:02:05');
INSERT INTO `sys_logininfor` VALUES ('222', 'test02', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-13 16:02:05');
INSERT INTO `sys_logininfor` VALUES ('223', 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2023-12-13 16:04:04');
INSERT INTO `sys_logininfor` VALUES ('224', 'kd_01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '验证码已失效', '2023-12-13 16:05:52');
INSERT INTO `sys_logininfor` VALUES ('225', 'admin', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-13 16:05:52');
INSERT INTO `sys_logininfor` VALUES ('226', 'kd_01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '用户不存在/密码错误', '2023-12-13 16:06:05');
INSERT INTO `sys_logininfor` VALUES ('227', 'kd_01', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '密码输入错误1次', '2023-12-13 16:06:05');
INSERT INTO `sys_logininfor` VALUES ('228', 'kd_02', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '0', '登录成功', '2023-12-13 16:06:27');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int(11) DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(11) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int(11) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2005 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '0', '1', 'system', null, '', '1', '0', 'M', '0', '0', '', 'system', 'admin', '2022-09-24 16:58:48', '', null, '系统管理目录');
INSERT INTO `sys_menu` VALUES ('2', '系统监控', '0', '2', 'monitor', null, '', '1', '0', 'M', '0', '0', '', 'monitor', 'admin', '2022-09-24 16:58:48', '', null, '系统监控目录');
INSERT INTO `sys_menu` VALUES ('3', '系统工具', '0', '3', 'tool', null, '', '1', '0', 'M', '0', '0', '', 'tool', 'admin', '2022-09-24 16:58:48', '', null, '系统工具目录');
INSERT INTO `sys_menu` VALUES ('4', '若依官网', '0', '4', 'http://ruoyi.vip', null, '', '0', '0', 'M', '1', '0', '', 'guide', 'admin', '2022-09-24 16:58:48', 'admin', '2022-10-16 21:05:45', '若依官网地址');
INSERT INTO `sys_menu` VALUES ('100', '网点管理', '1', '1', 'user', 'system/user/index', '', '1', '0', 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-09-24 16:58:48', '', null, '网点管理菜单');
INSERT INTO `sys_menu` VALUES ('101', '角色管理', '1', '2', 'role', 'system/role/index', '', '1', '0', 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-09-24 16:58:48', 'admin', '2023-11-29 16:55:24', '角色管理菜单');
INSERT INTO `sys_menu` VALUES ('102', '快递员管理', '1', '3', 'postman', 'system/postman/index', '', '1', '0', 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-09-24 16:58:48', '', null, '快递员管理菜单');
INSERT INTO `sys_menu` VALUES ('103', '菜单管理', '1', '4', 'menu', 'system/menu/index', '', '1', '0', 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-09-24 16:58:48', '', null, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES ('104', '部门管理', '1', '5', 'dept', 'system/dept/index', '', '1', '0', 'C', '0', '1', 'system:dept:list', 'tree', 'admin', '2022-09-24 16:58:48', 'admin', '2022-10-16 21:03:25', '部门管理菜单');
INSERT INTO `sys_menu` VALUES ('105', '岗位管理', '1', '6', 'post', 'system/post/index', '', '1', '0', 'C', '0', '1', 'system:post:list', 'post', 'admin', '2022-09-24 16:58:48', 'admin', '2022-10-16 21:03:45', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES ('106', '字典管理', '1', '7', 'dict', 'system/dict/index', '', '1', '0', 'C', '1', '0', 'system:dict:list', 'dict', 'admin', '2022-09-24 16:58:48', 'admin', '2023-12-13 16:19:17', '字典管理菜单');
INSERT INTO `sys_menu` VALUES ('107', '参数设置', '1', '8', 'config', 'system/config/index', '', '1', '0', 'C', '1', '0', 'system:config:list', 'edit', 'admin', '2022-09-24 16:58:48', 'admin', '2022-10-16 21:04:42', '参数设置菜单');
INSERT INTO `sys_menu` VALUES ('108', '通知公告', '1', '9', 'notice', 'system/notice/index', '', '1', '0', 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2022-09-24 16:58:48', '', null, '通知公告菜单');
INSERT INTO `sys_menu` VALUES ('109', '日志管理', '1', '10', 'log', '', '', '1', '0', 'M', '1', '0', '', 'log', 'admin', '2022-09-24 16:58:48', 'admin', '2022-10-16 21:04:56', '日志管理菜单');
INSERT INTO `sys_menu` VALUES ('110', '在线用户', '2', '1', 'online', 'monitor/online/index', '', '1', '0', 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-09-24 16:58:48', '', null, '在线用户菜单');
INSERT INTO `sys_menu` VALUES ('111', '定时任务', '2', '2', 'job', 'monitor/job/index', '', '1', '0', 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2022-09-24 16:58:48', '', null, '定时任务菜单');
INSERT INTO `sys_menu` VALUES ('112', '数据监控', '2', '3', 'druid', 'monitor/druid/index', '', '1', '0', 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2022-09-24 16:58:48', '', null, '数据监控菜单');
INSERT INTO `sys_menu` VALUES ('113', '服务监控', '2', '4', 'server', 'monitor/server/index', '', '1', '0', 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2022-09-24 16:58:48', '', null, '服务监控菜单');
INSERT INTO `sys_menu` VALUES ('114', '缓存监控', '2', '5', 'cache', 'monitor/cache/index', '', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-09-24 16:58:48', '', null, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES ('115', '缓存列表', '2', '6', 'cacheList', 'monitor/cache/list', '', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2022-09-24 16:58:48', '', null, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES ('116', '表单构建', '3', '1', 'build', 'tool/build/index', '', '1', '0', 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2022-09-24 16:58:48', '', null, '表单构建菜单');
INSERT INTO `sys_menu` VALUES ('117', '代码生成', '3', '2', 'gen', 'tool/gen/index', '', '1', '0', 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-09-24 16:58:48', '', null, '代码生成菜单');
INSERT INTO `sys_menu` VALUES ('118', '系统接口', '3', '3', 'swagger', 'tool/swagger/index', '', '1', '0', 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2022-09-24 16:58:48', '', null, '系统接口菜单');
INSERT INTO `sys_menu` VALUES ('500', '操作日志', '108', '1', 'operlog', 'monitor/operlog/index', '', '1', '0', 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2022-09-24 16:58:48', '', null, '操作日志菜单');
INSERT INTO `sys_menu` VALUES ('501', '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '', '1', '0', 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2022-09-24 16:58:48', '', null, '登录日志菜单');
INSERT INTO `sys_menu` VALUES ('1000', '用户查询', '100', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1001', '用户新增', '100', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1002', '用户修改', '100', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1003', '用户删除', '100', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1004', '用户导出', '100', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1005', '用户导入', '100', '6', '', '', '', '1', '0', 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1006', '重置密码', '100', '7', '', '', '', '1', '0', 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1007', '角色查询', '101', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1008', '角色新增', '101', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1009', '角色修改', '101', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1010', '角色删除', '101', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1011', '角色导出', '101', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1012', '菜单查询', '102', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1013', '菜单新增', '102', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1014', '菜单修改', '102', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1015', '菜单删除', '102', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1016', '部门查询', '103', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1017', '部门新增', '103', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1018', '部门修改', '103', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1019', '部门删除', '103', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1020', '岗位查询', '104', '1', '', '', '', '1', '0', 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1021', '岗位新增', '104', '2', '', '', '', '1', '0', 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1022', '岗位修改', '104', '3', '', '', '', '1', '0', 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1023', '岗位删除', '104', '4', '', '', '', '1', '0', 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1024', '岗位导出', '104', '5', '', '', '', '1', '0', 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1025', '字典查询', '105', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1026', '字典新增', '105', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1027', '字典修改', '105', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1028', '字典删除', '105', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1029', '字典导出', '105', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1030', '参数查询', '106', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1031', '参数新增', '106', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1032', '参数修改', '106', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1033', '参数删除', '106', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1034', '参数导出', '106', '5', '#', '', '', '1', '0', 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1035', '公告查询', '107', '1', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1036', '公告新增', '107', '2', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1037', '公告修改', '107', '3', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1038', '公告删除', '107', '4', '#', '', '', '1', '0', 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1039', '操作查询', '500', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1040', '操作删除', '500', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1041', '日志导出', '500', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1042', '登录查询', '501', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1043', '登录删除', '501', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1044', '日志导出', '501', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1045', '账户解锁', '501', '4', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1046', '在线查询', '109', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1047', '批量强退', '109', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1048', '单条强退', '109', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1049', '任务查询', '110', '1', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1050', '任务新增', '110', '2', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1051', '任务修改', '110', '3', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1052', '任务删除', '110', '4', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1053', '状态修改', '110', '5', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1054', '任务导出', '110', '6', '#', '', '', '1', '0', 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1055', '生成查询', '116', '1', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1056', '生成修改', '116', '2', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1057', '生成删除', '116', '3', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1058', '导入代码', '116', '4', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1059', '预览代码', '116', '5', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('1060', '生成代码', '116', '6', '#', '', '', '1', '0', 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-09-24 16:58:48', '', null, '');
INSERT INTO `sys_menu` VALUES ('2002', '订单管理', '1', '3', 'order', 'system/order/orderManage', null, '1', '0', 'C', '0', '0', '', 'documentation', 'admin', '2022-10-09 09:03:38', 'admin', '2022-10-16 16:54:05', '');
INSERT INTO `sys_menu` VALUES ('2003', '用户管理', '1', '3', 'party', 'system/party/index', null, '1', '0', 'C', '0', '0', '', 'number', 'admin', '2022-10-16 16:53:53', 'admin', '2022-10-16 16:54:24', '');
INSERT INTO `sys_menu` VALUES ('2004', '物流', '1', '2', 'tranRoute', 'system/tranRoute/index', null, '1', '0', 'C', '1', '0', '', 'allOrder', 'admin', '2023-11-11 18:56:37', 'admin', '2023-12-13 13:10:10', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES ('1', '温馨提醒：2023若依框架新版本发布啦', '2', 0x3C703EE696B0E78988E69CACE58685E5AEB97878787878783C2F703E, '0', 'admin', '2022-09-22 11:09:01', 'admin', '2023-11-11 19:07:12', '管理员');
INSERT INTO `sys_notice` VALUES ('2', '维护通知：网点管理系统凌晨维护', '1', 0x3C703EE7BBB4E68AA4E58685E5AEB9EFBC9AE4BD9CE88085E99C80E8A681E4BC91E681AF3C2F703E, '0', 'admin', '2022-09-22 11:09:01', 'admin', '2023-11-11 19:07:36', '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(11) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int(11) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int(11) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES ('100', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":100,\"email\":\"123@qq.com\",\"nickName\":\"test01\",\"params\":{},\"phonenumber\":\"13602222222\",\"postIds\":[4],\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"Test01\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-09-22 14:05:32');
INSERT INTO `sys_oper_log` VALUES ('101', '角色管理', '2', 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', '1', 'admin', null, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2022-09-22 11:09:01\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通网点\",\"roleSort\":\"2\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-09-22 16:03:48');
INSERT INTO `sys_oper_log` VALUES ('102', '用户管理', '1', 'com.ruoyi.web.controller.system.SysPostmanController.add()', 'POST', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":104,\"email\":\"123@qq.com\",\"nickName\":\"快递员03\",\"params\":{},\"phonenumber\":\"13020939876\",\"postIds\":[],\"remark\":\"测试三号\",\"roleIds\":[2],\"sex\":\"1\",\"status\":\"0\",\"userId\":100,\"userName\":\"test03\"}', null, '1', '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'100-2\' for key \'sys_user_role.PRIMARY\'\r\n### The error may exist in file [D:\\project2\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserRoleMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_user_role(user_id, role_id) values         (?,?)\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'100-2\' for key \'sys_user_role.PRIMARY\'\n; Duplicate entry \'100-2\' for key \'sys_user_role.PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'100-2\' for key \'sys_user_role.PRIMARY\'', '2022-09-26 08:30:25');
INSERT INTO `sys_oper_log` VALUES ('103', '用户管理', '1', 'com.ruoyi.web.controller.system.SysPostmanController.add()', 'POST', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":104,\"email\":\"123@qq.com\",\"nickName\":\"快递员03\",\"params\":{},\"phonenumber\":\"13020939876\",\"postIds\":[],\"remark\":\"测试三号\",\"roleIds\":[2],\"sex\":\"1\",\"status\":\"0\",\"userId\":101,\"userName\":\"test03\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-09-26 08:30:32');
INSERT INTO `sys_oper_log` VALUES ('104', '用户管理', '1', 'com.ruoyi.web.controller.system.SysPostmanController.add()', 'POST', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":105,\"email\":\"123@qq.com\",\"nickName\":\"快递员04\",\"params\":{},\"phonenumber\":\"15234567896\",\"postIds\":[],\"remark\":\"测试5号\",\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"kd_04\"}', null, '1', 'com.ruoyi.common.core.domain.entity.SysPostman cannot be cast to com.ruoyi.common.core.domain.entity.SysUser', '2022-09-26 08:32:12');
INSERT INTO `sys_oper_log` VALUES ('105', '用户管理', '5', 'com.ruoyi.web.controller.system.SysUserController.export()', 'POST', '1', 'admin', null, '/system/user/export', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{\"dataScope\":\"\"}}', null, '0', null, '2022-09-26 08:33:43');
INSERT INTO `sys_oper_log` VALUES ('106', '用户管理', '1', 'com.ruoyi.web.controller.system.SysPostmanController.add()', 'POST', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":103,\"email\":\"123@qq.com\",\"nickName\":\"快递员04\",\"params\":{},\"phonenumber\":\"15456544333\",\"postIds\":[],\"remark\":\"测试4号\",\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"kd_04\"}', '{\"msg\":\"新增用户\'kd_04\'失败，邮箱账号已存在\",\"code\":500}', '0', null, '2022-09-26 09:10:47');
INSERT INTO `sys_oper_log` VALUES ('107', '用户管理', '1', 'com.ruoyi.web.controller.system.SysPostmanController.add()', 'POST', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":103,\"email\":\"1234@qq.com\",\"nickName\":\"快递员04\",\"params\":{},\"phonenumber\":\"15456544333\",\"postIds\":[],\"remark\":\"测试4号\",\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userId\":102,\"userName\":\"kd_04\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-09-26 09:10:56');
INSERT INTO `sys_oper_log` VALUES ('108', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.changeStatus()', 'PUT', '1', 'admin', null, '/system/postman/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-09-26 09:11:07');
INSERT INTO `sys_oper_log` VALUES ('109', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.changeStatus()', 'PUT', '1', 'admin', null, '/system/postman/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-09-26 09:11:10');
INSERT INTO `sys_oper_log` VALUES ('110', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"test02\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userId\":101,\"userName\":\"test02\"}', null, '1', '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'101-2\' for key \'sys_user_role.PRIMARY\'\r\n### The error may exist in file [D:\\project2\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserRoleMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_user_role(user_id, role_id) values         (?,?)\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'101-2\' for key \'sys_user_role.PRIMARY\'\n; Duplicate entry \'101-2\' for key \'sys_user_role.PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'101-2\' for key \'sys_user_role.PRIMARY\'', '2022-09-28 09:26:38');
INSERT INTO `sys_oper_log` VALUES ('111', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"test02\",\"params\":{},\"phonenumber\":\"15233333333\",\"postIds\":[],\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userId\":102,\"userName\":\"test02\"}', null, '1', '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'102-2\' for key \'sys_user_role.PRIMARY\'\r\n### The error may exist in file [D:\\project2\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserRoleMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_user_role(user_id, role_id) values         (?,?)\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'102-2\' for key \'sys_user_role.PRIMARY\'\n; Duplicate entry \'102-2\' for key \'sys_user_role.PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'102-2\' for key \'sys_user_role.PRIMARY\'', '2022-09-28 09:27:07');
INSERT INTO `sys_oper_log` VALUES ('112', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.resetPwd()', 'PUT', '1', 'admin', null, '/system/postman/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-02 15:10:21');
INSERT INTO `sys_oper_log` VALUES ('113', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.changeStatus()', 'PUT', '1', 'admin', null, '/system/postman/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-02 15:10:53');
INSERT INTO `sys_oper_log` VALUES ('114', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.changeStatus()', 'PUT', '1', 'admin', null, '/system/postman/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-02 15:10:54');
INSERT INTO `sys_oper_log` VALUES ('115', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.edit()', 'PUT', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-24 16:58:48\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":2,\"params\":{}},\"deptId\":2,\"email\":\"kuaidi@qq.com\",\"loginDate\":\"2022-09-24 16:58:48\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"快递员02\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"remark\":\"快递员二号\",\"roleIds\":[],\"roles\":[],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"user\":{\"admin\":false,\"deptId\":2,\"nickName\":\"快递员02\",\"params\":{},\"userId\":2,\"userName\":\"kd_02\"},\"userId\":2,\"userName\":\"kd_02\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-02 15:32:56');
INSERT INTO `sys_oper_log` VALUES ('116', '菜单管理', '1', 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"skill\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"订单管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"order\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-06 15:40:28');
INSERT INTO `sys_oper_log` VALUES ('117', '菜单管理', '1', 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"订单列表\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"orderManage\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-06 15:41:22');
INSERT INTO `sys_oper_log` VALUES ('118', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-10-06 15:41:22\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"订单列表\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"orderManage\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-09 08:51:48');
INSERT INTO `sys_oper_log` VALUES ('119', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-10-06 15:40:28\",\"icon\":\"skill\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"订单管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"order\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-09 08:52:15');
INSERT INTO `sys_oper_log` VALUES ('120', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-10-06 15:40:28\",\"icon\":\"skill\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"订单管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"order\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-09 08:52:35');
INSERT INTO `sys_oper_log` VALUES ('121', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-10-06 15:41:22\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"订单列表\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"orderManage\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-09 08:52:49');
INSERT INTO `sys_oper_log` VALUES ('122', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2000', '127.0.0.1', '内网IP', '{menuId=2000}', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":500}', '0', null, '2022-10-09 08:59:17');
INSERT INTO `sys_oper_log` VALUES ('123', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2001', '127.0.0.1', '内网IP', '{menuId=2001}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-09 08:59:23');
INSERT INTO `sys_oper_log` VALUES ('124', '菜单管理', '3', 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', '1', 'admin', null, '/system/menu/2000', '127.0.0.1', '内网IP', '{menuId=2000}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-09 08:59:27');
INSERT INTO `sys_oper_log` VALUES ('125', '菜单管理', '1', 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/order/orderManage\",\"createBy\":\"admin\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"订单管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":1,\"path\":\"order\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-09 09:03:38');
INSERT INTO `sys_oper_log` VALUES ('126', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-09 10:08:22\",\"orderDept\":2,\"orderFromAddress\":\"福建省福州市上街镇\",\"orderFromName\":\"小明\",\"orderFromPhone\":\"15666666999\",\"orderId\":2,\"orderNumber\":105231231231,\"orderPrice\":20,\"orderStatus\":\"1\",\"orderToAddress\":\"福建省漳州市芗城区\",\"orderToName\":\"王五\",\"orderToPhone\":\"15666666666\",\"params\":{},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":false,\"nickName\":\"若依\",\"params\":{},\"status\":\"0\",\"userId\":2}}', null, '1', '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'2,\n			105231231231,\n			\'福建省福州市上街镇\',\n			\'小明\',\n			\'156666669\' at line 2\r\n### The error may exist in file [D:\\project2\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysOrderMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysOrderMapper.updateOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_order    SET ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?    where order_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'2,\n			105231231231,\n			\'福建省福州市上街镇\',\n			\'小明\',\n			\'156666669\' at line 2\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'2,\n			105231231231,\n			\'福建省福州市上街镇\',\n			\'小明\',\n			\'156666669\' at line 2', '2022-10-15 15:11:41');
INSERT INTO `sys_oper_log` VALUES ('127', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":213,\"orderFromAddress\":\"12312\",\"orderFromName\":\"21312\",\"orderFromPhone\":\"231312\",\"orderNumber\":778678769077727232,\"orderStatus\":\"3\",\"orderToAddress\":\"23123\",\"orderToName\":\"3123\",\"orderToPhone\":\"21312\",\"params\":{},\"remark\":\"21\"}', null, '1', 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'userId\' in \'class com.ruoyi.common.core.domain.entity.SysOrder\'', '2022-10-15 15:12:31');
INSERT INTO `sys_oper_log` VALUES ('128', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":100,\"orderFromAddress\":\"21312\",\"orderFromName\":\"231\",\"orderFromPhone\":\"12312\",\"orderNumber\":778679216156979200,\"orderStatus\":\"3\",\"orderToAddress\":\"1231\",\"orderToName\":\"231\",\"orderToPhone\":\"21312\",\"params\":{},\"remark\":\"123\"}', null, '1', 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'userId\' in \'class com.ruoyi.common.core.domain.entity.SysOrder\'', '2022-10-15 15:14:17');
INSERT INTO `sys_oper_log` VALUES ('129', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":100,\"orderFromAddress\":\"12321\",\"orderFromName\":\"2132\",\"orderFromPhone\":\"12312\",\"orderNumber\":778680096050655232,\"orderStatus\":\"3\",\"orderToAddress\":\"21312\",\"orderToName\":\"2131\",\"orderToPhone\":\"213\",\"params\":{},\"remark\":\"21\"}', null, '1', 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'deptId\' in \'class com.ruoyi.common.core.domain.entity.SysOrder\'', '2022-10-15 15:17:47');
INSERT INTO `sys_oper_log` VALUES ('130', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":1231,\"orderFromAddress\":\"12312\",\"orderFromName\":\"12312\",\"orderFromPhone\":\"231\",\"orderNumber\":778680665775550464,\"orderStatus\":\"3\",\"orderToAddress\":\"3123\",\"orderToName\":\"12312\",\"orderToPhone\":\"12312\",\"params\":{},\"remark\":\"123\"}', null, '1', 'Invalid bound statement (not found): com.ruoyi.system.mapper.SysOrderMapper.insertUser', '2022-10-15 15:20:03');
INSERT INTO `sys_oper_log` VALUES ('131', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":1231,\"orderFromAddress\":\"12312\",\"orderFromName\":\"1231\",\"orderFromPhone\":\"2131\",\"orderNumber\":778681059113185280,\"orderStatus\":\"3\",\"orderToAddress\":\"213\",\"orderToName\":\"2131\",\"orderToPhone\":\"213\",\"params\":{}}', null, '1', 'Invalid bound statement (not found): com.ruoyi.system.mapper.SysOrderMapper.insertUser', '2022-10-15 15:21:37');
INSERT INTO `sys_oper_log` VALUES ('132', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":100,\"orderFromAddress\":\"12312\",\"orderFromName\":\"21312\",\"orderFromPhone\":\"123\",\"orderId\":100,\"orderNumber\":778682211275911168,\"orderStatus\":\"3\",\"orderToAddress\":\"12312\",\"orderToName\":\"2311\",\"orderToPhone\":\"2313\",\"params\":{},\"remark\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 15:26:12');
INSERT INTO `sys_oper_log` VALUES ('133', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-15 15:26:12\",\"orderDept\":100,\"orderFromAddress\":\"12312\",\"orderFromName\":\"21312\",\"orderFromPhone\":\"123\",\"orderId\":100,\"orderNumber\":778682211275911200,\"orderPrice\":0,\"orderStatus\":\"2\",\"orderToAddress\":\"12312\",\"orderToName\":\"2311\",\"orderToPhone\":\"2313\",\"params\":{},\"remark\":\"1\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', null, '1', '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			778682211275911200,\n			\'12312\',\n			\'21312\',\n			\'123\',\n			\n			\'2\',\n			\'12\' at line 2\r\n### The error may exist in file [D:\\project2\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysOrderMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysOrderMapper.updateOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_order    SET ?,    ?,    ?,    ?,    ?,        ?,    ?,    ?,    ?,    ?    where order_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			778682211275911200,\n			\'12312\',\n			\'21312\',\n			\'123\',\n			\n			\'2\',\n			\'12\' at line 2\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			778682211275911200,\n			\'12312\',\n			\'21312\',\n			\'123\',\n			\n			\'2\',\n			\'12\' at line 2', '2022-10-15 15:26:47');
INSERT INTO `sys_oper_log` VALUES ('134', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-09 10:08:22\",\"orderDept\":100,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', null, '1', '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2\r\n### The error may exist in file [D:\\project2\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysOrderMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysOrderMapper.updateOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_order    SET ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?    where order_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2', '2022-10-15 15:27:55');
INSERT INTO `sys_oper_log` VALUES ('135', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-09 10:08:22\",\"orderDept\":100,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', null, '1', '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2\r\n### The error may exist in file [D:\\project2\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysOrderMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysOrderMapper.updateOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_order    SET ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?    where order_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2', '2022-10-15 15:36:18');
INSERT INTO `sys_oper_log` VALUES ('136', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-09 10:08:22\",\"orderDept\":100,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', null, '1', '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2\r\n### The error may exist in file [D:\\project2\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysOrderMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysOrderMapper.updateOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_order    SET ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?    where order_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2', '2022-10-15 15:36:51');
INSERT INTO `sys_oper_log` VALUES ('137', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-09 10:08:22\",\"orderDept\":100,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', null, '1', '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2\r\n### The error may exist in file [D:\\project2\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysOrderMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysOrderMapper.updateOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_order    SET ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?    where order_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2', '2022-10-15 15:39:28');
INSERT INTO `sys_oper_log` VALUES ('138', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-09 10:08:22\",\"orderDept\":100,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', null, '1', '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2\r\n### The error may exist in file [D:\\project2\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysOrderMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysOrderMapper.updateOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_order    SET ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?    where order_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2', '2022-10-15 15:39:57');
INSERT INTO `sys_oper_log` VALUES ('139', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-09 10:08:22\",\"orderDept\":100,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', null, '1', '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2\r\n### The error may exist in file [D:\\project2\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysOrderMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysOrderMapper.updateOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_order    SET ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?,    ?    where order_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'100,\n			103132312312,\n			\'福建省厦门市思明区\',\n			\'李四\',\n			\'1588888\' at line 2', '2022-10-15 15:41:33');
INSERT INTO `sys_oper_log` VALUES ('140', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-09 10:08:22\",\"orderDept\":100,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 15:44:49');
INSERT INTO `sys_oper_log` VALUES ('141', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-15 15:26:12\",\"orderDept\":100,\"orderFromAddress\":\"12312\",\"orderFromName\":\"21312\",\"orderFromPhone\":\"123\",\"orderId\":100,\"orderNumber\":778682211275911200,\"orderPrice\":23,\"orderStatus\":\"3\",\"orderToAddress\":\"12312\",\"orderToName\":\"2311\",\"orderToPhone\":\"2313\",\"params\":{},\"remark\":\"1\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 15:44:59');
INSERT INTO `sys_oper_log` VALUES ('142', '用户管理', '2', 'com.ruoyi.web.controller.system.SysUserController.changeStatus()', 'PUT', '1', 'admin', null, '/system/user/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":true,\"params\":{},\"status\":\"1\",\"userId\":1}', null, '1', '不允许操作超级管理员用户', '2022-10-15 15:46:05');
INSERT INTO `sys_oper_log` VALUES ('143', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-15 15:26:12\",\"orderDept\":100,\"orderFromAddress\":\"12312\",\"orderFromName\":\"21312\",\"orderFromPhone\":\"123\",\"orderId\":100,\"orderNumber\":778682211275911200,\"orderPrice\":23,\"orderStatus\":\"2\",\"orderToAddress\":\"12312\",\"orderToName\":\"2311\",\"orderToPhone\":\"2313\",\"params\":{},\"remark\":\"1\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 15:49:12');
INSERT INTO `sys_oper_log` VALUES ('144', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":100,\"orderFromAddress\":\"2131\",\"orderFromName\":\"2131\",\"orderFromPhone\":\"12312\",\"orderId\":100,\"orderNumber\":778693642411061248,\"orderPrice\":231,\"orderStatus\":\"3\",\"orderToAddress\":\"321\",\"orderToName\":\"21312\",\"orderToPhone\":\"21312\",\"params\":{},\"remark\":\"231\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 16:11:37');
INSERT INTO `sys_oper_log` VALUES ('145', '订单管理', '3', 'com.ruoyi.web.controller.system.SysOrderController.remove()', 'DELETE', '1', 'admin', null, '/system/order/100', '127.0.0.1', '内网IP', '{orderIds=100}', null, '1', 'Invalid bound statement (not found): com.ruoyi.system.mapper.SysOrderMapper.deleteorderByIds', '2022-10-15 16:11:44');
INSERT INTO `sys_oper_log` VALUES ('146', '订单管理', '3', 'com.ruoyi.web.controller.system.SysOrderController.remove()', 'DELETE', '1', 'admin', null, '/system/order/100', '127.0.0.1', '内网IP', '{orderIds=100}', null, '1', 'Invalid bound statement (not found): com.ruoyi.system.mapper.SysOrderMapper.deleteorderByIds', '2022-10-15 16:11:51');
INSERT INTO `sys_oper_log` VALUES ('147', '订单管理', '3', 'com.ruoyi.web.controller.system.SysOrderController.remove()', 'DELETE', '1', 'admin', null, '/system/order/100', '127.0.0.1', '内网IP', '{orderIds=100}', null, '1', 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'userId\' not found. Available parameters are [array, arg0]', '2022-10-15 16:12:57');
INSERT INTO `sys_oper_log` VALUES ('148', '订单管理', '3', 'com.ruoyi.web.controller.system.SysOrderController.remove()', 'DELETE', '1', 'admin', null, '/system/order/100', '127.0.0.1', '内网IP', '{orderIds=100}', null, '1', 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'userId\' not found. Available parameters are [array, arg0]', '2022-10-15 16:13:05');
INSERT INTO `sys_oper_log` VALUES ('149', '订单管理', '3', 'com.ruoyi.web.controller.system.SysOrderController.remove()', 'DELETE', '1', 'admin', null, '/system/order/100', '127.0.0.1', '内网IP', '{orderIds=100}', null, '1', 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'userId\' not found. Available parameters are [array, arg0]', '2022-10-15 16:15:28');
INSERT INTO `sys_oper_log` VALUES ('150', '订单管理', '3', 'com.ruoyi.web.controller.system.SysOrderController.remove()', 'DELETE', '1', 'admin', null, '/system/order/100', '127.0.0.1', '内网IP', '{orderIds=100}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 16:16:00');
INSERT INTO `sys_oper_log` VALUES ('151', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/order/orderManage\",\"createTime\":\"2022-10-09 09:03:38\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"订单管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":1,\"path\":\"order\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 16:16:49');
INSERT INTO `sys_oper_log` VALUES ('152', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":100,\"orderFromAddress\":\"2131\",\"orderFromName\":\"2131\",\"orderFromPhone\":\"2131\",\"orderId\":101,\"orderNumber\":778696336865505280,\"orderPrice\":213,\"orderStatus\":\"3\",\"orderToAddress\":\"2131\",\"orderToName\":\"231\",\"orderToPhone\":\"123\",\"params\":{},\"remark\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 16:22:19');
INSERT INTO `sys_oper_log` VALUES ('153', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderNumber\":778704277446340608,\"orderStatus\":\"3\",\"orderToPhone\":\"\",\"params\":{}}', null, '1', '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'order_to_name\' doesn\'t have a default value\r\n### The error may exist in file [D:\\project2\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysOrderMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysOrderMapper.insertOrder-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_order(            order_number,                     order_status,                    create_time   )values(            ?,                     ?,                    sysdate()   )\r\n### Cause: java.sql.SQLException: Field \'order_to_name\' doesn\'t have a default value\n; Field \'order_to_name\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'order_to_name\' doesn\'t have a default value', '2022-10-15 16:53:53');
INSERT INTO `sys_oper_log` VALUES ('154', '岗位管理', '5', 'com.ruoyi.web.controller.system.SysPostController.export()', 'POST', '1', 'admin', null, '/system/post/export', '127.0.0.1', '内网IP', '{\"flag\":false,\"params\":{}}', null, '0', null, '2022-10-15 16:58:26');
INSERT INTO `sys_oper_log` VALUES ('155', '订单管理', '5', 'com.ruoyi.web.controller.system.SysOrderController.export()', 'POST', '1', 'admin', null, '/system/order/export', '127.0.0.1', '内网IP', '{\"params\":{\"dataScope\":\"\"}}', null, '0', null, '2022-10-15 17:04:26');
INSERT INTO `sys_oper_log` VALUES ('156', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.edit()', 'PUT', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-24 16:58:48\",\"delFlag\":\"0\",\"deptId\":2,\"email\":\"kuaidi@qq.com\",\"loginDate\":\"2022-09-24 16:58:48\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"快递员02\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"remark\":\"快递员二号\",\"roleIds\":[2],\"roles\":[],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"user\":{\"admin\":false,\"nickName\":\"快递员02\",\"params\":{},\"status\":\"0\",\"userId\":2,\"userName\":\"kd_02\"},\"userId\":2,\"userName\":\"kd_02\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 17:08:02');
INSERT INTO `sys_oper_log` VALUES ('157', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":2,\"orderFromAddress\":\"123\",\"orderFromName\":\"213\",\"orderFromPhone\":\"123\",\"orderId\":102,\"orderNumber\":778709104259772416,\"orderPrice\":80,\"orderStatus\":\"3\",\"orderToAddress\":\"2313\",\"orderToName\":\"3213\",\"orderToPhone\":\"12312\",\"params\":{},\"remark\":\"232\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 17:13:03');
INSERT INTO `sys_oper_log` VALUES ('158', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-15 17:13:03\",\"orderDept\":2,\"orderFromAddress\":\"123\",\"orderFromName\":\"213\",\"orderFromPhone\":\"123\",\"orderId\":102,\"orderNumber\":778709104259772400,\"orderPrice\":80,\"orderStatus\":\"2\",\"orderToAddress\":\"2313\",\"orderToName\":\"3213\",\"orderToPhone\":\"12312\",\"params\":{},\"remark\":\"232\",\"user\":{\"admin\":false,\"nickName\":\"若依\",\"params\":{},\"status\":\"0\",\"userId\":2}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 17:13:12');
INSERT INTO `sys_oper_log` VALUES ('159', '订单管理', '3', 'com.ruoyi.web.controller.system.SysOrderController.remove()', 'DELETE', '1', 'admin', null, '/system/order/102', '127.0.0.1', '内网IP', '{orderIds=102}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 17:13:17');
INSERT INTO `sys_oper_log` VALUES ('160', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":100,\"orderFromAddress\":\"23213\",\"orderFromName\":\"213\",\"orderFromPhone\":\"3213\",\"orderId\":103,\"orderNumber\":778710044081664000,\"orderPrice\":12,\"orderStatus\":\"3\",\"orderToAddress\":\"32112\",\"orderToName\":\"3213\",\"orderToPhone\":\"21312\",\"params\":{},\"remark\":\"213\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 17:16:47');
INSERT INTO `sys_oper_log` VALUES ('161', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-15 17:16:47\",\"orderDept\":100,\"orderFromAddress\":\"23213\",\"orderFromName\":\"213\",\"orderFromPhone\":\"3213\",\"orderId\":103,\"orderNumber\":778710044081664000,\"orderPrice\":12,\"orderStatus\":\"2\",\"orderToAddress\":\"32112\",\"orderToName\":\"3213\",\"orderToPhone\":\"21312\",\"params\":{},\"remark\":\"213\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-15 17:17:44');
INSERT INTO `sys_oper_log` VALUES ('162', '菜单管理', '1', 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"number\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"用户管理\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":1,\"path\":\"party\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 16:53:53');
INSERT INTO `sys_oper_log` VALUES ('163', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/order/orderManage\",\"createTime\":\"2022-10-09 09:03:38\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"订单管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":1,\"path\":\"order\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 16:54:05');
INSERT INTO `sys_oper_log` VALUES ('164', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/party/index\",\"createTime\":\"2022-10-16 16:53:53\",\"icon\":\"number\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"用户管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":1,\"path\":\"party\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 16:54:24');
INSERT INTO `sys_oper_log` VALUES ('165', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.edit()', 'PUT', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-10-16 15:03:57\",\"delFlag\":\"0\",\"email\":\"lala@qq.com\",\"loginDate\":\"2022-10-16 15:03:57\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"哒哒\",\"params\":{},\"partyId\":2,\"partyName\":\"test02\",\"phonenumber\":\"15666666777\",\"remark\":\"测试用户\",\"sex\":\"0\",\"status\":\"0\"}', null, '1', '不允许操作超级管理员用户', '2022-10-16 18:12:31');
INSERT INTO `sys_oper_log` VALUES ('166', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.resetPwd()', 'PUT', '1', 'admin', null, '/system/party/resetPwd', '127.0.0.1', '内网IP', '{\"params\":{},\"partyId\":2}', null, '1', '不允许操作超级管理员用户', '2022-10-16 18:13:18');
INSERT INTO `sys_oper_log` VALUES ('167', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.changeStatus()', 'PUT', '1', 'admin', null, '/system/party/changeStatus', '127.0.0.1', '内网IP', '{\"params\":{},\"partyId\":2,\"status\":\"1\"}', null, '1', '不允许操作超级管理员用户', '2022-10-16 18:13:24');
INSERT INTO `sys_oper_log` VALUES ('168', '用户管理', '1', 'com.ruoyi.web.controller.system.SysPartyController.add()', 'POST', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"email\":\"234@132.com\",\"nickName\":\"hhh\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15234543456\",\"remark\":\"231\",\"sex\":\"0\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 18:14:27');
INSERT INTO `sys_oper_log` VALUES ('169', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.resetPwd()', 'PUT', '1', 'admin', null, '/system/party/resetPwd', '127.0.0.1', '内网IP', '{\"params\":{},\"partyId\":100}', null, '1', '不允许操作超级管理员用户', '2022-10-16 18:14:34');
INSERT INTO `sys_oper_log` VALUES ('170', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.changeStatus()', 'PUT', '1', 'admin', null, '/system/party/changeStatus', '127.0.0.1', '内网IP', '{\"params\":{},\"partyId\":100,\"status\":\"1\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 18:41:29');
INSERT INTO `sys_oper_log` VALUES ('171', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.changeStatus()', 'PUT', '1', 'admin', null, '/system/party/changeStatus', '127.0.0.1', '内网IP', '{\"params\":{},\"partyId\":100,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 18:41:32');
INSERT INTO `sys_oper_log` VALUES ('172', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.changeStatus()', 'PUT', '1', 'admin', null, '/system/party/changeStatus', '127.0.0.1', '内网IP', '{\"params\":{},\"partyId\":100,\"status\":\"1\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 19:57:44');
INSERT INTO `sys_oper_log` VALUES ('173', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.changeStatus()', 'PUT', '1', 'admin', null, '/system/party/changeStatus', '127.0.0.1', '内网IP', '{\"params\":{},\"partyId\":100,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 19:57:46');
INSERT INTO `sys_oper_log` VALUES ('174', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.resetPwd()', 'PUT', '1', 'admin', null, '/system/party/resetPwd', '127.0.0.1', '内网IP', '{\"params\":{},\"partyId\":100,\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 19:57:54');
INSERT INTO `sys_oper_log` VALUES ('175', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.resetPwd()', 'PUT', '1', 'admin', null, '/system/postman/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 19:58:40');
INSERT INTO `sys_oper_log` VALUES ('176', '角色管理', '2', 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', '1', 'admin', null, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2022-09-22 11:09:01\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,3,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,109,1046,1047,1048,2,110,1049,1050,1051,1052,1053,1054,111,112,113,114,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通网点\",\"roleSort\":\"2\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 19:59:42');
INSERT INTO `sys_oper_log` VALUES ('177', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.edit()', 'PUT', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-24 16:58:48\",\"delFlag\":\"0\",\"deptId\":100,\"email\":\"kuaidi@qq.com\",\"loginDate\":\"2022-09-24 16:58:48\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"快递员02\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"remark\":\"快递员二号\",\"roleIds\":[],\"roles\":[],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"user\":{\"admin\":false,\"nickName\":\"快递员02\",\"params\":{},\"status\":\"0\",\"userId\":2,\"userName\":\"kd_02\"},\"userId\":2,\"userName\":\"kd_02\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 20:41:39');
INSERT INTO `sys_oper_log` VALUES ('178', '用户管理', '1', 'com.ruoyi.web.controller.system.SysPostmanController.add()', 'POST', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":2,\"email\":\"111@qq.com\",\"nickName\":\"1231\",\"params\":{},\"phonenumber\":\"13221345435\",\"postIds\":[],\"remark\":\"213\",\"roleIds\":[],\"sex\":\"0\",\"status\":\"0\",\"userId\":103,\"userName\":\"test02\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 20:42:16');
INSERT INTO `sys_oper_log` VALUES ('179', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":2,\"orderFromAddress\":\"32423\",\"orderFromName\":\"342\",\"orderFromPhone\":\"423\",\"orderId\":104,\"orderNumber\":779129043395293184,\"orderPrice\":23,\"orderStatus\":\"3\",\"orderToAddress\":\"3423\",\"orderToName\":\"3432\",\"orderToPhone\":\"342\",\"params\":{},\"remark\":\"342\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:01:45');
INSERT INTO `sys_oper_log` VALUES ('180', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dept/index\",\"createTime\":\"2022-09-24 16:58:48\",\"icon\":\"tree\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":104,\"menuName\":\"部门管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":1,\"path\":\"dept\",\"perms\":\"system:dept:list\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:03:25');
INSERT INTO `sys_oper_log` VALUES ('181', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/post/index\",\"createTime\":\"2022-09-24 16:58:48\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":105,\"menuName\":\"岗位管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":1,\"path\":\"post\",\"perms\":\"system:post:list\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:03:45');
INSERT INTO `sys_oper_log` VALUES ('182', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dict/index\",\"createTime\":\"2022-09-24 16:58:48\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":106,\"menuName\":\"字典管理\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":1,\"path\":\"dict\",\"perms\":\"system:dict:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:04:34');
INSERT INTO `sys_oper_log` VALUES ('183', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/config/index\",\"createTime\":\"2022-09-24 16:58:48\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":107,\"menuName\":\"参数设置\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":1,\"path\":\"config\",\"perms\":\"system:config:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:04:42');
INSERT INTO `sys_oper_log` VALUES ('184', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2022-09-24 16:58:48\",\"icon\":\"log\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":109,\"menuName\":\"日志管理\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":1,\"path\":\"log\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:04:56');
INSERT INTO `sys_oper_log` VALUES ('185', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-09-24 16:58:48\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:05:45');
INSERT INTO `sys_oper_log` VALUES ('186', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-15 16:08:07\",\"orderDept\":100,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888889\",\"params\":{},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:08:07');
INSERT INTO `sys_oper_log` VALUES ('187', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-15 16:22:19\",\"orderDept\":100,\"orderFromAddress\":\"2131\",\"orderFromName\":\"2131\",\"orderFromPhone\":\"13234212345\",\"orderId\":101,\"orderNumber\":778696336865505300,\"orderPrice\":213,\"orderStatus\":\"3\",\"orderToAddress\":\"2131\",\"orderToName\":\"231\",\"orderToPhone\":\"15554212345\",\"params\":{},\"remark\":\"123\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:43:11');
INSERT INTO `sys_oper_log` VALUES ('188', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-15 17:16:47\",\"orderDept\":100,\"orderFromAddress\":\"23213\",\"orderFromName\":\"213\",\"orderFromPhone\":\"16664212345\",\"orderId\":103,\"orderNumber\":778710044081664000,\"orderPrice\":12,\"orderStatus\":\"2\",\"orderToAddress\":\"32112\",\"orderToName\":\"3213\",\"orderToPhone\":\"13277712345\",\"params\":{},\"remark\":\"213\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:43:27');
INSERT INTO `sys_oper_log` VALUES ('189', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:01:45\",\"orderDept\":2,\"orderFromAddress\":\"32423\",\"orderFromName\":\"342\",\"orderFromPhone\":\"19999212345\",\"orderId\":104,\"orderNumber\":779129043395293200,\"orderPrice\":23,\"orderStatus\":\"3\",\"orderToAddress\":\"3423\",\"orderToName\":\"3432\",\"orderToPhone\":\"18834212345\",\"params\":{},\"remark\":\"342\",\"user\":{\"admin\":false,\"nickName\":\"若依\",\"params\":{},\"status\":\"0\",\"userId\":2}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:43:38');
INSERT INTO `sys_oper_log` VALUES ('190', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-15 16:22:19\",\"orderDept\":1,\"orderFromAddress\":\"2131\",\"orderFromName\":\"2131\",\"orderFromPhone\":\"13234212345\",\"orderId\":101,\"orderNumber\":778696336865505300,\"orderPrice\":213,\"orderStatus\":\"3\",\"orderToAddress\":\"2131\",\"orderToName\":\"231\",\"orderToPhone\":\"15554212345\",\"params\":{},\"remark\":\"123\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:44:00');
INSERT INTO `sys_oper_log` VALUES ('191', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-15 17:16:47\",\"orderDept\":100,\"orderFromAddress\":\"23213\",\"orderFromName\":\"213\",\"orderFromPhone\":\"16664212345\",\"orderId\":103,\"orderNumber\":778710044081664000,\"orderPrice\":12,\"orderStatus\":\"2\",\"orderToAddress\":\"32112\",\"orderToName\":\"3213\",\"orderToPhone\":\"\",\"params\":{},\"remark\":\"213\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:45:13');
INSERT INTO `sys_oper_log` VALUES ('192', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-15 16:22:19\",\"orderDept\":1,\"orderFromAddress\":\"2131\",\"orderFromName\":\"2131\",\"orderFromPhone\":\"13234212345\",\"orderId\":101,\"orderNumber\":778696336865505300,\"orderPrice\":213,\"orderStatus\":\"3\",\"orderToAddress\":\"2131\",\"orderToName\":\"231\",\"orderToPhone\":\"\",\"params\":{},\"remark\":\"123\",\"user\":{\"admin\":true,\"nickName\":\"若依\",\"params\":{},\"status\":\"0\",\"userId\":1}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:45:32');
INSERT INTO `sys_oper_log` VALUES ('193', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-15 17:16:47\",\"orderDept\":100,\"orderFromAddress\":\"23213\",\"orderFromName\":\"213\",\"orderFromPhone\":\"16664212345\",\"orderId\":103,\"orderNumber\":778710044081664000,\"orderPrice\":125,\"orderStatus\":\"2\",\"orderToAddress\":\"32112\",\"orderToName\":\"3213\",\"orderToPhone\":\"13277712345\",\"params\":{},\"remark\":\"213\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":100}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:45:40');
INSERT INTO `sys_oper_log` VALUES ('194', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-15 16:22:19\",\"orderDept\":1,\"orderFromAddress\":\"2131\",\"orderFromName\":\"2131\",\"orderFromPhone\":\"13234212345\",\"orderId\":101,\"orderNumber\":778696336865505300,\"orderPrice\":213,\"orderStatus\":\"3\",\"orderToAddress\":\"2131\",\"orderToName\":\"231\",\"orderToPhone\":\"\",\"params\":{},\"remark\":\"123\",\"user\":{\"admin\":true,\"nickName\":\"若依\",\"params\":{},\"status\":\"0\",\"userId\":1}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-16 21:46:32');
INSERT INTO `sys_oper_log` VALUES ('195', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"test01\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":false,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"test01\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"userId\":100,\"userName\":\"kd_01\"},\"userId\":100,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"userId\":100,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 10:09:40');
INSERT INTO `sys_oper_log` VALUES ('196', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.edit()', 'PUT', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-10-16 18:14:27\",\"delFlag\":\"0\",\"email\":\"234@132.com\",\"loginIp\":\"\",\"nickName\":\"hhh\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15666666777\",\"remark\":\"231\",\"sex\":\"0\",\"status\":\"0\"}', '{\"msg\":\"修改用户\'544\'失败，手机号码已存在\",\"code\":500}', '0', null, '2022-10-17 10:10:56');
INSERT INTO `sys_oper_log` VALUES ('197', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.edit()', 'PUT', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-10-16 18:14:27\",\"delFlag\":\"0\",\"email\":\"234@132.com\",\"loginIp\":\"\",\"nickName\":\"hhh\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15666666777\",\"remark\":\"231\",\"sex\":\"0\",\"status\":\"0\"}', '{\"msg\":\"修改用户\'544\'失败，手机号码已存在\",\"code\":500}', '0', null, '2022-10-17 10:11:00');
INSERT INTO `sys_oper_log` VALUES ('198', '用户管理', '5', 'com.ruoyi.web.controller.system.SysPartyController.export()', 'POST', '1', 'admin', null, '/system/party/export', '127.0.0.1', '内网IP', '{\"params\":{\"dataScope\":\"\"}}', null, '0', null, '2022-10-17 10:11:57');
INSERT INTO `sys_oper_log` VALUES ('199', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:11:44');
INSERT INTO `sys_oper_log` VALUES ('200', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:12:25');
INSERT INTO `sys_oper_log` VALUES ('201', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:14:53');
INSERT INTO `sys_oper_log` VALUES ('202', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:15:16');
INSERT INTO `sys_oper_log` VALUES ('203', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:16:08');
INSERT INTO `sys_oper_log` VALUES ('204', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:17:33');
INSERT INTO `sys_oper_log` VALUES ('205', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:20:47');
INSERT INTO `sys_oper_log` VALUES ('206', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:21:41');
INSERT INTO `sys_oper_log` VALUES ('207', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:34:21');
INSERT INTO `sys_oper_log` VALUES ('208', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.edit()', 'PUT', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-10-16 15:03:57\",\"delFlag\":\"0\",\"email\":\"dada@163.com\",\"loginDate\":\"2022-10-16 15:03:57\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"啦啦\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888666\",\"remark\":\"测试用户\",\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:37:18');
INSERT INTO `sys_oper_log` VALUES ('209', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:37:30');
INSERT INTO `sys_oper_log` VALUES ('210', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15666666777\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:41:19');
INSERT INTO `sys_oper_log` VALUES ('211', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:41:26');
INSERT INTO `sys_oper_log` VALUES ('212', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15666666777\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:41:53');
INSERT INTO `sys_oper_log` VALUES ('213', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15666666777\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:43:11');
INSERT INTO `sys_oper_log` VALUES ('214', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15234543456\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:44:23');
INSERT INTO `sys_oper_log` VALUES ('215', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.edit()', 'PUT', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-10-16 15:03:57\",\"delFlag\":\"0\",\"email\":\"dada@163.com\",\"loginDate\":\"2022-10-16 15:03:57\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"啦啦\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888888\",\"remark\":\"测试用户\",\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:47:38');
INSERT INTO `sys_oper_log` VALUES ('216', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:47:50');
INSERT INTO `sys_oper_log` VALUES ('217', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.edit()', 'PUT', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-10-16 15:03:57\",\"delFlag\":\"0\",\"email\":\"dada@163.com\",\"loginDate\":\"2022-10-16 15:03:57\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"啦啦\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888889\",\"remark\":\"测试用户\",\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:48:20');
INSERT INTO `sys_oper_log` VALUES ('218', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15234543456\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:53:56');
INSERT INTO `sys_oper_log` VALUES ('219', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":1,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15234543456\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 11:59:21');
INSERT INTO `sys_oper_log` VALUES ('220', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四1\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":1,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:00:17');
INSERT INTO `sys_oper_log` VALUES ('221', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":1,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:00:23');
INSERT INTO `sys_oper_log` VALUES ('222', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":1,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15234543456\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:01:17');
INSERT INTO `sys_oper_log` VALUES ('223', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":2,\"orderFromAddress\":\"福建省福州市上街镇\",\"orderFromName\":\"小明\",\"orderFromPhone\":\"15666666999\",\"orderId\":2,\"orderNumber\":105231231231,\"orderParty\":2,\"orderPostman\":2,\"orderPrice\":20,\"orderStatus\":\"1\",\"orderToAddress\":\"福建省漳州市芗城区\",\"orderToName\":\"王五\",\"orderToPhone\":\"15666666666\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"test00\",\"params\":{},\"partyId\":2,\"partyName\":\"test02\",\"phonenumber\":\"15234543456\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":false,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"test00\",\"params\":{},\"phonenumber\":\"15666666666\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":false,\"nickName\":\"test00\",\"params\":{},\"userId\":2,\"userName\":\"kd_02\"},\"userId\":2,\"userName\":\"kd_02\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":false,\"nickName\":\"test00\",\"params\":{},\"userId\":2,\"userName\":\"kd_02\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:03:29');
INSERT INTO `sys_oper_log` VALUES ('224', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.edit()', 'PUT', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-10-16 15:03:57\",\"delFlag\":\"0\",\"email\":\"lala@qq.com\",\"loginDate\":\"2022-10-16 15:03:57\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"哒哒\",\"params\":{},\"partyId\":2,\"partyName\":\"test02\",\"phonenumber\":\"15666666666\",\"remark\":\"测试用户\",\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:04:09');
INSERT INTO `sys_oper_log` VALUES ('225', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.edit()', 'PUT', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-10-16 15:03:57\",\"delFlag\":\"0\",\"email\":\"lala@qq.com\",\"loginDate\":\"2022-10-16 15:03:57\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"哒哒\",\"params\":{},\"partyId\":2,\"partyName\":\"test02\",\"phonenumber\":\"15666666669\",\"remark\":\"测试用户\",\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:04:17');
INSERT INTO `sys_oper_log` VALUES ('226', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":1,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:04:29');
INSERT INTO `sys_oper_log` VALUES ('227', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":1,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:08:23');
INSERT INTO `sys_oper_log` VALUES ('228', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":1,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"roles\":[],\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:08:43');
INSERT INTO `sys_oper_log` VALUES ('229', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:49:18');
INSERT INTO `sys_oper_log` VALUES ('230', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15234543456\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:50:37');
INSERT INTO `sys_oper_log` VALUES ('231', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:55:53');
INSERT INTO `sys_oper_log` VALUES ('232', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15234543456\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:56:01');
INSERT INTO `sys_oper_log` VALUES ('233', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 12:57:35');
INSERT INTO `sys_oper_log` VALUES ('234', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15234543456\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 13:06:10');
INSERT INTO `sys_oper_log` VALUES ('235', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 13:06:36');
INSERT INTO `sys_oper_log` VALUES ('236', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 13:08:19');
INSERT INTO `sys_oper_log` VALUES ('237', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 13:11:11');
INSERT INTO `sys_oper_log` VALUES ('238', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15234543458\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 13:15:39');
INSERT INTO `sys_oper_log` VALUES ('239', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 13:16:46');
INSERT INTO `sys_oper_log` VALUES ('240', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 13:17:13');
INSERT INTO `sys_oper_log` VALUES ('241', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 13:18:15');
INSERT INTO `sys_oper_log` VALUES ('242', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 13:18:44');
INSERT INTO `sys_oper_log` VALUES ('243', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 13:20:52');
INSERT INTO `sys_oper_log` VALUES ('244', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 13:22:24');
INSERT INTO `sys_oper_log` VALUES ('245', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":2,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":100,\"partyName\":\"544\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 13:25:37');
INSERT INTO `sys_oper_log` VALUES ('246', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":2,\"orderPostman\":1,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":2,\"partyName\":\"test02\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 13:32:36');
INSERT INTO `sys_oper_log` VALUES ('247', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":2,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":2,\"partyName\":\"test02\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888883\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 16:46:32');
INSERT INTO `sys_oper_log` VALUES ('248', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":2,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":2,\"partyName\":\"test02\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"15888888881\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 16:46:51');
INSERT INTO `sys_oper_log` VALUES ('249', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":2,\"orderPostman\":101,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":2,\"partyName\":\"test02\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":true,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"13020939876\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"kd_01\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 16:48:02');
INSERT INTO `sys_oper_log` VALUES ('250', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":2,\"orderFromAddress\":\"2131\",\"orderFromName\":\"213\",\"orderFromPhone\":\"15463254653\",\"orderId\":100,\"orderNumber\":779431564001161216,\"orderPrice\":21,\"orderStatus\":\"3\",\"orderToAddress\":\"231\",\"orderToName\":\"2312\",\"orderToPhone\":\"15463254653\",\"params\":{},\"postman\":{\"admin\":false,\"params\":{}}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 17:03:51');
INSERT INTO `sys_oper_log` VALUES ('251', '订单管理', '3', 'com.ruoyi.web.controller.system.SysOrderController.remove()', 'DELETE', '1', 'admin', null, '/system/order/100', '127.0.0.1', '内网IP', '{orderIds=100}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 17:05:26');
INSERT INTO `sys_oper_log` VALUES ('252', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":2,\"orderFromAddress\":\"2131\",\"orderFromName\":\"231\",\"orderFromPhone\":\"13432333434\",\"orderId\":101,\"orderNumber\":779432047629578240,\"orderPrice\":23,\"orderStatus\":\"3\",\"orderToAddress\":\"2311\",\"orderToName\":\"231\",\"orderToPhone\":\"13432333434\",\"params\":{},\"postman\":{\"admin\":false,\"params\":{}}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 17:05:46');
INSERT INTO `sys_oper_log` VALUES ('253', '订单管理', '3', 'com.ruoyi.web.controller.system.SysOrderController.remove()', 'DELETE', '1', 'admin', null, '/system/order/101', '127.0.0.1', '内网IP', '{orderIds=101}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 17:08:53');
INSERT INTO `sys_oper_log` VALUES ('254', '用户管理', '2', 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-22 11:09:01\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"测试部门\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":105,\"email\":\"ry@qq.com\",\"loginDate\":\"2022-09-22 14:01:08\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"test00\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 17:54:02');
INSERT INTO `sys_oper_log` VALUES ('255', '用户管理', '2', 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-22 11:09:01\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"测试部门\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":105,\"email\":\"ry@qq.com\",\"loginDate\":\"2022-09-22 14:01:08\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"test00\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通网点\",\"roleSort\":\"2\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 18:41:56');
INSERT INTO `sys_oper_log` VALUES ('256', '用户管理', '2', 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-22 11:09:01\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"测试部门\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":105,\"email\":\"ry@qq.com\",\"loginDate\":\"2022-09-22 14:01:08\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"test00\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通网点\",\"roleSort\":\"2\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 18:42:24');
INSERT INTO `sys_oper_log` VALUES ('257', '用户管理', '2', 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-22 11:09:01\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"测试部门\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":105,\"email\":\"ry@qq.com\",\"loginDate\":\"2022-09-22 14:01:08\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"test00\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通网点\",\"roleSort\":\"2\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:03:11');
INSERT INTO `sys_oper_log` VALUES ('258', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.edit()', 'PUT', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-24 16:58:48\",\"delFlag\":\"0\",\"deptId\":100,\"email\":\"kuaidi@qq.com\",\"loginDate\":\"2022-09-24 16:58:48\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"快递员02\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"remark\":\"快递员二号\",\"roleIds\":[],\"roles\":[],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":2,\"userName\":\"kd_02\"},\"userId\":2,\"userName\":\"kd_02\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:04:08');
INSERT INTO `sys_oper_log` VALUES ('259', '用户管理', '2', 'com.ruoyi.web.controller.system.SysUserController.changeStatus()', 'PUT', '1', 'admin', null, '/system/user/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"status\":\"1\",\"updateBy\":\"admin\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:06:07');
INSERT INTO `sys_oper_log` VALUES ('260', '用户管理', '2', 'com.ruoyi.web.controller.system.SysUserController.changeStatus()', 'PUT', '1', 'admin', null, '/system/user/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:06:49');
INSERT INTO `sys_oper_log` VALUES ('261', '用户管理', '2', 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-22 11:09:01\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"测试部门\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":105,\"email\":\"ry@qq.com\",\"loginDate\":\"2022-09-22 14:01:08\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"test00\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:08:55');
INSERT INTO `sys_oper_log` VALUES ('262', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.edit()', 'PUT', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":true,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-24 16:58:48\",\"delFlag\":\"0\",\"deptId\":100,\"email\":\"kuaidi@163.com\",\"loginDate\":\"2022-09-24 16:58:48\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"快递员01\",\"params\":{},\"phonenumber\":\"15888888888\",\"postIds\":[1],\"remark\":\"快递员一号\",\"roleIds\":[],\"roles\":[],\"sex\":\"1\",\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"}', null, '1', '不允许操作超级管理员用户', '2022-10-17 19:09:18');
INSERT INTO `sys_oper_log` VALUES ('263', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.edit()', 'PUT', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-24 16:58:48\",\"delFlag\":\"0\",\"deptId\":2,\"email\":\"kuaidi@qq.com\",\"loginDate\":\"2022-09-24 16:58:48\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"快递员02\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"remark\":\"快递员二号\",\"roleIds\":[],\"roles\":[],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":2,\"userName\":\"kd_02\"},\"userId\":2,\"userName\":\"kd_02\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:09:42');
INSERT INTO `sys_oper_log` VALUES ('264', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.resetPwd()', 'PUT', '1', 'admin', null, '/system/postman/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:09:55');
INSERT INTO `sys_oper_log` VALUES ('265', '用户管理', '2', 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-22 11:09:01\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"测试部门\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":105,\"email\":\"ry@qq.com\",\"loginDate\":\"2022-09-22 14:01:08\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"test00\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:10:19');
INSERT INTO `sys_oper_log` VALUES ('266', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.edit()', 'PUT', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-26 08:30:32\",\"delFlag\":\"0\",\"deptId\":1,\"email\":\"123@qq.com\",\"loginIp\":\"\",\"nickName\":\"快递员03\",\"params\":{},\"phonenumber\":\"13020939876\",\"postIds\":[],\"remark\":\"测试三号\",\"roleIds\":[],\"roles\":[],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":101,\"userName\":\"test03\"},\"userId\":101,\"userName\":\"test03\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:10:39');
INSERT INTO `sys_oper_log` VALUES ('267', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.resetPwd()', 'PUT', '1', 'admin', null, '/system/postman/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:10:45');
INSERT INTO `sys_oper_log` VALUES ('268', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":1,\"orderFromAddress\":\"福建省厦门市思明区\",\"orderFromName\":\"李四\",\"orderFromPhone\":\"15888887777\",\"orderId\":1,\"orderNumber\":103132312312,\"orderParty\":100,\"orderPostman\":101,\"orderPrice\":10,\"orderStatus\":\"0\",\"orderToAddress\":\"福建省福州市上街镇\",\"orderToName\":\"张三\",\"orderToPhone\":\"15888888888\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"partyId\":2,\"partyName\":\"test02\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":false,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"总网点\",\"params\":{},\"phonenumber\":\"13020939876\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":101,\"userName\":\"test03\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":true,\"nickName\":\"总网点\",\"params\":{},\"userId\":1,\"userName\":\"test03\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:18:28');
INSERT INTO `sys_oper_log` VALUES ('269', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-10-16 21:59:19\",\"orderDept\":2,\"orderFromAddress\":\"福建省福州市上街镇\",\"orderFromName\":\"小明\",\"orderFromPhone\":\"15666666999\",\"orderId\":2,\"orderNumber\":105231231231,\"orderParty\":100,\"orderPostman\":2,\"orderPrice\":20,\"orderStatus\":\"1\",\"orderToAddress\":\"福建省漳州市芗城区\",\"orderToName\":\"王五\",\"orderToPhone\":\"15666666666\",\"params\":{},\"party\":{\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"test00\",\"params\":{},\"partyId\":2,\"partyName\":\"test02\",\"phonenumber\":\"15666666669\",\"remark\":\"轻拿轻放\",\"status\":\"0\"},\"postman\":{\"admin\":false,\"createTime\":\"2022-10-16 21:59:19\",\"nickName\":\"test00\",\"params\":{},\"phonenumber\":\"15666666666\",\"remark\":\"轻拿轻放\",\"status\":\"0\",\"userId\":2,\"userName\":\"kd_02\"},\"remark\":\"轻拿轻放\",\"user\":{\"admin\":false,\"nickName\":\"test00\",\"params\":{},\"userId\":2,\"userName\":\"kd_02\"}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:18:48');
INSERT INTO `sys_oper_log` VALUES ('270', '用户管理', '2', 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-22 11:09:01\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"测试部门\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":105,\"email\":\"ry@qq.com\",\"loginDate\":\"2022-09-22 14:01:08\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"test00\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通网点\",\"roleSort\":\"2\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:19:15');
INSERT INTO `sys_oper_log` VALUES ('271', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.edit()', 'PUT', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":true,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-24 16:58:48\",\"delFlag\":\"0\",\"deptId\":2,\"email\":\"kuaidi@163.com\",\"loginDate\":\"2022-09-24 16:58:48\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"快递员01\",\"params\":{},\"phonenumber\":\"15888888888\",\"postIds\":[1],\"remark\":\"快递员一号\",\"roleIds\":[],\"roles\":[],\"sex\":\"1\",\"status\":\"0\",\"user\":{\"admin\":true,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":1,\"userName\":\"kd_01\"},\"userId\":1,\"userName\":\"kd_01\"}', null, '1', '不允许操作超级管理员用户', '2022-10-17 19:19:32');
INSERT INTO `sys_oper_log` VALUES ('272', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.edit()', 'PUT', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-26 08:30:32\",\"delFlag\":\"0\",\"deptId\":100,\"email\":\"123@qq.com\",\"loginIp\":\"\",\"nickName\":\"快递员03\",\"params\":{},\"phonenumber\":\"13020939876\",\"postIds\":[],\"remark\":\"测试三号\",\"roleIds\":[],\"roles\":[],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"user\":{\"admin\":false,\"nickName\":\"总网点\",\"params\":{},\"status\":\"0\",\"userId\":101,\"userName\":\"test03\"},\"userId\":101,\"userName\":\"test03\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:20:12');
INSERT INTO `sys_oper_log` VALUES ('273', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.edit()', 'PUT', '1', 'admin', null, '/system/postman', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-09-26 08:30:32\",\"delFlag\":\"0\",\"deptId\":2,\"email\":\"123@qq.com\",\"loginIp\":\"\",\"nickName\":\"快递员03\",\"params\":{},\"phonenumber\":\"13020939876\",\"postIds\":[],\"remark\":\"测试三号\",\"roleIds\":[],\"roles\":[],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"user\":{\"admin\":false,\"nickName\":\"test01\",\"params\":{},\"status\":\"0\",\"userId\":101,\"userName\":\"test03\"},\"userId\":101,\"userName\":\"test03\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:43:14');
INSERT INTO `sys_oper_log` VALUES ('274', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.resetPwd()', 'PUT', '1', 'admin', null, '/system/postman/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:43:23');
INSERT INTO `sys_oper_log` VALUES ('275', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.edit()', 'PUT', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-10-16 15:03:57\",\"delFlag\":\"0\",\"email\":\"dada@163.com\",\"loginDate\":\"2022-10-16 15:03:57\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"啦啦\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888889\",\"remark\":\"测试用户\",\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:44:03');
INSERT INTO `sys_oper_log` VALUES ('276', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.resetPwd()', 'PUT', '1', 'admin', null, '/system/party/resetPwd', '127.0.0.1', '内网IP', '{\"params\":{},\"partyId\":2,\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2022-10-17 19:44:10');
INSERT INTO `sys_oper_log` VALUES ('277', '菜单管理', '1', 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/tranRoute/index\",\"createBy\":\"admin\",\"icon\":\"allOrder\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"物流\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"tranRoute\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-11 18:56:37');
INSERT INTO `sys_oper_log` VALUES ('278', '角色管理', '2', 'com.ruoyi.web.controller.system.SysRoleController.changeStatus()', 'PUT', '1', 'admin', null, '/system/role/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"status\":\"1\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-11 19:05:23');
INSERT INTO `sys_oper_log` VALUES ('279', '角色管理', '2', 'com.ruoyi.web.controller.system.SysRoleController.changeStatus()', 'PUT', '1', 'admin', null, '/system/role/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-11 19:05:25');
INSERT INTO `sys_oper_log` VALUES ('280', '通知公告', '2', 'com.ruoyi.web.controller.system.SysNoticeController.edit()', 'PUT', '1', 'admin', null, '/system/notice', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-09-22 19:09:01\",\"noticeContent\":\"<p>新版本内容xxxxxx</p>\",\"noticeId\":1,\"noticeTitle\":\"温馨提醒：2023若依框架新版本发布啦\",\"noticeType\":\"2\",\"params\":{},\"remark\":\"管理员\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-11 19:07:12');
INSERT INTO `sys_oper_log` VALUES ('281', '通知公告', '2', 'com.ruoyi.web.controller.system.SysNoticeController.edit()', 'PUT', '1', 'admin', null, '/system/notice', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-09-22 19:09:01\",\"noticeContent\":\"<p>维护内容：作者需要休息</p>\",\"noticeId\":2,\"noticeTitle\":\"维护通知：网点管理系统凌晨维护\",\"noticeType\":\"1\",\"params\":{},\"remark\":\"管理员\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-11 19:07:36');
INSERT INTO `sys_oper_log` VALUES ('282', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"email\":\"1254659708@qq.com\",\"nickName\":\"王欢\",\"params\":{},\"phonenumber\":\"15160468797\",\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":102,\"userName\":\"最强快递中心\"}', null, '1', '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'102-2\' for key \'PRIMARY\'\r\n### The error may exist in file [D:\\第一组工训材料\\源码\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserRoleMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_user_role(user_id, role_id) values         (?,?)\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'102-2\' for key \'PRIMARY\'\n; Duplicate entry \'102-2\' for key \'PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'102-2\' for key \'PRIMARY\'', '2023-11-11 19:12:14');
INSERT INTO `sys_oper_log` VALUES ('283', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"email\":\"1254659708@qq.com\",\"nickName\":\"王欢\",\"params\":{},\"phonenumber\":\"15160468797\",\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":103,\"userName\":\"最强快递中心\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-11 19:12:14');
INSERT INTO `sys_oper_log` VALUES ('284', '用户管理', '3', 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', '1', 'admin', null, '/system/user/103', '127.0.0.1', '内网IP', '{userIds=103}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-11 19:12:35');
INSERT INTO `sys_oper_log` VALUES ('285', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"email\":\"1254659708@qq.com\",\"nickName\":\"欢欢\",\"params\":{},\"phonenumber\":\"15160468797\",\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":104,\"userName\":\"网点\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-11 19:13:12');
INSERT INTO `sys_oper_log` VALUES ('286', '用户管理', '3', 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', '1', 'admin', null, '/system/user/2', '127.0.0.1', '内网IP', '{userIds=2}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-11 20:36:06');
INSERT INTO `sys_oper_log` VALUES ('287', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"email\":\"1234659708@qq.com\",\"nickName\":\"林神\",\"params\":{},\"phonenumber\":\"18888888888\",\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":105,\"userName\":\"林家\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-11 20:37:03');
INSERT INTO `sys_oper_log` VALUES ('288', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"1254659708@qq.com\",\"nickName\":\"庄家\",\"params\":{},\"phonenumber\":\"15160468797\",\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userName\":\"zhuan\"}', '{\"msg\":\"新增用户\'zhuan\'失败，手机号码已存在\",\"code\":500}', '0', null, '2023-11-11 20:52:44');
INSERT INTO `sys_oper_log` VALUES ('289', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"1254659708@qq.com\",\"nickName\":\"庄家\",\"params\":{},\"phonenumber\":\"19999999999\",\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userName\":\"zhuan\"}', '{\"msg\":\"新增用户\'zhuan\'失败，邮箱账号已存在\",\"code\":500}', '0', null, '2023-11-11 20:52:57');
INSERT INTO `sys_oper_log` VALUES ('290', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"email\":\"12@qq.com\",\"nickName\":\"庄家\",\"params\":{},\"phonenumber\":\"19999999999\",\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":106,\"userName\":\"zhuan\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-11 20:53:05');
INSERT INTO `sys_oper_log` VALUES ('291', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/role/index\",\"createTime\":\"2022-09-25 00:58:48\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":101,\"menuName\":\"角色管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"role\",\"perms\":\"system:role:list\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-29 16:54:46');
INSERT INTO `sys_oper_log` VALUES ('292', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/role/index\",\"createTime\":\"2022-09-25 00:58:48\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":101,\"menuName\":\"角色管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"role\",\"perms\":\"system:role:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-29 16:55:24');
INSERT INTO `sys_oper_log` VALUES ('293', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dict/index\",\"createTime\":\"2022-09-25 00:58:48\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":106,\"menuName\":\"字典管理\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":1,\"path\":\"dict\",\"perms\":\"system:dict:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-29 16:55:36');
INSERT INTO `sys_oper_log` VALUES ('294', '字典类型', '1', 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', '1', 'admin', null, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"菜单显示\",\"dictType\":\"new_menu_visible\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-29 16:58:32');
INSERT INTO `sys_oper_log` VALUES ('295', '字典类型', '9', 'com.ruoyi.web.controller.system.SysDictTypeController.refreshCache()', 'DELETE', '1', 'admin', null, '/system/dict/type/refreshCache', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-11-29 16:59:36');
INSERT INTO `sys_oper_log` VALUES ('296', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.resetPwd()', 'PUT', '1', 'admin', null, '/system/party/resetPwd', '127.0.0.1', '内网IP', '{\"params\":{},\"partyId\":2,\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-05 19:18:20');
INSERT INTO `sys_oper_log` VALUES ('297', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":100,\"orderFromAddress\":\"福建省福州市闽侯县福州大学\",\"orderFromName\":\"王欢\",\"orderFromPhone\":\"11888888888\",\"orderId\":3,\"orderNumber\":929494364319920128,\"orderParty\":\"2\",\"orderPrice\":12,\"orderToAddress\":\"福建省莆田市涵江区江口\",\"orderToName\":\"林xx\",\"orderToPhone\":\"18888888888\",\"orderWeight\":2,\"params\":{},\"remark\":\"重要内容\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-05 19:19:51');
INSERT INTO `sys_oper_log` VALUES ('298', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.resetPwd()', 'PUT', '1', 'admin', null, '/system/postman/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":true,\"params\":{},\"userId\":1}', null, '1', '不允许操作超级管理员用户', '2023-12-05 19:45:41');
INSERT INTO `sys_oper_log` VALUES ('299', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.resetPwd()', 'PUT', '1', 'admin', null, '/system/postman/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":true,\"params\":{},\"userId\":1}', null, '1', '不允许操作超级管理员用户', '2023-12-05 19:45:56');
INSERT INTO `sys_oper_log` VALUES ('300', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.resetPwd()', 'PUT', '1', 'admin', null, '/system/postman/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":true,\"params\":{},\"userId\":1}', null, '1', '不允许操作超级管理员用户', '2023-12-05 19:46:53');
INSERT INTO `sys_oper_log` VALUES ('301', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPostmanController.resetPwd()', 'PUT', '1', 'admin', null, '/system/postman/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":102}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-05 19:47:26');
INSERT INTO `sys_oper_log` VALUES ('302', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":100,\"orderFromAddress\":\"福建省莆田市涵江区白沙镇龙东村110号\",\"orderFromName\":\"小黄\",\"orderFromPhone\":\"11111111111\",\"orderId\":4,\"orderNumber\":929503843274993664,\"orderParty\":\"2\",\"orderPrice\":12,\"orderToAddress\":\"福建省福州市福清市汤臣一品002号\",\"orderToName\":\"宇少\",\"orderToPhone\":\"13333333333\",\"orderWeight\":2,\"params\":{},\"remark\":\"易碎物品、轻拿轻放\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-05 19:57:31');
INSERT INTO `sys_oper_log` VALUES ('303', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":1,\"orderId\":4,\"orderPostman\":\"102\",\"orderStatus\":\"4\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-05 19:57:47');
INSERT INTO `sys_oper_log` VALUES ('304', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":1,\"orderId\":4,\"orderPostman\":\"102\",\"orderStatus\":\"0\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-05 19:57:54');
INSERT INTO `sys_oper_log` VALUES ('305', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/tranRoute/index\",\"createTime\":\"2023-11-12 02:56:37\",\"icon\":\"allOrder\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"物流\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"tranRoute\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 13:10:10');
INSERT INTO `sys_oper_log` VALUES ('306', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/tranRoute/index\",\"createTime\":\"2023-11-12 02:56:37\",\"icon\":\"allOrder\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"物流\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"tranRoute\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 13:10:10');
INSERT INTO `sys_oper_log` VALUES ('307', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.resetPwd()', 'PUT', '1', 'admin', null, '/system/party/resetPwd', '127.0.0.1', '内网IP', '{\"params\":{},\"partyId\":1,\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 13:10:41');
INSERT INTO `sys_oper_log` VALUES ('308', '订单管理', '1', 'com.ruoyi.web.controller.system.SysOrderController.add()', 'POST', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":100,\"orderFromAddress\":\"福建省福州市福清市汤臣一品002号\",\"orderFromName\":\"宇少\",\"orderFromPhone\":\"13333333333\",\"orderId\":5,\"orderNumber\":932343941318324224,\"orderParty\":\"2\",\"orderPrice\":12,\"orderToAddress\":\"福建省莆田市涵江区江口\",\"orderToName\":\"林xx\",\"orderToPhone\":\"18888888888\",\"orderWeight\":2,\"params\":{},\"remark\":\"\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:03:03');
INSERT INTO `sys_oper_log` VALUES ('309', '订单管理', '2', 'com.ruoyi.web.controller.system.SysOrderController.edit()', 'PUT', '1', 'admin', null, '/system/order', '127.0.0.1', '内网IP', '{\"orderDept\":2,\"orderId\":2,\"orderPostman\":\"2\",\"orderStatus\":\"2\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:06:44');
INSERT INTO `sys_oper_log` VALUES ('310', '订单管理', '3', 'com.ruoyi.web.controller.system.SysOrderController.remove()', 'DELETE', '1', 'admin', null, '/system/order/3', '127.0.0.1', '内网IP', '{orderIds=3}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:08:15');
INSERT INTO `sys_oper_log` VALUES ('311', '订单管理', '3', 'com.ruoyi.web.controller.system.SysOrderController.remove()', 'DELETE', '1', 'admin', null, '/system/order/5', '127.0.0.1', '内网IP', '{orderIds=5}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:08:18');
INSERT INTO `sys_oper_log` VALUES ('312', '用户管理', '3', 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', '1', 'admin', null, '/system/user/104', '127.0.0.1', '内网IP', '{userIds=104}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:11:41');
INSERT INTO `sys_oper_log` VALUES ('313', '用户管理', '3', 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', '1', 'admin', null, '/system/user/105', '127.0.0.1', '内网IP', '{userIds=105}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:11:52');
INSERT INTO `sys_oper_log` VALUES ('314', '用户管理', '3', 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', '1', 'admin', null, '/system/user/106', '127.0.0.1', '内网IP', '{userIds=106}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:11:55');
INSERT INTO `sys_oper_log` VALUES ('315', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"email\":\"1254659708@qq.com\",\"nickName\":\"网点01\",\"params\":{},\"phonenumber\":\"15160468888\",\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":107,\"userName\":\"new_01\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:13:54');
INSERT INTO `sys_oper_log` VALUES ('316', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"1254659708@qq.com\",\"nickName\":\"网点02\",\"params\":{},\"phonenumber\":\"15166669999\",\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userName\":\"new_02\"}', '{\"msg\":\"新增用户\'new_02\'失败，邮箱账号已存在\",\"code\":500}', '0', null, '2023-12-13 16:14:50');
INSERT INTO `sys_oper_log` VALUES ('317', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"email\":\"1254659709@qq.com\",\"nickName\":\"网点02\",\"params\":{},\"phonenumber\":\"15166669999\",\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":108,\"userName\":\"new_02\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:15:01');
INSERT INTO `sys_oper_log` VALUES ('318', '用户管理', '1', 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', '1', 'admin', null, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"email\":\"125469710@qq.com\",\"nickName\":\"网点03\",\"params\":{},\"phonenumber\":\"15177779999\",\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":109,\"userName\":\"new_03\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:15:39');
INSERT INTO `sys_oper_log` VALUES ('319', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.edit()', 'PUT', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2023-11-11 23:03:57\",\"delFlag\":\"0\",\"email\":\"dada@163.com\",\"loginDate\":\"2023-11-11 23:03:57\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"小太阳\",\"params\":{},\"partyId\":1,\"partyName\":\"test01\",\"phonenumber\":\"15888888889\",\"remark\":\"测试用户\",\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:16:42');
INSERT INTO `sys_oper_log` VALUES ('320', '用户管理', '2', 'com.ruoyi.web.controller.system.SysPartyController.edit()', 'PUT', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2023-11-11 23:03:57\",\"delFlag\":\"0\",\"email\":\"lala@qq.com\",\"loginDate\":\"2023-11-11 23:03:57\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"小木匠\",\"params\":{},\"partyId\":2,\"partyName\":\"test02\",\"phonenumber\":\"15666666669\",\"remark\":\"测试用户\",\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:16:57');
INSERT INTO `sys_oper_log` VALUES ('321', '用户管理', '3', 'com.ruoyi.web.controller.system.SysPartyController.remove()', 'DELETE', '1', 'admin', null, '/system/party/100', '127.0.0.1', '内网IP', '{partyIds=100}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:17:10');
INSERT INTO `sys_oper_log` VALUES ('322', '用户管理', '1', 'com.ruoyi.web.controller.system.SysPartyController.add()', 'POST', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"email\":\"1254659710@qq.com\",\"nickName\":\"小林\",\"params\":{},\"partyId\":101,\"partyName\":\"test03\",\"phonenumber\":\"15166668888\",\"sex\":\"0\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:18:00');
INSERT INTO `sys_oper_log` VALUES ('323', '用户管理', '1', 'com.ruoyi.web.controller.system.SysPartyController.add()', 'POST', '1', 'admin', null, '/system/party', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"email\":\"1254659705@qq.com\",\"nickName\":\"小欢\",\"params\":{},\"partyId\":102,\"partyName\":\"test04\",\"phonenumber\":\"15177778888\",\"sex\":\"0\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:18:49');
INSERT INTO `sys_oper_log` VALUES ('324', '菜单管理', '2', 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', '1', 'admin', null, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dict/index\",\"createTime\":\"2022-09-25 00:58:48\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":106,\"menuName\":\"字典管理\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":1,\"path\":\"dict\",\"perms\":\"system:dict:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', '0', null, '2023-12-13 16:19:17');

-- ----------------------------
-- Table structure for sys_order
-- ----------------------------
DROP TABLE IF EXISTS `sys_order`;
CREATE TABLE `sys_order` (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_number` varchar(100) NOT NULL COMMENT '订单编号',
  `order_takenum` varchar(100) DEFAULT NULL COMMENT '取件码',
  `order_dept` bigint(20) DEFAULT NULL COMMENT '所属网点',
  `order_postman` varchar(30) DEFAULT NULL COMMENT '接单快递员',
  `order_party` varchar(30) DEFAULT NULL COMMENT '下单用户',
  `order_weight` bigint(20) NOT NULL COMMENT '订单重量',
  `order_price` bigint(20) DEFAULT '0' COMMENT '订单价格',
  `order_to_name` varchar(30) NOT NULL COMMENT '收货联系人',
  `order_from_name` varchar(30) NOT NULL COMMENT '订单联系人',
  `order_to_phone` varchar(30) NOT NULL COMMENT '订单收货人电话',
  `order_from_phone` varchar(30) NOT NULL COMMENT '订单联系人电话',
  `order_to_address` varchar(400) NOT NULL COMMENT '订单目的地址',
  `order_from_address` varchar(400) NOT NULL COMMENT '订单寄出地址',
  `remark` varchar(500) DEFAULT NULL COMMENT '订单备注',
  `order_status` varchar(30) DEFAULT '3' COMMENT '订单状态',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单信息表';

-- ----------------------------
-- Records of sys_order
-- ----------------------------
INSERT INTO `sys_order` VALUES ('1', '103132312312', '1789', '100', '1', '1', '1', '10', '张三', '李四', '15888888888', '15888887777', '福建省福州市上街镇', '福建省厦门市思明区', '轻拿轻放', '0', '0', '2023-11-11 20:04:06');
INSERT INTO `sys_order` VALUES ('2', '105231231231', '2456', '2', '2', '2', '2', '20', '王五', '小明', '15666666666', '15666666999', '福建省莆田市涵江区', '福建省福州市上街镇', '轻拿轻放', '2', '0', '2023-11-11 20:04:06');
INSERT INTO `sys_order` VALUES ('3', '929494364319920128', null, '100', null, '2', '2', '12', '林xx', '王欢', '18888888888', '11888888888', '福建省莆田市涵江区江口', '福建省福州市闽侯县福州大学', '重要内容', '3', '2', '2023-12-05 19:19:51');
INSERT INTO `sys_order` VALUES ('4', '929503843274993664', null, '1', '102', '2', '2', '12', '宇少', '小黄', '13333333333', '11111111111', '福建省福州市福清市汤臣一品002号', '福建省莆田市涵江区白沙镇龙东村110号', '易碎物品、轻拿轻放', '0', '0', '2023-12-05 19:57:31');
INSERT INTO `sys_order` VALUES ('5', '932343941318324224', null, '100', null, '2', '2', '12', '林xx', '宇少', '18888888888', '13333333333', '福建省莆田市涵江区江口', '福建省福州市福清市汤臣一品002号', null, '3', '2', '2023-12-13 16:03:03');

-- ----------------------------
-- Table structure for sys_ordertran
-- ----------------------------
DROP TABLE IF EXISTS `sys_ordertran`;
CREATE TABLE `sys_ordertran` (
  `orderTran_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '运输ID',
  `order_number` bigint(20) NOT NULL COMMENT '订单编号',
  `order_tran` text COMMENT '运输经纬',
  PRIMARY KEY (`orderTran_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单运输表';

-- ----------------------------
-- Records of sys_ordertran
-- ----------------------------
INSERT INTO `sys_ordertran` VALUES ('1', '103132312312', '[{\"lat\":\"24.445676\",\"lng\":\"118.082745\"},{\"lat\":\"24.521539\",\"lng\":\"118.13298\"},{\"lat\":\"24.643923\",\"lng\":\"118.140533\"},{\"lat\":\"24.687291\",\"lng\":\"118.188255\"},{\"lat\":\"24.861679\",\"lng\":\"118.584335\"},{\"lat\":\"25.259761\",\"lng\":\"118.875473\"},{\"lat\":25.279734532543685,\"lng\":118.89601513779044},{\"lat\":25.31953381980307,\"lng\":118.90770718025298}]');
INSERT INTO `sys_ordertran` VALUES ('2', '105231231231', '[{\"lat\": \"26.074226\",\"lng\": \"119.20401\"},{\"lat\": \"25.8416\",\"lng\": \"118.932831\"},{\"lat\": \"25.524771\",\"lng\": \"119.081146\"},{\"lat\": \"25.375968\",\"lng\": \"118.916351\"},{\"lat\": \"25.3983\",\"lng\": \"118.633453\"},{\"lat\": \"25.343703\",\"lng\": \"118.29837\"},{\"lat\": \"25.035515\",\"lng\": \"118.397247\"},{\"lat\": \"24.706591\",\"lng\": \"118.408234\"},{\"lat\": \"24.58177\",\"lng\": \"117.97702\"},{\"lat\": \"24.564285\",\"lng\": \"117.666656\"}]');
INSERT INTO `sys_ordertran` VALUES ('3', '929503843274993700', '[]');

-- ----------------------------
-- Table structure for sys_party
-- ----------------------------
DROP TABLE IF EXISTS `sys_party`;
CREATE TABLE `sys_party` (
  `party_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `party_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`party_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_party
-- ----------------------------
INSERT INTO `sys_party` VALUES ('1', 'test01', '小太阳', 'dada@163.com', '15888888889', '0', '', '$2a$10$azpFcw0www7ME5HR17AHAeNFSyK3YF0okYU/V8xzGRz9e98wX6Yvy', '0', '0', '127.0.0.1', '2023-11-11 15:03:57', 'admin', '2023-11-11 15:03:57', 'admin', '2023-12-13 16:16:42', '测试用户');
INSERT INTO `sys_party` VALUES ('2', 'test02', '小木匠', 'lala@qq.com', '15666666669', '0', '', '$2a$10$Syz5PJ82SgrwFsb4aM2Pc.sEoMtqif7aZttW57wzQBomLp6pyRJ5e', '0', '0', '127.0.0.1', '2023-11-11 15:03:57', 'admin', '2023-11-11 15:03:57', 'admin', '2023-12-13 16:16:57', '测试用户');
INSERT INTO `sys_party` VALUES ('100', '544', 'hhh', '234@132.com', '15234543456', '0', '', '$2a$10$hNKmn.gPUArE8hDiSXgG1.fXUibGD/56VbeiU4JawixwQYEE82E7.', '0', '2', '', null, 'admin', '2023-11-11 18:14:27', 'admin', '2023-11-11 19:57:54', '231');
INSERT INTO `sys_party` VALUES ('101', 'test03', '小林', '1254659710@qq.com', '15166668888', '0', '', '$2a$10$rIbMg0tOR7JNPE2dbJctsuAnoxUR6fTEvDu8hqdKBYaBUq/ycI07C', '0', '0', '', null, 'admin', '2023-12-13 16:18:00', '', null, null);
INSERT INTO `sys_party` VALUES ('102', 'test04', '小欢', '1254659705@qq.com', '15177778888', '0', '', '$2a$10$XGECgnJXque2Sy73i.Y5LeG2uKemuTj0yXNzZ3kAamP1yzy1OEu0a', '0', '0', '', null, 'admin', '2023-12-13 16:18:49', '', null, null);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int(11) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES ('1', 'ceo', '董事长', '1', '0', 'admin', '2023-11-11 11:09:01', '', null, '');
INSERT INTO `sys_post` VALUES ('2', 'se', '项目经理', '2', '0', 'admin', '2023-11-11 11:09:01', '', null, '');
INSERT INTO `sys_post` VALUES ('3', 'hr', '人力资源', '3', '0', 'admin', '2023-11-11 11:09:01', '', null, '');
INSERT INTO `sys_post` VALUES ('4', 'user', '普通员工', '4', '0', 'admin', '2023-11-11 11:09:01', '', null, '');

-- ----------------------------
-- Table structure for sys_postman
-- ----------------------------
DROP TABLE IF EXISTS `sys_postman`;
CREATE TABLE `sys_postman` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '网点ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `wallet` bigint(20) DEFAULT '0' COMMENT '钱包',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='快递员信息表';

-- ----------------------------
-- Records of sys_postman
-- ----------------------------
INSERT INTO `sys_postman` VALUES ('1', '100', 'kd_01', '快递员01', '00', 'kuaidi@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2023-11-11 16:58:48', 'admin', '2023-11-11 16:58:48', '', null, '快递员一号', '10000');
INSERT INTO `sys_postman` VALUES ('2', '2', 'kd_02', '快递员02', '00', 'kuaidi@qq.com', '15666666666', '1', '', '$2a$10$t9oteyz75FfCIIrjXRcBHu8ulfaEP4Nb3ezwXSZxvii/JNFPJb4y6', '0', '0', '127.0.0.1', '2023-11-11 16:58:48', 'admin', '2023-11-11 16:58:48', 'admin', '2022-10-17 19:10:45', '快递员二号', '10');
INSERT INTO `sys_postman` VALUES ('101', '2', 'test03', '快递员03', '00', '123@qq.com', '13020939876', '1', '', '$2a$10$3b7TspCNlii.pMJTZWVwQey7Oc5bXIWGjyiElvyO75YH.tWSTCYcy', '0', '0', '', null, 'admin', '2023-11-11 08:30:32', 'admin', '2022-10-17 19:43:14', '测试三号', '0');
INSERT INTO `sys_postman` VALUES ('102', '1', 'kd_04', '快递员04', '00', '1234@qq.com', '15456544333', '0', '', '$2a$10$173whBG0VpRl0Ee2mjD/BOur/4j65rIe31G7Qae2aHyXaToK./6zi', '0', '0', '', null, 'admin', '2023-11-11 09:10:56', 'admin', '2023-12-05 19:47:26', '测试4号', '0');
INSERT INTO `sys_postman` VALUES ('103', '2', 'test02', '1231', '00', '111@qq.com', '13221345435', '0', '', '$2a$10$R6TZYvwxb746dzBqfqqRF.Cjoqlu.SgTYqHvMKX5GlQnsO43JNy0O', '0', '0', '', null, 'admin', '2023-11-11 20:42:16', '', null, '213', '0');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(11) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'admin', '1', '1', '1', '1', '0', '0', 'admin', '2023-11-11 11:09:01', '', null, '超级管理员');
INSERT INTO `sys_role` VALUES ('2', '普通网点', 'common', '2', '2', '0', '0', '0', '0', 'admin', '2023-11-11 11:09:01', 'admin', '2023-11-11 19:05:25', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES ('2', '100');
INSERT INTO `sys_role_dept` VALUES ('2', '101');
INSERT INTO `sys_role_dept` VALUES ('2', '105');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('2', '1');
INSERT INTO `sys_role_menu` VALUES ('2', '2');
INSERT INTO `sys_role_menu` VALUES ('2', '3');
INSERT INTO `sys_role_menu` VALUES ('2', '4');
INSERT INTO `sys_role_menu` VALUES ('2', '101');
INSERT INTO `sys_role_menu` VALUES ('2', '102');
INSERT INTO `sys_role_menu` VALUES ('2', '103');
INSERT INTO `sys_role_menu` VALUES ('2', '104');
INSERT INTO `sys_role_menu` VALUES ('2', '105');
INSERT INTO `sys_role_menu` VALUES ('2', '106');
INSERT INTO `sys_role_menu` VALUES ('2', '107');
INSERT INTO `sys_role_menu` VALUES ('2', '108');
INSERT INTO `sys_role_menu` VALUES ('2', '109');
INSERT INTO `sys_role_menu` VALUES ('2', '110');
INSERT INTO `sys_role_menu` VALUES ('2', '111');
INSERT INTO `sys_role_menu` VALUES ('2', '112');
INSERT INTO `sys_role_menu` VALUES ('2', '113');
INSERT INTO `sys_role_menu` VALUES ('2', '114');
INSERT INTO `sys_role_menu` VALUES ('2', '115');
INSERT INTO `sys_role_menu` VALUES ('2', '116');
INSERT INTO `sys_role_menu` VALUES ('2', '117');
INSERT INTO `sys_role_menu` VALUES ('2', '500');
INSERT INTO `sys_role_menu` VALUES ('2', '501');
INSERT INTO `sys_role_menu` VALUES ('2', '1007');
INSERT INTO `sys_role_menu` VALUES ('2', '1008');
INSERT INTO `sys_role_menu` VALUES ('2', '1009');
INSERT INTO `sys_role_menu` VALUES ('2', '1010');
INSERT INTO `sys_role_menu` VALUES ('2', '1011');
INSERT INTO `sys_role_menu` VALUES ('2', '1012');
INSERT INTO `sys_role_menu` VALUES ('2', '1013');
INSERT INTO `sys_role_menu` VALUES ('2', '1014');
INSERT INTO `sys_role_menu` VALUES ('2', '1015');
INSERT INTO `sys_role_menu` VALUES ('2', '1016');
INSERT INTO `sys_role_menu` VALUES ('2', '1017');
INSERT INTO `sys_role_menu` VALUES ('2', '1018');
INSERT INTO `sys_role_menu` VALUES ('2', '1019');
INSERT INTO `sys_role_menu` VALUES ('2', '1020');
INSERT INTO `sys_role_menu` VALUES ('2', '1021');
INSERT INTO `sys_role_menu` VALUES ('2', '1022');
INSERT INTO `sys_role_menu` VALUES ('2', '1023');
INSERT INTO `sys_role_menu` VALUES ('2', '1024');
INSERT INTO `sys_role_menu` VALUES ('2', '1025');
INSERT INTO `sys_role_menu` VALUES ('2', '1026');
INSERT INTO `sys_role_menu` VALUES ('2', '1027');
INSERT INTO `sys_role_menu` VALUES ('2', '1028');
INSERT INTO `sys_role_menu` VALUES ('2', '1029');
INSERT INTO `sys_role_menu` VALUES ('2', '1030');
INSERT INTO `sys_role_menu` VALUES ('2', '1031');
INSERT INTO `sys_role_menu` VALUES ('2', '1032');
INSERT INTO `sys_role_menu` VALUES ('2', '1033');
INSERT INTO `sys_role_menu` VALUES ('2', '1034');
INSERT INTO `sys_role_menu` VALUES ('2', '1035');
INSERT INTO `sys_role_menu` VALUES ('2', '1036');
INSERT INTO `sys_role_menu` VALUES ('2', '1037');
INSERT INTO `sys_role_menu` VALUES ('2', '1038');
INSERT INTO `sys_role_menu` VALUES ('2', '1039');
INSERT INTO `sys_role_menu` VALUES ('2', '1040');
INSERT INTO `sys_role_menu` VALUES ('2', '1041');
INSERT INTO `sys_role_menu` VALUES ('2', '1042');
INSERT INTO `sys_role_menu` VALUES ('2', '1043');
INSERT INTO `sys_role_menu` VALUES ('2', '1044');
INSERT INTO `sys_role_menu` VALUES ('2', '1045');
INSERT INTO `sys_role_menu` VALUES ('2', '1046');
INSERT INTO `sys_role_menu` VALUES ('2', '1047');
INSERT INTO `sys_role_menu` VALUES ('2', '1048');
INSERT INTO `sys_role_menu` VALUES ('2', '1049');
INSERT INTO `sys_role_menu` VALUES ('2', '1050');
INSERT INTO `sys_role_menu` VALUES ('2', '1051');
INSERT INTO `sys_role_menu` VALUES ('2', '1052');
INSERT INTO `sys_role_menu` VALUES ('2', '1053');
INSERT INTO `sys_role_menu` VALUES ('2', '1054');
INSERT INTO `sys_role_menu` VALUES ('2', '1055');
INSERT INTO `sys_role_menu` VALUES ('2', '1056');
INSERT INTO `sys_role_menu` VALUES ('2', '1057');
INSERT INTO `sys_role_menu` VALUES ('2', '1058');
INSERT INTO `sys_role_menu` VALUES ('2', '1059');
INSERT INTO `sys_role_menu` VALUES ('2', '1060');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '103', 'admin', '总网点', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2023-12-13 08:05:52', 'admin', '2023-11-11 11:09:01', '', '2023-12-13 16:05:52', '管理员');
INSERT INTO `sys_user` VALUES ('2', '105', 'ry', 'test00', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '2', '127.0.0.1', '2023-12-13 08:06:27', 'admin', '2023-11-11 11:09:01', 'admin', '2023-12-13 16:06:27', '测试员');
INSERT INTO `sys_user` VALUES ('100', '100', 'Test01', 'test01', '00', '123@qq.com', '13602222222', '0', '', '$2a$10$.A5sT6CfLnOxkvzYFsxO1O40STd0RN9/zBiVCn/A6vNr5tdD8zblG', '0', '0', '127.0.0.1', '2023-11-11 14:07:35', 'admin', '2023-11-11 14:05:32', '', '2023-11-11 14:07:34', null);
INSERT INTO `sys_user` VALUES ('103', null, '最强快递中心', '王欢', '00', '1254659708@qq.com', '15160468797', '0', '', '$2a$10$xdijp9E.Zuq8Bj0sqpOgde46mVs3ajDSiqgsuuE2/pwEU1RioqTBS', '0', '2', '', null, 'admin', '2023-11-11 19:12:14', '', null, null);
INSERT INTO `sys_user` VALUES ('104', null, '网点', '欢欢', '00', '1254659708@qq.com', '15160468797', '0', '', '$2a$10$INC8wD6fpNxSB6WaCnYpxOZxgWyl6Vb/R7O/pZFH6p.eq30jasQBS', '0', '2', '', null, 'admin', '2023-11-11 19:13:12', '', null, null);
INSERT INTO `sys_user` VALUES ('105', null, '林家', '林神', '00', '1234659708@qq.com', '18888888888', '0', '', '$2a$10$YireciGdU8byX3LCVasnOOfZ.JrT7s3su3EB6chKYTvxtYqb862.q', '0', '2', '', null, 'admin', '2023-11-11 20:37:03', '', null, null);
INSERT INTO `sys_user` VALUES ('106', null, 'zhuan', '庄家', '00', '12@qq.com', '19999999999', '0', '', '$2a$10$Bldb23MzIvWgvdAoDDZlMOvTSwKsFumQVeUWwhwVp.viCytrXawG6', '0', '2', '127.0.0.1', '2023-11-11 12:53:37', 'admin', '2023-11-11 20:53:05', '', '2023-11-11 20:53:37', null);
INSERT INTO `sys_user` VALUES ('107', null, 'new_01', '网点01', '00', '1254659708@qq.com', '15160468888', '0', '', '$2a$10$G.aWnl2PE24nn3Awl/Hpl.HBGd862WUoXHUj4wfZNJOAHXodarXHq', '0', '0', '', null, 'admin', '2023-12-13 16:13:54', '', null, null);
INSERT INTO `sys_user` VALUES ('108', null, 'new_02', '网点02', '00', '1254659709@qq.com', '15166669999', '0', '', '$2a$10$NJw.lGNyQzcgSrzLGdHVzuQYSmObyIrr.AdznOteDFxGHy0S8PpdO', '0', '0', '', null, 'admin', '2023-12-13 16:15:01', '', null, null);
INSERT INTO `sys_user` VALUES ('109', null, 'new_03', '网点03', '00', '125469710@qq.com', '15177779999', '0', '', '$2a$10$285plXL1dVp6JkgJeHRAleJNOFvhuIQT5tLX3OH/Q21RNXWR5Xopm', '0', '0', '', null, 'admin', '2023-12-13 16:15:39', '', null, null);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES ('1', '1');
INSERT INTO `sys_user_post` VALUES ('100', '4');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('100', '2');
INSERT INTO `sys_user_role` VALUES ('102', '2');
INSERT INTO `sys_user_role` VALUES ('107', '2');
INSERT INTO `sys_user_role` VALUES ('108', '2');
INSERT INTO `sys_user_role` VALUES ('109', '2');
