/*
 Navicat Premium Data Transfer

 Source Server         : hospital
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : hospital

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 04/01/2023 12:48:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cashiers
-- ----------------------------
DROP TABLE IF EXISTS `cashiers`;
CREATE TABLE `cashiers`  (
  `cashier_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工号',
  `cashier_identity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `cashier_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '密码',
  `cashier_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `cashier_gender` int NULL DEFAULT 1 COMMENT '性别1男,0女',
  `cashier_tel` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电话',
  `cashier_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '家庭住址',
  PRIMARY KEY (`cashier_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cashiers
-- ----------------------------
INSERT INTO `cashiers` VALUES ('P20230021', '150102199707077610', '123456', '叶嘉伦', 0, '15243992699', '闵行区宾川路561号');
INSERT INTO `cashiers` VALUES ('P20230023', '150102199707079910', '123456', '卢子韬', 1, '15243994521', '环区南街二巷362号');
INSERT INTO `cashiers` VALUES ('P20230042', '150102199707076066', '123456', '卢岚', 1, '15243996022', '罗湖区清水河一路818号');
INSERT INTO `cashiers` VALUES ('P20230057', '150102199707077744', '419818', '姚致远', 0, '15243992429', '乐丰六路388号');

-- ----------------------------
-- Table structure for check_tables
-- ----------------------------
DROP TABLE IF EXISTS `check_tables`;
CREATE TABLE `check_tables`  (
  `check_id` int NOT NULL AUTO_INCREMENT COMMENT '检查单号',
  `patient_identity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者身份证号',
  `doctor_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '医生工号',
  `check_description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '检查项目描述',
  `is_payed` int NULL DEFAULT 0 COMMENT '是否支付1是,0否',
  `is_checked` int NULL DEFAULT 0 COMMENT '是否完成检查1是,0否',
  `bill_time` datetime NULL DEFAULT NULL COMMENT '开具时间',
  PRIMARY KEY (`check_id`) USING BTREE,
  INDEX `patient_identity`(`patient_identity` ASC) USING BTREE,
  INDEX `doctor_id`(`doctor_id` ASC) USING BTREE,
  INDEX `medicine_id`(`check_description` ASC) USING BTREE,
  CONSTRAINT `check_tables_ibfk_1` FOREIGN KEY (`patient_identity`) REFERENCES `patients` (`patient_identity`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `check_tables_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of check_tables
-- ----------------------------
INSERT INTO `check_tables` VALUES (1, '362424199909126677', 'D0001001', '心电图', 1, 0, '2023-01-03 14:53:08');
INSERT INTO `check_tables` VALUES (2, '362424199909126677', 'D0001008', '心电图', 0, 0, '2023-01-03 16:02:52');

-- ----------------------------
-- Table structure for departments
-- ----------------------------
DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments`  (
  `department_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '科室编号',
  `department_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '科室名称',
  `department_tel` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '科室电话',
  `department_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '科室地址',
  PRIMARY KEY (`department_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of departments
-- ----------------------------
INSERT INTO `departments` VALUES ('DE000001', '内科', '023-65112301', '银河区玉华路23号');
INSERT INTO `departments` VALUES ('DE000002', '外科', '023-65112302', '银河区玉华路23号');
INSERT INTO `departments` VALUES ('DE000003', '儿科', '023-65112303', '银河区玉华路23号');
INSERT INTO `departments` VALUES ('DE000004', '五官科', '023-65112304', '银河区玉华路23号');
INSERT INTO `departments` VALUES ('DE000005', '皮肤科', '023-65112305', '银河区玉华路23号');
INSERT INTO `departments` VALUES ('DE000006', '康复科', '023-65112306', '银河区玉华路23号');

-- ----------------------------
-- Table structure for dept_queue
-- ----------------------------
DROP TABLE IF EXISTS `dept_queue`;
CREATE TABLE `dept_queue`  (
  `dept_queue_id` int NOT NULL AUTO_INCREMENT COMMENT '科室号队列编号',
  `department_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '科室编号',
  `dept_queue_date` date NULL DEFAULT NULL COMMENT '日期',
  `register_id` int NULL DEFAULT NULL COMMENT '挂号单号',
  `register_number` int NULL DEFAULT NULL COMMENT '挂号单上的号码',
  `state` int NULL DEFAULT NULL COMMENT '是否完成诊断（1：是，0：否）',
  PRIMARY KEY (`dept_queue_id`) USING BTREE,
  INDEX `department_id`(`department_id` ASC) USING BTREE,
  INDEX `register_id`(`register_id` ASC) USING BTREE,
  CONSTRAINT `dept_queue_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `dept_queue_ibfk_2` FOREIGN KEY (`register_id`) REFERENCES `register_tables` (`register_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dept_queue
-- ----------------------------
INSERT INTO `dept_queue` VALUES (12, 'DE000002', '2023-01-03', 3, 1, 1);

-- ----------------------------
-- Table structure for doctor_queue
-- ----------------------------
DROP TABLE IF EXISTS `doctor_queue`;
CREATE TABLE `doctor_queue`  (
  `doctor_queue_id` int NOT NULL AUTO_INCREMENT,
  `doctor_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `doctor_queue_date` date NULL DEFAULT NULL,
  `register_id` int NULL DEFAULT NULL,
  `register_number` int NULL DEFAULT NULL,
  `state` int NULL DEFAULT NULL COMMENT '是否完成诊断(1：是，0：否)',
  PRIMARY KEY (`doctor_queue_id`) USING BTREE,
  INDEX `doctor_id`(`doctor_id` ASC) USING BTREE,
  INDEX `register_id`(`register_id` ASC) USING BTREE,
  CONSTRAINT `doctor_queue_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `doctor_queue_ibfk_2` FOREIGN KEY (`register_id`) REFERENCES `register_tables` (`register_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor_queue
-- ----------------------------
INSERT INTO `doctor_queue` VALUES (22, 'D0001001', '2023-01-03', 1, 1, 1);
INSERT INTO `doctor_queue` VALUES (23, 'D0001012', '2023-01-03', 4, 1, 0);

-- ----------------------------
-- Table structure for doctors
-- ----------------------------
DROP TABLE IF EXISTS `doctors`;
CREATE TABLE `doctors`  (
  `doctor_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工号',
  `doctor_identity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `doctor_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '密码',
  `doctor_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `doctor_gender` int NULL DEFAULT 1 COMMENT '性别1男,0女',
  `doctor_tel` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电话',
  `doctor_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '家庭住址',
  `department_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`doctor_id`) USING BTREE,
  INDEX `doctors_ibfk_1`(`department_id` ASC) USING BTREE,
  CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of doctors
-- ----------------------------
INSERT INTO `doctors` VALUES ('D0000001', '000000000000000001', '123456', '默认', 1, NULL, '重庆大学虎溪校区', 'DE000001');
INSERT INTO `doctors` VALUES ('D0001001', '428402199003042213', '123456', '彭翊', 1, '18300110022', '重庆大学虎溪校区', 'DE000001');
INSERT INTO `doctors` VALUES ('D0001002', '428402199305063510', '123456', '毛青', 1, '18300110033', '重庆大学虎溪校区', 'DE000001');
INSERT INTO `doctors` VALUES ('D0001003', '428402198308023341', '123456', '毛颖', 0, '18543215035', '重庆大学虎溪校区', 'DE000001');
INSERT INTO `doctors` VALUES ('D0001004', '428402198810053545', '123456', '章慧', 0, '18563215064', '重庆大学虎溪校区', 'DE000001');
INSERT INTO `doctors` VALUES ('D0001005', '428402199812253445', '123456', '杨菲菲', 0, '18563215065', '重庆大学虎溪校区', 'DE000006');
INSERT INTO `doctors` VALUES ('D0001006', '428402199302258425', '123456', '杨琳', 0, '18163315063', '重庆大学虎溪校区', 'DE000002');
INSERT INTO `doctors` VALUES ('D0001007', '428402198304258415', '123456', '杨柳', 1, '18163315064', '重庆大学虎溪校区', 'DE000002');
INSERT INTO `doctors` VALUES ('D0001008', '428402198607151615', '123456', '杨希川', 1, '18163315084', '重庆大学虎溪校区', 'DE000002');
INSERT INTO `doctors` VALUES ('D0001009', '428402197608121716', '123456', '唐康来', 1, '18163315184', '重庆大学虎溪校区', 'DE000006');
INSERT INTO `doctors` VALUES ('D0001010', '428402198202211213', '123456', '熊炜', 1, '18163315186', '重庆大学虎溪校区', 'DE000002');
INSERT INTO `doctors` VALUES ('D0001011', '428402198804251225', '123456', '阴正琴', 0, '18163315206', '重庆大学虎溪校区', 'DE000003');
INSERT INTO `doctors` VALUES ('D0001012', '428402198610092415', '123456', '宋波', 1, '18163315205', '重庆大学虎溪校区', 'DE000003');
INSERT INTO `doctors` VALUES ('D0001013', '428402198611092417', '123456', '史常旭', 1, '18163315206', '重庆大学虎溪校区', 'DE000003');
INSERT INTO `doctors` VALUES ('D0001014', '428402198712062418', '123456', '钱峰', 1, '18163315207', '重庆大学虎溪校区', 'DE000003');
INSERT INTO `doctors` VALUES ('D0001015', '428402198902282219', '123456', '罗高兴', 1, '18163315208', '重庆大学虎溪校区', 'DE000003');
INSERT INTO `doctors` VALUES ('D0001016', '428402198807282112', '123456', '林江恺', 1, '18163315100', '重庆大学虎溪校区', 'DE000004');
INSERT INTO `doctors` VALUES ('D0001017', '428402197308135322', '123456', '梁志清', 0, '18163315101', '重庆大学虎溪校区', 'DE000004');
INSERT INTO `doctors` VALUES ('D0001018', '428402197402035323', '123456', '梁后杰', 0, '18163315102', '重庆大学虎溪校区', 'DE000004');
INSERT INTO `doctors` VALUES ('D0001019', '428402196403095212', '123456', '刘宏亮', 1, '18163315103', '重庆大学虎溪校区', 'DE000004');
INSERT INTO `doctors` VALUES ('D0001020', '428402197703142414', '123456', '姜军', 1, '18163315104', '重庆大学虎溪校区', 'DE000004');
INSERT INTO `doctors` VALUES ('D0001021', '428402197803241415', '123456', '黄学全', 1, '18163315105', '重庆大学虎溪校区', 'DE000005');
INSERT INTO `doctors` VALUES ('D0001022', '428402197902081216', '123456', '冯华', 1, '18163315106', '重庆大学虎溪校区', 'DE000006');
INSERT INTO `doctors` VALUES ('D0001023', '428402199112092413', '123456', '陈文生', 1, '18163315107', '重庆大学虎溪校区', 'DE000005');
INSERT INTO `doctors` VALUES ('D0001024', '428402198411085011', '123456', '陈杰', 1, '18163315108', '重庆大学虎溪校区', 'DE000005');
INSERT INTO `doctors` VALUES ('D0001025', '428402198310149816', '123456', '方勇', 1, '18163315109', '重庆大学虎溪校区', 'DE000004');
INSERT INTO `doctors` VALUES ('D0001026', '428402198603205338', '123456', '陈兵', 1, '18163315110', '重庆大学虎溪校区', 'DE000006');
INSERT INTO `doctors` VALUES ('D0001027', '428402198405149533', '123456', '蔡志明', 1, '18163315111', '重庆大学虎溪校区', 'DE000006');
INSERT INTO `doctors` VALUES ('D0001028', '428402198901248232', '123456', '蔡景修', 1, '18163315112', '重庆大学虎溪校区', 'DE000004');
INSERT INTO `doctors` VALUES ('D0001029', '428402198012243467', '123456', '赵敏', 0, '18163315113', '重庆大学虎溪校区', 'DE000004');
INSERT INTO `doctors` VALUES ('D0001030', '428402198809210223', '123456', '黄蓉', 0, '18163315115', '重庆大学虎溪校区', 'DE000005');

-- ----------------------------
-- Table structure for medicines
-- ----------------------------
DROP TABLE IF EXISTS `medicines`;
CREATE TABLE `medicines`  (
  `medicine_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '药品编号',
  `medicine_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '药品名称',
  `medicine_number` int NULL DEFAULT NULL COMMENT '药品余量',
  `medicine_money` double NULL DEFAULT NULL COMMENT '药品单价',
  PRIMARY KEY (`medicine_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of medicines
-- ----------------------------
INSERT INTO `medicines` VALUES ('ME0010001', '维生素A', 1000, 3);
INSERT INTO `medicines` VALUES ('ME00100010', '滴眼液', 2, 10.9);
INSERT INTO `medicines` VALUES ('ME00100011', '桂林西瓜霜', 10, 17.8);
INSERT INTO `medicines` VALUES ('ME00100012', '六味地黄丸', 42, 45.5);
INSERT INTO `medicines` VALUES ('ME00100013', '健胃消食片', 66, 14.5);
INSERT INTO `medicines` VALUES ('ME00100014', '红霉素软膏', 668, 5);
INSERT INTO `medicines` VALUES ('ME00100015', '止咳糖浆', 698, 45.7);
INSERT INTO `medicines` VALUES ('ME0010002', '维生素B', 1000, 3);
INSERT INTO `medicines` VALUES ('ME0010003', '维生素C', 1000, 3);
INSERT INTO `medicines` VALUES ('ME0010004', '维生素D', 1000, 3);
INSERT INTO `medicines` VALUES ('ME0010005', '维生素E', 1000, 3);
INSERT INTO `medicines` VALUES ('ME0010006', '板蓝根', 1000, 9.9);
INSERT INTO `medicines` VALUES ('ME0010007', '创口贴', 1000, 5.5);
INSERT INTO `medicines` VALUES ('ME0010008', '999感冒灵', 1000, 15.6);
INSERT INTO `medicines` VALUES ('ME0010009', '水杨酸软膏', 0, 13.4);

-- ----------------------------
-- Table structure for patients
-- ----------------------------
DROP TABLE IF EXISTS `patients`;
CREATE TABLE `patients`  (
  `patient_identity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '身份证号',
  `patient_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `patient_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `patient_gender` int NULL DEFAULT 1 COMMENT '性别1男,0女',
  `patient_tel` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电话',
  `patient_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '家庭住址',
  `patient_is_black` int NULL DEFAULT 0 COMMENT '黑名单标记1在,0不在',
  PRIMARY KEY (`patient_identity`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of patients
-- ----------------------------
INSERT INTO `patients` VALUES ('362424199909126677', '123456', '王车', 0, '11011213456', '水利局2号', 0);

-- ----------------------------
-- Table structure for pay_tables
-- ----------------------------
DROP TABLE IF EXISTS `pay_tables`;
CREATE TABLE `pay_tables`  (
  `pay_id` int NOT NULL AUTO_INCREMENT COMMENT '缴费单号',
  `patient_identity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者身份证号',
  `cashier_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '收费人员工号',
  `pay_item` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '缴费项目',
  `pay_way` int NULL DEFAULT 0 COMMENT '缴费方式:0现金,1微信,2支付宝',
  `pay_money` float NULL DEFAULT 0 COMMENT '缴费金额',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '缴费时间',
  PRIMARY KEY (`pay_id`) USING BTREE,
  INDEX `patient_identity`(`patient_identity` ASC) USING BTREE,
  INDEX `doctor_id`(`cashier_id` ASC) USING BTREE,
  CONSTRAINT `pay_tables_ibfk_1` FOREIGN KEY (`patient_identity`) REFERENCES `patients` (`patient_identity`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pay_tables_ibfk_3` FOREIGN KEY (`cashier_id`) REFERENCES `cashiers` (`cashier_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_tables
-- ----------------------------
INSERT INTO `pay_tables` VALUES (11, '362424199909126677', 'P20230021', '1', 0, 30, '2023-01-03 14:21:48');
INSERT INTO `pay_tables` VALUES (12, '362424199909126677', 'P20230021', 'C1', 0, 30, '2023-01-03 15:06:33');
INSERT INTO `pay_tables` VALUES (13, '362424199909126677', 'P20230021', '3', 1, 5, '2023-01-03 15:48:34');
INSERT INTO `pay_tables` VALUES (14, '362424199909126677', 'P20230021', '4', 0, 30, '2023-01-03 15:55:38');
INSERT INTO `pay_tables` VALUES (17, '362424199909126677', 'P20230021', 'P2', 0, 14.5, '2023-01-03 16:32:28');
INSERT INTO `pay_tables` VALUES (18, '362424199909126677', 'P20230021', 'P3', 0, 3, '2023-01-03 16:32:28');

-- ----------------------------
-- Table structure for pharmacists
-- ----------------------------
DROP TABLE IF EXISTS `pharmacists`;
CREATE TABLE `pharmacists`  (
  `pharmacist_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '工号',
  `pharmacist_identity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `pharmacist_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '密码',
  `pharmacist_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `pharmacist_gender` int NULL DEFAULT 1 COMMENT '性别1男,0女',
  `pharmacist_tel` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电话',
  `pharmacist_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '家庭住址',
  PRIMARY KEY (`pharmacist_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pharmacists
-- ----------------------------
INSERT INTO `pharmacists` VALUES ('M2023016', '150102199909097477', '123456', '萧秀英', 1, '17843997054', '龙岗区学园一巷306号');
INSERT INTO `pharmacists` VALUES ('M2023044', '150102199909094317', '123456', '段安琪', 0, '17843992847', '福田区深南大道961号');
INSERT INTO `pharmacists` VALUES ('M2023084', '150102199909098271', '123456', '余岚', 0, '17843993847', '罗湖区清水河一路443号');
INSERT INTO `pharmacists` VALUES ('M2023097', '150102199909093839', '123456', '金岚', 0, '17843991443', '房山区岳琉路284号');

-- ----------------------------
-- Table structure for prescription_tables
-- ----------------------------
DROP TABLE IF EXISTS `prescription_tables`;
CREATE TABLE `prescription_tables`  (
  `prescription_id` int NOT NULL AUTO_INCREMENT COMMENT '处方单号',
  `patient_identity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者身份证号',
  `doctor_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '医生工号',
  `medicine_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '药品编号',
  `medicine_number` int NULL DEFAULT NULL COMMENT '药品数量',
  `bill_time` datetime NULL DEFAULT NULL COMMENT '开具时间',
  PRIMARY KEY (`prescription_id`) USING BTREE,
  INDEX `patient_identity`(`patient_identity` ASC) USING BTREE,
  INDEX `doctor_id`(`doctor_id` ASC) USING BTREE,
  INDEX `medicine_id`(`medicine_id` ASC) USING BTREE,
  CONSTRAINT `prescription_tables_ibfk_1` FOREIGN KEY (`patient_identity`) REFERENCES `patients` (`patient_identity`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `prescription_tables_ibfk_3` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `prescription_tables_ibfk_4` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`medicine_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of prescription_tables
-- ----------------------------
INSERT INTO `prescription_tables` VALUES (1, '362424199909126677', 'D0001001', 'ME00100013', 1, '2023-01-03 14:53:48');
INSERT INTO `prescription_tables` VALUES (2, '362424199909126677', 'D0001008', 'ME00100013', 1, '2023-01-03 16:03:38');
INSERT INTO `prescription_tables` VALUES (3, '362424199909126677', 'D0001008', 'ME0010001', 1, '2023-01-03 16:03:38');

-- ----------------------------
-- Table structure for records
-- ----------------------------
DROP TABLE IF EXISTS `records`;
CREATE TABLE `records`  (
  `record_id` int NOT NULL AUTO_INCREMENT COMMENT '病历编号',
  `patient_identity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者身份证号',
  `doctor_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '医生工号',
  `symptom_description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '症状描述',
  `prescription_ids` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '开具的处方单号，多个编号，逗号分隔',
  `check_ids` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '开具的检查单号，多个编号，逗号分隔',
  `bill_time` datetime NULL DEFAULT NULL COMMENT '开具时间',
  PRIMARY KEY (`record_id`) USING BTREE,
  INDEX `patient_identity`(`patient_identity` ASC) USING BTREE,
  INDEX `doctor_id`(`doctor_id` ASC) USING BTREE,
  INDEX `medicine_id`(`symptom_description` ASC) USING BTREE,
  CONSTRAINT `records_ibfk_1` FOREIGN KEY (`patient_identity`) REFERENCES `patients` (`patient_identity`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `records_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of records
-- ----------------------------
INSERT INTO `records` VALUES (1, '362424199909126677', 'D0001001', '症状描述：///\n', '1,', '1', '2023-01-03 14:52:52');
INSERT INTO `records` VALUES (2, '362424199909126677', 'D0001008', '症状描述：水水水水水\n', '2,3,', '2', '2023-01-03 16:02:45');

-- ----------------------------
-- Table structure for refund_tables
-- ----------------------------
DROP TABLE IF EXISTS `refund_tables`;
CREATE TABLE `refund_tables`  (
  `refund_id` int NOT NULL AUTO_INCREMENT COMMENT '退费单号',
  `patient_identity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者身份证号',
  `cashier_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '收费人员工号',
  `pay_id` int NULL DEFAULT NULL COMMENT '缴费单号',
  `refund_way` int NULL DEFAULT 0 COMMENT '退费方式:0现金,1微信,2支付宝',
  `refund_money` float NULL DEFAULT 0 COMMENT '退费金额',
  `refund_time` datetime NULL DEFAULT NULL COMMENT '退费时间',
  PRIMARY KEY (`refund_id`) USING BTREE,
  INDEX `patient_identity`(`patient_identity` ASC) USING BTREE,
  INDEX `doctor_id`(`cashier_id` ASC) USING BTREE,
  INDEX `pay_id`(`pay_id` ASC) USING BTREE,
  CONSTRAINT `refund_tables_ibfk_1` FOREIGN KEY (`patient_identity`) REFERENCES `patients` (`patient_identity`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `refund_tables_ibfk_2` FOREIGN KEY (`cashier_id`) REFERENCES `cashiers` (`cashier_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of refund_tables
-- ----------------------------
INSERT INTO `refund_tables` VALUES (10, '362424199909126677', 'P20230021', 12, 0, 30, '2023-01-03 15:45:30');

-- ----------------------------
-- Table structure for register_tables
-- ----------------------------
DROP TABLE IF EXISTS `register_tables`;
CREATE TABLE `register_tables`  (
  `register_id` int NOT NULL AUTO_INCREMENT COMMENT '挂号单号',
  `patient_identity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者身份证号',
  `department_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '挂号的科室编号',
  `doctor_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'D0000001' COMMENT '挂号的医生工号',
  `register_type` int NULL DEFAULT 1 COMMENT '挂号类型1科室，0专家',
  `register_queue_type` int NULL DEFAULT 0 COMMENT '挂号排队类型1预约,0现场',
  `register_ number` int NULL DEFAULT NULL COMMENT '排队号',
  `register_time` datetime NULL DEFAULT NULL COMMENT '预约时段的起始时间',
  PRIMARY KEY (`register_id`) USING BTREE,
  INDEX `patient_identity`(`patient_identity` ASC) USING BTREE,
  INDEX `department_id`(`department_id` ASC) USING BTREE,
  INDEX `doctor_id`(`doctor_id` ASC) USING BTREE,
  CONSTRAINT `register_tables_ibfk_1` FOREIGN KEY (`patient_identity`) REFERENCES `patients` (`patient_identity`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `register_tables_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `register_tables_ibfk_3` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of register_tables
-- ----------------------------
INSERT INTO `register_tables` VALUES (1, '362424199909126677', 'DE000001', 'D0001001', 0, 1, 1, '2023-01-03 14:21:36');
INSERT INTO `register_tables` VALUES (3, '362424199909126677', 'DE000002', 'D0000001', 1, 0, 1, '2023-01-03 15:48:19');
INSERT INTO `register_tables` VALUES (4, '362424199909126677', 'DE000003', 'D0001012', 0, 0, 1, '2023-01-03 15:55:28');

-- ----------------------------
-- Table structure for remain_dept_numbers
-- ----------------------------
DROP TABLE IF EXISTS `remain_dept_numbers`;
CREATE TABLE `remain_dept_numbers`  (
  `remain_dept_number_id` int NOT NULL AUTO_INCREMENT,
  `department_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  `number` int NULL DEFAULT NULL,
  PRIMARY KEY (`remain_dept_number_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1777 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of remain_dept_numbers
-- ----------------------------
INSERT INTO `remain_dept_numbers` VALUES (1489, 'DE000001', '2023-01-03 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1490, 'DE000002', '2023-01-03 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1491, 'DE000003', '2023-01-03 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1492, 'DE000004', '2023-01-03 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1493, 'DE000005', '2023-01-03 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1494, 'DE000006', '2023-01-03 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1495, 'DE000001', '2023-01-03 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1496, 'DE000002', '2023-01-03 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1497, 'DE000003', '2023-01-03 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1498, 'DE000004', '2023-01-03 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1499, 'DE000005', '2023-01-03 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1500, 'DE000006', '2023-01-03 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1501, 'DE000001', '2023-01-03 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1502, 'DE000002', '2023-01-03 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1503, 'DE000003', '2023-01-03 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1504, 'DE000004', '2023-01-03 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1505, 'DE000005', '2023-01-03 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1506, 'DE000006', '2023-01-03 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1507, 'DE000001', '2023-01-03 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1508, 'DE000002', '2023-01-03 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1509, 'DE000003', '2023-01-03 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1510, 'DE000004', '2023-01-03 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1511, 'DE000005', '2023-01-03 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1512, 'DE000006', '2023-01-03 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1513, 'DE000001', '2023-01-03 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1514, 'DE000002', '2023-01-03 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1515, 'DE000003', '2023-01-03 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1516, 'DE000004', '2023-01-03 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1517, 'DE000005', '2023-01-03 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1518, 'DE000006', '2023-01-03 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1519, 'DE000001', '2023-01-03 14:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1520, 'DE000002', '2023-01-03 14:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1521, 'DE000003', '2023-01-03 14:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1522, 'DE000004', '2023-01-03 14:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1523, 'DE000005', '2023-01-03 14:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1524, 'DE000006', '2023-01-03 14:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1525, 'DE000001', '2023-01-03 15:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1526, 'DE000002', '2023-01-03 15:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1527, 'DE000003', '2023-01-03 15:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1528, 'DE000004', '2023-01-03 15:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1529, 'DE000005', '2023-01-03 15:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1530, 'DE000006', '2023-01-03 15:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1531, 'DE000001', '2023-01-03 16:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1532, 'DE000002', '2023-01-03 16:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1533, 'DE000003', '2023-01-03 16:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1534, 'DE000004', '2023-01-03 16:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1535, 'DE000005', '2023-01-03 16:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1536, 'DE000006', '2023-01-03 16:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1537, 'DE000001', '2023-01-03 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1538, 'DE000002', '2023-01-03 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1539, 'DE000003', '2023-01-03 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1540, 'DE000004', '2023-01-03 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1541, 'DE000005', '2023-01-03 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1542, 'DE000006', '2023-01-03 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1543, 'DE000001', '2023-01-03 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1544, 'DE000002', '2023-01-03 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1545, 'DE000003', '2023-01-03 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1546, 'DE000004', '2023-01-03 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1547, 'DE000005', '2023-01-03 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1548, 'DE000006', '2023-01-03 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1549, 'DE000001', '2023-01-03 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1550, 'DE000002', '2023-01-03 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1551, 'DE000003', '2023-01-03 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1552, 'DE000004', '2023-01-03 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1553, 'DE000005', '2023-01-03 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1554, 'DE000006', '2023-01-03 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1555, 'DE000001', '2023-01-03 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1556, 'DE000002', '2023-01-03 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1557, 'DE000003', '2023-01-03 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1558, 'DE000004', '2023-01-03 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1559, 'DE000005', '2023-01-03 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1560, 'DE000006', '2023-01-03 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1561, 'DE000001', '2023-01-03 13:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1562, 'DE000002', '2023-01-03 13:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1563, 'DE000003', '2023-01-03 13:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1564, 'DE000004', '2023-01-03 13:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1565, 'DE000005', '2023-01-03 13:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1566, 'DE000006', '2023-01-03 13:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1567, 'DE000001', '2023-01-03 14:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1568, 'DE000002', '2023-01-03 14:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1569, 'DE000003', '2023-01-03 14:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1570, 'DE000004', '2023-01-03 14:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1571, 'DE000005', '2023-01-03 14:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1572, 'DE000006', '2023-01-03 14:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1573, 'DE000001', '2023-01-03 15:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1574, 'DE000002', '2023-01-03 15:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1575, 'DE000003', '2023-01-03 15:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1576, 'DE000004', '2023-01-03 15:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1577, 'DE000005', '2023-01-03 15:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1578, 'DE000006', '2023-01-03 15:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1579, 'DE000001', '2023-01-03 16:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1580, 'DE000002', '2023-01-03 16:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1581, 'DE000003', '2023-01-03 16:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1582, 'DE000004', '2023-01-03 16:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1583, 'DE000005', '2023-01-03 16:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1584, 'DE000006', '2023-01-03 16:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1585, 'DE000001', '2023-01-03 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1586, 'DE000002', '2023-01-03 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1587, 'DE000003', '2023-01-03 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1588, 'DE000004', '2023-01-03 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1589, 'DE000005', '2023-01-03 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1590, 'DE000006', '2023-01-03 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1591, 'DE000001', '2023-01-03 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1592, 'DE000002', '2023-01-03 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1593, 'DE000003', '2023-01-03 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1594, 'DE000004', '2023-01-03 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1595, 'DE000005', '2023-01-03 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1596, 'DE000006', '2023-01-03 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1597, 'DE000001', '2023-01-03 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1598, 'DE000002', '2023-01-03 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1599, 'DE000003', '2023-01-03 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1600, 'DE000004', '2023-01-03 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1601, 'DE000005', '2023-01-03 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1602, 'DE000006', '2023-01-03 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1603, 'DE000001', '2023-01-03 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1604, 'DE000002', '2023-01-03 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1605, 'DE000003', '2023-01-03 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1606, 'DE000004', '2023-01-03 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1607, 'DE000005', '2023-01-03 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1608, 'DE000006', '2023-01-03 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1609, 'DE000001', '2023-01-03 13:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1610, 'DE000002', '2023-01-03 13:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1611, 'DE000003', '2023-01-03 13:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1612, 'DE000004', '2023-01-03 13:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1613, 'DE000005', '2023-01-03 13:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1614, 'DE000006', '2023-01-03 13:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1615, 'DE000001', '2023-01-03 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1616, 'DE000002', '2023-01-03 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1617, 'DE000003', '2023-01-03 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1618, 'DE000004', '2023-01-03 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1619, 'DE000005', '2023-01-03 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1620, 'DE000006', '2023-01-03 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1621, 'DE000001', '2023-01-03 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1622, 'DE000002', '2023-01-03 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1623, 'DE000003', '2023-01-03 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1624, 'DE000004', '2023-01-03 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1625, 'DE000005', '2023-01-03 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1626, 'DE000006', '2023-01-03 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1627, 'DE000001', '2023-01-03 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1628, 'DE000002', '2023-01-03 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1629, 'DE000003', '2023-01-03 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1630, 'DE000004', '2023-01-03 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1631, 'DE000005', '2023-01-03 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1632, 'DE000006', '2023-01-03 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1633, 'DE000001', '2023-01-04 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1634, 'DE000002', '2023-01-04 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1635, 'DE000003', '2023-01-04 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1636, 'DE000004', '2023-01-04 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1637, 'DE000005', '2023-01-04 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1638, 'DE000006', '2023-01-04 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1639, 'DE000001', '2023-01-04 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1640, 'DE000002', '2023-01-04 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1641, 'DE000003', '2023-01-04 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1642, 'DE000004', '2023-01-04 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1643, 'DE000005', '2023-01-04 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1644, 'DE000006', '2023-01-04 10:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1645, 'DE000001', '2023-01-04 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1646, 'DE000002', '2023-01-04 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1647, 'DE000003', '2023-01-04 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1648, 'DE000004', '2023-01-04 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1649, 'DE000005', '2023-01-04 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1650, 'DE000006', '2023-01-04 11:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1651, 'DE000001', '2023-01-04 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1652, 'DE000002', '2023-01-04 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1653, 'DE000003', '2023-01-04 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1654, 'DE000004', '2023-01-04 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1655, 'DE000005', '2023-01-04 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1656, 'DE000006', '2023-01-04 12:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1657, 'DE000001', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1658, 'DE000002', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1659, 'DE000003', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1660, 'DE000004', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1661, 'DE000005', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1662, 'DE000006', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1663, 'DE000001', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1664, 'DE000002', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1665, 'DE000003', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1666, 'DE000004', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1667, 'DE000005', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1668, 'DE000006', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1669, 'DE000001', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1670, 'DE000002', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1671, 'DE000003', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1672, 'DE000004', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1673, 'DE000005', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1674, 'DE000006', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1675, 'DE000001', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1676, 'DE000002', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1677, 'DE000003', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1678, 'DE000004', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1679, 'DE000005', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1680, 'DE000006', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1681, 'DE000001', '2023-01-04 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1682, 'DE000002', '2023-01-04 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1683, 'DE000003', '2023-01-04 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1684, 'DE000004', '2023-01-04 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1685, 'DE000005', '2023-01-04 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1686, 'DE000006', '2023-01-04 09:00:01', 20);
INSERT INTO `remain_dept_numbers` VALUES (1687, 'DE000001', '2023-01-04 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1688, 'DE000002', '2023-01-04 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1689, 'DE000003', '2023-01-04 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1690, 'DE000004', '2023-01-04 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1691, 'DE000005', '2023-01-04 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1692, 'DE000006', '2023-01-04 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1693, 'DE000001', '2023-01-04 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1694, 'DE000002', '2023-01-04 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1695, 'DE000003', '2023-01-04 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1696, 'DE000004', '2023-01-04 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1697, 'DE000005', '2023-01-04 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1698, 'DE000006', '2023-01-04 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1699, 'DE000001', '2023-01-04 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1700, 'DE000002', '2023-01-04 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1701, 'DE000003', '2023-01-04 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1702, 'DE000004', '2023-01-04 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1703, 'DE000005', '2023-01-04 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1704, 'DE000006', '2023-01-04 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1705, 'DE000001', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1706, 'DE000002', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1707, 'DE000003', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1708, 'DE000004', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1709, 'DE000005', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1710, 'DE000006', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1711, 'DE000001', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1712, 'DE000002', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1713, 'DE000003', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1714, 'DE000004', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1715, 'DE000005', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1716, 'DE000006', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1717, 'DE000001', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1718, 'DE000002', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1719, 'DE000003', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1720, 'DE000004', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1721, 'DE000005', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1722, 'DE000006', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1723, 'DE000001', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1724, 'DE000002', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1725, 'DE000003', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1726, 'DE000004', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1727, 'DE000005', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1728, 'DE000006', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1729, 'DE000001', '2023-01-04 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1730, 'DE000002', '2023-01-04 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1731, 'DE000003', '2023-01-04 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1732, 'DE000004', '2023-01-04 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1733, 'DE000005', '2023-01-04 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1734, 'DE000006', '2023-01-04 09:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1735, 'DE000001', '2023-01-04 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1736, 'DE000002', '2023-01-04 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1737, 'DE000003', '2023-01-04 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1738, 'DE000004', '2023-01-04 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1739, 'DE000005', '2023-01-04 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1740, 'DE000006', '2023-01-04 10:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1741, 'DE000001', '2023-01-04 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1742, 'DE000002', '2023-01-04 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1743, 'DE000003', '2023-01-04 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1744, 'DE000004', '2023-01-04 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1745, 'DE000005', '2023-01-04 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1746, 'DE000006', '2023-01-04 11:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1747, 'DE000001', '2023-01-04 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1748, 'DE000002', '2023-01-04 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1749, 'DE000003', '2023-01-04 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1750, 'DE000004', '2023-01-04 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1751, 'DE000005', '2023-01-04 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1752, 'DE000006', '2023-01-04 12:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1753, 'DE000001', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1754, 'DE000002', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1755, 'DE000003', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1756, 'DE000004', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1757, 'DE000005', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1758, 'DE000006', '2023-01-04 13:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1759, 'DE000001', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1760, 'DE000002', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1761, 'DE000003', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1762, 'DE000004', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1763, 'DE000005', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1764, 'DE000006', '2023-01-04 14:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1765, 'DE000001', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1766, 'DE000002', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1767, 'DE000003', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1768, 'DE000004', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1769, 'DE000005', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1770, 'DE000006', '2023-01-04 15:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1771, 'DE000001', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1772, 'DE000002', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1773, 'DE000003', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1774, 'DE000004', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1775, 'DE000005', '2023-01-04 16:00:00', 20);
INSERT INTO `remain_dept_numbers` VALUES (1776, 'DE000006', '2023-01-04 16:00:00', 20);

-- ----------------------------
-- Table structure for remain_doctor_numbers
-- ----------------------------
DROP TABLE IF EXISTS `remain_doctor_numbers`;
CREATE TABLE `remain_doctor_numbers`  (
  `remain_doctor_number_id` int NOT NULL AUTO_INCREMENT,
  `doctor_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `number` int NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`remain_doctor_number_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8978 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of remain_doctor_numbers
-- ----------------------------
INSERT INTO `remain_doctor_numbers` VALUES (7538, 'D0001001', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7539, 'D0001002', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7540, 'D0001003', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7541, 'D0001004', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7542, 'D0001005', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7543, 'D0001006', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7544, 'D0001007', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7545, 'D0001008', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7546, 'D0001009', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7547, 'D0001010', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7548, 'D0001011', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7549, 'D0001012', 4, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7550, 'D0001013', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7551, 'D0001014', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7552, 'D0001015', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7553, 'D0001016', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7554, 'D0001017', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7555, 'D0001018', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7556, 'D0001019', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7557, 'D0001020', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7558, 'D0001021', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7559, 'D0001022', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7560, 'D0001023', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7561, 'D0001024', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7562, 'D0001025', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7563, 'D0001026', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7564, 'D0001027', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7565, 'D0001028', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7566, 'D0001029', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7567, 'D0001030', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7568, 'D0001001', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7569, 'D0001002', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7570, 'D0001003', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7571, 'D0001004', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7572, 'D0001005', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7573, 'D0001006', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7574, 'D0001007', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7575, 'D0001008', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7576, 'D0001009', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7577, 'D0001010', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7578, 'D0001011', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7579, 'D0001012', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7580, 'D0001013', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7581, 'D0001014', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7582, 'D0001015', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7583, 'D0001016', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7584, 'D0001017', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7585, 'D0001018', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7586, 'D0001019', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7587, 'D0001020', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7588, 'D0001021', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7589, 'D0001022', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7590, 'D0001023', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7591, 'D0001024', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7592, 'D0001025', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7593, 'D0001026', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7594, 'D0001027', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7595, 'D0001028', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7596, 'D0001029', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7597, 'D0001030', 5, '2023-01-03 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7598, 'D0001001', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7599, 'D0001002', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7600, 'D0001003', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7601, 'D0001004', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7602, 'D0001005', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7603, 'D0001006', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7604, 'D0001007', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7605, 'D0001008', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7606, 'D0001009', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7607, 'D0001010', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7608, 'D0001011', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7609, 'D0001012', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7610, 'D0001013', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7611, 'D0001014', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7612, 'D0001015', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7613, 'D0001016', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7614, 'D0001017', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7615, 'D0001018', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7616, 'D0001019', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7617, 'D0001020', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7618, 'D0001021', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7619, 'D0001022', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7620, 'D0001023', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7621, 'D0001024', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7622, 'D0001025', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7623, 'D0001026', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7624, 'D0001027', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7625, 'D0001028', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7626, 'D0001029', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7627, 'D0001030', 5, '2023-01-03 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7628, 'D0001001', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7629, 'D0001002', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7630, 'D0001003', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7631, 'D0001004', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7632, 'D0001005', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7633, 'D0001006', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7634, 'D0001007', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7635, 'D0001008', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7636, 'D0001009', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7637, 'D0001010', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7638, 'D0001011', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7639, 'D0001012', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7640, 'D0001013', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7641, 'D0001014', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7642, 'D0001015', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7643, 'D0001016', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7644, 'D0001017', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7645, 'D0001018', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7646, 'D0001019', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7647, 'D0001020', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7648, 'D0001021', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7649, 'D0001022', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7650, 'D0001023', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7651, 'D0001024', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7652, 'D0001025', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7653, 'D0001026', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7654, 'D0001027', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7655, 'D0001028', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7656, 'D0001029', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7657, 'D0001030', 5, '2023-01-03 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7658, 'D0001001', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7659, 'D0001002', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7660, 'D0001003', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7661, 'D0001004', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7662, 'D0001005', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7663, 'D0001006', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7664, 'D0001007', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7665, 'D0001008', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7666, 'D0001009', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7667, 'D0001010', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7668, 'D0001011', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7669, 'D0001012', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7670, 'D0001013', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7671, 'D0001014', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7672, 'D0001015', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7673, 'D0001016', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7674, 'D0001017', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7675, 'D0001018', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7676, 'D0001019', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7677, 'D0001020', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7678, 'D0001021', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7679, 'D0001022', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7680, 'D0001023', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7681, 'D0001024', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7682, 'D0001025', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7683, 'D0001026', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7684, 'D0001027', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7685, 'D0001028', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7686, 'D0001029', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7687, 'D0001030', 5, '2023-01-03 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7688, 'D0001001', 2, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7689, 'D0001002', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7690, 'D0001003', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7691, 'D0001004', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7692, 'D0001005', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7693, 'D0001006', 4, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7694, 'D0001007', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7695, 'D0001008', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7696, 'D0001009', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7697, 'D0001010', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7698, 'D0001011', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7699, 'D0001012', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7700, 'D0001013', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7701, 'D0001014', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7702, 'D0001015', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7703, 'D0001016', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7704, 'D0001017', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7705, 'D0001018', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7706, 'D0001019', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7707, 'D0001020', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7708, 'D0001021', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7709, 'D0001022', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7710, 'D0001023', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7711, 'D0001024', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7712, 'D0001025', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7713, 'D0001026', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7714, 'D0001027', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7715, 'D0001028', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7716, 'D0001029', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7717, 'D0001030', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7718, 'D0001001', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7719, 'D0001002', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7720, 'D0001003', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7721, 'D0001004', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7722, 'D0001005', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7723, 'D0001006', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7724, 'D0001007', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7725, 'D0001008', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7726, 'D0001009', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7727, 'D0001010', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7728, 'D0001011', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7729, 'D0001012', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7730, 'D0001013', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7731, 'D0001014', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7732, 'D0001015', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7733, 'D0001016', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7734, 'D0001017', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7735, 'D0001018', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7736, 'D0001019', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7737, 'D0001020', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7738, 'D0001021', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7739, 'D0001022', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7740, 'D0001023', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7741, 'D0001024', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7742, 'D0001025', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7743, 'D0001026', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7744, 'D0001027', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7745, 'D0001028', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7746, 'D0001029', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7747, 'D0001030', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7748, 'D0001001', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7749, 'D0001002', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7750, 'D0001003', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7751, 'D0001004', 4, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7752, 'D0001005', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7753, 'D0001006', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7754, 'D0001007', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7755, 'D0001008', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7756, 'D0001009', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7757, 'D0001010', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7758, 'D0001011', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7759, 'D0001012', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7760, 'D0001013', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7761, 'D0001014', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7762, 'D0001015', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7763, 'D0001016', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7764, 'D0001017', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7765, 'D0001018', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7766, 'D0001019', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7767, 'D0001020', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7768, 'D0001021', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7769, 'D0001022', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7770, 'D0001023', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7771, 'D0001024', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7772, 'D0001025', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7773, 'D0001026', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7774, 'D0001027', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7775, 'D0001028', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7776, 'D0001029', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7777, 'D0001030', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7778, 'D0001001', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7779, 'D0001002', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7780, 'D0001003', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7781, 'D0001004', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7782, 'D0001005', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7783, 'D0001006', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7784, 'D0001007', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7785, 'D0001008', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7786, 'D0001009', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7787, 'D0001010', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7788, 'D0001011', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7789, 'D0001012', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7790, 'D0001013', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7791, 'D0001014', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7792, 'D0001015', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7793, 'D0001016', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7794, 'D0001017', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7795, 'D0001018', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7796, 'D0001019', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7797, 'D0001020', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7798, 'D0001021', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7799, 'D0001022', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7800, 'D0001023', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7801, 'D0001024', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7802, 'D0001025', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7803, 'D0001026', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7804, 'D0001027', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7805, 'D0001028', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7806, 'D0001029', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7807, 'D0001030', 5, '2023-01-03 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (7808, 'D0001001', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7809, 'D0001002', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7810, 'D0001003', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7811, 'D0001004', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7812, 'D0001005', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7813, 'D0001006', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7814, 'D0001007', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7815, 'D0001008', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7816, 'D0001009', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7817, 'D0001010', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7818, 'D0001011', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7819, 'D0001012', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7820, 'D0001013', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7821, 'D0001014', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7822, 'D0001015', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7823, 'D0001016', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7824, 'D0001017', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7825, 'D0001018', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7826, 'D0001019', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7827, 'D0001020', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7828, 'D0001021', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7829, 'D0001022', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7830, 'D0001023', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7831, 'D0001024', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7832, 'D0001025', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7833, 'D0001026', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7834, 'D0001027', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7835, 'D0001028', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7836, 'D0001029', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7837, 'D0001030', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7838, 'D0001001', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7839, 'D0001002', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7840, 'D0001003', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7841, 'D0001004', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7842, 'D0001005', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7843, 'D0001006', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7844, 'D0001007', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7845, 'D0001008', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7846, 'D0001009', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7847, 'D0001010', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7848, 'D0001011', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7849, 'D0001012', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7850, 'D0001013', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7851, 'D0001014', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7852, 'D0001015', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7853, 'D0001016', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7854, 'D0001017', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7855, 'D0001018', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7856, 'D0001019', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7857, 'D0001020', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7858, 'D0001021', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7859, 'D0001022', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7860, 'D0001023', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7861, 'D0001024', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7862, 'D0001025', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7863, 'D0001026', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7864, 'D0001027', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7865, 'D0001028', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7866, 'D0001029', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7867, 'D0001030', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7868, 'D0001001', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7869, 'D0001002', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7870, 'D0001003', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7871, 'D0001004', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7872, 'D0001005', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7873, 'D0001006', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7874, 'D0001007', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7875, 'D0001008', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7876, 'D0001009', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7877, 'D0001010', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7878, 'D0001011', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7879, 'D0001012', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7880, 'D0001013', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7881, 'D0001014', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7882, 'D0001015', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7883, 'D0001016', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7884, 'D0001017', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7885, 'D0001018', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7886, 'D0001019', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7887, 'D0001020', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7888, 'D0001021', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7889, 'D0001022', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7890, 'D0001023', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7891, 'D0001024', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7892, 'D0001025', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7893, 'D0001026', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7894, 'D0001027', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7895, 'D0001028', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7896, 'D0001029', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7897, 'D0001030', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7898, 'D0001001', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7899, 'D0001002', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7900, 'D0001003', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7901, 'D0001004', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7902, 'D0001005', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7903, 'D0001006', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7904, 'D0001007', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7905, 'D0001008', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7906, 'D0001009', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7907, 'D0001010', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7908, 'D0001011', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7909, 'D0001012', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7910, 'D0001013', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7911, 'D0001014', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7912, 'D0001015', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7913, 'D0001016', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7914, 'D0001017', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7915, 'D0001018', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7916, 'D0001019', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7917, 'D0001020', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7918, 'D0001021', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7919, 'D0001022', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7920, 'D0001023', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7921, 'D0001024', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7922, 'D0001025', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7923, 'D0001026', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7924, 'D0001027', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7925, 'D0001028', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7926, 'D0001029', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7927, 'D0001030', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7928, 'D0001001', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7929, 'D0001002', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7930, 'D0001003', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7931, 'D0001004', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7932, 'D0001005', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7933, 'D0001006', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7934, 'D0001007', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7935, 'D0001008', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7936, 'D0001009', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7937, 'D0001010', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7938, 'D0001011', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7939, 'D0001012', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7940, 'D0001013', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7941, 'D0001014', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7942, 'D0001015', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7943, 'D0001016', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7944, 'D0001017', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7945, 'D0001018', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7946, 'D0001019', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7947, 'D0001020', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7948, 'D0001021', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7949, 'D0001022', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7950, 'D0001023', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7951, 'D0001024', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7952, 'D0001025', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7953, 'D0001026', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7954, 'D0001027', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7955, 'D0001028', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7956, 'D0001029', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7957, 'D0001030', 5, '2023-01-03 14:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7958, 'D0001001', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7959, 'D0001002', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7960, 'D0001003', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7961, 'D0001004', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7962, 'D0001005', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7963, 'D0001006', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7964, 'D0001007', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7965, 'D0001008', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7966, 'D0001009', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7967, 'D0001010', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7968, 'D0001011', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7969, 'D0001012', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7970, 'D0001013', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7971, 'D0001014', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7972, 'D0001015', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7973, 'D0001016', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7974, 'D0001017', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7975, 'D0001018', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7976, 'D0001019', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7977, 'D0001020', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7978, 'D0001021', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7979, 'D0001022', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7980, 'D0001023', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7981, 'D0001024', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7982, 'D0001025', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7983, 'D0001026', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7984, 'D0001027', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7985, 'D0001028', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7986, 'D0001029', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7987, 'D0001030', 5, '2023-01-03 15:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7988, 'D0001001', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7989, 'D0001002', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7990, 'D0001003', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7991, 'D0001004', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7992, 'D0001005', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7993, 'D0001006', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7994, 'D0001007', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7995, 'D0001008', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7996, 'D0001009', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7997, 'D0001010', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7998, 'D0001011', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (7999, 'D0001012', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8000, 'D0001013', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8001, 'D0001014', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8002, 'D0001015', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8003, 'D0001016', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8004, 'D0001017', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8005, 'D0001018', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8006, 'D0001019', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8007, 'D0001020', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8008, 'D0001021', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8009, 'D0001022', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8010, 'D0001023', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8011, 'D0001024', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8012, 'D0001025', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8013, 'D0001026', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8014, 'D0001027', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8015, 'D0001028', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8016, 'D0001029', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8017, 'D0001030', 5, '2023-01-03 16:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8018, 'D0001001', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8019, 'D0001002', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8020, 'D0001003', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8021, 'D0001004', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8022, 'D0001005', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8023, 'D0001006', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8024, 'D0001007', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8025, 'D0001008', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8026, 'D0001009', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8027, 'D0001010', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8028, 'D0001011', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8029, 'D0001012', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8030, 'D0001013', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8031, 'D0001014', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8032, 'D0001015', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8033, 'D0001016', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8034, 'D0001017', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8035, 'D0001018', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8036, 'D0001019', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8037, 'D0001020', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8038, 'D0001021', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8039, 'D0001022', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8040, 'D0001023', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8041, 'D0001024', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8042, 'D0001025', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8043, 'D0001026', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8044, 'D0001027', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8045, 'D0001028', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8046, 'D0001029', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8047, 'D0001030', 5, '2023-01-03 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8048, 'D0001001', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8049, 'D0001002', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8050, 'D0001003', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8051, 'D0001004', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8052, 'D0001005', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8053, 'D0001006', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8054, 'D0001007', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8055, 'D0001008', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8056, 'D0001009', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8057, 'D0001010', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8058, 'D0001011', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8059, 'D0001012', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8060, 'D0001013', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8061, 'D0001014', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8062, 'D0001015', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8063, 'D0001016', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8064, 'D0001017', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8065, 'D0001018', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8066, 'D0001019', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8067, 'D0001020', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8068, 'D0001021', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8069, 'D0001022', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8070, 'D0001023', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8071, 'D0001024', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8072, 'D0001025', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8073, 'D0001026', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8074, 'D0001027', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8075, 'D0001028', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8076, 'D0001029', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8077, 'D0001030', 5, '2023-01-03 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8078, 'D0001001', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8079, 'D0001002', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8080, 'D0001003', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8081, 'D0001004', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8082, 'D0001005', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8083, 'D0001006', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8084, 'D0001007', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8085, 'D0001008', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8086, 'D0001009', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8087, 'D0001010', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8088, 'D0001011', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8089, 'D0001012', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8090, 'D0001013', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8091, 'D0001014', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8092, 'D0001015', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8093, 'D0001016', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8094, 'D0001017', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8095, 'D0001018', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8096, 'D0001019', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8097, 'D0001020', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8098, 'D0001021', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8099, 'D0001022', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8100, 'D0001023', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8101, 'D0001024', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8102, 'D0001025', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8103, 'D0001026', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8104, 'D0001027', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8105, 'D0001028', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8106, 'D0001029', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8107, 'D0001030', 5, '2023-01-03 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8108, 'D0001001', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8109, 'D0001002', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8110, 'D0001003', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8111, 'D0001004', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8112, 'D0001005', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8113, 'D0001006', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8114, 'D0001007', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8115, 'D0001008', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8116, 'D0001009', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8117, 'D0001010', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8118, 'D0001011', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8119, 'D0001012', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8120, 'D0001013', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8121, 'D0001014', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8122, 'D0001015', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8123, 'D0001016', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8124, 'D0001017', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8125, 'D0001018', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8126, 'D0001019', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8127, 'D0001020', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8128, 'D0001021', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8129, 'D0001022', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8130, 'D0001023', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8131, 'D0001024', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8132, 'D0001025', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8133, 'D0001026', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8134, 'D0001027', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8135, 'D0001028', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8136, 'D0001029', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8137, 'D0001030', 5, '2023-01-03 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8138, 'D0001001', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8139, 'D0001002', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8140, 'D0001003', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8141, 'D0001004', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8142, 'D0001005', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8143, 'D0001006', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8144, 'D0001007', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8145, 'D0001008', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8146, 'D0001009', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8147, 'D0001010', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8148, 'D0001011', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8149, 'D0001012', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8150, 'D0001013', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8151, 'D0001014', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8152, 'D0001015', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8153, 'D0001016', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8154, 'D0001017', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8155, 'D0001018', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8156, 'D0001019', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8157, 'D0001020', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8158, 'D0001021', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8159, 'D0001022', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8160, 'D0001023', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8161, 'D0001024', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8162, 'D0001025', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8163, 'D0001026', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8164, 'D0001027', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8165, 'D0001028', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8166, 'D0001029', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8167, 'D0001030', 5, '2023-01-03 13:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8168, 'D0001001', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8169, 'D0001002', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8170, 'D0001003', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8171, 'D0001004', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8172, 'D0001005', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8173, 'D0001006', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8174, 'D0001007', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8175, 'D0001008', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8176, 'D0001009', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8177, 'D0001010', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8178, 'D0001011', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8179, 'D0001012', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8180, 'D0001013', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8181, 'D0001014', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8182, 'D0001015', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8183, 'D0001016', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8184, 'D0001017', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8185, 'D0001018', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8186, 'D0001019', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8187, 'D0001020', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8188, 'D0001021', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8189, 'D0001022', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8190, 'D0001023', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8191, 'D0001024', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8192, 'D0001025', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8193, 'D0001026', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8194, 'D0001027', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8195, 'D0001028', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8196, 'D0001029', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8197, 'D0001030', 5, '2023-01-03 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8198, 'D0001001', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8199, 'D0001002', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8200, 'D0001003', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8201, 'D0001004', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8202, 'D0001005', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8203, 'D0001006', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8204, 'D0001007', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8205, 'D0001008', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8206, 'D0001009', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8207, 'D0001010', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8208, 'D0001011', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8209, 'D0001012', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8210, 'D0001013', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8211, 'D0001014', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8212, 'D0001015', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8213, 'D0001016', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8214, 'D0001017', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8215, 'D0001018', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8216, 'D0001019', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8217, 'D0001020', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8218, 'D0001021', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8219, 'D0001022', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8220, 'D0001023', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8221, 'D0001024', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8222, 'D0001025', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8223, 'D0001026', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8224, 'D0001027', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8225, 'D0001028', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8226, 'D0001029', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8227, 'D0001030', 5, '2023-01-03 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8228, 'D0001001', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8229, 'D0001002', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8230, 'D0001003', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8231, 'D0001004', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8232, 'D0001005', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8233, 'D0001006', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8234, 'D0001007', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8235, 'D0001008', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8236, 'D0001009', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8237, 'D0001010', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8238, 'D0001011', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8239, 'D0001012', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8240, 'D0001013', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8241, 'D0001014', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8242, 'D0001015', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8243, 'D0001016', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8244, 'D0001017', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8245, 'D0001018', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8246, 'D0001019', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8247, 'D0001020', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8248, 'D0001021', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8249, 'D0001022', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8250, 'D0001023', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8251, 'D0001024', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8252, 'D0001025', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8253, 'D0001026', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8254, 'D0001027', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8255, 'D0001028', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8256, 'D0001029', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8257, 'D0001030', 5, '2023-01-03 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8258, 'D0001001', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8259, 'D0001002', 4, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8260, 'D0001003', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8261, 'D0001004', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8262, 'D0001005', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8263, 'D0001006', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8264, 'D0001007', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8265, 'D0001008', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8266, 'D0001009', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8267, 'D0001010', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8268, 'D0001011', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8269, 'D0001012', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8270, 'D0001013', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8271, 'D0001014', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8272, 'D0001015', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8273, 'D0001016', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8274, 'D0001017', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8275, 'D0001018', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8276, 'D0001019', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8277, 'D0001020', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8278, 'D0001021', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8279, 'D0001022', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8280, 'D0001023', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8281, 'D0001024', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8282, 'D0001025', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8283, 'D0001026', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8284, 'D0001027', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8285, 'D0001028', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8286, 'D0001029', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8287, 'D0001030', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8288, 'D0001001', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8289, 'D0001002', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8290, 'D0001003', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8291, 'D0001004', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8292, 'D0001005', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8293, 'D0001006', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8294, 'D0001007', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8295, 'D0001008', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8296, 'D0001009', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8297, 'D0001010', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8298, 'D0001011', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8299, 'D0001012', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8300, 'D0001013', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8301, 'D0001014', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8302, 'D0001015', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8303, 'D0001016', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8304, 'D0001017', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8305, 'D0001018', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8306, 'D0001019', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8307, 'D0001020', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8308, 'D0001021', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8309, 'D0001022', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8310, 'D0001023', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8311, 'D0001024', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8312, 'D0001025', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8313, 'D0001026', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8314, 'D0001027', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8315, 'D0001028', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8316, 'D0001029', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8317, 'D0001030', 5, '2023-01-04 10:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8318, 'D0001001', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8319, 'D0001002', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8320, 'D0001003', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8321, 'D0001004', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8322, 'D0001005', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8323, 'D0001006', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8324, 'D0001007', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8325, 'D0001008', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8326, 'D0001009', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8327, 'D0001010', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8328, 'D0001011', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8329, 'D0001012', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8330, 'D0001013', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8331, 'D0001014', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8332, 'D0001015', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8333, 'D0001016', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8334, 'D0001017', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8335, 'D0001018', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8336, 'D0001019', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8337, 'D0001020', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8338, 'D0001021', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8339, 'D0001022', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8340, 'D0001023', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8341, 'D0001024', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8342, 'D0001025', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8343, 'D0001026', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8344, 'D0001027', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8345, 'D0001028', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8346, 'D0001029', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8347, 'D0001030', 5, '2023-01-04 11:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8348, 'D0001001', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8349, 'D0001002', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8350, 'D0001003', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8351, 'D0001004', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8352, 'D0001005', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8353, 'D0001006', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8354, 'D0001007', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8355, 'D0001008', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8356, 'D0001009', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8357, 'D0001010', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8358, 'D0001011', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8359, 'D0001012', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8360, 'D0001013', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8361, 'D0001014', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8362, 'D0001015', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8363, 'D0001016', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8364, 'D0001017', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8365, 'D0001018', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8366, 'D0001019', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8367, 'D0001020', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8368, 'D0001021', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8369, 'D0001022', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8370, 'D0001023', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8371, 'D0001024', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8372, 'D0001025', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8373, 'D0001026', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8374, 'D0001027', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8375, 'D0001028', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8376, 'D0001029', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8377, 'D0001030', 5, '2023-01-04 12:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8378, 'D0001001', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8379, 'D0001002', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8380, 'D0001003', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8381, 'D0001004', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8382, 'D0001005', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8383, 'D0001006', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8384, 'D0001007', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8385, 'D0001008', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8386, 'D0001009', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8387, 'D0001010', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8388, 'D0001011', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8389, 'D0001012', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8390, 'D0001013', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8391, 'D0001014', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8392, 'D0001015', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8393, 'D0001016', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8394, 'D0001017', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8395, 'D0001018', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8396, 'D0001019', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8397, 'D0001020', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8398, 'D0001021', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8399, 'D0001022', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8400, 'D0001023', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8401, 'D0001024', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8402, 'D0001025', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8403, 'D0001026', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8404, 'D0001027', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8405, 'D0001028', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8406, 'D0001029', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8407, 'D0001030', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8408, 'D0001001', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8409, 'D0001002', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8410, 'D0001003', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8411, 'D0001004', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8412, 'D0001005', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8413, 'D0001006', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8414, 'D0001007', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8415, 'D0001008', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8416, 'D0001009', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8417, 'D0001010', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8418, 'D0001011', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8419, 'D0001012', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8420, 'D0001013', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8421, 'D0001014', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8422, 'D0001015', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8423, 'D0001016', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8424, 'D0001017', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8425, 'D0001018', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8426, 'D0001019', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8427, 'D0001020', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8428, 'D0001021', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8429, 'D0001022', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8430, 'D0001023', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8431, 'D0001024', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8432, 'D0001025', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8433, 'D0001026', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8434, 'D0001027', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8435, 'D0001028', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8436, 'D0001029', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8437, 'D0001030', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8438, 'D0001001', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8439, 'D0001002', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8440, 'D0001003', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8441, 'D0001004', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8442, 'D0001005', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8443, 'D0001006', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8444, 'D0001007', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8445, 'D0001008', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8446, 'D0001009', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8447, 'D0001010', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8448, 'D0001011', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8449, 'D0001012', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8450, 'D0001013', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8451, 'D0001014', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8452, 'D0001015', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8453, 'D0001016', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8454, 'D0001017', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8455, 'D0001018', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8456, 'D0001019', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8457, 'D0001020', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8458, 'D0001021', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8459, 'D0001022', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8460, 'D0001023', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8461, 'D0001024', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8462, 'D0001025', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8463, 'D0001026', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8464, 'D0001027', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8465, 'D0001028', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8466, 'D0001029', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8467, 'D0001030', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8468, 'D0001001', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8469, 'D0001002', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8470, 'D0001003', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8471, 'D0001004', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8472, 'D0001005', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8473, 'D0001006', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8474, 'D0001007', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8475, 'D0001008', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8476, 'D0001009', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8477, 'D0001010', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8478, 'D0001011', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8479, 'D0001012', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8480, 'D0001013', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8481, 'D0001014', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8482, 'D0001015', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8483, 'D0001016', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8484, 'D0001017', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8485, 'D0001018', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8486, 'D0001019', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8487, 'D0001020', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8488, 'D0001021', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8489, 'D0001022', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8490, 'D0001023', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8491, 'D0001024', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8492, 'D0001025', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8493, 'D0001026', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8494, 'D0001027', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8495, 'D0001028', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8496, 'D0001029', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8497, 'D0001030', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8498, 'D0001001', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8499, 'D0001002', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8500, 'D0001003', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8501, 'D0001004', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8502, 'D0001005', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8503, 'D0001006', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8504, 'D0001007', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8505, 'D0001008', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8506, 'D0001009', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8507, 'D0001010', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8508, 'D0001011', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8509, 'D0001012', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8510, 'D0001013', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8511, 'D0001014', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8512, 'D0001015', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8513, 'D0001016', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8514, 'D0001017', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8515, 'D0001018', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8516, 'D0001019', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8517, 'D0001020', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8518, 'D0001021', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8519, 'D0001022', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8520, 'D0001023', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8521, 'D0001024', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8522, 'D0001025', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8523, 'D0001026', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8524, 'D0001027', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8525, 'D0001028', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8526, 'D0001029', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8527, 'D0001030', 5, '2023-01-04 09:00:01');
INSERT INTO `remain_doctor_numbers` VALUES (8528, 'D0001001', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8529, 'D0001002', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8530, 'D0001003', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8531, 'D0001004', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8532, 'D0001005', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8533, 'D0001006', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8534, 'D0001007', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8535, 'D0001008', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8536, 'D0001009', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8537, 'D0001010', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8538, 'D0001011', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8539, 'D0001012', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8540, 'D0001013', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8541, 'D0001014', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8542, 'D0001015', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8543, 'D0001016', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8544, 'D0001017', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8545, 'D0001018', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8546, 'D0001019', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8547, 'D0001020', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8548, 'D0001021', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8549, 'D0001022', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8550, 'D0001023', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8551, 'D0001024', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8552, 'D0001025', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8553, 'D0001026', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8554, 'D0001027', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8555, 'D0001028', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8556, 'D0001029', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8557, 'D0001030', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8558, 'D0001001', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8559, 'D0001002', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8560, 'D0001003', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8561, 'D0001004', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8562, 'D0001005', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8563, 'D0001006', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8564, 'D0001007', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8565, 'D0001008', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8566, 'D0001009', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8567, 'D0001010', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8568, 'D0001011', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8569, 'D0001012', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8570, 'D0001013', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8571, 'D0001014', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8572, 'D0001015', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8573, 'D0001016', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8574, 'D0001017', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8575, 'D0001018', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8576, 'D0001019', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8577, 'D0001020', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8578, 'D0001021', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8579, 'D0001022', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8580, 'D0001023', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8581, 'D0001024', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8582, 'D0001025', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8583, 'D0001026', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8584, 'D0001027', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8585, 'D0001028', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8586, 'D0001029', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8587, 'D0001030', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8588, 'D0001001', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8589, 'D0001002', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8590, 'D0001003', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8591, 'D0001004', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8592, 'D0001005', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8593, 'D0001006', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8594, 'D0001007', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8595, 'D0001008', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8596, 'D0001009', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8597, 'D0001010', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8598, 'D0001011', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8599, 'D0001012', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8600, 'D0001013', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8601, 'D0001014', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8602, 'D0001015', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8603, 'D0001016', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8604, 'D0001017', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8605, 'D0001018', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8606, 'D0001019', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8607, 'D0001020', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8608, 'D0001021', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8609, 'D0001022', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8610, 'D0001023', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8611, 'D0001024', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8612, 'D0001025', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8613, 'D0001026', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8614, 'D0001027', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8615, 'D0001028', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8616, 'D0001029', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8617, 'D0001030', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8618, 'D0001001', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8619, 'D0001002', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8620, 'D0001003', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8621, 'D0001004', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8622, 'D0001005', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8623, 'D0001006', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8624, 'D0001007', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8625, 'D0001008', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8626, 'D0001009', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8627, 'D0001010', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8628, 'D0001011', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8629, 'D0001012', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8630, 'D0001013', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8631, 'D0001014', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8632, 'D0001015', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8633, 'D0001016', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8634, 'D0001017', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8635, 'D0001018', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8636, 'D0001019', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8637, 'D0001020', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8638, 'D0001021', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8639, 'D0001022', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8640, 'D0001023', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8641, 'D0001024', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8642, 'D0001025', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8643, 'D0001026', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8644, 'D0001027', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8645, 'D0001028', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8646, 'D0001029', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8647, 'D0001030', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8648, 'D0001001', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8649, 'D0001002', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8650, 'D0001003', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8651, 'D0001004', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8652, 'D0001005', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8653, 'D0001006', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8654, 'D0001007', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8655, 'D0001008', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8656, 'D0001009', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8657, 'D0001010', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8658, 'D0001011', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8659, 'D0001012', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8660, 'D0001013', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8661, 'D0001014', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8662, 'D0001015', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8663, 'D0001016', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8664, 'D0001017', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8665, 'D0001018', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8666, 'D0001019', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8667, 'D0001020', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8668, 'D0001021', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8669, 'D0001022', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8670, 'D0001023', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8671, 'D0001024', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8672, 'D0001025', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8673, 'D0001026', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8674, 'D0001027', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8675, 'D0001028', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8676, 'D0001029', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8677, 'D0001030', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8678, 'D0001001', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8679, 'D0001002', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8680, 'D0001003', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8681, 'D0001004', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8682, 'D0001005', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8683, 'D0001006', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8684, 'D0001007', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8685, 'D0001008', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8686, 'D0001009', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8687, 'D0001010', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8688, 'D0001011', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8689, 'D0001012', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8690, 'D0001013', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8691, 'D0001014', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8692, 'D0001015', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8693, 'D0001016', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8694, 'D0001017', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8695, 'D0001018', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8696, 'D0001019', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8697, 'D0001020', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8698, 'D0001021', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8699, 'D0001022', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8700, 'D0001023', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8701, 'D0001024', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8702, 'D0001025', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8703, 'D0001026', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8704, 'D0001027', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8705, 'D0001028', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8706, 'D0001029', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8707, 'D0001030', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8708, 'D0001001', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8709, 'D0001002', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8710, 'D0001003', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8711, 'D0001004', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8712, 'D0001005', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8713, 'D0001006', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8714, 'D0001007', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8715, 'D0001008', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8716, 'D0001009', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8717, 'D0001010', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8718, 'D0001011', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8719, 'D0001012', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8720, 'D0001013', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8721, 'D0001014', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8722, 'D0001015', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8723, 'D0001016', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8724, 'D0001017', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8725, 'D0001018', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8726, 'D0001019', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8727, 'D0001020', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8728, 'D0001021', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8729, 'D0001022', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8730, 'D0001023', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8731, 'D0001024', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8732, 'D0001025', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8733, 'D0001026', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8734, 'D0001027', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8735, 'D0001028', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8736, 'D0001029', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8737, 'D0001030', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8738, 'D0001001', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8739, 'D0001002', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8740, 'D0001003', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8741, 'D0001004', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8742, 'D0001005', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8743, 'D0001006', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8744, 'D0001007', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8745, 'D0001008', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8746, 'D0001009', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8747, 'D0001010', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8748, 'D0001011', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8749, 'D0001012', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8750, 'D0001013', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8751, 'D0001014', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8752, 'D0001015', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8753, 'D0001016', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8754, 'D0001017', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8755, 'D0001018', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8756, 'D0001019', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8757, 'D0001020', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8758, 'D0001021', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8759, 'D0001022', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8760, 'D0001023', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8761, 'D0001024', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8762, 'D0001025', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8763, 'D0001026', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8764, 'D0001027', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8765, 'D0001028', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8766, 'D0001029', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8767, 'D0001030', 5, '2023-01-04 09:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8768, 'D0001001', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8769, 'D0001002', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8770, 'D0001003', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8771, 'D0001004', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8772, 'D0001005', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8773, 'D0001006', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8774, 'D0001007', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8775, 'D0001008', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8776, 'D0001009', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8777, 'D0001010', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8778, 'D0001011', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8779, 'D0001012', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8780, 'D0001013', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8781, 'D0001014', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8782, 'D0001015', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8783, 'D0001016', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8784, 'D0001017', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8785, 'D0001018', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8786, 'D0001019', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8787, 'D0001020', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8788, 'D0001021', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8789, 'D0001022', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8790, 'D0001023', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8791, 'D0001024', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8792, 'D0001025', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8793, 'D0001026', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8794, 'D0001027', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8795, 'D0001028', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8796, 'D0001029', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8797, 'D0001030', 5, '2023-01-04 10:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8798, 'D0001001', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8799, 'D0001002', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8800, 'D0001003', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8801, 'D0001004', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8802, 'D0001005', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8803, 'D0001006', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8804, 'D0001007', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8805, 'D0001008', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8806, 'D0001009', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8807, 'D0001010', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8808, 'D0001011', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8809, 'D0001012', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8810, 'D0001013', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8811, 'D0001014', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8812, 'D0001015', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8813, 'D0001016', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8814, 'D0001017', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8815, 'D0001018', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8816, 'D0001019', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8817, 'D0001020', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8818, 'D0001021', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8819, 'D0001022', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8820, 'D0001023', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8821, 'D0001024', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8822, 'D0001025', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8823, 'D0001026', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8824, 'D0001027', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8825, 'D0001028', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8826, 'D0001029', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8827, 'D0001030', 5, '2023-01-04 11:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8828, 'D0001001', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8829, 'D0001002', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8830, 'D0001003', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8831, 'D0001004', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8832, 'D0001005', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8833, 'D0001006', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8834, 'D0001007', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8835, 'D0001008', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8836, 'D0001009', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8837, 'D0001010', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8838, 'D0001011', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8839, 'D0001012', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8840, 'D0001013', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8841, 'D0001014', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8842, 'D0001015', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8843, 'D0001016', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8844, 'D0001017', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8845, 'D0001018', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8846, 'D0001019', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8847, 'D0001020', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8848, 'D0001021', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8849, 'D0001022', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8850, 'D0001023', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8851, 'D0001024', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8852, 'D0001025', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8853, 'D0001026', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8854, 'D0001027', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8855, 'D0001028', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8856, 'D0001029', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8857, 'D0001030', 5, '2023-01-04 12:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8858, 'D0001001', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8859, 'D0001002', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8860, 'D0001003', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8861, 'D0001004', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8862, 'D0001005', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8863, 'D0001006', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8864, 'D0001007', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8865, 'D0001008', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8866, 'D0001009', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8867, 'D0001010', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8868, 'D0001011', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8869, 'D0001012', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8870, 'D0001013', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8871, 'D0001014', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8872, 'D0001015', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8873, 'D0001016', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8874, 'D0001017', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8875, 'D0001018', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8876, 'D0001019', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8877, 'D0001020', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8878, 'D0001021', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8879, 'D0001022', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8880, 'D0001023', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8881, 'D0001024', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8882, 'D0001025', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8883, 'D0001026', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8884, 'D0001027', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8885, 'D0001028', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8886, 'D0001029', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8887, 'D0001030', 5, '2023-01-04 13:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8888, 'D0001001', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8889, 'D0001002', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8890, 'D0001003', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8891, 'D0001004', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8892, 'D0001005', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8893, 'D0001006', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8894, 'D0001007', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8895, 'D0001008', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8896, 'D0001009', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8897, 'D0001010', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8898, 'D0001011', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8899, 'D0001012', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8900, 'D0001013', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8901, 'D0001014', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8902, 'D0001015', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8903, 'D0001016', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8904, 'D0001017', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8905, 'D0001018', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8906, 'D0001019', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8907, 'D0001020', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8908, 'D0001021', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8909, 'D0001022', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8910, 'D0001023', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8911, 'D0001024', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8912, 'D0001025', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8913, 'D0001026', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8914, 'D0001027', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8915, 'D0001028', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8916, 'D0001029', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8917, 'D0001030', 5, '2023-01-04 14:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8918, 'D0001001', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8919, 'D0001002', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8920, 'D0001003', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8921, 'D0001004', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8922, 'D0001005', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8923, 'D0001006', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8924, 'D0001007', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8925, 'D0001008', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8926, 'D0001009', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8927, 'D0001010', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8928, 'D0001011', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8929, 'D0001012', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8930, 'D0001013', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8931, 'D0001014', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8932, 'D0001015', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8933, 'D0001016', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8934, 'D0001017', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8935, 'D0001018', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8936, 'D0001019', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8937, 'D0001020', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8938, 'D0001021', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8939, 'D0001022', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8940, 'D0001023', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8941, 'D0001024', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8942, 'D0001025', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8943, 'D0001026', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8944, 'D0001027', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8945, 'D0001028', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8946, 'D0001029', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8947, 'D0001030', 5, '2023-01-04 15:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8948, 'D0001001', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8949, 'D0001002', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8950, 'D0001003', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8951, 'D0001004', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8952, 'D0001005', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8953, 'D0001006', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8954, 'D0001007', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8955, 'D0001008', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8956, 'D0001009', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8957, 'D0001010', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8958, 'D0001011', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8959, 'D0001012', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8960, 'D0001013', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8961, 'D0001014', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8962, 'D0001015', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8963, 'D0001016', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8964, 'D0001017', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8965, 'D0001018', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8966, 'D0001019', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8967, 'D0001020', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8968, 'D0001021', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8969, 'D0001022', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8970, 'D0001023', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8971, 'D0001024', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8972, 'D0001025', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8973, 'D0001026', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8974, 'D0001027', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8975, 'D0001028', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8976, 'D0001029', 5, '2023-01-04 16:00:00');
INSERT INTO `remain_doctor_numbers` VALUES (8977, 'D0001030', 5, '2023-01-04 16:00:00');

-- ----------------------------
-- Table structure for reserve_tables
-- ----------------------------
DROP TABLE IF EXISTS `reserve_tables`;
CREATE TABLE `reserve_tables`  (
  `reserve_id` int NOT NULL AUTO_INCREMENT COMMENT '预约单号',
  `patient_identity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者身份证号',
  `department_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '预约的科室编号',
  `doctor_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'D0000001' COMMENT '预约的医生工号',
  `reserve_type` int NULL DEFAULT 1 COMMENT '预约类型1科室，0专家',
  `reserve_state` int NULL DEFAULT 0 COMMENT '预约状态,0待确认,1已完成,-1已取消',
  `reserve_time` datetime NULL DEFAULT NULL COMMENT '预约时段的起始时间',
  PRIMARY KEY (`reserve_id`) USING BTREE,
  INDEX `patient_identity`(`patient_identity` ASC) USING BTREE,
  INDEX `department_id`(`department_id` ASC) USING BTREE,
  INDEX `doctor_id`(`doctor_id` ASC) USING BTREE,
  CONSTRAINT `reserve_tables_ibfk_1` FOREIGN KEY (`patient_identity`) REFERENCES `patients` (`patient_identity`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reserve_tables_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reserve_tables_ibfk_3` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reserve_tables
-- ----------------------------
INSERT INTO `reserve_tables` VALUES (1, '362424199909126677', 'DE000001', 'D0001001', 0, 1, '2023-01-03 14:00:00');

-- ----------------------------
-- Table structure for return_medicine_tables
-- ----------------------------
DROP TABLE IF EXISTS `return_medicine_tables`;
CREATE TABLE `return_medicine_tables`  (
  `return_id` int NOT NULL AUTO_INCREMENT COMMENT '取药单号',
  `patient_identity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者身份证号',
  `pharmacist_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '药剂师工号',
  `prescription_id` int NULL DEFAULT NULL COMMENT '处方单号',
  `medicine_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '药品编号',
  `return_number` int NULL DEFAULT NULL COMMENT '药品数量',
  `return_time` datetime NULL DEFAULT NULL COMMENT '退药时间',
  PRIMARY KEY (`return_id`) USING BTREE,
  INDEX `patient_identity`(`patient_identity` ASC) USING BTREE,
  INDEX `doctor_id`(`pharmacist_id` ASC) USING BTREE,
  INDEX `medicine_id`(`medicine_id` ASC) USING BTREE,
  INDEX `prescription_id`(`prescription_id` ASC) USING BTREE,
  CONSTRAINT `return_medicine_tables_ibfk_1` FOREIGN KEY (`patient_identity`) REFERENCES `patients` (`patient_identity`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `return_medicine_tables_ibfk_2` FOREIGN KEY (`pharmacist_id`) REFERENCES `pharmacists` (`pharmacist_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `return_medicine_tables_ibfk_4` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`medicine_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `return_medicine_tables_ibfk_5` FOREIGN KEY (`prescription_id`) REFERENCES `prescription_tables` (`prescription_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of return_medicine_tables
-- ----------------------------
INSERT INTO `return_medicine_tables` VALUES (4, '362424199909126677', 'M2023016', 2, 'ME00100013', 1, '2023-01-03 16:51:06');
INSERT INTO `return_medicine_tables` VALUES (5, '362424199909126677', 'M2023016', 3, 'ME0010001', 1, '2023-01-03 16:51:06');

-- ----------------------------
-- Table structure for take_medine_tables
-- ----------------------------
DROP TABLE IF EXISTS `take_medine_tables`;
CREATE TABLE `take_medine_tables`  (
  `take_id` int NOT NULL AUTO_INCREMENT COMMENT '取药单号',
  `patient_identity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者身份证号',
  `pharmacist_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '药剂师工号',
  `prescription_id` int NOT NULL COMMENT '药品编号',
  `take_state` int NULL DEFAULT 0 COMMENT '取药状态,0待配药,1配药中,2待取药,3已取药',
  `bill_time` datetime NULL DEFAULT NULL COMMENT '开具时间',
  `take_time` datetime NULL DEFAULT NULL COMMENT '取药时间',
  PRIMARY KEY (`take_id`, `prescription_id`) USING BTREE,
  INDEX `patient_identity`(`patient_identity` ASC) USING BTREE,
  INDEX `doctor_id`(`pharmacist_id` ASC) USING BTREE,
  INDEX `medicine_id`(`prescription_id` ASC) USING BTREE,
  CONSTRAINT `take_medine_tables_ibfk_1` FOREIGN KEY (`patient_identity`) REFERENCES `patients` (`patient_identity`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `take_medine_tables_ibfk_2` FOREIGN KEY (`pharmacist_id`) REFERENCES `pharmacists` (`pharmacist_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `take_medine_tables_ibfk_3` FOREIGN KEY (`prescription_id`) REFERENCES `prescription_tables` (`prescription_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of take_medine_tables
-- ----------------------------
INSERT INTO `take_medine_tables` VALUES (1, '362424199909126677', 'M2023016', 2, 4, '2023-01-03 16:32:28', '2023-01-03 16:45:50');
INSERT INTO `take_medine_tables` VALUES (1, '362424199909126677', 'M2023016', 3, 4, '2023-01-03 16:32:28', '2023-01-03 16:45:50');

-- ----------------------------
-- Table structure for tmp_medicines
-- ----------------------------
DROP TABLE IF EXISTS `tmp_medicines`;
CREATE TABLE `tmp_medicines`  (
  `medicine_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '药品编号',
  `medicine_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '药品名称',
  `medicine_number` int NULL DEFAULT NULL COMMENT '药品数量',
  `medicine_money` float(255, 0) NULL DEFAULT NULL COMMENT '药品单价',
  PRIMARY KEY (`medicine_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tmp_medicines
-- ----------------------------

-- ----------------------------
-- Table structure for violate_tables
-- ----------------------------
DROP TABLE IF EXISTS `violate_tables`;
CREATE TABLE `violate_tables`  (
  `violate_id` int NOT NULL AUTO_INCREMENT COMMENT '违约记录编号',
  `reserve_id` int NULL DEFAULT NULL COMMENT '预约单号',
  PRIMARY KEY (`violate_id`) USING BTREE,
  INDEX `reserve_id`(`reserve_id` ASC) USING BTREE,
  CONSTRAINT `violate_tables_ibfk_1` FOREIGN KEY (`reserve_id`) REFERENCES `reserve_tables` (`reserve_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of violate_tables
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
