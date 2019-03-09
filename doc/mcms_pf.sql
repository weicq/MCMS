/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost:3306
 Source Schema         : mcms_pf

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : 65001

 Date: 07/03/2019 15:30:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app`  (
  `app_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '站点id',
  `app_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '站点名称',
  `app_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '站点域名，多个回车换行显示',
  `app_logo` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网站logo',
  `app_keyword` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '站点关键字',
  `app_copyright` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '站点版权信息',
  `app_style` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '站点风格',
  `app_managerid` int(11) NULL DEFAULT NULL COMMENT '站点对于管理员编号',
  `app_description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `app_datetime` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `app_mobile_style` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '移动端风格',
  `app_pay_date` datetime(0) NULL DEFAULT NULL COMMENT '应用续费时间',
  `app_pay` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '费用清单',
  `app_state` int(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0运行中 1已停止  ',
  `app_mobile_state` int(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0启用 1停用',
  `app_login_page` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自定义登录界面',
  PRIMARY KEY (`app_id`) USING BTREE,
  INDEX `fk_app_manager_1`(`app_managerid`) USING BTREE,
  CONSTRAINT `fk_app_manager_1` FOREIGN KEY (`app_managerid`) REFERENCES `manager` (`manager_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app
-- ----------------------------
INSERT INTO `app` VALUES (1, 'MCMS-OPEN', 'http://localhost:8080/ms-mcms\r\n', '', '', '', 'company1809', 50, '', NULL, 'm', NULL, '', 0, 0, '');

-- ----------------------------
-- Table structure for basic
-- ----------------------------
DROP TABLE IF EXISTS `basic`;
CREATE TABLE `basic`  (
  `basic_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `basic_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `basic_description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `basic_thumbnails` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缩略图',
  `basic_hit` bigint(22) NULL DEFAULT NULL COMMENT '点击次数',
  `basic_sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `basic_datetime` datetime(0) NULL DEFAULT NULL COMMENT ' 发布时间',
  `basic_updatetime` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `basic_peopleid` int(22) NULL DEFAULT NULL COMMENT '用户编号',
  `basic_categoryid` int(22) NULL DEFAULT NULL COMMENT '所属分类编号',
  `basic_appid` int(11) NOT NULL COMMENT '应用编号',
  `basic_modelid` int(11) NULL DEFAULT NULL COMMENT '模块编号',
  `basic_comment` int(11) NULL DEFAULT NULL COMMENT '评论次数',
  `basic_collect` int(11) NULL DEFAULT NULL COMMENT '收藏次数',
  `basic_share` int(11) NULL DEFAULT NULL COMMENT '分享次数',
  `basic_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '属性',
  `basic_display` int(1) NULL DEFAULT 0 COMMENT '显示属性 0显示1不显示',
  PRIMARY KEY (`basic_id`) USING BTREE,
  UNIQUE INDEX `basic_id`(`basic_id`) USING BTREE,
  INDEX `basic_appid`(`basic_appid`) USING BTREE,
  INDEX `basic_modelid`(`basic_modelid`) USING BTREE,
  INDEX `basic_categoryid`(`basic_categoryid`) USING BTREE,
  INDEX `basic_title`(`basic_title`) USING BTREE,
  CONSTRAINT `fk_basic_app_id` FOREIGN KEY (`basic_appid`) REFERENCES `app` (`app_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_basic_categoryid` FOREIGN KEY (`basic_categoryid`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '基础表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for basic_attention
-- ----------------------------
DROP TABLE IF EXISTS `basic_attention`;
CREATE TABLE `basic_attention`  (
  `ba_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `ba_people_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `ba_app_id` int(11) NULL DEFAULT NULL COMMENT '用户应用id',
  `ba_basic_id` int(11) NULL DEFAULT NULL COMMENT '用户收藏关联的基础id',
  `ba_type` int(11) NULL DEFAULT NULL COMMENT '收藏类型 1： 收藏  2：顶',
  `ba_datetime` datetime(0) NULL DEFAULT NULL COMMENT '用户收藏文章，帖子或商品时的时间',
  `ba_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收藏的文章,帖子，商品的链接地址',
  PRIMARY KEY (`ba_id`) USING BTREE,
  INDEX `fk_basic_attention_basic_1`(`ba_basic_id`) USING BTREE,
  INDEX `ba_people_id`(`ba_people_id`) USING BTREE,
  CONSTRAINT `fk_basic_attention_basic_1` FOREIGN KEY (`ba_basic_id`) REFERENCES `basic` (`basic_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for basic_column
-- ----------------------------
DROP TABLE IF EXISTS `basic_column`;
CREATE TABLE `basic_column`  (
  `column_category_id` int(11) NOT NULL COMMENT '关联category表（类别表ID）',
  `column_keyword` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目简介',
  `column_descrip` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目关键字的扩展',
  `column_type` int(2) NULL DEFAULT NULL COMMENT '1,代表最终列表栏目。2，代表频道封面。3，带表外部链接',
  `column_url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '如果是外部链接，则保持外部链接地址。如果为最终列表栏目，就保存文章显示列表',
  `column_listurl` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最终列表栏目的列表模板地址',
  `column_path` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目路径',
  `column_cm_id` int(11) NULL DEFAULT NULL COMMENT '栏目管理的内容模型id',
  PRIMARY KEY (`column_category_id`) USING BTREE,
  INDEX `fk_basic_column_id`(`column_cm_id`) USING BTREE,
  CONSTRAINT `fk_basic_column_id` FOREIGN KEY (`column_cm_id`) REFERENCES `mdiy_content_model` (`cm_id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `fk_column_category_id` FOREIGN KEY (`column_category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '栏目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for basic_log
-- ----------------------------
DROP TABLE IF EXISTS `basic_log`;
CREATE TABLE `basic_log`  (
  `bl_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `bl_basic_id` int(11) NOT NULL COMMENT '引用编号',
  `bl_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ip地址',
  `bl_datetime` datetime(0) NOT NULL COMMENT '记录时间',
  `bl_is_mobile` int(1) NOT NULL DEFAULT 0 COMMENT '1移动端 0默认pc',
  PRIMARY KEY (`bl_id`) USING BTREE,
  INDEX `fk_basic_log_basic_1`(`bl_basic_id`) USING BTREE,
  CONSTRAINT `fk_basic_log_basic_1` FOREIGN KEY (`bl_basic_id`) REFERENCES `basic` (`basic_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '信息访问日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别ID',
  `category_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类别标题',
  `category_sort` int(10) NULL DEFAULT NULL COMMENT '类别排序',
  `category_datetime` datetime(0) NULL DEFAULT NULL COMMENT '类别发布时间',
  `category_managerid` int(22) NULL DEFAULT NULL COMMENT '发布用户id',
  `category_modelid` int(11) NULL DEFAULT NULL COMMENT '所属模块id',
  `category_categoryid` int(11) NULL DEFAULT NULL COMMENT '父类别编号',
  `category_smallimg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '略缩图',
  `category_appid` int(11) NULL DEFAULT NULL COMMENT '应用编号',
  `category_description` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目描述',
  `category_parent_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父类型编号',
  `category_dict_id` int(11) NULL DEFAULT 0 COMMENT '字典对应编号',
  `create_by` int(11) NULL DEFAULT 0 COMMENT '创建人',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` int(11) NULL DEFAULT 0 COMMENT '更新人',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `del` int(11) NOT NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`category_id`) USING BTREE,
  INDEX `category_appid`(`category_appid`) USING BTREE,
  INDEX `category_managerid`(`category_managerid`) USING BTREE,
  INDEX `category_modelid`(`category_modelid`) USING BTREE,
  INDEX `category_categoryid`(`category_categoryid`) USING BTREE,
  CONSTRAINT `fk_category_app_id` FOREIGN KEY (`category_appid`) REFERENCES `app` (`app_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_category_category_id` FOREIGN KEY (`category_categoryid`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cms_article
-- ----------------------------
DROP TABLE IF EXISTS `cms_article`;
CREATE TABLE `cms_article`  (
  `article_basicid` int(20) NOT NULL DEFAULT 0 COMMENT '文章id',
  `article_author` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章作者',
  `article_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文章内容',
  `article_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章类型',
  `article_source` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章来源',
  `article_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章跳转链接地址',
  `article_keyword` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章关键字',
  `article_freeorder` int(255) NULL DEFAULT NULL COMMENT '文章自定义显示顺序',
  `article_webid` int(11) NULL DEFAULT NULL COMMENT '文章管理的应用id',
  PRIMARY KEY (`article_basicid`) USING BTREE,
  UNIQUE INDEX `article_basicid`(`article_basicid`) USING BTREE,
  INDEX `article_webid`(`article_webid`) USING BTREE,
  CONSTRAINT `fk_cms_article_basic_1` FOREIGN KEY (`article_basicid`) REFERENCES `basic` (`basic_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cms_class_50
-- ----------------------------
DROP TABLE IF EXISTS `cms_class_50`;
CREATE TABLE `cms_class_50`  (
  `basicid` int(11) NOT NULL,
  `school` varchar(220) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `platform` varchar(220) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`basicid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_class_50
-- ----------------------------
INSERT INTO `cms_class_50` VALUES (2, '1', '2');
INSERT INTO `cms_class_50` VALUES (3, '3', '2');
INSERT INTO `cms_class_50` VALUES (4, '1', '4');
INSERT INTO `cms_class_50` VALUES (5, '2', '1');
INSERT INTO `cms_class_50` VALUES (6, '2', '1');
INSERT INTO `cms_class_50` VALUES (7, '1', '1');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论id（主键）',
  `comment_commentid` int(11) NOT NULL COMMENT '父评论id',
  `comment_content` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论的内容',
  `comment_picture` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论时发布的图片，可上传多张图片',
  `comment_time` datetime(0) NOT NULL COMMENT '评论时间',
  `comment_type` int(11) NOT NULL DEFAULT 2 COMMENT '评论的类型：1 匿名，2 公开，默认为公开',
  `comment_peopleid` int(11) NULL DEFAULT 0 COMMENT '评论者id，默认为非会员用户（即游客）',
  `comment_points` int(11) NULL DEFAULT 0 COMMENT '评价打分（-1至5分）',
  `comment_basicid` int(11) NOT NULL COMMENT '（文章、商品...）绑定basicid（外键）',
  `comment_appid` int(11) NULL DEFAULT NULL COMMENT '(文章、商品）绑定的应用编号',
  `comment_file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件文件名称',
  `comment_file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件文件路径',
  `comment_is_anonymous` int(11) NULL DEFAULT 0 COMMENT '是否匿名',
  `comment_audit` int(1) NULL DEFAULT 0 COMMENT '0默认显示 1:审核不通过',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `index2`(`comment_basicid`) USING BTREE,
  INDEX `fk_comment_people_1`(`comment_peopleid`) USING BTREE,
  CONSTRAINT `fk_comment` FOREIGN KEY (`comment_basicid`) REFERENCES `basic` (`basic_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_people_1` FOREIGN KEY (`comment_peopleid`) REFERENCES `people` (`people_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`  (
  `manager_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员id(主键)',
  `manager_name` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员用户名',
  `manager_nickname` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员昵称',
  `manager_password` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员密码',
  `manager_roleid` int(11) NULL DEFAULT NULL COMMENT '角色编号',
  `manager_peopleid` bigint(22) NULL DEFAULT 0 COMMENT '用户编号即商家编号',
  `manager_time` datetime(0) NULL DEFAULT NULL COMMENT '管理员创建时间',
  `manager_system_skin_id` int(11) NULL DEFAULT 0 COMMENT '管理员主界面样式',
  PRIMARY KEY (`manager_id`) USING BTREE,
  INDEX `fk_manager_role_1`(`manager_roleid`) USING BTREE,
  CONSTRAINT `fk_manager_role_1` FOREIGN KEY (`manager_roleid`) REFERENCES `role` (`role_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES (50, 'msopen', 'msopen', '9d8622060de5f24937b60585c3f4d66b', 48, 0, '2015-09-18 11:54:36', 0);

-- ----------------------------
-- Table structure for manager_model_page
-- ----------------------------
DROP TABLE IF EXISTS `manager_model_page`;
CREATE TABLE `manager_model_page`  (
  `mmp_manager_id` int(11) NULL DEFAULT NULL COMMENT '自增长id',
  `mmp_model_id` int(11) NULL DEFAULT NULL COMMENT '模块编号',
  `mmp_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '默认后台显示的主界面',
  INDEX `fk_manager_model_page_manager_1`(`mmp_manager_id`) USING BTREE,
  INDEX `fk_manager_model_page_model_1`(`mmp_model_id`) USING BTREE,
  CONSTRAINT `fk_manager_model_page_manager_1` FOREIGN KEY (`mmp_manager_id`) REFERENCES `manager` (`manager_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_manager_model_page_model_1` FOREIGN KEY (`mmp_model_id`) REFERENCES `model` (`model_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员对应的每个模块的主界面自定义' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mdiy_content_mode_field
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_content_mode_field`;
CREATE TABLE `mdiy_content_mode_field`  (
  `field_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '字段自增长id',
  `field_tipsname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段提示文字',
  `field_fieldname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名称',
  `field_type` int(11) NULL DEFAULT NULL COMMENT '字段类型（如1.单行，2.多行，3.图片，等）',
  `field_default` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段默认值',
  `field_isnull` int(11) NULL DEFAULT NULL COMMENT '字段是否为空 0:必填 1:可选',
  `field_cmid` int(11) NULL DEFAULT NULL COMMENT '关联内容模型表id',
  `field_sort` int(11) NULL DEFAULT NULL COMMENT '字段排序',
  `field_issearch` int(255) NULL DEFAULT NULL COMMENT '字段是否支持后台搜索0：不支持，1：支持',
  `field_length` int(11) NULL DEFAULT 1 COMMENT '字段长度',
  `create_by` int(11) NULL DEFAULT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `update_by` int(11) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  `del` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`field_id`) USING BTREE,
  INDEX `fk_mdiy_content_mode_field_mdiy_content_model_1`(`field_cmid`) USING BTREE,
  CONSTRAINT `fk_mdiy_content_mode_field_mdiy_content_model_1` FOREIGN KEY (`field_cmid`) REFERENCES `mdiy_content_model` (`cm_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义内容模型关联字段表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mdiy_content_mode_field
-- ----------------------------
INSERT INTO `mdiy_content_mode_field` VALUES (5, '产品参数', 'detail', 2, NULL, 1, 1, NULL, 0, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `mdiy_content_mode_field` VALUES (6, '商品栏目ID', 'BI', 1, NULL, 1, 2, NULL, 0, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `mdiy_content_mode_field` VALUES (8, '描述1', 'descripone', 2, NULL, 1, 3, NULL, 0, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `mdiy_content_mode_field` VALUES (9, '描述2', 'descriptwo', 2, NULL, 1, 3, NULL, 0, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `mdiy_content_mode_field` VALUES (10, '描述3', 'descripTh', 2, NULL, 1, 3, NULL, 0, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `mdiy_content_mode_field` VALUES (11, '描述4', 'descripFo', 2, NULL, 1, 3, NULL, 0, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `mdiy_content_mode_field` VALUES (12, '描述5', 'descripFi', 2, NULL, 1, 3, NULL, 0, 1, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mdiy_content_model
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_content_model`;
CREATE TABLE `mdiy_content_model`  (
  `cm_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `cm_tips_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单提示文字',
  `cm_table_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单名称',
  `cm_model_id` int(11) NULL DEFAULT NULL COMMENT '模块编号',
  `cm_app_id` int(11) NULL DEFAULT NULL COMMENT '应用编号',
  `create_by` int(11) NULL DEFAULT NULL,
  `creaet_date` datetime(0) NULL DEFAULT NULL,
  `update_by` int(11) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`cm_id`) USING BTREE,
  INDEX `fk_mdiy_content_model`(`cm_app_id`) USING BTREE,
  CONSTRAINT `fk_mdiy_content_model` FOREIGN KEY (`cm_app_id`) REFERENCES `app` (`app_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义模型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mdiy_content_model
-- ----------------------------
INSERT INTO `mdiy_content_model` VALUES (1, '茶叶', 'mdiy_tea_2', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `mdiy_content_model` VALUES (2, '商品品牌', 'mdiy_brand_2', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `mdiy_content_model` VALUES (3, '自定义', 'mdiy_mooc_50', 0, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mdiy_dict
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_dict`;
CREATE TABLE `mdiy_dict`  (
  `dict_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `app_id` int(11) NULL DEFAULT NULL COMMENT '应用编号',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '数据值',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '标签名',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '类型',
  `dict_description` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述',
  `dict_sort` int(10) NOT NULL DEFAULT 0 COMMENT '排序（升序）',
  `dict_parent_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '0' COMMENT '父级编号',
  `dict_remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注信息',
  `create_by` int(64) NULL DEFAULT 0 COMMENT '创建者',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` int(64) NULL DEFAULT 0 COMMENT '更新者',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `del` int(1) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`dict_id`) USING BTREE,
  INDEX `fk_mdiy_dict`(`app_id`) USING BTREE,
  INDEX `dict_value`(`dict_value`) USING BTREE,
  INDEX `dict_label`(`dict_label`) USING BTREE,
  CONSTRAINT `fk_mdiy_dict` FOREIGN KEY (`app_id`) REFERENCES `app` (`app_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mdiy_dict
-- ----------------------------
INSERT INTO `mdiy_dict` VALUES (1, 1, 'f', '幻灯', '文章属性', NULL, 3, '0', NULL, 0, NULL, 0, NULL, 0);
INSERT INTO `mdiy_dict` VALUES (2, 1, 'p', '图片', '文章属性', NULL, 1, '0', NULL, 0, NULL, 0, NULL, 0);
INSERT INTO `mdiy_dict` VALUES (3, 1, 'c', '推荐', '文章属性', NULL, 4, '0', NULL, 0, NULL, 0, NULL, 0);
INSERT INTO `mdiy_dict` VALUES (4, 1, 'h', '头条', '文章属性', NULL, 2, '0', NULL, 0, NULL, 0, NULL, 0);

-- ----------------------------
-- Table structure for mdiy_form
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_form`;
CREATE TABLE `mdiy_form`  (
  `form_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `form_tips_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '自定义表单提示文字',
  `form_table_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '自定义表单表名',
  `form_app_id` int(11) NOT NULL COMMENT '自定义表单关联的应用编号',
  `create_by` int(11) NULL DEFAULT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `update_by` int(11) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`form_id`) USING BTREE,
  INDEX `fk_mdiy_form`(`form_app_id`) USING BTREE,
  CONSTRAINT `fk_mdiy_form` FOREIGN KEY (`form_app_id`) REFERENCES `app` (`app_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义表单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mdiy_form
-- ----------------------------
INSERT INTO `mdiy_form` VALUES (1, '留言', 'mdiy_message_50', 1, 0, '2018-06-29 17:37:13', 0, '2018-06-29 17:37:13');

-- ----------------------------
-- Table structure for mdiy_form_field
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_form_field`;
CREATE TABLE `mdiy_form_field`  (
  `ff_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '字段自增长id',
  `ff_tipsname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段提示文字',
  `ff_fieldname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名称',
  `ff_type` int(11) NULL DEFAULT NULL COMMENT '字段类型（如1.单行，2.多行，3.图片，等）',
  `ff_default` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段的默认值',
  `ff_isnull` int(11) NULL DEFAULT NULL COMMENT '字段是否为空',
  `ff_sort` int(11) NULL DEFAULT NULL COMMENT '自定义表单的排序',
  `ff_formid` int(11) NULL DEFAULT NULL COMMENT '字段管理的表单id',
  PRIMARY KEY (`ff_id`) USING BTREE,
  INDEX `fk_mdiy_form_field`(`ff_formid`) USING BTREE,
  CONSTRAINT `fk_mdiy_form_field` FOREIGN KEY (`ff_formid`) REFERENCES `mdiy_form` (`form_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义表单字段表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mdiy_form_field
-- ----------------------------
INSERT INTO `mdiy_form_field` VALUES (1, '姓名', 'NAME', 1, '', 1, 0, 1);
INSERT INTO `mdiy_form_field` VALUES (2, '手机号', 'PHONE', 1, '', 1, 0, 1);
INSERT INTO `mdiy_form_field` VALUES (3, '留言内容', 'CONTENT', 3, '', 1, 0, 1);

-- ----------------------------
-- Table structure for mdiy_message_50
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_message_50`;
CREATE TABLE `mdiy_message_50`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp(0) NULL DEFAULT NULL COMMENT 'CURRENT_TIMESTAMP',
  `fromID` int(11) NULL DEFAULT NULL,
  `NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `PHONE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CONTENT` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mdiy_mooc_50
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_mooc_50`;
CREATE TABLE `mdiy_mooc_50`  (
  `basicid` int(11) NOT NULL,
  `images` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `descripone` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `descriptwo` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `descripth` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `descripfo` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `descripfi` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`basicid`) USING BTREE,
  CONSTRAINT `fk_mdiy_mooc_50_basicid` FOREIGN KEY (`basicid`) REFERENCES `basic` (`basic_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mdiy_page
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_page`;
CREATE TABLE `mdiy_page`  (
  `page_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `page_app_id` int(11) NOT NULL COMMENT '应用id',
  `page_model_id` int(11) NULL DEFAULT NULL COMMENT '模块id',
  `page_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自定义页面绑定模板的路径',
  `page_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自定义页面标题',
  `page_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自定义页面访问路径',
  `create_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`page_id`) USING BTREE,
  INDEX `index_page_key`(`page_key`) USING BTREE,
  INDEX `index_page_app_id`(`page_app_id`) USING BTREE,
  INDEX `index_page_model_id`(`page_model_id`) USING BTREE,
  CONSTRAINT `fk_page_app_id` FOREIGN KEY (`page_app_id`) REFERENCES `app` (`app_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义页面表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mdiy_page
-- ----------------------------
INSERT INTO `mdiy_page` VALUES (1, 1, 0, 'people/register.htm', '注册', 'register', NULL);
INSERT INTO `mdiy_page` VALUES (2, 1, 0, 'people/login.htm', '登录', 'login', NULL);
INSERT INTO `mdiy_page` VALUES (3, 1, 0, 'people/center.htm', '个人中心', 'people/center', NULL);
INSERT INTO `mdiy_page` VALUES (4, 1, 0, 'people/password-change.htm', '修改密码', 'people/password-change', NULL);

-- ----------------------------
-- Table structure for mdiy_search
-- ----------------------------
DROP TABLE IF EXISTS `mdiy_search`;
CREATE TABLE `mdiy_search`  (
  `search_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `search_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '搜索名称',
  `search_templets` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '搜索结果模版',
  `search_app_id` int(11) NOT NULL COMMENT '搜索管理的应用id',
  `search_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'cms' COMMENT '搜索类型',
  PRIMARY KEY (`search_id`) USING BTREE,
  INDEX `fk_mdiy_search`(`search_app_id`) USING BTREE,
  CONSTRAINT `fk_mdiy_search` FOREIGN KEY (`search_app_id`) REFERENCES `app` (`app_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '自定义搜索表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mdiy_search
-- ----------------------------
INSERT INTO `mdiy_search` VALUES (1, '头部', 'search.htm', 1, 'cms');
INSERT INTO `mdiy_search` VALUES (9, '列表页面搜索', 'search-list.htm', 1, 'cms');

-- ----------------------------
-- Table structure for model
-- ----------------------------
DROP TABLE IF EXISTS `model`;
CREATE TABLE `model`  (
  `model_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '模块自增长id',
  `model_title` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模块标题',
  `model_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模块编码',
  `model_modelid` int(22) NULL DEFAULT NULL COMMENT '模块的父模块id',
  `model_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模块连接地址',
  `model_datetime` datetime(0) NULL DEFAULT NULL,
  `model_icon` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模块图标',
  `model_modelmanagerid` int(11) NULL DEFAULT NULL COMMENT '模块关联的关联员id',
  `model_sort` int(11) NULL DEFAULT NULL COMMENT '模块的排序',
  `model_ismenu` int(1) NULL DEFAULT NULL COMMENT '模块是否是菜单',
  `model_parent_ids` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父级编号集合，从小到大排序',
  `is_child` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单类型',
  PRIMARY KEY (`model_id`) USING BTREE,
  UNIQUE INDEX `sys_c009201`(`model_id`) USING BTREE,
  INDEX `model_modelid`(`model_modelid`) USING BTREE,
  INDEX `model_code`(`model_code`) USING BTREE,
  CONSTRAINT `fk_model_model_id` FOREIGN KEY (`model_modelid`) REFERENCES `model` (`model_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 155 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模块表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of model
-- ----------------------------
INSERT INTO `model` VALUES (1, '内容管理', '02000000', NULL, '', '2014-08-01 16:19:50', '&#xe77a;', 0, 5, 1, NULL, NULL);
INSERT INTO `model` VALUES (4, '管理员管理', '01020000', 23, 'basic/manager/index.do', '2014-08-03 09:15:02', '', 0, 0, 1, '23', NULL);
INSERT INTO `model` VALUES (5, '角色管理', '01010000', 23, 'basic/role/index.do', '2014-08-03 09:15:14', '', 0, 0, 1, '23', NULL);
INSERT INTO `model` VALUES (7, '栏目管理', '02990000', 1, 'cms/column/index.do', '2014-08-03 09:16:29', '', 0, 2, 1, '1', NULL);
INSERT INTO `model` VALUES (8, '文章管理', '02980000', 1, 'cms/article/index.do', '2014-08-03 09:17:10', '', 0, 3, 1, '1', NULL);
INSERT INTO `model` VALUES (22, '会员中心', '07000000', NULL, '', '2014-09-08 08:11:28', '&#xe6b6;', 0, 4, 1, NULL, NULL);
INSERT INTO `model` VALUES (23, '权限管理', '01000000', NULL, '', '2014-09-08 08:12:22', '&#xe950;', 0, 2, 1, NULL, NULL);
INSERT INTO `model` VALUES (80, '静态化', '02020000', 1, 'cms/generate/index.do', '2014-12-18 11:37:15', '', 0, 1, 1, '1', NULL);
INSERT INTO `model` VALUES (84, '系统管理', '12000000', NULL, '', '2014-12-18 18:30:24', '&#xe71f;', 0, 1, 1, NULL, NULL);
INSERT INTO `model` VALUES (86, '应用设置', '12010000', 84, 'app/-1/edit.do', '2014-12-18 18:31:59', '', 0, 0, 1, '84', NULL);
INSERT INTO `model` VALUES (88, '用户管理', '07020100', 22, 'people/peopleUser/index.do ', '2015-09-18 11:44:54', '', 0, 0, 1, '22', NULL);
INSERT INTO `model` VALUES (91, '模板管理', '12020000', 84, 'template/queryTemplateSkin.do', NULL, '', 0, 0, 1, '84', NULL);
INSERT INTO `model` VALUES (92, '查看', '02990001', 7, 'cms:column:view', '2017-09-04 11:05:24', '', 0, 0, 0, '1,7', NULL);
INSERT INTO `model` VALUES (93, '查看', '02980001', 8, 'article:view', '2017-09-04 11:05:58', '', 0, 0, 0, '1,8', NULL);
INSERT INTO `model` VALUES (94, '查看', '02020001', 80, 'cms:generate:view', '2017-09-04 11:07:50', '', 0, 0, 0, '1,80', NULL);
INSERT INTO `model` VALUES (95, '查看', '07020101', 88, 'people:view', '2017-09-04 11:08:24', '', 0, 0, 0, '22,88', NULL);
INSERT INTO `model` VALUES (96, '菜单管理', '01030000', 23, 'model/index.do', '2017-09-04 11:09:26', '', 0, 0, 1, '23', NULL);
INSERT INTO `model` VALUES (97, '查看', '01020001', 4, 'manager:view', '2017-09-04 11:09:58', '', 0, 0, 0, '23,4', NULL);
INSERT INTO `model` VALUES (98, '查看', '01010001', 5, 'role:view', '2017-09-04 11:10:20', '', 0, 0, 0, '23,5', NULL);
INSERT INTO `model` VALUES (99, '查看', '01030001', 96, 'model:view', '2017-09-04 11:10:43', '', 0, 0, 0, '23,96', NULL);
INSERT INTO `model` VALUES (100, '查看', '12020001', 91, 'template:view', '2017-09-04 11:12:02', '', 0, 0, 0, '84,91', NULL);
INSERT INTO `model` VALUES (101, '查看', '12010001', 86, 'app:view', '2017-09-04 11:12:46', '', 0, 0, 0, '84,86', NULL);
INSERT INTO `model` VALUES (104, '自定义管理', '20000000', NULL, '', '2017-09-04 11:17:41', '&#xe6dd', 0, 3, 1, NULL, NULL);
INSERT INTO `model` VALUES (105, '自定义页面', '20010000', 104, 'mdiy/page/index.do', '2017-09-04 11:18:51', '', 0, 0, 1, '104', NULL);
INSERT INTO `model` VALUES (106, '自定义表单', '20020000', 104, 'mdiy/form/index.do', '2017-09-04 11:19:15', '', 0, 0, 1, '104', NULL);
INSERT INTO `model` VALUES (107, '自定义模型', '20030000', 104, 'mdiy/contentModel/index.do', '2017-09-04 11:20:15', '', 0, 0, 1, '104', NULL);
INSERT INTO `model` VALUES (108, '自定义搜索', '20040000', 104, 'mdiy/search/index.do', '2017-09-04 11:20:31', '', 0, 0, 1, '104', NULL);
INSERT INTO `model` VALUES (109, '自定义字典', '20050000', 104, 'mdiy/dict/index.do', '2017-09-04 11:21:09', '', 0, 0, 1, '104', NULL);
INSERT INTO `model` VALUES (110, '查看', '20010001', 105, 'mdiy:page:view', '2017-09-04 11:21:47', NULL, 0, 0, 0, '104,105', NULL);
INSERT INTO `model` VALUES (111, '查看', '20020001', 106, 'mdiy:form:view', '2017-09-04 11:22:17', '', 0, 0, 0, '104,106', NULL);
INSERT INTO `model` VALUES (112, '查看', '20030001', 107, 'mdiy:content:view', '2017-09-04 11:22:45', '', 0, 0, 0, '104,107', NULL);
INSERT INTO `model` VALUES (113, '查看', '20040001', 108, 'mdiy:search:view', '2017-09-04 11:23:04', '', 0, 0, 0, '104,108', NULL);
INSERT INTO `model` VALUES (114, '查看', '20050001', 109, 'mdiy:dict:view', '2017-09-04 11:23:23', '', 0, 0, 0, '104,109', NULL);
INSERT INTO `model` VALUES (115, '删除', '02980003', 8, 'article:del', '2017-09-04 13:24:41', '', 0, 0, 0, '1,8', NULL);
INSERT INTO `model` VALUES (116, '修改', '02980004', 8, 'article:update', '2017-09-04 13:24:58', '', 0, 0, 0, '1,8', NULL);
INSERT INTO `model` VALUES (117, '新增', '02980002', 8, 'article:save', '2017-09-04 13:25:37', '', 0, 0, 0, '1,8', NULL);
INSERT INTO `model` VALUES (118, '生成主页', '02020002', 80, 'cms:generate:index', '2017-09-04 13:31:16', '', 0, 0, 0, '1,80', NULL);
INSERT INTO `model` VALUES (119, '生成栏目', '02020003', 80, 'cms:generate:column', '2017-09-04 13:31:47', '', 0, 0, 0, '1,80', NULL);
INSERT INTO `model` VALUES (120, '生成文章', '02020004', 80, 'cms:generate:article', '2017-09-04 13:32:14', '', 0, 0, 0, '1,80', NULL);
INSERT INTO `model` VALUES (121, '删除', '07020103', 88, 'people:del', '2017-09-04 14:06:19', '', 0, 0, 0, '22,88', NULL);
INSERT INTO `model` VALUES (122, '修改', '07020104', 88, 'people:update', '2017-09-04 14:07:40', '', 0, 0, 0, '22,88', NULL);
INSERT INTO `model` VALUES (123, '新增', '07020102', 88, 'people:save', '2017-09-04 14:08:07', '', 0, 0, 0, '22,88', NULL);
INSERT INTO `model` VALUES (124, '删除', '01020003', 4, 'manager:del', '2017-09-04 14:08:52', '', 0, 0, 0, '23,4', NULL);
INSERT INTO `model` VALUES (125, '修改', '01020004', 4, 'manager:update', '2017-09-04 14:09:24', '', 0, 0, 0, '23,4', NULL);
INSERT INTO `model` VALUES (126, '新增', '01020002', 4, 'manager:save', '2017-09-04 14:09:45', '', 0, 0, 0, '23,4', NULL);
INSERT INTO `model` VALUES (127, '删除', '01010003', 5, 'role:del', '2017-09-04 14:10:56', '', 0, 0, 0, '23,5', NULL);
INSERT INTO `model` VALUES (128, '修改', '01010004', 5, 'role:update', '2017-09-04 14:11:36', '', 0, 0, 0, '23,5', NULL);
INSERT INTO `model` VALUES (129, '新增', '01010002', 5, 'role:save', '2017-09-04 14:12:09', '', 0, 0, 0, '23,5', NULL);
INSERT INTO `model` VALUES (130, '删除', '01030003', 96, 'model:del', '2017-09-04 14:13:05', '', 0, 0, 0, '23,96', NULL);
INSERT INTO `model` VALUES (131, '修改', '01030004', 96, 'model:update', '2017-09-04 14:13:34', '', 0, 0, 0, '23,96', NULL);
INSERT INTO `model` VALUES (132, '新增', '01030002', 96, 'model:save', '2017-09-04 14:14:03', '', 0, 0, 0, '23,96', NULL);
INSERT INTO `model` VALUES (133, '修改', '12010004', 86, 'app:update', '2017-09-04 14:14:42', '', 0, 0, 0, '84,86', NULL);
INSERT INTO `model` VALUES (134, '删除', '12020003', 91, 'template:del', '2017-09-04 14:16:25', '', 0, 0, 0, '84,91', NULL);
INSERT INTO `model` VALUES (135, '修改', '12020004', 91, 'template:update', '2017-09-04 14:16:54', '', 0, 0, 0, '84,91', NULL);
INSERT INTO `model` VALUES (136, '上传', '12020002', 91, 'template:upload', '2017-09-04 14:18:20', '', 0, 0, 0, '84,91', NULL);
INSERT INTO `model` VALUES (137, '删除', '20010003', 105, 'mdiy:page:del', '2017-09-04 14:19:05', NULL, 0, 0, 0, '104,105', NULL);
INSERT INTO `model` VALUES (138, '修改', '20010004', 105, 'mdiy:page:update', '2017-09-04 14:19:44', NULL, 0, 0, 0, '104,105', NULL);
INSERT INTO `model` VALUES (139, '新增', '20010002', 105, 'mdiy:page:save', '2017-09-04 14:20:04', NULL, 0, 0, 0, '104,105', NULL);
INSERT INTO `model` VALUES (140, '删除', '20020003', 106, 'mdiy:form:del', '2017-09-04 14:23:53', '', 0, 0, 0, '104,106', NULL);
INSERT INTO `model` VALUES (141, '修改', '20020004', 106, 'mdiy:form:update', '2017-09-04 14:24:20', '', 0, 0, 0, '104,106', NULL);
INSERT INTO `model` VALUES (142, '新增', '20020002', 106, 'mdiy:form:save', '2017-09-04 14:24:39', '', 0, 0, 0, '104,106', NULL);
INSERT INTO `model` VALUES (143, '删除', '20030003', 107, 'mdiy:content:del', '2017-09-04 14:25:21', '', 0, 0, 0, '104,107', NULL);
INSERT INTO `model` VALUES (144, '修改', '20030004', 107, 'mdiy:content:update', '2017-09-04 14:25:48', '', 0, 0, 0, '104,107', NULL);
INSERT INTO `model` VALUES (145, '新增', '20030002', 107, 'mdiy:content:save', '2017-09-04 14:26:12', '', 0, 0, 0, '104,107', NULL);
INSERT INTO `model` VALUES (146, '删除', '20040003', 108, 'mdiy:search:del', '2017-09-04 14:26:55', '', 0, 0, 0, '104,108', NULL);
INSERT INTO `model` VALUES (147, '修改', '20040004', 108, 'mdiy:search:update', '2017-09-04 14:27:13', '', 0, 0, 0, '104,108', NULL);
INSERT INTO `model` VALUES (148, '新增', '20040002', 108, 'mdiy:search:save', '2017-09-04 14:27:33', '', 0, 0, 0, '104,108', NULL);
INSERT INTO `model` VALUES (149, '删除', '20050003', 109, 'mdiy:dict:del', '2017-09-04 14:28:00', '', 0, 0, 0, '104,109', NULL);
INSERT INTO `model` VALUES (150, '修改', '20050004', 109, 'mdiy:dict:update', '2017-09-04 14:28:17', '', 0, 0, 0, '104,109', NULL);
INSERT INTO `model` VALUES (151, '新增', '20050002', 109, 'mdiy:dict:save', '2017-09-04 14:28:41', '', 0, 0, 0, '104,109', NULL);
INSERT INTO `model` VALUES (152, '删除', '02990002', 7, 'cms:column:del', '2018-06-20 17:53:51', '', 0, 0, 0, '1,7', NULL);
INSERT INTO `model` VALUES (153, '修改', '02990003', 7, 'cms:column:update', '2018-06-20 17:54:43', NULL, 0, 0, 0, '1,7', NULL);
INSERT INTO `model` VALUES (154, '新增', '02990004', 7, 'cms:column:save', '2018-06-20 17:55:26', NULL, 0, 0, 0, '1,7', NULL);

-- ----------------------------
-- Table structure for people
-- ----------------------------
DROP TABLE IF EXISTS `people`;
CREATE TABLE `people`  (
  `people_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '增长自id',
  `people_phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `people_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `people_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `people_datetime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '注册时间',
  `people_app_id` int(11) NOT NULL COMMENT '应用编号',
  `people_mail` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `people_state` int(2) NULL DEFAULT 0 COMMENT '用户状态',
  `people_code` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '随机验证码',
  `people_codesenddate` datetime(0) NULL DEFAULT NULL COMMENT '发送验证码时间',
  `people_phonecheck` int(1) NULL DEFAULT 0 COMMENT '1手机验证通过',
  `people_maillcheck` int(1) NULL DEFAULT 0 COMMENT '1邮箱验证通过',
  PRIMARY KEY (`people_id`) USING BTREE,
  INDEX `fk_people`(`people_app_id`) USING BTREE,
  CONSTRAINT `fk_people` FOREIGN KEY (`people_app_id`) REFERENCES `app` (`app_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '户用基础表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for people_user
-- ----------------------------
DROP TABLE IF EXISTS `people_user`;
CREATE TABLE `people_user`  (
  `pu_people_id` int(11) NOT NULL COMMENT '用户id关联people表的（people_id）',
  `pu_real_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户真实名称',
  `pu_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户地址',
  `pu_icon` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像图标地址',
  `pu_nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `pu_sex` int(2) NULL DEFAULT NULL COMMENT '用户性别(0.未知、1.男、2.女)',
  `pu_birthday` date NULL DEFAULT NULL COMMENT '用户出生年月日',
  `pu_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `pu_province` int(11) NULL DEFAULT 0 COMMENT '省',
  `pu_city` int(11) NULL DEFAULT 0 COMMENT '城市',
  `pu_district` int(11) NULL DEFAULT 0 COMMENT '区',
  `pu_street` int(11) NULL DEFAULT 0 COMMENT '街道',
  PRIMARY KEY (`pu_people_id`) USING BTREE,
  INDEX `pu_people_id`(`pu_people_id`) USING BTREE,
  CONSTRAINT `fk_people_user_people_1` FOREIGN KEY (`pu_people_id`) REFERENCES `people` (`people_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户基础信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id，自增长',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `role_managerid` int(11) NULL DEFAULT 0 COMMENT '角色管理员编号',
  `app_id` int(11) NOT NULL COMMENT '应用编号',
  PRIMARY KEY (`role_id`) USING BTREE,
  INDEX `role_managerid`(`role_managerid`) USING BTREE,
  INDEX `fk_role_app_id`(`app_id`) USING BTREE,
  CONSTRAINT `fk_role_app_id` FOREIGN KEY (`app_id`) REFERENCES `app` (`app_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (48, 'msopen', 50, 1);

-- ----------------------------
-- Table structure for role_model
-- ----------------------------
DROP TABLE IF EXISTS `role_model`;
CREATE TABLE `role_model`  (
  `rm_modelid` int(22) NULL DEFAULT NULL COMMENT '模块编号',
  `rm_roleid` int(22) NULL DEFAULT NULL COMMENT '角色编号',
  UNIQUE INDEX `index`(`rm_modelid`, `rm_roleid`) USING BTREE,
  INDEX `rm_modelid`(`rm_modelid`) USING BTREE,
  INDEX `fk_role_model_role_1`(`rm_roleid`) USING BTREE,
  CONSTRAINT `fk_role_model_role_1` FOREIGN KEY (`rm_roleid`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `role_model_ibfk_1` FOREIGN KEY (`rm_modelid`) REFERENCES `model` (`model_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色模块关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_model
-- ----------------------------
INSERT INTO `role_model` VALUES (1, 48);
INSERT INTO `role_model` VALUES (4, 48);
INSERT INTO `role_model` VALUES (5, 48);
INSERT INTO `role_model` VALUES (7, 48);
INSERT INTO `role_model` VALUES (8, 48);
INSERT INTO `role_model` VALUES (22, 48);
INSERT INTO `role_model` VALUES (23, 48);
INSERT INTO `role_model` VALUES (80, 48);
INSERT INTO `role_model` VALUES (84, 48);
INSERT INTO `role_model` VALUES (86, 48);
INSERT INTO `role_model` VALUES (88, 48);
INSERT INTO `role_model` VALUES (91, 48);
INSERT INTO `role_model` VALUES (92, 48);
INSERT INTO `role_model` VALUES (93, 48);
INSERT INTO `role_model` VALUES (94, 48);
INSERT INTO `role_model` VALUES (95, 48);
INSERT INTO `role_model` VALUES (96, 48);
INSERT INTO `role_model` VALUES (97, 48);
INSERT INTO `role_model` VALUES (98, 48);
INSERT INTO `role_model` VALUES (99, 48);
INSERT INTO `role_model` VALUES (100, 48);
INSERT INTO `role_model` VALUES (101, 48);
INSERT INTO `role_model` VALUES (104, 48);
INSERT INTO `role_model` VALUES (105, 48);
INSERT INTO `role_model` VALUES (106, 48);
INSERT INTO `role_model` VALUES (107, 48);
INSERT INTO `role_model` VALUES (108, 48);
INSERT INTO `role_model` VALUES (109, 48);
INSERT INTO `role_model` VALUES (110, 48);
INSERT INTO `role_model` VALUES (111, 48);
INSERT INTO `role_model` VALUES (112, 48);
INSERT INTO `role_model` VALUES (113, 48);
INSERT INTO `role_model` VALUES (114, 48);
INSERT INTO `role_model` VALUES (115, 48);
INSERT INTO `role_model` VALUES (116, 48);
INSERT INTO `role_model` VALUES (117, 48);
INSERT INTO `role_model` VALUES (118, 48);
INSERT INTO `role_model` VALUES (119, 48);
INSERT INTO `role_model` VALUES (120, 48);
INSERT INTO `role_model` VALUES (121, 48);
INSERT INTO `role_model` VALUES (122, 48);
INSERT INTO `role_model` VALUES (123, 48);
INSERT INTO `role_model` VALUES (124, 48);
INSERT INTO `role_model` VALUES (125, 48);
INSERT INTO `role_model` VALUES (126, 48);
INSERT INTO `role_model` VALUES (127, 48);
INSERT INTO `role_model` VALUES (128, 48);
INSERT INTO `role_model` VALUES (129, 48);
INSERT INTO `role_model` VALUES (130, 48);
INSERT INTO `role_model` VALUES (131, 48);
INSERT INTO `role_model` VALUES (132, 48);
INSERT INTO `role_model` VALUES (133, 48);
INSERT INTO `role_model` VALUES (134, 48);
INSERT INTO `role_model` VALUES (135, 48);
INSERT INTO `role_model` VALUES (136, 48);
INSERT INTO `role_model` VALUES (137, 48);
INSERT INTO `role_model` VALUES (138, 48);
INSERT INTO `role_model` VALUES (139, 48);
INSERT INTO `role_model` VALUES (140, 48);
INSERT INTO `role_model` VALUES (141, 48);
INSERT INTO `role_model` VALUES (142, 48);
INSERT INTO `role_model` VALUES (143, 48);
INSERT INTO `role_model` VALUES (144, 48);
INSERT INTO `role_model` VALUES (145, 48);
INSERT INTO `role_model` VALUES (146, 48);
INSERT INTO `role_model` VALUES (147, 48);
INSERT INTO `role_model` VALUES (148, 48);
INSERT INTO `role_model` VALUES (149, 48);
INSERT INTO `role_model` VALUES (150, 48);
INSERT INTO `role_model` VALUES (151, 48);
INSERT INTO `role_model` VALUES (152, 48);
INSERT INTO `role_model` VALUES (153, 48);
INSERT INTO `role_model` VALUES (154, 48);

SET FOREIGN_KEY_CHECKS = 1;
