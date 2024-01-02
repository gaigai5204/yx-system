/*
SQLyog Ultimate v12.14 (64 bit)
MySQL - 5.5.40 : Database - books
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`books` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `books`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET gbk COLLATE gbk_bin NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `status` int(2) DEFAULT '1',
  `lend_num` int(11) DEFAULT NULL,
  `max_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=gbk;

/*Data for the table `admin` */

insert  into `admin`(`aid`,`username`,`name`,`password`,`email`,`phone`,`status`,`lend_num`,`max_num`) values 
(10,'1002','1002','123','1002','1002',1,1,1),
(2,'admin','小红','123','1888@qq.com','18866668888',2,99,99),
(6,'1000','丽丽','123','123@qq.com','121',1,30,5),
(9,'8888','小绿','123','188666@qq.com','18866668888',1,999,999),
(7,'1001','小白','123','12','12',1,10,10),
(12,'test1','123','123','123','123',1,30,5);

/*Table structure for table `book` */

DROP TABLE IF EXISTS `book`;

CREATE TABLE `book` (
  `bid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(205) NOT NULL,
  `card` varchar(205) CHARACTER SET utf8 NOT NULL,
  `autho` varchar(205) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `press` varchar(205) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bid`),
  UNIQUE KEY `ISBN` (`card`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=gbk;

/*Data for the table `book` */

insert  into `book`(`bid`,`name`,`card`,`autho`,`num`,`press`,`type`) values 
(7,'红楼梦','1001','曹植',777,'xx出版社','世界名著'),
(6,'三国演义','1000','罗贯中',99,'清华大学出版社','世界名著'),
(8,'java修炼之道','6666','李白',99,'理工学院出版社','教育教辅'),
(9,'五年高考三年模拟','1002','成龙',70,'成龙出版社','教育教辅'),
(10,'宇宙的起源','1003','史蒂芬霍金',99,'史蒂夫出版社','科普'),
(11,'秘密花园','1004','范冰冰',88,'范冰冰出版社','小说'),
(13,'明朝那些事儿','1005','犀利哥',99,'李白出版社','历史');

/*Table structure for table `booktype` */

DROP TABLE IF EXISTS `booktype`;

CREATE TABLE `booktype` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=gbk;

/*Data for the table `booktype` */

insert  into `booktype`(`tid`,`name`) values 
(7,'名人传记'),
(6,'科普'),
(5,'世界名著'),
(8,'历史'),
(9,'教育教辅'),
(10,'小说');

/*Table structure for table `history` */

DROP TABLE IF EXISTS `history`;

CREATE TABLE `history` (
  `hid` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) DEFAULT NULL,
  `bid` int(11) DEFAULT NULL,
  `card` char(255) DEFAULT NULL,
  `bookname` char(255) DEFAULT NULL,
  `adminname` char(255) DEFAULT NULL,
  `username` char(255) DEFAULT NULL,
  `begintime` char(255) DEFAULT NULL,
  `endtime` char(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`hid`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `history` */

insert  into `history`(`hid`,`aid`,`bid`,`card`,`bookname`,`adminname`,`username`,`begintime`,`endtime`,`status`) values 
(12,9,6,'1000','三国演义','8888','小绿','2020-3-30','2020-5-15',0),
(11,9,7,'1001','红楼梦','8888','小绿','2020-3-30','2020-4-30',1),
(10,9,8,'6666','java修炼之道','8888','小绿','2020-2-30','2020-2-30',0),
(9,9,9,'1002','五年高考三年模拟','8888','小绿','2020-2-30','2020-2-30',0),
(8,9,7,'1001','红楼梦','8888','小绿','2020-2-30','2020-2-30',0),
(7,9,11,'1004','秘密花园','8888','小绿','2020-2-30','2020-2-30',0),
(13,7,7,'1001','红楼梦','1001','小白','2020-3-30','2020-2-30',0),
(14,7,11,'1004','秘密花园','1001','小白','2020-3-30','2020-4-30',1),
(15,9,7,'1001','红楼梦','8888','小绿','2020-5-15','2020-6-15',1),
(16,9,7,'1001','红楼梦','8888','小绿','2020-5-15','2020-6-15',1),
(17,9,7,'1001','红楼梦','8888','小绿','2020-5-15','2020-5-15',0),
(18,9,6,'1000','三国演义','8888','小绿','2020-5-15','2020-6-15',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
