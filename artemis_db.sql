-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 15, 2016 at 11:29 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `artemis_db`
--
CREATE DATABASE IF NOT EXISTS `artemis_db` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `artemis_db`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addInstitute`(IN `id` VARCHAR(100), IN `des` TEXT, IN `color` VARCHAR(255), IN `status` VARCHAR(200))
BEGIN
insert into institutes values(id,des,color,status);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addProgram`(IN `id` VARCHAR(100), IN `description` VARCHAR(255), IN `facilitator` VARCHAR(100))
INSERT INTO programs VALUES (id,description,facilitator)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addRoom`(IN `id` VARCHAR(100), IN `d` TEXT, IN `inst_id` VARCHAR(100), IN `status` VARCHAR(200))
BEGIN
insert into rooms values(id,d,inst_id,status);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addSchedule`(IN `st` TIME, IN `et` TIME, IN `days` VARCHAR(255), IN `section` VARCHAR(10), IN `sbj_id` VARCHAR(255), IN `room_id` VARCHAR(255), IN `teacher_id` VARCHAR(255), IN `inst_id` VARCHAR(100), IN `sy` VARCHAR(100), IN `session_type` VARCHAR(100))
BEGIN
insert into class_sched values(null,st,et,days,section,session_type,sbj_id,room_id,
teacher_id,inst_id,sy);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addSchoolYear`(IN `sy` VARCHAR(255), IN `status` VARCHAR(200))
BEGIN
insert into school_year values(sy,status);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addSubject`(IN `id` VARCHAR(100), IN `dc` TEXT, IN `lec` TINYINT, IN `lab` TINYINT, IN `pf` VARCHAR(100))
BEGIN
insert into subjects values(id,dc,lec,lab,pf);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addTeacher`(IN `id` VARCHAR(255),IN `fn` VARCHAR(255), IN `ln` VARCHAR(255), IN `gender` VARCHAR(255), IN `inst_id` VARCHAR(100))
BEGIN
insert into teachers values(id,fn,ln,gender,inst_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addUserAccount`(firstname varchar(255),
lastname varchar(255),gender varchar(10),op varchar(100),inst varchar(100),
access varchar(100),un varchar(255),pw varchar(255))
BEGIN
insert into user_accounts values(null,firstname,lastname,gender,op,inst,access,un,pw);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dayConflicts`(rid varchar(100),st time,et time,school_year varchar(100))
BEGIN
#params(room,st,et,sy)
#this procedure shows the schedule with conflicts to the parameter
select * from class_sched 
where room_id = rid and !(st <= start_time and et <= start_time or
 st >= end_time and et >= end_time) and sy = school_year;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getRoomClassSched`(IN `r_id` VARCHAR(100), IN `d` VARCHAR(100))
BEGIN
select * from class_sched
where room_id = r_id and `day` = d;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showActiveRoomsByInstitute`(IN `i` VARCHAR(100))
SELECT *
FROM rooms
WHERE institute_id = i AND access_status = 'Active'
ORDER BY id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showActiveSchoolYear`()
BEGIN
select * from school_year where access_status = 'Active';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllActiveInstitutes`()
SELECT * FROM institutes WHERE access_status = 'Active'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllActiveRooms`()
SELECT * FROM rooms WHERE access_status='Active'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllInstitutes`()
BEGIN
select * from institutes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllPrograms`()
SELECT * FROM programs$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllRooms`()
BEGIN
select * from rooms
order by id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllSchoolYear`()
BEGIN
select * from school_year;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllSubjects`()
BEGIN
select * from subjects;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllTeachers`()
select * from teachers order by lastname asc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllTeachersByInstitute`(IN `inst` VARCHAR(255))
SELECT * FROM teachers WHERE institute_id = inst
 order by lastname asc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllUserAccounts`()
BEGIN
 select id,firstname,lastname,gender,access_type,institute,access_status,username from user_accounts;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showRoomsByInstitute`(i varchar(255))
BEGIN
select * from rooms
where institute_id = i
order by id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showTeachersPopulation`(IN `gen` VARCHAR(100))
SELECT institute_id,count(id)as count,gender FROM teachers
WHERE gender= gen
GROUP BY institute_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `class_sched`
--

CREATE TABLE IF NOT EXISTS `class_sched` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `day` varchar(255) NOT NULL,
  `section` varchar(10) NOT NULL,
  `session_type` varchar(100) NOT NULL,
  `subject_id` varchar(100) NOT NULL,
  `room_id` varchar(100) NOT NULL,
  `teacher_id` varchar(255) NOT NULL,
  `institute_id` varchar(100) NOT NULL,
  `sy` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `institute_id` (`institute_id`),
  KEY `room_id` (`room_id`),
  KEY `subject_id` (`subject_id`),
  KEY `teacher_id` (`teacher_id`),
  KEY `sy` (`sy`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=160 ;

--
-- Dumping data for table `class_sched`
--

INSERT INTO `class_sched` (`id`, `start_time`, `end_time`, `day`, `section`, `session_type`, `subject_id`, `room_id`, `teacher_id`, `institute_id`, `sy`) VALUES
(131, '08:00:00', '10:00:00', 'Tue', 'BSED-1A', 'LEC', 'EDUC 124', 'ED101', '11', 'IETT', '2015-2016 1st Semester'),
(132, '08:00:00', '10:00:00', 'Thu', 'BSED-1A', 'LEC', 'EDUC 124', 'ED101', '11', 'IETT', '2015-2016 1st Semester'),
(133, '13:00:00', '13:30:00', 'Mon', 'BSED-1A', 'LEC', 'EDUC11144', 'MS2', '11', 'IETT', '2015-2016 1st Semester'),
(134, '13:00:00', '13:30:00', 'Wed', 'BSED-1A', 'LEC', 'EDUC11144', 'MS2', '11', 'IETT', '2015-2016 1st Semester'),
(135, '13:00:00', '13:30:00', 'Fri', 'BSED-1A', 'LEC', 'EDUC11144', 'MS2', '11', 'IETT', '2015-2016 1st Semester'),
(138, '07:00:00', '08:00:00', 'Mon', 'BAT-1A', 'LEC', 'POLSCI 1', 'AG101', '14', 'IALS', '2015-2016 1st Semester'),
(139, '07:00:00', '08:00:00', 'Wed', 'BAT-1A', 'LEC', 'POLSCI 1', 'AG101', '14', 'IALS', '2015-2016 1st Semester'),
(140, '08:00:00', '09:00:00', 'Mon', 'BSCE-1A', 'LEC', 'IT100', 'CL1', '6', 'ICE', '2015-2016 1st Semester'),
(141, '08:00:00', '09:00:00', 'Wed', 'BSCE-1A', 'LEC', 'IT100', 'CL1', '6', 'ICE', '2015-2016 1st Semester'),
(142, '08:00:00', '09:00:00', 'Fri', 'BSCE-1A', 'LEC', 'IT100', 'CL1', '6', 'ICE', '2015-2016 1st Semester'),
(143, '08:00:00', '09:30:00', 'Tue', 'BITM-1A', 'LEC', 'IT115', 'AG101', '10', 'ICE', '2015-2016 1st Semester'),
(144, '08:00:00', '09:30:00', 'Thu', 'BITM-1A', 'LEC', 'IT115', 'AG101', '10', 'ICE', '2015-2016 1st Semester'),
(145, '07:00:00', '08:00:00', 'Mon', 'BSIT-1B', 'LAB', 'IT101', 'CL2', '2', 'ICE', '2015-2016 1st Semester'),
(146, '07:00:00', '08:00:00', 'Wed', 'BSIT-1B', 'LAB', 'IT101', 'CL2', '2', 'ICE', '2015-2016 1st Semester'),
(147, '07:00:00', '08:00:00', 'Fri', 'BSIT-1B', 'LAB', 'IT101', 'CL2', '2', 'ICE', '2015-2016 1st Semester'),
(148, '12:00:00', '13:00:00', 'Mon', 'BITM-1B', 'LEC', 'IT100', 'CL1', '6', 'ICE', '2015-2016 1st Semester'),
(149, '12:00:00', '13:00:00', 'Wed', 'BITM-1B', 'LEC', 'IT100', 'CL1', '6', 'ICE', '2015-2016 1st Semester'),
(150, '12:00:00', '13:00:00', 'Fri', 'BITM-1B', 'LEC', 'IT100', 'CL1', '6', 'ICE', '2015-2016 1st Semester'),
(151, '09:00:00', '10:00:00', 'Mon', 'BITM-2A', 'LAB', 'IT114', 'CL1', '2', 'ICE', '2015-2016 1st Semester'),
(152, '09:00:00', '10:00:00', 'Wed', 'BITM-2A', 'LAB', 'IT114', 'CL1', '2', 'ICE', '2015-2016 1st Semester'),
(153, '09:00:00', '10:00:00', 'Fri', 'BITM-2A', 'LAB', 'IT114', 'CL1', '2', 'ICE', '2015-2016 1st Semester'),
(154, '10:00:00', '11:00:00', 'Mon', 'BITM-2A', 'LAB', 'IT114', 'CL1', '2', 'ICE', '2015-2016 1st Semester'),
(155, '10:00:00', '11:00:00', 'Wed', 'BITM-2A', 'LAB', 'IT114', 'CL1', '2', 'ICE', '2015-2016 1st Semester'),
(156, '10:00:00', '11:00:00', 'Fri', 'BITM-2A', 'LAB', 'IT114', 'CL1', '2', 'ICE', '2015-2016 1st Semester'),
(158, '10:00:00', '11:30:00', 'Tue', 'BAT-1A', 'LEC', 'POLSCI 1', 'AG101', '15', 'IALS', '2015-2016 1st Semester'),
(159, '10:00:00', '11:30:00', 'Thu', 'BAT-1A', 'LEC', 'POLSCI 1', 'AG101', '15', 'IALS', '2015-2016 1st Semester');

-- --------------------------------------------------------

--
-- Table structure for table `institutes`
--

CREATE TABLE IF NOT EXISTS `institutes` (
  `id` varchar(100) NOT NULL,
  `description` text,
  `color` varchar(255) DEFAULT NULL,
  `access_status` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `institutes`
--

INSERT INTO `institutes` (`id`, `description`, `color`, `access_status`) VALUES
('IALS', 'Institute of Agriculture and Life Sciences', '0:204:102', 'Active'),
('IBPA', 'Institute of Business and Public Affairs', '255:102:102', 'Active'),
('ICE', 'Intstitute of Computing and Engineering', '255:153:51', 'Active'),
('IETT', 'Institute of Education and Teachers Training', '51:153:255', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE IF NOT EXISTS `programs` (
  `id` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `facilitator` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `facilitator` (`facilitator`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `programs`
--

INSERT INTO `programs` (`id`, `description`, `facilitator`) VALUES
('BAT', 'Bachelor of Science in Agricultural Technology', 'IALS'),
('BITM', 'Bachelor of Industrial Technology Management', 'ICE'),
('BS-CRIM', 'Bachelor of Science in Criminology', 'IBPA'),
('BSBA', 'Bachelor of Science in Business Administration', 'IBPA'),
('BSCE', 'Bachelor of Science in Civil Engineering', 'ICE'),
('BSED', 'Bachelor of Science in Education', 'IETT'),
('BSHRM', 'Bachelor of Science in Hotel & Restaurant Management', 'IALS'),
('BSIT', 'Bachelor of Science in Information Technology', 'ICE'),
('BSN', 'Bachelor of Science in Nursing', 'IALS'),
('EDP', 'Electronic Data Processing', 'ICE');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE IF NOT EXISTS `rooms` (
  `id` varchar(100) NOT NULL,
  `description` text,
  `institute_id` varchar(100) NOT NULL,
  `access_status` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `institute_id` (`institute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `description`, `institute_id`, `access_status`) VALUES
('AG101', 'Agriculture Room', 'IALS', 'Active'),
('AG102', 'Agriculture Room', 'IALS', 'Active'),
('CL1', 'Computer Lab 1', 'ICE', 'Active'),
('CL2', 'Computer Lab 2', 'ICE', 'Active'),
('CL3', 'Comp Lab 3', 'ICE', 'Active'),
('CL4', 'Comp Lab 4', 'ICE', 'Active'),
('CL5', 'Comp Lab 5', 'ICE', 'Active'),
('ED101', 'Eudcation 101', 'IETT', 'Active'),
('G4', 'Gym 4', 'IBPA', 'Draft'),
('H2', 'Hrm 2', 'IBPA', 'Archived'),
('H7', 'Hotel 7', 'IBPA', 'Active'),
('H8', 'Hrm 8', 'IBPA', 'Archived'),
('ML1', 'Multimedia Lab 1', 'ICE', 'Active'),
('MS1', '<Unidentified Yet>', 'IALS', 'Active'),
('MS2', 'Ambot', 'IALS', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `school_year`
--

CREATE TABLE IF NOT EXISTS `school_year` (
  `sy_sem` varchar(255) NOT NULL,
  `access_status` varchar(200) NOT NULL,
  PRIMARY KEY (`sy_sem`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `school_year`
--

INSERT INTO `school_year` (`sy_sem`, `access_status`) VALUES
('2015-2016 1st Semester', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE IF NOT EXISTS `subjects` (
  `id` varchar(100) NOT NULL,
  `description` text,
  `lect_units` tinyint(4) DEFAULT NULL,
  `lab_units` tinyint(4) DEFAULT NULL,
  `program_facilitator` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `program_facilitator` (`program_facilitator`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `description`, `lect_units`, `lab_units`, `program_facilitator`) VALUES
('EDUC 124', 'Facilitating Learning', 3, 1, 'IETT'),
('EDUC11144', 'wegwegwe', 3, 0, 'IETT'),
('EDUC114', 'Principles of Learning', 4, 0, 'IETT'),
('HUM1', 'Humanities 101', 3, 0, 'IALS'),
('IT100', 'esvsebsrbs', 3, 0, 'ICE'),
('IT101', 'wefwef', 3, 3, 'ICE'),
('IT114', 'afs', 3, 4, 'ICE'),
('IT115', 'wefnwle', 3, 0, 'ICE'),
('IT123', 'asfsf', 3, 3, 'ICE'),
('IT158', 'Mobile Programming', 3, 3, 'ICE'),
('LEA2', 'ambot', 3, 3, 'IBPA'),
('MATH101', 'Algebra', 3, 0, 'ICE'),
('POLSCI 1', 'Political Science', 3, 0, 'IALS');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE IF NOT EXISTS `teachers` (
  `id` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `institute_id` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `institute_id` (`institute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `firstname`, `lastname`, `gender`, `institute_id`) VALUES
('1', 'Dony', 'Dongiapon', 'Male', 'ICE'),
('10', 'Jay Paul', 'Gonzaga', 'Male', 'ICE'),
('11', 'Jun-jun', 'Negro', 'Male', 'IETT'),
('12', 'Rodrigo', 'Duterte', 'Male', 'IETT'),
('123421-123', 'Jefferson', 'Buot', 'Male', 'ICE'),
('13', 'Marumi', 'Roxas', 'Male', 'IBPA'),
('14', 'Gracia', 'Poe', 'Female', 'IALS'),
('15', 'Cindy', 'Lasco', 'Female', 'IALS'),
('2', 'Lanie', 'Laureano', 'Female', 'ICE'),
('23452-235', 'Lyza', 'Soberano', 'Female', 'ICE'),
('3', 'Don John Jays', 'Dela Cruz', 'Male', 'IBPA'),
('34234-234', 'Julius', 'Ambot', 'Male', 'ICE'),
('3efwe', 'fwefw', 'wef', 'Male', 'ICE'),
('4', 'Donyarita Maria Josifenawwegweg', 'Tagapagtanggols', 'Female', 'IALS'),
('5', 'Idonu', 'Watosay', 'Male', 'IBPA'),
('6', 'Jean', 'Eballe', 'Female', 'ICE'),
('7', 'Wail', 'He', 'Male', 'IALS'),
('8', 'Jeah', 'Gonzales', 'Male', 'IETT'),
('9', 'Dianne', 'Reyes', 'Female', 'IBPA'),
('aef', 'aef', 'awf', 'Male', 'ICE'),
('kj', 'kjh', 'kj', 'Male', 'ICE');

-- --------------------------------------------------------

--
-- Table structure for table `user_accounts`
--

CREATE TABLE IF NOT EXISTS `user_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `access_type` varchar(100) DEFAULT NULL,
  `institute` varchar(100) NOT NULL,
  `access_status` varchar(100) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `user_password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `user_accounts`
--

INSERT INTO `user_accounts` (`id`, `firstname`, `lastname`, `gender`, `access_type`, `institute`, `access_status`, `username`, `user_password`) VALUES
(1, 'Jefferson', 'Buot', 'Male', 'Institute Admin', 'ICE', 'Active', 'jeff', 'qvcqczohs'),
(2, 'Neilza', 'Buot', 'Female', 'Institute Admin', 'IBPA', 'Draft', 'jez', 'qvcqczohs'),
(3, 'Soliven Jess', 'Montillado', 'Male', 'View Only', 'N/A', 'Active', 'soliven_25', 'acbhwzzorc'),
(4, 'Chuckie', 'Gumobao', 'Male', 'View Only', 'N/A', 'Active', 'chuckie', 'qviqywsuom'),
(5, 'Rey', 'Sumaylo', 'Male', 'View Only', 'N/A', 'Active', 'CoolDev', 'fsmgiaomzc'),
(6, 'User', 'User', 'Male', 'View Only', 'N/A', 'Active', 'user', 'doggkcfr'),
(7, 'Jestony', 'Pagayon', 'Male', 'Institute Admin', 'IALS', 'Active', 'Jestony', 'qvcqczohs'),
(8, 'Blythe', 'Lobrigas', 'Male', 'Institute Admin', 'IBPA', 'Active', 'blythe', 'qodgzcqy2293'),
(9, 'Jocelyn', 'Arles', 'Female', 'Institute Admin', 'IETT', 'Active', 'jocelyn', 'xc123456'),
(10, 'Danver', 'Palmiano', 'Male', 'Institute Admin', 'IALS', 'Active', 'danver', 'robjsf08');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `class_sched`
--
ALTER TABLE `class_sched`
  ADD CONSTRAINT `class_sched_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `class_sched_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `class_sched_ibfk_3` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `class_sched_ibfk_4` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `class_sched_ibfk_5` FOREIGN KEY (`sy`) REFERENCES `school_year` (`sy_sem`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `programs`
--
ALTER TABLE `programs`
  ADD CONSTRAINT `programs_ibfk_1` FOREIGN KEY (`facilitator`) REFERENCES `institutes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `subjects_ibfk_1` FOREIGN KEY (`program_facilitator`) REFERENCES `institutes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
