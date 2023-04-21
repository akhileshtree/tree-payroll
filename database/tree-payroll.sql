-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 20, 2023 at 01:53 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tree-payroll`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `prosavesessionmanagement` (IN `s_UserId` INT, IN `s_UserType` VARCHAR(15), IN `s_IpAddress` VARCHAR(20), IN `s_Country` VARCHAR(30), IN `s_LoginTime` DATETIME, IN `s_LogoutTime` DATETIME, IN `s_LoginType` VARCHAR(10), `s_RandId` VARCHAR(100))   insert into tbl_sessionmanagement(UserId,UserType,IpAddress,Country,LoginTime,LogoutTime,LoginType,RandId) 
values(s_UserId,s_UserType,s_IpAddress,s_Country,s_LoginTime,s_LogoutTime,s_LoginType,s_RandId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proupdatesessionmanagement` (IN `s_LogoutTime` DATETIME, IN `s_RandId` VARCHAR(100))   update tbl_sessionmanagement set LogoutTime=s_LogoutTime where RandId=s_RandId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prouserlogin` (IN `sp_uname` VARCHAR(100), IN `sp_pswd` VARCHAR(50), IN `sp_cid` INT)   select * from tbl_register where UserName=sp_uname and Password=md5(sp_pswd) and department_type_id= sp_cid and Status='0'$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_adminuser`
--

CREATE TABLE `tbl_adminuser` (
  `Sno` int(11) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Mobile` varchar(50) NOT NULL,
  `EMail` varchar(200) NOT NULL,
  `UserName` varchar(100) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Default_Password` varchar(100) NOT NULL,
  `RepSenior` varchar(200) NOT NULL,
  `UserType` varchar(50) NOT NULL,
  `SecureId` int(11) NOT NULL,
  `IpAddress` varchar(20) NOT NULL,
  `Status` int(11) NOT NULL,
  `Crdate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `LastLogin` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tbl_adminuser`
--

INSERT INTO `tbl_adminuser` (`Sno`, `Name`, `Mobile`, `EMail`, `UserName`, `Password`, `Default_Password`, `RepSenior`, `UserType`, `SecureId`, `IpAddress`, `Status`, `Crdate`, `LastLogin`) VALUES
(1, 'Administrator', '', 'admin@admin.com', 'admin', '21232f297a57a5a743894a0e4a801fc3', '', 'admin', 'admin', 1, '192.168.1.2', 0, '2013-08-05 05:04:31', '2012-05-14 15:42:21'),
(2, 'Praveen', '9997071506', 'pu1984@gmail.com', 'praveen', 'b499a35423259a61d1731e1443b748be', '', 'admin', 'admin', 0, '192.168.1.2', 0, '2013-08-09 08:11:05', '2012-05-14 15:42:21');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_attendance`
--

CREATE TABLE `tbl_attendance` (
  `id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `attendance_status` varchar(20) DEFAULT NULL,
  `attendance_date` datetime NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_department`
--

CREATE TABLE `tbl_department` (
  `depatment_id` int(11) NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `note` varchar(255) DEFAULT 'N/A',
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_department`
--

INSERT INTO `tbl_department` (`depatment_id`, `department_name`, `note`, `status`) VALUES
(1, 'Software Developer', '', 0),
(2, 'word press developer', '', 0),
(3, 'marketing', '', 0),
(4, 'Digital markting', '', 0),
(5, 'SEO', '', 0),
(6, 'Data entery', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_employee`
--

CREATE TABLE `tbl_employee` (
  `id` int(11) NOT NULL,
  `emp_id` varchar(11) NOT NULL,
  `emp_card_no` varchar(50) NOT NULL,
  `emp_name` varchar(50) NOT NULL,
  `emp_email` varchar(255) NOT NULL,
  `emp_ph_no` varchar(25) NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `maritalstatus` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `pan_number` varchar(50) DEFAULT NULL,
  `adhar_number` varchar(50) DEFAULT NULL,
  `blood_group` varchar(25) NOT NULL,
  `department` int(10) NOT NULL,
  `designation` int(10) NOT NULL,
  `salary` decimal(12,2) NOT NULL,
  `worktype` varchar(20) NOT NULL,
  `joiningdate` date NOT NULL,
  `leavingdate` date NOT NULL,
  `p_name` varchar(50) NOT NULL,
  `p_number` varchar(20) NOT NULL,
  `p_relation` varchar(20) NOT NULL,
  `p_address` text NOT NULL,
  `bankname` varchar(50) NOT NULL,
  `bank_branch` varchar(255) NOT NULL,
  `accnumber` varchar(20) NOT NULL,
  `accname` varchar(20) NOT NULL,
  `ifscno` varchar(20) NOT NULL,
  `acctype` varchar(20) NOT NULL,
  `emp_image` varchar(50) NOT NULL,
  `emp_status` varchar(20) NOT NULL DEFAULT 'active',
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_employee`
--

INSERT INTO `tbl_employee` (`id`, `emp_id`, `emp_card_no`, `emp_name`, `emp_email`, `emp_ph_no`, `dob`, `gender`, `maritalstatus`, `address`, `pan_number`, `adhar_number`, `blood_group`, `department`, `designation`, `salary`, `worktype`, `joiningdate`, `leavingdate`, `p_name`, `p_number`, `p_relation`, `p_address`, `bankname`, `bank_branch`, `accnumber`, `accname`, `ifscno`, `acctype`, `emp_image`, `emp_status`, `date`) VALUES
(1005, 'TREE1003', '102', 'Aman Bisht', 'aman123@gmail.com', '7654321890', '1996-12-01', 'M', 'married', 'The Mall Road Mussoorie Uttarakhand  ', 'PANCARD1234', 'caedno123', 'O+', 2, 2, '20000.00', 'ft', '2018-01-01', '2022-08-24', 'Mumma', '1111111111', 'mother', 'The Mall Road Mussoorie Uttarakhand  ', 'State Bank Of India', 'DHARAMPUR', '876556566755', 'Amanbisht', 'SBIN0005475', 'Saving', '20220818105330.jpg', 'active', '2022-08-18 08:53:30'),
(1006, 'TREE1006', '103', 'Test', 'abc@gmail.com', '7456034448', '2001-10-13', 'M', 'married', 'Qwerty', 'EUTIOERUTIOE48594', '123456789012', 'O+', 3, 1, '10000.00', 'part', '2022-10-01', '0000-00-00', '', '', ' ', '', 'State Bank Of India', 'DHARAMPUR', '234567890', 'My Full Name', 'SBIN0005475', 'Saving', '20221013100148.png', 'active', '2022-10-13 08:01:48');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_register`
--

CREATE TABLE `tbl_register` (
  `Sno` int(11) NOT NULL,
  `companyName` varchar(200) NOT NULL DEFAULT 'Tree Multisoft services',
  `department_type_id` int(12) NOT NULL,
  `UserName` varchar(50) DEFAULT NULL,
  `Name` varchar(255) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `passStatus` int(11) NOT NULL DEFAULT 0,
  `sesion_id` varchar(100) NOT NULL,
  `Address` varchar(200) NOT NULL,
  `c_person` varchar(100) NOT NULL,
  `mobileNo` varchar(255) NOT NULL,
  `emailId` varchar(50) NOT NULL,
  `website` varchar(255) NOT NULL,
  `Remarks` varchar(200) NOT NULL,
  `sideBar` varchar(255) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `Role` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tbl_register`
--

INSERT INTO `tbl_register` (`Sno`, `companyName`, `department_type_id`, `UserName`, `Name`, `Password`, `passStatus`, `sesion_id`, `Address`, `c_person`, `mobileNo`, `emailId`, `website`, `Remarks`, `sideBar`, `photo`, `Role`, `status`) VALUES
(1, 'Tree Multisoft services', 0, 'admin', 'TREE MULTISOFT', '202cb962ac59075b964b07152d234b70', 0, '61unf7iisiftisppnsfvkt7agb', '10-B Mothorowala Road, Near Rawat Wedding Point and opp. PNB Bank, Ajabpur Kalan Dehradun,248001, Uttarakhand, India', '', '5555897896', 'infotech@treemultisoft.com', 'www.treemultisoft.com', '', '1,2,3,4,5', '20220830070344.jpg', 'admin', 0),
(78, 'Tree Multisoft services', 0, 'abijalwan3@gmail.com', 'TREE1006', '202cb962ac59075b964b07152d234b70', 0, 'gn8r9aualvcj6jjhh12p0fke06', 'Dehradun', '', '7579124918', 'abijalwan3@gmail.com', '', '', '', '20220830071737.jpg', 'user', 0),
(79, 'Tree Multisoft services', 0, 'gbijalwan5@gmail.com', 'TREE1007', '202cb962ac59075b964b07152d234b70', 0, '', 'Dehradun', '', '7456034448', 'gbijalwan5@gmail.com', '', '', '', '20220830022016.jpg', 'user', 1),
(80, 'Tree Multisoft services', 0, 'aman123@gmail.com', 'TREE1003', '21232f297a57a5a743894a0e4a801fc3', 0, 'vsl5o73tg98c9ajs11h5kgvu65', 'The Mall Road Mussoorie Uttarakhand  ', '', '7654321890', 'aman123@gmail.com', '', '', '', '20220818105330.jpg', 'user', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_services`
--

CREATE TABLE `tbl_services` (
  `service_id` int(11) NOT NULL,
  `service` varchar(100) NOT NULL,
  `note` varchar(255) NOT NULL,
  `status` int(1) NOT NULL,
  `crDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tbl_services`
--

INSERT INTO `tbl_services` (`service_id`, `service`, `note`, `status`, `crDate`) VALUES
(3, 'Website', '', 0, '2022-03-08 02:04:25'),
(2, 'Software', '', 0, '2022-03-08 02:04:20'),
(4, 'Digital Marketing', '', 0, '2022-04-20 10:25:26'),
(5, 'Bulk SMS', '', 0, '2022-03-31 04:18:23'),
(11, 'Voice Call', '', 0, '2022-05-09 06:58:23'),
(1, 'Domain and Hosting', '', 0, '2022-01-17 02:19:16');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_sessionmanagement`
--

CREATE TABLE `tbl_sessionmanagement` (
  `Sno` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `UserType` varchar(15) NOT NULL,
  `IpAddress` varchar(20) NOT NULL,
  `Country` varchar(30) NOT NULL,
  `LoginTime` datetime NOT NULL,
  `LogoutTime` datetime NOT NULL,
  `LoginType` varchar(10) NOT NULL,
  `RandId` varchar(100) NOT NULL,
  `CrDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tbl_sessionmanagement`
--

INSERT INTO `tbl_sessionmanagement` (`Sno`, `UserId`, `UserType`, `IpAddress`, `Country`, `LoginTime`, `LogoutTime`, `LoginType`, `RandId`, `CrDate`) VALUES
(87, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-10 19:31:12', '2014-02-10 19:31:13', 'SuperAdmin', '32525', '2014-02-10 08:31:13'),
(88, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-11 10:53:14', '2014-02-11 11:01:45', 'SuperAdmin', '27934', '2014-02-11 00:01:45'),
(89, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-11 17:53:39', '2014-02-11 17:53:40', 'SuperAdmin', '22807', '2014-02-11 06:53:40'),
(90, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-11 19:12:13', '2014-02-11 19:13:08', 'SuperAdmin', '1294', '2014-02-11 08:13:08'),
(91, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 11:49:53', '2014-02-18 11:56:35', 'SuperAdmin', '4304', '2014-02-18 00:56:35'),
(92, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 11:56:53', '2014-02-18 11:58:17', 'SuperAdmin', '14537', '2014-02-18 00:58:17'),
(93, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 11:58:29', '2014-02-18 12:07:01', 'SuperAdmin', '12560', '2014-02-18 01:07:01'),
(94, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 12:07:11', '2014-02-18 12:26:30', 'SuperAdmin', '29705', '2014-02-18 01:26:30'),
(95, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 12:30:03', '2014-02-18 12:31:15', 'SuperAdmin', '26477', '2014-02-18 01:31:15'),
(96, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 13:40:05', '2014-02-18 13:40:27', 'SuperAdmin', '4396', '2014-02-18 02:40:27'),
(97, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 14:16:31', '2014-02-18 15:06:50', 'SuperAdmin', '26613', '2014-02-18 04:06:50'),
(98, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 15:41:04', '2014-02-18 15:53:19', 'SuperAdmin', '6538', '2014-02-18 04:53:19'),
(99, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 16:45:57', '2014-02-18 17:21:17', 'SuperAdmin', '22030', '2014-02-18 06:21:17'),
(100, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 18:07:28', '2014-02-18 19:20:19', 'SuperAdmin', '10803', '2014-02-18 08:20:19'),
(101, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 13:42:11', '2014-02-20 13:42:13', 'SuperAdmin', '7397', '2014-02-20 02:42:13'),
(102, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 14:35:53', '2014-02-20 14:35:54', 'SuperAdmin', '26578', '2014-02-20 03:35:54'),
(103, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 15:14:21', '2014-02-20 17:06:59', 'SuperAdmin', '4444', '2014-02-20 06:06:59'),
(104, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 17:07:12', '2014-02-20 17:07:57', 'SuperAdmin', '16837', '2014-02-20 06:07:57'),
(105, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 17:08:08', '2014-02-20 17:11:52', 'SuperAdmin', '24739', '2014-02-20 06:11:52'),
(106, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 17:12:02', '2014-02-20 17:12:26', 'SuperAdmin', '32672', '2014-02-20 06:12:26'),
(107, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 17:12:36', '2014-02-20 17:12:50', 'SuperAdmin', '7269', '2014-02-20 06:12:50'),
(108, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 17:12:55', '2014-02-20 17:39:23', 'SuperAdmin', '30670', '2014-02-20 06:39:23'),
(109, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 19:58:23', '2014-02-20 19:58:23', 'SuperAdmin', '3386', '2014-02-20 08:58:23'),
(110, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 20:47:38', '2014-02-20 20:48:10', 'SuperAdmin', '5644', '2014-02-20 09:48:10'),
(111, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 20:48:28', '2014-02-20 20:54:08', 'SuperAdmin', '32235', '2014-02-20 09:54:08'),
(112, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 20:54:30', '2014-02-20 21:02:49', 'SuperAdmin', '26440', '2014-02-20 10:02:49'),
(113, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-21 11:08:14', '2014-02-21 11:24:46', 'SuperAdmin', '15189', '2014-02-21 00:24:46'),
(114, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-21 11:49:06', '2014-02-21 12:46:57', 'SuperAdmin', '18265', '2014-02-21 01:46:57'),
(115, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-21 15:20:20', '2014-02-21 15:20:20', 'SuperAdmin', '30447', '2014-02-21 04:20:20'),
(116, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-21 18:10:00', '2014-02-21 18:10:00', 'SuperAdmin', '14106', '2014-02-21 07:10:00'),
(117, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-21 19:01:14', '2014-02-21 19:28:02', 'SuperAdmin', '6625', '2014-02-21 08:28:02'),
(118, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-21 19:54:09', '2014-02-21 20:08:30', 'SuperAdmin', '22890', '2014-02-21 09:08:30'),
(119, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 07:29:45', '2014-02-22 07:29:45', 'SuperAdmin', '9349', '2014-02-21 20:29:45'),
(120, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 10:48:31', '2014-02-22 11:58:27', 'SuperAdmin', '17158', '2014-02-22 00:58:27'),
(121, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 13:31:03', '2014-02-22 13:48:21', 'SuperAdmin', '3675', '2014-02-22 02:48:21'),
(122, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 16:11:07', '2014-02-22 17:31:23', 'SuperAdmin', '1784', '2014-02-22 06:31:23'),
(123, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 17:10:52', '2014-02-22 17:10:52', 'SuperAdmin', '4683', '2014-02-22 06:10:52'),
(124, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 17:31:32', '2014-02-22 18:17:22', 'SuperAdmin', '3527', '2014-02-22 07:17:22'),
(125, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 20:19:40', '2014-02-22 20:20:02', 'SuperAdmin', '2403', '2014-02-22 09:20:02'),
(126, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 20:41:43', '2014-02-22 20:41:43', 'SuperAdmin', '12062', '2014-02-22 09:41:43'),
(127, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 11:00:56', '2014-02-25 11:03:09', 'SuperAdmin', '523', '2014-02-25 00:03:09'),
(128, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 13:22:31', '2014-02-25 13:47:27', 'SuperAdmin', '8741', '2014-02-25 02:47:27'),
(129, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 14:16:05', '2014-02-25 14:16:13', 'SuperAdmin', '13773', '2014-02-25 03:16:13'),
(130, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 15:35:29', '2014-02-25 16:04:31', 'SuperAdmin', '32762', '2014-02-25 05:04:31'),
(131, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 16:59:56', '2014-02-25 17:06:16', 'SuperAdmin', '13446', '2014-02-25 06:06:16'),
(132, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 17:06:42', '2014-02-25 17:06:50', 'SuperAdmin', '24803', '2014-02-25 06:06:50'),
(133, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 17:07:49', '2014-02-25 20:07:11', 'SuperAdmin', '22955', '2014-02-25 09:07:11'),
(134, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-26 16:48:21', '2014-02-26 17:14:52', 'SuperAdmin', '25839', '2014-02-26 06:14:52'),
(135, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-26 17:51:00', '2014-02-26 17:58:41', 'SuperAdmin', '4456', '2014-02-26 06:58:41'),
(136, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-01 11:59:46', '2014-03-01 14:37:47', 'SuperAdmin', '23509', '2014-03-01 03:37:47'),
(137, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 12:08:06', '2014-03-03 12:08:06', 'SuperAdmin', '16598', '2014-03-03 01:08:06'),
(138, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 13:36:05', '2014-03-03 13:36:43', 'SuperAdmin', '22657', '2014-03-03 02:36:43'),
(139, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 13:37:24', '2014-03-03 13:37:24', 'SuperAdmin', '25669', '2014-03-03 02:37:24'),
(140, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 13:58:36', '2014-03-03 14:05:55', 'SuperAdmin', '5731', '2014-03-03 03:05:55'),
(141, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 14:27:36', '2014-03-03 14:38:08', 'SuperAdmin', '32599', '2014-03-03 03:38:08'),
(142, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 15:37:21', '2014-03-03 18:29:48', 'SuperAdmin', '25184', '2014-03-03 07:29:48'),
(143, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 18:31:30', '2014-03-03 19:03:39', 'SuperAdmin', '24063', '2014-03-03 08:03:39'),
(144, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-04 10:39:28', '2014-03-04 10:46:53', 'SuperAdmin', '28209', '2014-03-03 23:46:53'),
(145, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-04 17:21:22', '2014-03-04 17:30:30', 'SuperAdmin', '2326', '2014-03-04 06:30:30'),
(146, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-05 11:34:18', '2014-03-05 11:34:31', 'SuperAdmin', '2005', '2014-03-05 00:34:31'),
(147, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-05 12:24:25', '2014-03-05 12:41:21', 'SuperAdmin', '26522', '2014-03-05 01:41:21'),
(148, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-05 15:55:51', '2014-03-05 16:14:48', 'SuperAdmin', '14539', '2014-03-05 05:14:48'),
(149, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-05 17:55:56', '2014-03-05 20:07:49', 'SuperAdmin', '14504', '2014-03-05 09:07:49'),
(150, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-06 10:52:02', '2014-03-06 10:52:02', 'SuperAdmin', '32705', '2014-03-05 23:52:02'),
(151, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-06 11:39:34', '2014-03-06 12:49:22', 'SuperAdmin', '20466', '2014-03-06 01:49:22'),
(152, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-07 18:47:45', '2014-03-07 19:44:19', 'SuperAdmin', '23734', '2014-03-07 08:44:19'),
(153, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-08 10:37:29', '2014-03-08 11:50:16', 'SuperAdmin', '23548', '2014-03-08 00:50:16'),
(154, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-08 12:15:13', '2014-03-08 12:15:17', 'SuperAdmin', '3813', '2014-03-08 01:15:17'),
(155, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-08 12:42:38', '2014-03-08 12:46:19', 'SuperAdmin', '24147', '2014-03-08 01:46:19'),
(156, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-08 13:10:08', '2014-03-08 13:13:38', 'SuperAdmin', '14502', '2014-03-08 02:13:38'),
(157, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-08 13:36:59', '2014-03-08 14:12:07', 'SuperAdmin', '5292', '2014-03-08 03:12:07'),
(158, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-10 10:38:15', '2014-03-10 10:38:16', 'SuperAdmin', '30029', '2014-03-09 23:38:16'),
(159, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-10 10:59:27', '2014-03-10 12:14:37', 'SuperAdmin', '21355', '2014-03-10 01:14:37'),
(160, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-10 12:35:39', '2014-03-10 14:04:00', 'SuperAdmin', '20168', '2014-03-10 03:04:00'),
(161, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-10 15:55:28', '2014-03-10 17:24:15', 'SuperAdmin', '15498', '2014-03-10 06:24:15'),
(162, 1, 'admin', '127.0.0.1', '', '2014-03-10 17:48:28', '2014-03-10 18:02:29', 'SuperAdmin', '3956', '2014-03-10 07:02:29'),
(163, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-10 18:22:45', '2014-03-10 20:24:05', 'SuperAdmin', '1299', '2014-03-10 09:24:05'),
(164, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-11 13:47:10', '2014-03-11 15:31:28', 'SuperAdmin', '18207', '2014-03-11 04:31:28'),
(165, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-11 16:04:25', '2014-03-11 16:23:38', 'SuperAdmin', '10369', '2014-03-11 05:23:38'),
(166, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-11 17:07:06', '2014-03-11 17:54:47', 'SuperAdmin', '15654', '2014-03-11 06:54:47'),
(167, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-12 11:28:40', '2014-03-12 16:23:46', 'SuperAdmin', '8719', '2014-03-12 05:23:46'),
(168, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-12 16:44:01', '2014-03-12 16:52:15', 'SuperAdmin', '1812', '2014-03-12 05:52:15'),
(169, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-12 18:35:15', '2014-03-12 18:41:47', 'SuperAdmin', '4053', '2014-03-12 07:41:47'),
(170, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-12 19:05:48', '2014-03-12 19:08:40', 'SuperAdmin', '27244', '2014-03-12 08:08:40'),
(171, 1, 'admin', '127.0.0.1', '', '2014-03-12 19:31:49', '2014-03-12 20:46:29', 'SuperAdmin', '20523', '2014-03-12 09:46:29'),
(172, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-13 14:06:22', '2014-03-13 14:09:05', 'SuperAdmin', '27206', '2014-03-13 03:09:05'),
(173, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-14 19:51:34', '2014-03-14 19:53:52', 'SuperAdmin', '28344', '2014-03-14 08:53:52'),
(174, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 10:52:29', '2014-03-15 11:07:55', 'SuperAdmin', '29999', '2014-03-15 00:07:55'),
(175, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 12:10:11', '2014-03-15 12:16:13', 'SuperAdmin', '25745', '2014-03-15 01:16:13'),
(176, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 12:37:35', '2014-03-15 14:29:36', 'SuperAdmin', '26162', '2014-03-15 03:29:36'),
(177, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 15:14:57', '2014-03-15 15:51:43', 'SuperAdmin', '12278', '2014-03-15 04:51:43'),
(178, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 15:51:49', '2014-03-15 16:49:19', 'SuperAdmin', '15389', '2014-03-15 05:49:19'),
(179, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 17:17:58', '2014-03-15 17:21:44', 'SuperAdmin', '4087', '2014-03-15 06:21:44'),
(180, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 17:44:05', '2014-03-15 18:13:22', 'SuperAdmin', '22090', '2014-03-15 07:13:22'),
(181, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 18:37:30', '2014-03-15 18:49:58', 'SuperAdmin', '15972', '2014-03-15 07:49:58'),
(182, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 19:11:41', '2014-03-15 19:34:32', 'SuperAdmin', '31163', '2014-03-15 08:34:32'),
(183, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 19:56:32', '2014-03-15 20:01:27', 'SuperAdmin', '14541', '2014-03-15 09:01:27'),
(184, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-16 10:33:15', '2014-03-16 10:34:36', 'SuperAdmin', '28904', '2014-03-15 23:34:36'),
(185, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-16 13:43:31', '2014-03-16 14:08:30', 'SuperAdmin', '21890', '2014-03-16 03:08:30'),
(186, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-16 14:44:16', '2014-03-16 14:44:46', 'SuperAdmin', '13459', '2014-03-16 03:44:46'),
(187, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-16 15:17:52', '2014-03-16 15:32:09', 'SuperAdmin', '13182', '2014-03-16 04:32:09'),
(188, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-18 16:59:08', '2014-03-18 17:06:46', 'SuperAdmin', '3350', '2014-03-18 06:06:46'),
(189, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-21 23:58:05', '2014-03-21 23:58:40', 'SuperAdmin', '20949', '2014-03-21 12:58:40'),
(190, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-25 13:25:44', '2014-03-25 13:27:43', 'SuperAdmin', '7356', '2014-03-25 02:27:43'),
(191, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-29 16:57:40', '2014-03-29 16:57:40', 'SuperAdmin', '11671', '2014-03-29 05:57:40'),
(192, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-29 17:23:25', '2014-03-29 17:51:19', 'SuperAdmin', '7044', '2014-03-29 06:51:19'),
(193, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-31 12:33:08', '2014-03-31 12:35:43', 'SuperAdmin', '31749', '2014-03-31 01:35:43'),
(194, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-31 13:09:55', '2014-03-31 13:09:55', 'SuperAdmin', '14281', '2014-03-31 02:09:55'),
(195, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-31 14:00:19', '2014-03-31 15:36:28', 'SuperAdmin', '23352', '2014-03-31 04:36:28'),
(196, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-31 15:57:33', '2014-03-31 17:32:51', 'SuperAdmin', '4877', '2014-03-31 06:32:51'),
(197, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-31 19:12:45', '2014-03-31 19:12:46', 'SuperAdmin', '29707', '2014-03-31 08:12:46'),
(198, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-31 19:40:57', '2014-03-31 20:25:36', 'SuperAdmin', '29416', '2014-03-31 09:25:36'),
(199, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-01 09:46:04', '2014-04-01 09:46:04', 'SuperAdmin', '11982', '2014-03-31 22:46:04'),
(200, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-01 13:07:36', '2014-04-01 16:17:10', 'SuperAdmin', '126', '2014-04-01 05:17:10'),
(201, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-01 18:25:45', '2014-04-01 18:48:10', 'SuperAdmin', '5676', '2014-04-01 07:48:10'),
(202, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-01 19:28:59', '2014-04-01 20:31:58', 'SuperAdmin', '2293', '2014-04-01 09:31:58'),
(203, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 10:41:23', '2014-04-02 11:09:05', 'SuperAdmin', '30347', '2014-04-02 00:09:05'),
(204, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 11:29:23', '2014-04-02 12:16:50', 'SuperAdmin', '17090', '2014-04-02 01:16:50'),
(205, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 13:00:24', '2014-04-02 13:00:24', 'SuperAdmin', '1925', '2014-04-02 02:00:24'),
(206, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 13:56:26', '2014-04-02 14:16:54', 'SuperAdmin', '29412', '2014-04-02 03:16:54'),
(207, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 15:01:51', '2014-04-02 17:10:00', 'SuperAdmin', '9467', '2014-04-02 06:10:00'),
(208, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 18:33:04', '2014-04-02 18:33:04', 'SuperAdmin', '14397', '2014-04-02 07:33:04'),
(209, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 19:31:38', '2014-04-02 19:41:13', 'SuperAdmin', '4941', '2014-04-02 08:41:13'),
(210, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 10:28:06', '2014-04-03 10:28:06', 'SuperAdmin', '16241', '2014-04-02 23:28:06'),
(211, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 11:19:22', '2014-04-03 11:19:22', 'SuperAdmin', '11280', '2014-04-03 00:19:22'),
(212, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 12:14:43', '2014-04-03 12:41:57', 'SuperAdmin', '10132', '2014-04-03 01:41:57'),
(213, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 13:39:25', '2014-04-03 13:39:25', 'SuperAdmin', '2504', '2014-04-03 02:39:25'),
(214, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 14:11:41', '2014-04-03 14:11:42', 'SuperAdmin', '8534', '2014-04-03 03:11:42'),
(215, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 14:59:47', '2014-04-03 14:59:48', 'SuperAdmin', '17009', '2014-04-03 03:59:48'),
(216, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 15:41:02', '2014-04-03 15:41:02', 'SuperAdmin', '22915', '2014-04-03 04:41:02'),
(217, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 16:32:19', '2014-04-03 16:32:19', 'SuperAdmin', '14080', '2014-04-03 05:32:19'),
(218, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 19:52:49', '2014-04-03 19:52:50', 'SuperAdmin', '6969', '2014-04-03 08:52:50'),
(219, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 20:18:21', '2014-04-03 20:52:01', 'SuperAdmin', '872', '2014-04-03 09:52:01'),
(220, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-04 12:06:54', '2014-04-04 12:35:56', 'SuperAdmin', '807', '2014-04-04 01:35:56'),
(221, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-04 13:00:44', '2014-04-04 13:12:02', 'SuperAdmin', '10919', '2014-04-04 02:12:02'),
(222, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-04 13:55:08', '2014-04-04 13:59:15', 'SuperAdmin', '29386', '2014-04-04 02:59:15'),
(223, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-04 15:56:17', '2014-04-04 16:24:55', 'SuperAdmin', '10091', '2014-04-04 05:24:55'),
(224, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-04 20:10:32', '2014-04-04 20:10:33', 'SuperAdmin', '27092', '2014-04-04 09:10:33'),
(225, 1, 'admin', '192.168.1.90', 'Reserved', '2014-04-05 10:05:46', '2014-04-05 10:05:53', 'SuperAdmin', '4808', '2014-04-04 23:05:53'),
(226, 1, 'admin', '192.168.1.90', 'Reserved', '2014-04-05 11:03:44', '2014-04-05 12:32:07', 'SuperAdmin', '15761', '2014-04-05 01:32:07'),
(227, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-05 11:16:01', '2014-04-05 12:08:18', 'SuperAdmin', '18460', '2014-04-05 01:08:18'),
(228, 1, 'admin', '192.168.1.90', 'Reserved', '2014-04-05 12:32:31', '2014-04-05 12:35:23', 'SuperAdmin', '8033', '2014-04-05 01:35:23'),
(229, 1, 'admin', '192.168.1.90', 'Reserved', '2014-04-05 12:52:35', '2014-04-05 14:27:58', 'SuperAdmin', '27685', '2014-04-05 03:27:58'),
(230, 1, 'admin', '192.168.1.90', 'Reserved', '2014-04-05 15:20:08', '2014-04-05 15:23:23', 'SuperAdmin', '358', '2014-04-05 04:23:23'),
(231, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-07 09:42:45', '2014-04-07 09:42:46', 'SuperAdmin', '29129', '2014-04-06 22:42:46'),
(232, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-07 14:22:49', '2014-04-07 14:22:49', 'SuperAdmin', '8434', '2014-04-07 03:22:49'),
(233, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-07 15:41:20', '2014-04-07 15:41:20', 'SuperAdmin', '506', '2014-04-07 04:41:20'),
(234, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-07 16:31:55', '2014-04-07 16:31:55', 'SuperAdmin', '13227', '2014-04-07 05:31:55'),
(235, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-07 17:51:04', '2014-04-07 18:10:18', 'SuperAdmin', '18952', '2014-04-07 07:10:18'),
(236, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-08 10:11:01', '2014-04-08 10:11:02', 'SuperAdmin', '1364', '2014-04-07 23:11:02'),
(237, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-12 14:00:37', '2014-04-12 14:03:39', 'SuperAdmin', '28907', '2014-04-12 03:03:39'),
(238, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-12 16:44:46', '2014-04-12 16:47:15', 'SuperAdmin', '23613', '2014-04-12 05:47:15'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-02 13:04:12', '2022-08-02 13:04:32', 'SuperAdmin', '23252', '2022-08-02 07:34:32'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-02 14:18:06', '2022-08-02 14:27:35', 'SuperAdmin', '29821', '2022-08-02 08:57:35'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-02 14:30:19', '2022-08-02 14:30:19', 'SuperAdmin', '5703', '2022-08-02 09:00:19'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-02 15:05:22', '2022-08-02 17:38:33', 'SuperAdmin', '28573', '2022-08-02 12:08:33'),
(0, 2, 'Tree Multisoft ', '::1', '', '2022-08-02 17:38:38', '2022-08-02 17:41:08', 'SuperAdmin', '4310', '2022-08-02 12:11:08'),
(0, 2, 'Tree Multisoft ', '::1', '', '2022-08-02 17:41:16', '2022-08-02 17:42:30', 'SuperAdmin', '3927', '2022-08-02 12:12:30'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-02 17:42:35', '2022-08-02 17:42:43', 'SuperAdmin', '24877', '2022-08-02 12:12:43'),
(0, 2, 'Tree Multisoft ', '::1', '', '2022-08-02 17:42:48', '2022-08-02 17:58:42', 'SuperAdmin', '18880', '2022-08-02 12:28:42'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-02 17:58:46', '2022-08-02 17:59:20', 'SuperAdmin', '18018', '2022-08-02 12:29:20'),
(0, 2, 'Tree Multisoft ', '::1', '', '2022-08-02 17:59:25', '2022-08-02 18:37:17', 'SuperAdmin', '1011', '2022-08-02 13:07:17'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-02 18:37:22', '2022-08-02 18:40:24', 'SuperAdmin', '32053', '2022-08-02 13:10:24'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-03 09:34:50', '2022-08-03 09:35:20', 'SuperAdmin', '24866', '2022-08-03 04:05:20'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-03 09:39:55', '2022-08-03 12:42:15', 'SuperAdmin', '18861', '2022-08-03 07:12:15'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-03 12:43:28', '2022-08-03 13:32:05', 'SuperAdmin', '9781', '2022-08-03 08:02:05'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-03 15:43:53', '2022-08-03 16:14:37', 'SuperAdmin', '9773', '2022-08-03 10:44:37'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-03 16:56:08', '2022-08-03 16:56:10', 'SuperAdmin', '10082', '2022-08-03 11:26:10'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-03 18:36:09', '2022-08-03 18:44:15', 'SuperAdmin', '17774', '2022-08-03 13:14:15'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-03 18:47:38', '2022-08-03 18:47:59', 'SuperAdmin', '4503', '2022-08-03 13:17:59'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-04 09:27:01', '2022-08-04 09:30:54', 'SuperAdmin', '12081', '2022-08-04 04:00:54'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-04 09:56:49', '2022-08-04 09:56:53', 'SuperAdmin', '16824', '2022-08-04 04:26:53'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-04 10:18:21', '2022-08-04 10:35:48', 'SuperAdmin', '15249', '2022-08-04 05:05:48'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-04 11:17:10', '2022-08-04 11:17:12', 'SuperAdmin', '18617', '2022-08-04 05:47:12'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-04 11:47:08', '2022-08-04 12:34:18', 'SuperAdmin', '2273', '2022-08-04 07:04:18'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-04 14:19:53', '2022-08-04 14:54:01', 'SuperAdmin', '22001', '2022-08-04 09:24:01'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-04 15:16:16', '2022-08-04 16:36:34', 'SuperAdmin', '21021', '2022-08-04 11:06:34'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-05 09:08:12', '2022-08-05 11:35:19', 'SuperAdmin', '31860', '2022-08-05 06:05:19'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-05 12:06:40', '2022-08-05 12:20:26', 'SuperAdmin', '21987', '2022-08-05 06:50:26'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-05 13:14:33', '2022-08-05 13:33:54', 'SuperAdmin', '26109', '2022-08-05 08:03:54'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-05 14:13:25', '2022-08-05 16:06:38', 'SuperAdmin', '5803', '2022-08-05 10:36:38'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-05 17:12:45', '2022-08-05 18:29:15', 'SuperAdmin', '19315', '2022-08-05 12:59:15'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-08 09:49:43', '2022-08-08 09:51:48', 'SuperAdmin', '9435', '2022-08-08 04:21:48'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-08 10:14:23', '2022-08-08 10:19:01', 'SuperAdmin', '19488', '2022-08-08 04:49:01'),
(0, 1, 'Tree Multisoft ', '192.168.1.17', '', '2022-08-08 10:46:27', '2022-08-08 10:46:35', 'SuperAdmin', '23001', '2022-08-08 05:16:35'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-08 10:51:57', '2022-08-08 11:10:29', 'SuperAdmin', '441', '2022-08-08 05:40:29'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-08 12:00:03', '2022-08-08 12:31:35', 'SuperAdmin', '23830', '2022-08-08 07:01:35'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-08 13:10:02', '2022-08-08 13:29:51', 'SuperAdmin', '6936', '2022-08-08 07:59:51'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-08 14:08:31', '2022-08-08 18:35:12', 'SuperAdmin', '2417', '2022-08-08 13:05:12'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-09 09:26:01', '2022-08-09 11:10:34', 'SuperAdmin', '10921', '2022-08-09 05:40:34'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-09 12:03:42', '2022-08-09 12:37:55', 'SuperAdmin', '31254', '2022-08-09 07:07:55'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-09 13:20:07', '2022-08-09 13:22:46', 'SuperAdmin', '16335', '2022-08-09 07:52:46'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-10 17:06:54', '2022-08-10 17:09:40', 'SuperAdmin', '13730', '2022-08-10 11:39:40'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-12 09:47:19', '2022-08-12 09:48:12', 'SuperAdmin', '13025', '2022-08-12 04:18:12'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-15 11:20:46', '2022-08-15 13:05:02', 'SuperAdmin', '31145', '2022-08-15 07:35:02'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-15 13:27:55', '2022-08-15 13:28:07', 'SuperAdmin', '20308', '2022-08-15 07:58:07'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-15 14:58:57', '2022-08-15 14:59:58', 'SuperAdmin', '4960', '2022-08-15 09:29:58'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-15 15:26:58', '2022-08-15 16:13:31', 'SuperAdmin', '30429', '2022-08-15 10:43:31'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-16 09:24:16', '2022-08-16 10:09:16', 'SuperAdmin', '24694', '2022-08-16 04:39:16'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-17 09:27:11', '2022-08-17 12:29:49', 'SuperAdmin', '10066', '2022-08-17 06:59:49'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-17 15:12:22', '2022-08-17 18:58:32', 'SuperAdmin', '26057', '2022-08-17 13:28:32'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-18 09:33:58', '2022-08-18 10:03:09', 'SuperAdmin', '12511', '2022-08-18 04:33:09'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-18 10:03:15', '2022-08-18 13:05:19', 'SuperAdmin', '15888', '2022-08-18 07:35:19'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-18 13:05:23', '2022-08-18 13:18:24', 'SuperAdmin', '22857', '2022-08-18 07:48:24'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-18 13:18:28', '2022-08-18 13:34:14', 'SuperAdmin', '11022', '2022-08-18 08:04:14'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-18 14:15:09', '2022-08-18 14:26:20', 'SuperAdmin', '28065', '2022-08-18 08:56:20'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-18 18:29:14', '2022-08-18 18:39:20', 'SuperAdmin', '20880', '2022-08-18 13:09:20'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-19 09:34:33', '2022-08-19 11:04:45', 'SuperAdmin', '24497', '2022-08-19 05:34:45'),
(87, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-10 19:31:12', '2014-02-10 19:31:13', 'SuperAdmin', '32525', '2014-02-10 08:31:13'),
(88, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-11 10:53:14', '2014-02-11 11:01:45', 'SuperAdmin', '27934', '2014-02-11 00:01:45'),
(89, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-11 17:53:39', '2014-02-11 17:53:40', 'SuperAdmin', '22807', '2014-02-11 06:53:40'),
(90, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-11 19:12:13', '2014-02-11 19:13:08', 'SuperAdmin', '1294', '2014-02-11 08:13:08'),
(91, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 11:49:53', '2014-02-18 11:56:35', 'SuperAdmin', '4304', '2014-02-18 00:56:35'),
(92, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 11:56:53', '2014-02-18 11:58:17', 'SuperAdmin', '14537', '2014-02-18 00:58:17'),
(93, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 11:58:29', '2014-02-18 12:07:01', 'SuperAdmin', '12560', '2014-02-18 01:07:01'),
(94, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 12:07:11', '2014-02-18 12:26:30', 'SuperAdmin', '29705', '2014-02-18 01:26:30'),
(95, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 12:30:03', '2014-02-18 12:31:15', 'SuperAdmin', '26477', '2014-02-18 01:31:15'),
(96, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 13:40:05', '2014-02-18 13:40:27', 'SuperAdmin', '4396', '2014-02-18 02:40:27'),
(97, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 14:16:31', '2014-02-18 15:06:50', 'SuperAdmin', '26613', '2014-02-18 04:06:50'),
(98, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 15:41:04', '2014-02-18 15:53:19', 'SuperAdmin', '6538', '2014-02-18 04:53:19'),
(99, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 16:45:57', '2014-02-18 17:21:17', 'SuperAdmin', '22030', '2014-02-18 06:21:17'),
(100, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-18 18:07:28', '2014-02-18 19:20:19', 'SuperAdmin', '10803', '2014-02-18 08:20:19'),
(101, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 13:42:11', '2014-02-20 13:42:13', 'SuperAdmin', '7397', '2014-02-20 02:42:13'),
(102, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 14:35:53', '2014-02-20 14:35:54', 'SuperAdmin', '26578', '2014-02-20 03:35:54'),
(103, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 15:14:21', '2014-02-20 17:06:59', 'SuperAdmin', '4444', '2014-02-20 06:06:59'),
(104, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 17:07:12', '2014-02-20 17:07:57', 'SuperAdmin', '16837', '2014-02-20 06:07:57'),
(105, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 17:08:08', '2014-02-20 17:11:52', 'SuperAdmin', '24739', '2014-02-20 06:11:52'),
(106, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 17:12:02', '2014-02-20 17:12:26', 'SuperAdmin', '32672', '2014-02-20 06:12:26'),
(107, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 17:12:36', '2014-02-20 17:12:50', 'SuperAdmin', '7269', '2014-02-20 06:12:50'),
(108, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 17:12:55', '2014-02-20 17:39:23', 'SuperAdmin', '30670', '2014-02-20 06:39:23'),
(109, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 19:58:23', '2014-02-20 19:58:23', 'SuperAdmin', '3386', '2014-02-20 08:58:23'),
(110, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 20:47:38', '2014-02-20 20:48:10', 'SuperAdmin', '5644', '2014-02-20 09:48:10'),
(111, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 20:48:28', '2014-02-20 20:54:08', 'SuperAdmin', '32235', '2014-02-20 09:54:08'),
(112, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-20 20:54:30', '2014-02-20 21:02:49', 'SuperAdmin', '26440', '2014-02-20 10:02:49'),
(113, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-21 11:08:14', '2014-02-21 11:24:46', 'SuperAdmin', '15189', '2014-02-21 00:24:46'),
(114, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-21 11:49:06', '2014-02-21 12:46:57', 'SuperAdmin', '18265', '2014-02-21 01:46:57'),
(115, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-21 15:20:20', '2014-02-21 15:20:20', 'SuperAdmin', '30447', '2014-02-21 04:20:20'),
(116, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-21 18:10:00', '2014-02-21 18:10:00', 'SuperAdmin', '14106', '2014-02-21 07:10:00'),
(117, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-21 19:01:14', '2014-02-21 19:28:02', 'SuperAdmin', '6625', '2014-02-21 08:28:02'),
(118, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-21 19:54:09', '2014-02-21 20:08:30', 'SuperAdmin', '22890', '2014-02-21 09:08:30'),
(119, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 07:29:45', '2014-02-22 07:29:45', 'SuperAdmin', '9349', '2014-02-21 20:29:45'),
(120, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 10:48:31', '2014-02-22 11:58:27', 'SuperAdmin', '17158', '2014-02-22 00:58:27'),
(121, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 13:31:03', '2014-02-22 13:48:21', 'SuperAdmin', '3675', '2014-02-22 02:48:21'),
(122, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 16:11:07', '2014-02-22 17:31:23', 'SuperAdmin', '1784', '2014-02-22 06:31:23'),
(123, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 17:10:52', '2014-02-22 17:10:52', 'SuperAdmin', '4683', '2014-02-22 06:10:52'),
(124, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 17:31:32', '2014-02-22 18:17:22', 'SuperAdmin', '3527', '2014-02-22 07:17:22'),
(125, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 20:19:40', '2014-02-22 20:20:02', 'SuperAdmin', '2403', '2014-02-22 09:20:02'),
(126, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-22 20:41:43', '2014-02-22 20:41:43', 'SuperAdmin', '12062', '2014-02-22 09:41:43'),
(127, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 11:00:56', '2014-02-25 11:03:09', 'SuperAdmin', '523', '2014-02-25 00:03:09'),
(128, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 13:22:31', '2014-02-25 13:47:27', 'SuperAdmin', '8741', '2014-02-25 02:47:27'),
(129, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 14:16:05', '2014-02-25 14:16:13', 'SuperAdmin', '13773', '2014-02-25 03:16:13'),
(130, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 15:35:29', '2014-02-25 16:04:31', 'SuperAdmin', '32762', '2014-02-25 05:04:31'),
(131, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 16:59:56', '2014-02-25 17:06:16', 'SuperAdmin', '13446', '2014-02-25 06:06:16'),
(132, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 17:06:42', '2014-02-25 17:06:50', 'SuperAdmin', '24803', '2014-02-25 06:06:50'),
(133, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-25 17:07:49', '2014-02-25 20:07:11', 'SuperAdmin', '22955', '2014-02-25 09:07:11'),
(134, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-26 16:48:21', '2014-02-26 17:14:52', 'SuperAdmin', '25839', '2014-02-26 06:14:52'),
(135, 1, 'admin', '127.0.0.1', 'Reserved', '2014-02-26 17:51:00', '2014-02-26 17:58:41', 'SuperAdmin', '4456', '2014-02-26 06:58:41'),
(136, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-01 11:59:46', '2014-03-01 14:37:47', 'SuperAdmin', '23509', '2014-03-01 03:37:47'),
(137, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 12:08:06', '2014-03-03 12:08:06', 'SuperAdmin', '16598', '2014-03-03 01:08:06'),
(138, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 13:36:05', '2014-03-03 13:36:43', 'SuperAdmin', '22657', '2014-03-03 02:36:43'),
(139, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 13:37:24', '2014-03-03 13:37:24', 'SuperAdmin', '25669', '2014-03-03 02:37:24'),
(140, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 13:58:36', '2014-03-03 14:05:55', 'SuperAdmin', '5731', '2014-03-03 03:05:55'),
(141, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 14:27:36', '2014-03-03 14:38:08', 'SuperAdmin', '32599', '2014-03-03 03:38:08'),
(142, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 15:37:21', '2014-03-03 18:29:48', 'SuperAdmin', '25184', '2014-03-03 07:29:48'),
(143, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-03 18:31:30', '2014-03-03 19:03:39', 'SuperAdmin', '24063', '2014-03-03 08:03:39'),
(144, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-04 10:39:28', '2014-03-04 10:46:53', 'SuperAdmin', '28209', '2014-03-03 23:46:53'),
(145, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-04 17:21:22', '2014-03-04 17:30:30', 'SuperAdmin', '2326', '2014-03-04 06:30:30'),
(146, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-05 11:34:18', '2014-03-05 11:34:31', 'SuperAdmin', '2005', '2014-03-05 00:34:31'),
(147, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-05 12:24:25', '2014-03-05 12:41:21', 'SuperAdmin', '26522', '2014-03-05 01:41:21'),
(148, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-05 15:55:51', '2014-03-05 16:14:48', 'SuperAdmin', '14539', '2014-03-05 05:14:48'),
(149, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-05 17:55:56', '2014-03-05 20:07:49', 'SuperAdmin', '14504', '2014-03-05 09:07:49'),
(150, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-06 10:52:02', '2014-03-06 10:52:02', 'SuperAdmin', '32705', '2014-03-05 23:52:02'),
(151, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-06 11:39:34', '2014-03-06 12:49:22', 'SuperAdmin', '20466', '2014-03-06 01:49:22'),
(152, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-07 18:47:45', '2014-03-07 19:44:19', 'SuperAdmin', '23734', '2014-03-07 08:44:19'),
(153, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-08 10:37:29', '2014-03-08 11:50:16', 'SuperAdmin', '23548', '2014-03-08 00:50:16'),
(154, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-08 12:15:13', '2014-03-08 12:15:17', 'SuperAdmin', '3813', '2014-03-08 01:15:17'),
(155, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-08 12:42:38', '2014-03-08 12:46:19', 'SuperAdmin', '24147', '2014-03-08 01:46:19'),
(156, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-08 13:10:08', '2014-03-08 13:13:38', 'SuperAdmin', '14502', '2014-03-08 02:13:38'),
(157, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-08 13:36:59', '2014-03-08 14:12:07', 'SuperAdmin', '5292', '2014-03-08 03:12:07'),
(158, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-10 10:38:15', '2014-03-10 10:38:16', 'SuperAdmin', '30029', '2014-03-09 23:38:16'),
(159, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-10 10:59:27', '2014-03-10 12:14:37', 'SuperAdmin', '21355', '2014-03-10 01:14:37'),
(160, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-10 12:35:39', '2014-03-10 14:04:00', 'SuperAdmin', '20168', '2014-03-10 03:04:00'),
(161, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-10 15:55:28', '2014-03-10 17:24:15', 'SuperAdmin', '15498', '2014-03-10 06:24:15'),
(162, 1, 'admin', '127.0.0.1', '', '2014-03-10 17:48:28', '2014-03-10 18:02:29', 'SuperAdmin', '3956', '2014-03-10 07:02:29'),
(163, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-10 18:22:45', '2014-03-10 20:24:05', 'SuperAdmin', '1299', '2014-03-10 09:24:05'),
(164, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-11 13:47:10', '2014-03-11 15:31:28', 'SuperAdmin', '18207', '2014-03-11 04:31:28'),
(165, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-11 16:04:25', '2014-03-11 16:23:38', 'SuperAdmin', '10369', '2014-03-11 05:23:38'),
(166, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-11 17:07:06', '2014-03-11 17:54:47', 'SuperAdmin', '15654', '2014-03-11 06:54:47'),
(167, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-12 11:28:40', '2014-03-12 16:23:46', 'SuperAdmin', '8719', '2014-03-12 05:23:46'),
(168, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-12 16:44:01', '2014-03-12 16:52:15', 'SuperAdmin', '1812', '2014-03-12 05:52:15'),
(169, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-12 18:35:15', '2014-03-12 18:41:47', 'SuperAdmin', '4053', '2014-03-12 07:41:47'),
(170, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-12 19:05:48', '2014-03-12 19:08:40', 'SuperAdmin', '27244', '2014-03-12 08:08:40'),
(171, 1, 'admin', '127.0.0.1', '', '2014-03-12 19:31:49', '2014-03-12 20:46:29', 'SuperAdmin', '20523', '2014-03-12 09:46:29'),
(172, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-13 14:06:22', '2014-03-13 14:09:05', 'SuperAdmin', '27206', '2014-03-13 03:09:05'),
(173, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-14 19:51:34', '2014-03-14 19:53:52', 'SuperAdmin', '28344', '2014-03-14 08:53:52'),
(174, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 10:52:29', '2014-03-15 11:07:55', 'SuperAdmin', '29999', '2014-03-15 00:07:55'),
(175, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 12:10:11', '2014-03-15 12:16:13', 'SuperAdmin', '25745', '2014-03-15 01:16:13'),
(176, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 12:37:35', '2014-03-15 14:29:36', 'SuperAdmin', '26162', '2014-03-15 03:29:36'),
(177, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 15:14:57', '2014-03-15 15:51:43', 'SuperAdmin', '12278', '2014-03-15 04:51:43'),
(178, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 15:51:49', '2014-03-15 16:49:19', 'SuperAdmin', '15389', '2014-03-15 05:49:19'),
(179, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 17:17:58', '2014-03-15 17:21:44', 'SuperAdmin', '4087', '2014-03-15 06:21:44'),
(180, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 17:44:05', '2014-03-15 18:13:22', 'SuperAdmin', '22090', '2014-03-15 07:13:22'),
(181, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 18:37:30', '2014-03-15 18:49:58', 'SuperAdmin', '15972', '2014-03-15 07:49:58'),
(182, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 19:11:41', '2014-03-15 19:34:32', 'SuperAdmin', '31163', '2014-03-15 08:34:32'),
(183, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-15 19:56:32', '2014-03-15 20:01:27', 'SuperAdmin', '14541', '2014-03-15 09:01:27'),
(184, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-16 10:33:15', '2014-03-16 10:34:36', 'SuperAdmin', '28904', '2014-03-15 23:34:36'),
(185, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-16 13:43:31', '2014-03-16 14:08:30', 'SuperAdmin', '21890', '2014-03-16 03:08:30'),
(186, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-16 14:44:16', '2014-03-16 14:44:46', 'SuperAdmin', '13459', '2014-03-16 03:44:46'),
(187, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-16 15:17:52', '2014-03-16 15:32:09', 'SuperAdmin', '13182', '2014-03-16 04:32:09'),
(188, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-18 16:59:08', '2014-03-18 17:06:46', 'SuperAdmin', '3350', '2014-03-18 06:06:46'),
(189, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-21 23:58:05', '2014-03-21 23:58:40', 'SuperAdmin', '20949', '2014-03-21 12:58:40'),
(190, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-25 13:25:44', '2014-03-25 13:27:43', 'SuperAdmin', '7356', '2014-03-25 02:27:43'),
(191, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-29 16:57:40', '2014-03-29 16:57:40', 'SuperAdmin', '11671', '2014-03-29 05:57:40'),
(192, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-29 17:23:25', '2014-03-29 17:51:19', 'SuperAdmin', '7044', '2014-03-29 06:51:19'),
(193, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-31 12:33:08', '2014-03-31 12:35:43', 'SuperAdmin', '31749', '2014-03-31 01:35:43'),
(194, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-31 13:09:55', '2014-03-31 13:09:55', 'SuperAdmin', '14281', '2014-03-31 02:09:55'),
(195, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-31 14:00:19', '2014-03-31 15:36:28', 'SuperAdmin', '23352', '2014-03-31 04:36:28'),
(196, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-31 15:57:33', '2014-03-31 17:32:51', 'SuperAdmin', '4877', '2014-03-31 06:32:51'),
(197, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-31 19:12:45', '2014-03-31 19:12:46', 'SuperAdmin', '29707', '2014-03-31 08:12:46'),
(198, 1, 'admin', '127.0.0.1', 'Reserved', '2014-03-31 19:40:57', '2014-03-31 20:25:36', 'SuperAdmin', '29416', '2014-03-31 09:25:36'),
(199, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-01 09:46:04', '2014-04-01 09:46:04', 'SuperAdmin', '11982', '2014-03-31 22:46:04'),
(200, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-01 13:07:36', '2014-04-01 16:17:10', 'SuperAdmin', '126', '2014-04-01 05:17:10'),
(201, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-01 18:25:45', '2014-04-01 18:48:10', 'SuperAdmin', '5676', '2014-04-01 07:48:10'),
(202, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-01 19:28:59', '2014-04-01 20:31:58', 'SuperAdmin', '2293', '2014-04-01 09:31:58'),
(203, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 10:41:23', '2014-04-02 11:09:05', 'SuperAdmin', '30347', '2014-04-02 00:09:05'),
(204, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 11:29:23', '2014-04-02 12:16:50', 'SuperAdmin', '17090', '2014-04-02 01:16:50'),
(205, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 13:00:24', '2014-04-02 13:00:24', 'SuperAdmin', '1925', '2014-04-02 02:00:24'),
(206, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 13:56:26', '2014-04-02 14:16:54', 'SuperAdmin', '29412', '2014-04-02 03:16:54'),
(207, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 15:01:51', '2014-04-02 17:10:00', 'SuperAdmin', '9467', '2014-04-02 06:10:00'),
(208, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 18:33:04', '2014-04-02 18:33:04', 'SuperAdmin', '14397', '2014-04-02 07:33:04'),
(209, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-02 19:31:38', '2014-04-02 19:41:13', 'SuperAdmin', '4941', '2014-04-02 08:41:13'),
(210, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 10:28:06', '2014-04-03 10:28:06', 'SuperAdmin', '16241', '2014-04-02 23:28:06'),
(211, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 11:19:22', '2014-04-03 11:19:22', 'SuperAdmin', '11280', '2014-04-03 00:19:22'),
(212, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 12:14:43', '2014-04-03 12:41:57', 'SuperAdmin', '10132', '2014-04-03 01:41:57'),
(213, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 13:39:25', '2014-04-03 13:39:25', 'SuperAdmin', '2504', '2014-04-03 02:39:25'),
(214, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 14:11:41', '2014-04-03 14:11:42', 'SuperAdmin', '8534', '2014-04-03 03:11:42'),
(215, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 14:59:47', '2014-04-03 14:59:48', 'SuperAdmin', '17009', '2014-04-03 03:59:48'),
(216, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 15:41:02', '2014-04-03 15:41:02', 'SuperAdmin', '22915', '2014-04-03 04:41:02'),
(217, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 16:32:19', '2014-04-03 16:32:19', 'SuperAdmin', '14080', '2014-04-03 05:32:19'),
(218, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 19:52:49', '2014-04-03 19:52:50', 'SuperAdmin', '6969', '2014-04-03 08:52:50'),
(219, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-03 20:18:21', '2014-04-03 20:52:01', 'SuperAdmin', '872', '2014-04-03 09:52:01'),
(220, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-04 12:06:54', '2014-04-04 12:35:56', 'SuperAdmin', '807', '2014-04-04 01:35:56'),
(221, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-04 13:00:44', '2014-04-04 13:12:02', 'SuperAdmin', '10919', '2014-04-04 02:12:02'),
(222, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-04 13:55:08', '2014-04-04 13:59:15', 'SuperAdmin', '29386', '2014-04-04 02:59:15'),
(223, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-04 15:56:17', '2014-04-04 16:24:55', 'SuperAdmin', '10091', '2014-04-04 05:24:55'),
(224, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-04 20:10:32', '2014-04-04 20:10:33', 'SuperAdmin', '27092', '2014-04-04 09:10:33'),
(225, 1, 'admin', '192.168.1.90', 'Reserved', '2014-04-05 10:05:46', '2014-04-05 10:05:53', 'SuperAdmin', '4808', '2014-04-04 23:05:53'),
(226, 1, 'admin', '192.168.1.90', 'Reserved', '2014-04-05 11:03:44', '2014-04-05 12:32:07', 'SuperAdmin', '15761', '2014-04-05 01:32:07'),
(227, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-05 11:16:01', '2014-04-05 12:08:18', 'SuperAdmin', '18460', '2014-04-05 01:08:18'),
(228, 1, 'admin', '192.168.1.90', 'Reserved', '2014-04-05 12:32:31', '2014-04-05 12:35:23', 'SuperAdmin', '8033', '2014-04-05 01:35:23'),
(229, 1, 'admin', '192.168.1.90', 'Reserved', '2014-04-05 12:52:35', '2014-04-05 14:27:58', 'SuperAdmin', '27685', '2014-04-05 03:27:58'),
(230, 1, 'admin', '192.168.1.90', 'Reserved', '2014-04-05 15:20:08', '2014-04-05 15:23:23', 'SuperAdmin', '358', '2014-04-05 04:23:23'),
(231, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-07 09:42:45', '2014-04-07 09:42:46', 'SuperAdmin', '29129', '2014-04-06 22:42:46'),
(232, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-07 14:22:49', '2014-04-07 14:22:49', 'SuperAdmin', '8434', '2014-04-07 03:22:49'),
(233, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-07 15:41:20', '2014-04-07 15:41:20', 'SuperAdmin', '506', '2014-04-07 04:41:20'),
(234, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-07 16:31:55', '2014-04-07 16:31:55', 'SuperAdmin', '13227', '2014-04-07 05:31:55'),
(235, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-07 17:51:04', '2014-04-07 18:10:18', 'SuperAdmin', '18952', '2014-04-07 07:10:18'),
(236, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-08 10:11:01', '2014-04-08 10:11:02', 'SuperAdmin', '1364', '2014-04-07 23:11:02'),
(237, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-12 14:00:37', '2014-04-12 14:03:39', 'SuperAdmin', '28907', '2014-04-12 03:03:39'),
(238, 1, 'admin', '127.0.0.1', 'Reserved', '2014-04-12 16:44:46', '2014-04-12 16:47:15', 'SuperAdmin', '23613', '2014-04-12 05:47:15'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-19 11:05:02', '2022-08-19 11:05:05', 'SuperAdmin', '1223', '2022-08-19 05:35:05'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-19 11:05:10', '2022-08-19 13:33:25', 'SuperAdmin', '23284', '2022-08-19 08:03:25'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-19 14:15:02', '2022-08-19 16:14:36', 'SuperAdmin', '9146', '2022-08-19 10:44:36'),
(0, 69, 'Tree Multisoft ', '::1', '', '2022-08-19 16:14:51', '2022-08-19 16:18:40', 'SuperAdmin', '31206', '2022-08-19 10:48:40'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-19 16:18:47', '2022-08-19 16:20:05', 'SuperAdmin', '5260', '2022-08-19 10:50:05'),
(0, 3, 'Tree Multisoft ', '::1', '', '2022-08-19 16:20:09', '2022-08-19 16:20:39', 'SuperAdmin', '11047', '2022-08-19 10:50:39'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-19 16:20:43', '2022-08-19 16:52:01', 'SuperAdmin', '29140', '2022-08-19 11:22:01'),
(0, 72, 'Tree Multisoft ', '::1', '', '2022-08-19 16:52:17', '2022-08-19 16:52:23', 'SuperAdmin', '11023', '2022-08-19 11:22:23'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-19 16:52:28', '2022-08-19 16:53:57', 'SuperAdmin', '30414', '2022-08-19 11:23:57'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-19 16:54:11', '2022-08-19 18:06:16', 'SuperAdmin', '26916', '2022-08-19 12:36:16'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-22 13:24:45', '2022-08-22 13:30:02', 'SuperAdmin', '24896', '2022-08-22 08:00:02'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-22 14:06:55', '2022-08-22 14:59:44', 'SuperAdmin', '100', '2022-08-22 09:29:44'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-23 18:29:11', '2022-08-23 18:30:31', 'SuperAdmin', '29679', '2022-08-23 13:00:31'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-29 14:20:59', '2022-08-29 14:31:56', 'SuperAdmin', '19606', '2022-08-29 09:01:56'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-29 18:05:10', '2022-08-29 18:06:33', 'SuperAdmin', '16488', '2022-08-29 12:36:33'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-30 09:14:43', '2022-08-30 11:28:56', 'SuperAdmin', '26123', '2022-08-30 05:58:56');
INSERT INTO `tbl_sessionmanagement` (`Sno`, `UserId`, `UserType`, `IpAddress`, `Country`, `LoginTime`, `LogoutTime`, `LoginType`, `RandId`, `CrDate`) VALUES
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-30 11:30:10', '2022-08-30 12:18:03', 'SuperAdmin', '9870', '2022-08-30 06:48:03'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-30 12:19:43', '2022-08-30 12:25:07', 'SuperAdmin', '6571', '2022-08-30 06:55:07'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-30 12:25:12', '2022-08-30 12:30:51', 'SuperAdmin', '14877', '2022-08-30 07:00:51'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-30 12:30:59', '2022-08-30 12:31:06', 'SuperAdmin', '7578', '2022-08-30 07:01:06'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-30 12:32:20', '2022-08-30 12:32:44', 'SuperAdmin', '24998', '2022-08-30 07:02:44'),
(0, 76, 'Tree Multisoft ', '::1', '', '2022-08-30 12:32:49', '2022-08-30 12:33:20', 'SuperAdmin', '7808', '2022-08-30 07:03:20'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-30 12:33:24', '2022-08-30 13:31:12', 'SuperAdmin', '14027', '2022-08-30 08:01:12'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-30 14:10:56', '2022-08-30 14:51:33', 'SuperAdmin', '19636', '2022-08-30 09:21:33'),
(0, 2, 'Tree Multisoft ', '::1', '', '2022-08-30 14:51:52', '2022-08-30 14:52:02', 'SuperAdmin', '6398', '2022-08-30 09:22:02'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-30 14:52:07', '2022-08-30 17:38:56', 'SuperAdmin', '14431', '2022-08-30 12:08:56'),
(0, 78, 'Tree Multisoft ', '::1', '', '2022-08-30 17:39:19', '2022-08-30 17:39:22', 'SuperAdmin', '18186', '2022-08-30 12:09:22'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-30 17:39:27', '2022-08-30 17:54:08', 'SuperAdmin', '31611', '2022-08-30 12:24:08'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-30 17:54:24', '2022-08-30 17:58:02', 'SuperAdmin', '18902', '2022-08-30 12:28:02'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-30 18:38:36', '2022-08-30 18:38:36', 'SuperAdmin', '4544', '2022-08-30 13:08:36'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-31 09:28:14', '2022-08-31 09:47:49', 'SuperAdmin', '20277', '2022-08-31 04:17:49'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-08-31 10:26:06', '2022-08-31 10:26:06', 'SuperAdmin', '28712', '2022-08-31 04:56:06'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-15 13:06:10', '2022-09-15 13:06:17', 'SuperAdmin', '15116', '2022-09-15 07:36:17'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-19 14:37:37', '2022-09-19 14:47:52', 'SuperAdmin', '10946', '2022-09-19 09:17:52'),
(0, 80, 'Tree Multisoft ', '::1', '', '2022-09-19 14:48:03', '2022-09-19 14:48:12', 'SuperAdmin', '9252', '2022-09-19 09:18:12'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-19 14:48:16', '2022-09-19 15:11:43', 'SuperAdmin', '14773', '2022-09-19 09:41:43'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-19 17:36:21', '2022-09-19 17:38:47', 'SuperAdmin', '673', '2022-09-19 12:08:47'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-19 17:38:54', '2022-09-19 17:56:57', 'SuperAdmin', '16895', '2022-09-19 12:26:57'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-20 10:23:15', '2022-09-20 10:50:57', 'SuperAdmin', '20762', '2022-09-20 05:20:57'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-20 13:02:46', '2022-09-20 13:02:48', 'SuperAdmin', '32296', '2022-09-20 07:32:48'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-21 13:10:55', '2022-09-21 13:31:18', 'SuperAdmin', '23047', '2022-09-21 08:01:18'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-21 14:22:22', '2022-09-21 15:48:37', 'SuperAdmin', '10036', '2022-09-21 10:18:37'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-21 16:20:31', '2022-09-21 17:26:04', 'SuperAdmin', '2552', '2022-09-21 11:56:04'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-21 18:01:33', '2022-09-21 18:18:14', 'SuperAdmin', '767', '2022-09-21 12:48:14'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-22 10:00:55', '2022-09-22 10:14:00', 'SuperAdmin', '17553', '2022-09-22 04:44:00'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-22 10:35:54', '2022-09-22 12:52:59', 'SuperAdmin', '4086', '2022-09-22 07:22:59'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-22 13:14:43', '2022-09-22 13:14:43', 'SuperAdmin', '8961', '2022-09-22 07:44:43'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-22 14:49:17', '2022-09-22 15:07:35', 'SuperAdmin', '9428', '2022-09-22 09:37:35'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-22 15:33:22', '2022-09-22 16:15:01', 'SuperAdmin', '30333', '2022-09-22 10:45:01'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-22 16:15:07', '2022-09-22 16:54:32', 'SuperAdmin', '4174', '2022-09-22 11:24:32'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-22 17:22:24', '2022-09-22 17:34:24', 'SuperAdmin', '25027', '2022-09-22 12:04:24'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-22 17:55:37', '2022-09-22 18:13:04', 'SuperAdmin', '25967', '2022-09-22 12:43:04'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-26 09:35:43', '2022-09-26 09:35:43', 'SuperAdmin', '248', '2022-09-26 04:05:43'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-26 09:57:18', '2022-09-26 10:06:18', 'SuperAdmin', '1872', '2022-09-26 04:36:18'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-26 10:47:07', '2022-09-26 10:47:43', 'SuperAdmin', '11318', '2022-09-26 05:17:43'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-09-26 11:21:12', '2022-09-26 12:23:22', 'SuperAdmin', '10038', '2022-09-26 06:53:22'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-10-03 12:23:05', '2022-10-03 12:27:08', 'SuperAdmin', '26275', '2022-10-03 06:57:08'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-10-03 13:25:51', '2022-10-03 13:30:02', 'SuperAdmin', '8593', '2022-10-03 08:00:02'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-10-03 14:28:04', '2022-10-03 15:42:39', 'SuperAdmin', '10486', '2022-10-03 10:12:39'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-10-13 09:58:54', '2022-10-13 10:27:04', 'SuperAdmin', '9620', '2022-10-13 04:57:04'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-10-13 10:53:55', '2022-10-13 13:34:30', 'SuperAdmin', '9751', '2022-10-13 08:04:30'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-10-13 14:07:27', '2022-10-13 14:38:54', 'SuperAdmin', '2690', '2022-10-13 09:08:54'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-10-13 14:41:19', '2022-10-13 14:52:19', 'SuperAdmin', '27140', '2022-10-13 09:22:19'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-10-13 15:21:17', '2022-10-13 18:03:49', 'SuperAdmin', '18794', '2022-10-13 12:33:49'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-10-14 09:39:58', '2022-10-14 09:40:19', 'SuperAdmin', '15473', '2022-10-14 04:10:19'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-10-27 10:43:15', '2022-10-27 10:43:22', 'SuperAdmin', '2320', '2022-10-27 05:13:22'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-10-27 11:32:32', '2022-10-27 11:32:34', 'SuperAdmin', '1229', '2022-10-27 06:02:34'),
(0, 1, 'Tree Multisoft ', '::1', '', '2022-12-21 16:48:24', '2022-12-21 16:48:25', 'SuperAdmin', '22476', '2022-12-21 11:18:25'),
(0, 1, 'Tree Multisoft ', '::1', '', '2023-03-24 13:42:45', '2023-03-24 13:43:05', 'SuperAdmin', '1887390037', '2023-03-24 08:13:05'),
(0, 1, 'Tree Multisoft ', '::1', '', '2023-03-27 09:44:27', '2023-03-27 09:48:33', 'SuperAdmin', '916118523', '2023-03-27 04:18:33'),
(0, 1, 'Tree Multisoft ', '::1', '', '2023-04-20 17:02:39', '2023-04-20 17:23:22', 'SuperAdmin', '668064979', '2023-04-20 11:53:22');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_sidebar`
--

CREATE TABLE `tbl_sidebar` (
  `sidebar_id` int(11) NOT NULL,
  `category` varchar(255) NOT NULL,
  `sidebar_controller` varchar(255) NOT NULL,
  `sidebar_name` varchar(255) NOT NULL,
  `status` int(2) NOT NULL DEFAULT 0,
  `create_date` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_sidebar`
--

INSERT INTO `tbl_sidebar` (`sidebar_id`, `category`, `sidebar_controller`, `sidebar_name`, `status`, `create_date`) VALUES
(1, '0', 'department', 'Department', 0, '2022-08-18 04:37:39'),
(2, '1', 'employee', 'Add Employee', 0, '2022-08-18 04:38:01'),
(3, '1', 'attendance', 'Attendance', 0, '2022-09-26 05:54:42');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_temp_employe`
--

CREATE TABLE `tbl_temp_employe` (
  `id` int(11) NOT NULL,
  `emp_id` varchar(11) NOT NULL,
  `emp_card_no` varchar(50) NOT NULL,
  `emp_name` varchar(50) NOT NULL,
  `emp_email` varchar(255) NOT NULL,
  `emp_ph_no` varchar(25) NOT NULL,
  `dob` date NOT NULL,
  `gender` varchar(20) NOT NULL,
  `maritalstatus` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `pan_number` varchar(50) NOT NULL,
  `adhar_number` varchar(50) NOT NULL,
  `department` int(10) NOT NULL,
  `designation` int(10) NOT NULL,
  `salary` decimal(12,2) NOT NULL,
  `worktype` varchar(20) NOT NULL,
  `joiningdate` date NOT NULL,
  `leavingdate` date NOT NULL,
  `p_name` varchar(50) NOT NULL,
  `p_number` varchar(20) NOT NULL,
  `p_relation` varchar(20) NOT NULL,
  `p_address` text NOT NULL,
  `bankname` varchar(50) NOT NULL,
  `bank_branch` varchar(255) NOT NULL,
  `accnumber` varchar(20) NOT NULL,
  `accname` varchar(20) NOT NULL,
  `ifscno` varchar(20) NOT NULL,
  `acctype` varchar(20) NOT NULL,
  `emp_image` varchar(50) NOT NULL,
  `emp_status` varchar(20) NOT NULL DEFAULT 'left',
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_temp_employe`
--

INSERT INTO `tbl_temp_employe` (`id`, `emp_id`, `emp_card_no`, `emp_name`, `emp_email`, `emp_ph_no`, `dob`, `gender`, `maritalstatus`, `address`, `pan_number`, `adhar_number`, `department`, `designation`, `salary`, `worktype`, `joiningdate`, `leavingdate`, `p_name`, `p_number`, `p_relation`, `p_address`, `bankname`, `bank_branch`, `accnumber`, `accname`, `ifscno`, `acctype`, `emp_image`, `emp_status`, `date`) VALUES
(2, 'TREE1001', '100', 'test', 'abc@gmail.com', '9876543210', '2000-02-05', 'F', 'married', 'address', 'eutioerutioe48594', '123456789012', 1, 1, '10000.00', 'ft', '2022-08-01', '0000-00-00', 'mumma', '', ' ', '', 'State Bank of India', 'DHARAMPUR', '645645645', 'gdhfgsdhj', 'SBIN0005475', 'yztayzta', '20220815093452.jpg', 'left', '2022-08-15 10:29:08'),
(3, 'TREE1001', '100', 'test', 'test@123gmail.com', '9876543210', '1979-12-01', 'F', 'single', 'address', 'eutioerutioe48594', '123456789012', 1, 1, '10000.00', 'ft', '2022-01-01', '0000-00-00', 'my full name', '7545603232', 'husband', 'address', 'State Bank of India', 'DHARAMPUR', '6756756', 'my full name', 'SBIN0005475', 'saving', '20220816061020.jpg', 'left', '2022-08-16 04:34:37'),
(4, 'TREE1003', '102', 'gunjan bijalwan', 'tabbu@gmail.com', '9876543219', '1999-06-10', 'O', 'single', 'addresss', '4reter6455665', '4445556789', 3, 2, '10000.00', 'ft', '2022-08-17', '0000-00-00', '', '', ' ', '', 'State Bank of India', 'DHARAMPUR', '56756757', 'my full name', 'SBIN0005475', 'saving', '20220816061731.jpg', 'left', '2022-08-16 04:34:58'),
(5, 'TREE1002', '101', 'Gunjan bijalwan', 'abc@gmail.com', '7456037448', '2000-01-16', 'M', 'Other', '10-B Mothorowala Road, Near Rawat Wedding Point and opp. PNB Bank, Ajabpur Kalan Dehradun, Uttarakhand, India', 'eutioerutioe48594', '95689048948', 3, 1, '10000.00', 'ft', '2022-08-01', '0000-00-00', 'test', '9876543210', ' Mother', '10-B Mothorowala Road, Near Rawat Wedding Point and opp. PNB Bank, Ajabpur Kalan Dehradun, Uttarakhand, India', 'State Bank of India', 'DHARAMPUR', '43232423423234', 'gdhfgsdhj23324', 'SBIN0005475', 'saving', '20220816061241.jpg', 'left', '2022-08-30 12:06:02'),
(6, 'TREE1006', '103', 'Anjali Bijalwan', 'abijalwan3@gmail.com', '7579124918', '1996-08-23', 'F', 'single', 'Dehradun', 'eutioerutioe48594', '123456789012', 3, 3, '27000.00', 'ft', '2022-01-31', '0000-00-00', 'Qwerty', '9876543212', 'mother', 'Dehradunb', 'State Bank Of India', 'DHARAMPUR', '76543218904', 'Qwertyuuiiiuyhfg', 'SBIN0005475', 'Saving', '20220830071737.jpg', 'left', '2022-08-30 12:08:11'),
(7, 'TREE1007', '103', 'Gunjan Bijalwan', 'gbijalwan5@gmail.com', '7456034448', '2002-02-12', 'F', 'single', 'Dehradun', 'PAN346CARD', '8765123902344', 1, 1, '10000.00', 'ft', '2021-01-01', '0000-00-00', 'Mummy', '7579124518', 'mother', 'Tehri', 'State Bank Of India', 'DHARAMPUR', '987654321045789', 'My Full Name', 'SBIN0005475', 'Saving', '20220830022016.jpg', 'left', '2022-08-30 12:23:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_adminuser`
--
ALTER TABLE `tbl_adminuser`
  ADD PRIMARY KEY (`Sno`),
  ADD UNIQUE KEY `Sno` (`Sno`) USING BTREE,
  ADD KEY `Default_Password` (`Default_Password`) USING BTREE;

--
-- Indexes for table `tbl_department`
--
ALTER TABLE `tbl_department`
  ADD PRIMARY KEY (`depatment_id`),
  ADD UNIQUE KEY `department_name` (`department_name`);

--
-- Indexes for table `tbl_employee`
--
ALTER TABLE `tbl_employee`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `emp_id` (`emp_id`),
  ADD UNIQUE KEY `accnumber` (`accnumber`),
  ADD UNIQUE KEY `emp_email` (`emp_email`),
  ADD UNIQUE KEY `emp_ph_no` (`emp_ph_no`),
  ADD UNIQUE KEY `emp_card_no` (`emp_card_no`);

--
-- Indexes for table `tbl_register`
--
ALTER TABLE `tbl_register`
  ADD PRIMARY KEY (`Sno`),
  ADD UNIQUE KEY `UserName` (`UserName`),
  ADD KEY `companyName` (`companyName`,`department_type_id`),
  ADD KEY `Sno` (`Sno`);

--
-- Indexes for table `tbl_services`
--
ALTER TABLE `tbl_services`
  ADD PRIMARY KEY (`service_id`);

--
-- Indexes for table `tbl_sidebar`
--
ALTER TABLE `tbl_sidebar`
  ADD PRIMARY KEY (`sidebar_id`);

--
-- Indexes for table `tbl_temp_employe`
--
ALTER TABLE `tbl_temp_employe`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_adminuser`
--
ALTER TABLE `tbl_adminuser`
  MODIFY `Sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_department`
--
ALTER TABLE `tbl_department`
  MODIFY `depatment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_employee`
--
ALTER TABLE `tbl_employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1007;

--
-- AUTO_INCREMENT for table `tbl_register`
--
ALTER TABLE `tbl_register`
  MODIFY `Sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `tbl_services`
--
ALTER TABLE `tbl_services`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `tbl_sidebar`
--
ALTER TABLE `tbl_sidebar`
  MODIFY `sidebar_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_temp_employe`
--
ALTER TABLE `tbl_temp_employe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
