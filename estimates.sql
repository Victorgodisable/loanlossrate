-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 19, 2024 at 07:20 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `estimates`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add product detail', 7, 'add_productdetail'),
(26, 'Can change product detail', 7, 'change_productdetail'),
(27, 'Can delete product detail', 7, 'delete_productdetail'),
(28, 'Can view product detail', 7, 'view_productdetail'),
(29, 'Can add sales projection', 8, 'add_salesprojection'),
(30, 'Can change sales projection', 8, 'change_salesprojection'),
(31, 'Can delete sales projection', 8, 'delete_salesprojection'),
(32, 'Can view sales projection', 8, 'view_salesprojection'),
(33, 'Can add llr pricing assumption', 9, 'add_llrpricingassumption'),
(34, 'Can change llr pricing assumption', 9, 'change_llrpricingassumption'),
(35, 'Can delete llr pricing assumption', 9, 'delete_llrpricingassumption'),
(36, 'Can view llr pricing assumption', 9, 'view_llrpricingassumption'),
(37, 'Can add payment plan projection', 10, 'add_paymentplanprojection'),
(38, 'Can change payment plan projection', 10, 'change_paymentplanprojection'),
(39, 'Can delete payment plan projection', 10, 'delete_paymentplanprojection'),
(40, 'Can view payment plan projection', 10, 'view_paymentplanprojection');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `basicconcepts_llrpricingassumption`
--

CREATE TABLE `basicconcepts_llrpricingassumption` (
  `id` bigint(20) NOT NULL,
  `instance_number` int(11) DEFAULT NULL,
  `cost_per_credit` decimal(65,2) NOT NULL,
  `loan_duration` int(11) NOT NULL,
  `deposit` decimal(65,2) NOT NULL,
  `price` decimal(65,2) NOT NULL,
  `deposit_to_price_ratio` decimal(65,4) NOT NULL,
  `predicted_llr` decimal(15,2) NOT NULL,
  `anticipated_growth` decimal(5,2) DEFAULT NULL,
  `price_change` decimal(15,2) DEFAULT NULL,
  `total_volume_before` int(11) DEFAULT NULL,
  `total_volume_after` int(11) DEFAULT NULL,
  `unit_price_before` decimal(10,2) DEFAULT NULL,
  `unit_price_after` decimal(10,2) DEFAULT NULL,
  `gross_revenue_before` decimal(15,2) DEFAULT NULL,
  `gross_revenue_after` decimal(15,2) DEFAULT NULL,
  `current_priced_cm2_before` decimal(15,2) DEFAULT NULL,
  `current_priced_cm2_after` decimal(15,2) DEFAULT NULL,
  `expected_cm2_revenue_before` decimal(65,2) DEFAULT NULL,
  `expected_cm2_revenue_after` decimal(65,2) DEFAULT NULL,
  `current_llr` decimal(5,2) DEFAULT NULL,
  `llr_threshold_zero_sum` decimal(65,2) DEFAULT NULL,
  `payment_plan_id` bigint(20) NOT NULL,
  `comment` longtext DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `basicconcepts_llrpricingassumption`
--

INSERT INTO `basicconcepts_llrpricingassumption` (`id`, `instance_number`, `cost_per_credit`, `loan_duration`, `deposit`, `price`, `deposit_to_price_ratio`, `predicted_llr`, `anticipated_growth`, `price_change`, `total_volume_before`, `total_volume_after`, `unit_price_before`, `unit_price_after`, `gross_revenue_before`, `gross_revenue_after`, `current_priced_cm2_before`, `current_priced_cm2_after`, `expected_cm2_revenue_before`, `expected_cm2_revenue_after`, `current_llr`, `llr_threshold_zero_sum`, `payment_plan_id`, `comment`, `reason`) VALUES
(1, 1, 3000.00, 256, 400000.00, 1168000.00, 0.3425, 12.49, 10.00, 4353.90, 324000, 356400, 26224.00, 1168001.23, 8496576000.00, 416275636803.84, 850000.00, 17349.00, 72220896000000.00, 72220896000000.00, 13.49, 832660.00, 1, NULL, NULL),
(2, 1, 30000.00, 256, 4000000.00, 11680000.00, 0.3425, 16.93, 10.00, 44439.00, 324000, 356400, 26224.00, 11679999.14, 8496576000.00, 4162751694921.60, 6.00, 0.01, 509794560.00, 509794560.00, 17.93, 23.92, 5, 'helllo', 'Acquisition drive'),
(3, 1, 30000.00, 256, 4000000.00, 11680000.00, 0.3425, 16.08, 10.00, 43977.00, 324000, 356400, 26499.00, 11679998.68, 8585676000.00, 4162751529088.68, 7.00, 0.01, 600997320.00, 600997320.00, 17.08, 24.07, 6, '', 'LLR with in threshold'),
(4, 1, 5000.00, 390, 300000.00, 2250000.00, 0.1333, 13.79, -20.00, 6796.80, 324000, 259200, 32624.00, 2249998.98, 10570176000.00, 583199736238.08, 4.00, 0.07, 422807040.00, 422807040.00, 14.79, 18.72, 9, 'hello world', ''),
(5, 2, 3000.00, 256, 4000000.00, 4768000.00, 0.8389, 16.08, -20.00, 17893.00, 324000, 259200, 26499.00, 4767999.52, 8585676000.00, 1235865475247.04, 7.00, 0.05, 600997320.00, 600997320.00, 17.08, 24.03, 6, 'hello', ''),
(6, 1, 2000.00, 365, 150000.00, 880000.00, 0.1705, 17.40, 10.00, 2162.30, 324000, 356400, 38899.00, 880000.41, 12603276000.00, 313632145161.72, 7.00, 0.28, 882229320.00, 882229320.00, 18.40, 25.12, 17, 'Alright', ''),
(7, 1, 3000.00, 256, 4000000.00, 4768000.00, 0.8389, 8.20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 35, NULL, NULL),
(8, 2, 3000.00, 256, 4000000.00, 4768000.00, 0.8389, 8.20, -20.00, 15689.00, 324000, 259200, 30199.00, 4767999.31, 9784476000.00, 1235865422188.80, 6.00, 0.05, 587068560.00, 587068560.00, 9.20, 15.15, 35, 'hello', 'LLR within threshold'),
(9, 1, 3000.00, 256, 400000.00, 1168000.00, 0.3425, 22.60, 10.00, 4307.70, 324000, 356400, 26499.00, 1167999.07, 8585676000.00, 416274869581.56, 7.00, 0.14, 600997320.00, 600997320.00, 23.60, 30.46, 2, 'great', 'LLR within threshold'),
(10, 1, 3000.00, 256, 4000000.00, 4768000.00, 0.8389, 34.94, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15, NULL, NULL),
(11, 1, 3000.00, 256, 4000000.00, 4768000.00, 0.8389, 14.60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 43, NULL, NULL),
(12, 1, 5000.00, 390, 4000000.00, 5950000.00, 0.6723, 15.89, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 44, NULL, NULL),
(13, 1, 3000.00, 390, 400000.00, 1570000.00, 0.2548, 18.33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 99, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `basicconcepts_paymentplanprojection`
--

CREATE TABLE `basicconcepts_paymentplanprojection` (
  `id` bigint(20) NOT NULL,
  `product_cost` decimal(10,2) NOT NULL,
  `plan_name` varchar(100) NOT NULL,
  `projections` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `basicconcepts_paymentplanprojection`
--

INSERT INTO `basicconcepts_paymentplanprojection` (`id`, `product_cost`, `plan_name`, `projections`) VALUES
(1, 163.42, 'Samsung A14 4/128', '[{\"date\": \"2024-01\", \"amount\": \"1653\"}, {\"date\": \"2024-02\", \"amount\": \"2990\"}, {\"date\": \"2024-03\", \"amount\": \"2814\"}, {\"date\": \"2024-04\", \"amount\": \"1843\"}, {\"date\": \"2024-05\", \"amount\": \"1905\"}, {\"date\": \"2024-06\", \"amount\": \"1957\"}, {\"date\": \"2024-07\", \"amount\": \"2332\"}, {\"date\": \"2024-08\", \"amount\": \"2783\"}, {\"date\": \"2024-09\", \"amount\": \"2600\"}, {\"date\": \"2024-10\", \"amount\": \"2751\"}, {\"date\": \"2024-11\", \"amount\": \"2883\"}, {\"date\": \"2024-12\", \"amount\": \"0\"}]'),
(3, 100.03, 'Samsung A05s 4/64', '[{\"date\": \"2024-01\", \"amount\": \"0\"}, {\"date\": \"2024-02\", \"amount\": \"5184\"}, {\"date\": \"2024-03\", \"amount\": \"6332\"}, {\"date\": \"2024-04\", \"amount\": \"6060\"}, {\"date\": \"2024-05\", \"amount\": \"6206\"}, {\"date\": \"2024-06\", \"amount\": \"6510\"}, {\"date\": \"2024-07\", \"amount\": \"7789\"}, {\"date\": \"2024-08\", \"amount\": \"8341\"}, {\"date\": \"2024-09\", \"amount\": \"9073\"}, {\"date\": \"2024-10\", \"amount\": \"9515\"}, {\"date\": \"2024-11\", \"amount\": \"10013\"}, {\"date\": \"2024-12\", \"amount\": \"0\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `basicconcepts_productdetail`
--

CREATE TABLE `basicconcepts_productdetail` (
  `id` bigint(20) NOT NULL,
  `loan_id` varchar(5000) NOT NULL,
  `payment_plan` varchar(5000) NOT NULL,
  `cost_per_credit` decimal(65,2) NOT NULL,
  `deposit` decimal(65,2) NOT NULL,
  `loan_duration` int(11) NOT NULL,
  `product_price` decimal(65,2) NOT NULL,
  `product_price_weighted_llr_200` decimal(15,4) NOT NULL,
  `quality_of_sales` varchar(5000) NOT NULL,
  `deposit_to_price_ratio` decimal(65,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `basicconcepts_productdetail`
--

INSERT INTO `basicconcepts_productdetail` (`id`, `loan_id`, `payment_plan`, `cost_per_credit`, `deposit`, `loan_duration`, `product_price`, `product_price_weighted_llr_200`, `quality_of_sales`, `deposit_to_price_ratio`) VALUES
(1, '1', 'MK +Phone Nokia C22 2/64 V1 CG', 65.00, 1199.00, 385, 26224.00, 0.1349, '0.95425', 0.0457),
(2, '2', 'MK +Phone Nokia C22 2/64 v1 GT', 60.00, 2499.00, 400, 26499.00, 0.2360, '0.747545455', 0.0943),
(3, '3', 'MK +Phone Nokia C22 2/64 v1 NEW GT 60% Pilot', 60.00, 2499.00, 400, 26499.00, 0.1958, '0.896928571', 0.0943),
(4, '4', 'MK +Phone Nokia C22 2/64 v2 CG', 65.00, 1199.00, 385, 26224.00, 0.1591, '0.924966573', 0.0457),
(5, '5', 'MK +Phone Nokia C22 2/64 v2 CG 75% Pilot', 65.00, 1199.00, 385, 26224.00, 0.1793, '0.906745293', 0.0457),
(6, '6', 'MK +Phone Nokia C22 2/64 v2 GT', 60.00, 2499.00, 400, 26499.00, 0.1708, '0.922305672', 0.0943),
(7, '7', 'MK +Phone Nokia C31 4/64 v1', 65.00, 1999.00, 420, 29299.00, 0.1971, '0.92376', 0.0682),
(8, '8', 'MK +Phone Nokia C31 4/64 v1 CG', 80.00, 1399.00, 390, 32599.00, 0.2208, '0.859226415', 0.0429),
(9, '9', 'MK +Phone Nokia C31 4/64 v1 GT', 75.00, 2999.00, 395, 32624.00, 0.1479, '0.922189655', 0.0919),
(10, '10', 'MK +Phone Nokia C31 4/64 v2 NEW GT 60% Pilot', 75.00, 2999.00, 395, 32624.00, 0.1815, '0.907881271', 0.0919),
(11, '11', 'MK +Phone Nokia C31 4/64 v3 CG', 80.00, 1399.00, 390, 32599.00, 0.1718, '0.91698122', 0.0429),
(12, '12', 'MK +Phone Nokia C31 4/64 v3 GT', 75.00, 2999.00, 395, 32624.00, 0.1982, '0.901330159', 0.0919),
(13, '13', 'MK +Phone Nokia C31 4/64 v4 CG 75% Pilot', 80.00, 1399.00, 390, 32599.00, 0.1931, '0.902364352', 0.0429),
(14, '14', 'MK +Phone Nokia C31 4/64 v6 DS', 85.00, 1999.00, 400, 35999.00, 0.3212, '0.813741935', 0.0555),
(15, '15', 'MK +Phone Nokia C31 4/64 v7', 85.00, 1899.00, 400, 35899.00, 0.3594, '0.722458333', 0.0529),
(16, '16', 'MK +Phone Nokia G21 4/64 CSTR 1', 85.00, 1799.00, 410, 36649.00, 0.5474, '0.8235', 0.0491),
(17, '17', 'MK +Phone Nokia G21 4/64 DS v1 CG', 90.00, 1999.00, 410, 38899.00, 0.1840, '0.916510549', 0.0514),
(18, '18', 'MK +Phone Nokia G21 4/64 DS v1 GT', 90.00, 3999.00, 390, 39099.00, 0.2056, '0.852676471', 0.1023),
(19, '19', 'MK +Phone Nokia G21 4/64 DS v2 NEW GT 60% Pilot', 90.00, 3999.00, 390, 39099.00, 0.1124, '0.976357143', 0.1023),
(20, '20', 'MK +Phone Nokia G21 4/64 v3', 70.00, 1999.00, 365, 27549.00, 0.0621, '1.0', 0.0726),
(21, '21', 'MK +Phone Nokia T10 Tablet 4/64 CG v1', 100.00, 2899.00, 385, 41399.00, 0.2310, '0.875966667', 0.0700),
(22, '22', 'MK +Phone Nokia T10 Tablet 4/64 CG v2', 100.00, 2199.00, 385, 40699.00, 0.2339, '0.828987952', 0.0540),
(23, '23', 'MK +Phone Nokia T10 Tablet 4/64 GT v1', 95.00, 4699.00, 400, 42699.00, 0.0847, '1.0', 0.1100),
(24, '24', 'MK +Phone Samsung A03 Core 2/32  DS v16', 55.00, 1499.00, 400, 23499.00, 0.1297, '1.0', 0.0638),
(25, '25', 'MK +Phone Samsung A03 Core 2/32 DS NEW GT 60% Pilot', 65.00, 2499.00, 370, 26549.00, 0.1788, '0.851443878', 0.0941),
(26, '26', 'MK +Phone Samsung A03 Core 2/32 DS NEW v2 GT 60% Pilot', 70.00, 2599.00, 385, 29549.00, 0.2567, '0.837108434', 0.0880),
(27, '27', 'MK +Phone Samsung A03 Core 2/32 DS v1 CG', 65.00, 1199.00, 390, 26549.00, 0.1643, '0.926358355', 0.0452),
(28, '28', 'MK +Phone Samsung A03 Core 2/32 DS v1 GT', 65.00, 2499.00, 370, 26549.00, 0.1797, '0.90159364', 0.0941),
(29, '29', 'MK +Phone Samsung A03 Core 2/32 DS v2 CG', 70.00, 1299.00, 400, 29299.00, 0.1883, '0.900418893', 0.0443),
(30, '30', 'MK +Phone Samsung A03 Core 2/32 DS v2 GT', 70.00, 2599.00, 385, 29549.00, 0.2210, '0.877825641', 0.0880),
(31, '31', 'MK +Phone Samsung A03 Core 2/32 DS v3 CG', 70.00, 1299.00, 400, 29299.00, 0.1621, '0.932609719', 0.0443),
(32, '32', 'MK +Phone Samsung A03 Core 2/32 DS v3 CG 75% Pilot', 70.00, 1299.00, 400, 29299.00, 0.1739, '0.913995853', 0.0443),
(33, '33', 'MK +Phone Samsung A03 Core 2/32 DS v3 GT', 70.00, 2599.00, 380, 29199.00, 0.2200, '0.894003759', 0.0890),
(34, '34', 'MK +Phone Samsung A03 Core 2/32 DS v3 GT 60% Pilot', 70.00, 2599.00, 380, 29199.00, 0.2058, '0.893263566', 0.0890),
(35, '35', 'MK +Phone Samsung A03 Core 2/32 v22 DS', 70.00, 1499.00, 410, 30199.00, 0.0920, '1.0', 0.0496),
(36, '36', 'MK +Phone Samsung A03 Core 2/32 v23 DS', 70.00, 1499.00, 390, 28799.00, 0.1998, '0.840277778', 0.0521),
(37, '37', 'MK +Phone Samsung A04S 4/64 CSTR1 v1', 80.00, 2999.00, 400, 34999.00, 0.1915, '0.84425', 0.0857),
(38, '38', 'MK +Phone Samsung A04S 4/64 CSTR1 v3 DS', 90.00, 2499.00, 410, 39399.00, 0.0912, '1.0', 0.0634),
(39, '39', 'MK +Phone Samsung A04S 4/64 DS v4 CG', 80.00, 2299.00, 410, 35099.00, 0.0969, '1.0', 0.0655),
(40, '40', 'MK +Phone Samsung A04S 4/64 DS v7 GT', 100.00, 3799.00, 390, 42799.00, 0.2182, '0.870814607', 0.0888),
(41, '41', 'MK +Phone Samsung A04S 4/64 DS v8 CG', 100.00, 2799.00, 400, 42799.00, 0.1609, '0.931055111', 0.0654),
(42, '42', 'MK +Phone Samsung A04S 4/64 DS v9 CG 75% Pilot', 100.00, 2799.00, 400, 42799.00, 0.1590, '0.939569069', 0.0654),
(43, '43', 'MK +Phone Samsung A14 4/128 v2 CG', 120.00, 3799.00, 410, 52999.00, 0.1560, '0.941919626', 0.0717),
(44, '44', 'MK +Phone Samsung A14 4/128 v2 GT', 120.00, 4999.00, 400, 52999.00, 0.1689, '0.939040816', 0.0943),
(45, '45', 'MK +Phone Samsung A24 4/128 v3 CG', 150.00, 3999.00, 390, 62499.00, 0.1379, '0.993', 0.0640),
(46, '46', 'MK Phone Nokia C22 2/64 Insurance Pilot v2', 65.00, 3199.00, 365, 26924.00, 0.1391, '0.973211823', 0.1188),
(47, '47', 'MK Phone Nokia C22 2/64 v1', 65.00, 3199.00, 365, 26924.00, 0.2216, '0.923893939', 0.1188),
(48, '48', 'MK Phone Nokia C22 2/64 v1 HRA', 65.00, 3199.00, 365, 26924.00, 0.2041, '0.936969697', 0.1188),
(49, '49', 'MK Phone Nokia C22 2/64 v2', 65.00, 3199.00, 365, 26924.00, 0.1609, '0.959398019', 0.1188),
(50, '50', 'MK Phone Nokia C22 2/64 v2 HRA', 65.00, 3199.00, 365, 26924.00, 0.1861, '0.94629331', 0.1188),
(51, '51', 'MK Phone Nokia C31 4/64 Insurance Pilot v2', 80.00, 3699.00, 365, 32899.00, 0.1725, '0.978', 0.1124),
(52, '52', 'MK Phone Nokia C31 4/64 Insurance Pilot v4', 80.00, 3699.00, 365, 32899.00, 0.1536, '0.961622514', 0.1124),
(53, '53', 'MK Phone Nokia C31 4/64 v1', 70.00, 4299.00, 365, 29849.00, 0.0635, '1.0', 0.1440),
(54, '54', 'MK Phone Nokia C31 4/64 v2 HRA', 70.00, 4299.00, 365, 29849.00, 0.1649, '0.916666667', 0.1440),
(55, '55', 'MK Phone Nokia C31 4/64 v5', 80.00, 3499.00, 365, 32699.00, 0.0965, '1.0', 0.1070),
(56, '56', 'MK Phone Nokia C31 4/64 v5 HRA', 80.00, 3499.00, 365, 32699.00, 0.1854, '0.9156', 0.1070),
(57, '57', 'MK Phone Nokia C31 4/64 v6', 80.00, 3699.00, 365, 32899.00, 0.1636, '0.967612903', 0.1124),
(58, '58', 'MK Phone Nokia C31 4/64 v6 HRA', 80.00, 3699.00, 365, 32899.00, 0.2094, '0.924', 0.1124),
(59, '59', 'MK Phone Nokia C31 4/64 v8', 80.00, 3699.00, 365, 32899.00, 0.1714, '0.949911641', 0.1124),
(60, '60', 'MK Phone Nokia C31 4/64 v8 HRA', 80.00, 3699.00, 365, 32899.00, 0.2102, '0.924705577', 0.1124),
(61, '61', 'MK Phone Nokia C32 4/128 PLAK Insurance Pilot v1', 85.00, 3899.00, 365, 34924.00, 0.1154, '0.999088542', 0.1116),
(62, '62', 'MK Phone Nokia C32 4/128 PLAK v1', 85.00, 3899.00, 365, 34924.00, 0.1139, '0.993076923', 0.1116),
(63, '63', 'MK Phone Nokia G21 4/64 HMD v20', 95.00, 4899.00, 365, 39574.00, 0.0712, '0.9991', 0.1238),
(64, '64', 'MK Phone Nokia G21 4/64 HMD v20 HRA', 95.00, 4899.00, 365, 39574.00, 0.4115, '0.736642857', 0.1238),
(65, '65', 'MK Phone Nokia G21 4/64 Insurance Pilot v1', 95.00, 4899.00, 365, 39574.00, 0.1674, '0.943450945', 0.1238),
(66, '66', 'MK Phone Nokia G21 4/64 v18 HRA', 95.00, 4899.00, 365, 39574.00, 0.2320, '0.898812632', 0.1238),
(67, '67', 'MK Phone Nokia G21 4/64 v20', 95.00, 4899.00, 365, 39574.00, 0.1843, '0.933307133', 0.1238),
(68, '68', 'MK Phone Nokia T10 Tablet 4/64 v1', 100.00, 6799.00, 365, 43299.00, 0.2570, '0.859135593', 0.1570),
(69, '69', 'MK Phone Nokia T10 Tablet 4/64 v2', 100.00, 6099.00, 365, 42599.00, 0.2529, '0.966888889', 0.1432),
(70, '70', 'MK Phone Samsung A03 Core 2/32 28 DS', 71.00, 3399.00, 365, 29314.00, 0.1586, '0.965746258', 0.1160),
(71, '71', 'MK Phone Samsung A03 Core 2/32 Insurance Pilot v2', 65.00, 3199.00, 365, 26924.00, 0.2449, '0.95016', 0.1188),
(72, '72', 'MK Phone Samsung A03 Core 2/32 Insurance Pilot v3', 71.00, 3699.00, 365, 29614.00, 0.1431, '0.956828293', 0.1249),
(73, '73', 'MK Phone Samsung A03 Core 2/32 Insurance Pilot v4', 71.00, 3399.00, 365, 29314.00, 0.1493, '0.968212627', 0.1160),
(74, '74', 'MK Phone Samsung A03 Core 2/32 v1 FE Pilot', 71.00, 3399.00, 365, 29314.00, 0.1462, '0.972965116', 0.1160),
(75, '75', 'MK Phone Samsung A03 Core 2/32 v19 DS', 75.00, 3499.00, 365, 30874.00, 0.0895, '1.0', 0.1133),
(76, '76', 'MK Phone Samsung A03 Core 2/32 v26 DS', 65.00, 3199.00, 365, 26924.00, 0.1954, '0.921304833', 0.1188),
(77, '77', 'MK Phone Samsung A03 Core 2/32 v26 DS HRA', 65.00, 3199.00, 365, 26924.00, 0.2241, '0.923985714', 0.1188),
(78, '78', 'MK Phone Samsung A03 Core 2/32 v27 DS', 71.00, 3699.00, 365, 29614.00, 0.1636, '0.947226095', 0.1249),
(79, '79', 'MK Phone Samsung A03 Core 2/32 v27 DS HRA', 71.00, 3699.00, 365, 29614.00, 0.0925, '0.969242857', 0.1249),
(80, '80', 'MK Phone Samsung A03 Core 2/32 v28 DS HRA', 71.00, 3399.00, 365, 29314.00, 0.1686, '0.961116942', 0.1160),
(81, '81', 'MK Phone Samsung A04 4/64 ST Pilot v1', 90.00, 4999.00, 365, 37849.00, 0.1199, '0.975126761', 0.1321),
(82, '82', 'MK Phone Samsung A04e 3/32 v1 FE Pilot', 80.00, 4699.00, 365, 33899.00, 0.1392, '0.964805556', 0.1386),
(83, '83', 'MK Phone Samsung A04e 3/32 v1 ST Pilot', 80.00, 4699.00, 365, 33899.00, 0.1795, '0.946592593', 0.1386),
(84, '84', 'MK Phone Samsung A04e 3/64 v1 ST Pilot', 70.00, 4199.00, 365, 29749.00, 0.0398, '1.0', 0.1411),
(85, '85', 'MK Phone Samsung A04e 3/64 v2 ST Pilot', 85.00, 4899.00, 365, 35924.00, 0.1416, '0.96784058', 0.1364),
(86, '86', 'MK Phone Samsung A04S 4/64 DS v10 HRA', 105.00, 4499.00, 365, 42824.00, 0.1679, '0.952372828', 0.1051),
(87, '87', 'MK Phone Samsung A04S 4/64 DS v5', 85.00, 4199.00, 365, 35224.00, 0.0647, '1.0', 0.1192),
(88, '88', 'MK Phone Samsung A04S 4/64 DS v6 HRA', 85.00, 4199.00, 365, 35224.00, 0.0749, '1.0', 0.1192),
(89, '89', 'MK Phone Samsung A04S 4/64 DS v7 HRA', 105.00, 4999.00, 365, 43324.00, 0.4747, '0.8255', 0.1154),
(90, '90', 'MK Phone Samsung A04S 4/64 DS v8', 105.00, 4999.00, 365, 43324.00, 0.1493, '0.95789924', 0.1154),
(91, '91', 'MK Phone Samsung A04S 4/64 DS v9', 105.00, 4499.00, 365, 42824.00, 0.1681, '0.954474263', 0.1051),
(92, '92', 'MK Phone Samsung A04S 4/64 FE Pilot v1', 105.00, 4499.00, 365, 42824.00, 0.1366, '0.968075145', 0.1051),
(93, '93', 'MK Phone Samsung A04S 4/64 Insurance Pilot v2', 105.00, 4999.00, 365, 43324.00, 0.2429, '0.923763158', 0.1154),
(94, '94', 'MK Phone Samsung A04S 4/64 Insurance Pilot v4', 105.00, 4499.00, 365, 42824.00, 0.1542, '0.960849188', 0.1051),
(95, '95', 'MK Phone Samsung A13 4/64 v13', 90.00, 5599.00, 365, 38449.00, 0.1440, '0.98075', 0.1456),
(96, '96', 'MK Phone Samsung A14 4/128 Insurance Pilot v6', 130.00, 5599.00, 365, 53049.00, 0.1873, '0.938907317', 0.1055),
(97, '97', 'MK Phone Samsung A14 4/128 v1 ST Pilot', 135.00, 6299.00, 365, 55574.00, 0.0695, '1.0', 0.1133),
(98, '98', 'MK Phone Samsung A14 4/128 v2 ST Pilot', 130.00, 5599.00, 365, 53049.00, 0.1607, '0.94675', 0.1055),
(99, '99', 'MK Phone Samsung A14 4/128 v4', 130.00, 5599.00, 365, 53049.00, 0.1933, '0.928567033', 0.1055),
(100, '100', 'MK Phone Samsung A14 4/128 v5 HRA', 130.00, 5599.00, 365, 53049.00, 0.2606, '0.872345798', 0.1055),
(101, '101', 'MK Phone Samsung A14 4/64 v2 FE Pilot', 115.00, 5599.00, 365, 47574.00, 0.1535, '0.94673262', 0.1177),
(102, '102', 'MK Phone Samsung A23 4/128  ST Pilot v2', 120.00, 9699.00, 365, 53499.00, 0.1321, '0.949155556', 0.1813),
(103, '103', 'MK Phone Samsung A23 4/64 v13', 100.00, 6999.00, 365, 43499.00, 0.1900, '0.8238', 0.1609),
(104, '104', 'MK Phone Samsung A23 4/64 v15 DS', 100.00, 6999.00, 365, 43499.00, 0.2587, '0.921947368', 0.1609),
(105, '105', 'MK Phone Samsung A23 4/64 v16 DS HRA', 100.00, 6999.00, 365, 43499.00, 0.1236, '1.0', 0.1609),
(106, '106', 'MK Phone Samsung A24 4/128 Insurance Pilot v7', 150.00, 7699.00, 365, 62449.00, 0.1066, '0.989651613', 0.1233),
(107, '107', 'MK Phone Samsung A24 4/128 v5 HRA', 150.00, 7999.00, 365, 62749.00, 0.1083, '0.9888', 0.1275),
(108, '108', 'MK Phone Samsung A24 4/128 v6', 150.00, 7699.00, 365, 62449.00, 0.1360, '0.970518493', 0.1233),
(109, '109', 'MK Phone Nokia (G10 3/32) Saf -Data HMD', 55.00, 3999.00, 365, 24074.00, 0.1072, '0.907', 0.1661),
(110, '110', 'MK Phone Nokia 1.4  Saf-Data HMD', 45.00, 3299.00, 365, 19724.00, 0.1431, '0.961', 0.1673),
(111, '111', 'MK Phone Nokia 1.4  Saf-Data v1', 45.00, 3299.00, 365, 19724.00, 0.1245, '0.948', 0.1673),
(112, '112', 'MK Phone Nokia 1.4  Saf-Data v9', 50.00, 3499.00, 365, 21749.00, 0.1248, '0.942', 0.1609),
(113, '113', 'MK Phone Nokia 1.4  v2', 45.00, 3299.00, 365, 19724.00, 0.1429, '0.941', 0.1673),
(114, '114', 'MK Phone Nokia 1.4 Saf-Data HMD v2', 50.00, 3499.00, 365, 21749.00, 0.1211, '0.953', 0.1609),
(115, '115', 'MK Phone Nokia 2 2 v1 Rev A', 50.00, 2999.00, 200, 12999.00, 0.0887, '0.92', 0.2307),
(116, '116', 'MK Phone Nokia 2 2 v2 Rev B', 50.00, 1999.00, 180, 10999.00, 0.1738, '0.904', 0.1817),
(117, '117', 'MK Phone Nokia 2.3 v2', 50.00, 3999.00, 365, 22249.00, 0.1669, '0.98', 0.1797),
(118, '118', 'MK Phone Nokia 2.4 Saf-Data v1', 50.00, 3499.00, 365, 21749.00, 0.1819, '0.922', 0.1609),
(119, '119', 'MK Phone Nokia 2.4 v2', 50.00, 3499.00, 365, 21749.00, 0.1135, '0.96', 0.1609),
(120, '120', 'MK Phone Nokia 3.4 (4+64GB) v4', 65.00, 4999.00, 365, 28724.00, 0.0989, '0.963', 0.1740),
(121, '121', 'MK Phone Nokia 3.4 3+64 Saf-Data v1', 60.00, 4999.00, 365, 26899.00, 0.0556, '0.951', 0.1858),
(122, '122', 'MK Phone Nokia 3.4 3+64 Saf-Data v2', 60.00, 4499.00, 365, 26399.00, 0.0936, '0.954', 0.1704),
(123, '123', 'MK Phone Nokia 3.4 4+64 Saf-Data HMD', 65.00, 4999.00, 365, 28724.00, 0.1258, '0.974', 0.1740),
(124, '124', 'MK Phone Nokia 3.4 4+64 Saf-Data HMD v2', 60.00, 4499.00, 365, 26399.00, 0.0852, '0.968', 0.1704),
(125, '125', 'MK Phone Nokia 3.4 4+64 Saf-Data v1', 65.00, 4999.00, 365, 28724.00, 0.0933, '0.962', 0.1740),
(126, '126', 'MK Phone Nokia 5.4 4/128 Saf-Data HMD', 85.00, 5499.00, 365, 36524.00, 0.1185, '0.96', 0.1506),
(127, '127', 'MK Phone Nokia 5.4 4/128 Saf-Data v4', 85.00, 5499.00, 365, 36524.00, 0.1035, '0.96', 0.1506),
(128, '128', 'MK Phone Nokia 5.4 4/128 v3', 85.00, 5499.00, 365, 36524.00, 0.1111, '0.956', 0.1506),
(129, '129', 'MK Phone Nokia 5.4 v2', 85.00, 5499.00, 365, 36524.00, 0.1361, '0.968', 0.1506),
(130, '130', 'MK Phone Nokia C01 Plus 1/16 HMD v2 ', 40.00, 3299.00, 365, 17899.00, 0.1638, '0.938', 0.1843),
(131, '131', 'MK Phone Nokia C01 Plus 1/16 v1', 40.00, 3299.00, 365, 17899.00, 0.1175, '0.927', 0.1843),
(132, '132', 'MK Phone Nokia C01 Plus 1/16 v7', 40.00, 2499.00, 365, 17099.00, 0.1664, '0.915', 0.1461),
(133, '133', 'MK Phone Nokia C01 Plus 1/16 v9', 40.00, 2499.00, 365, 17099.00, 0.1641, '0.911', 0.1461),
(134, '134', 'MK Phone Nokia C01 Plus HMD 1/16 v8', 40.00, 2499.00, 365, 17099.00, 0.1741, '0.937', 0.1461),
(135, '135', 'MK Phone Nokia C01 Plus Iris 2/16 v6', 40.00, 3499.00, 365, 18099.00, 0.1221, '0.92', 0.1933),
(136, '136', 'MK Phone Nokia C01 Plus Iris 2/16 v8', 40.00, 3299.00, 365, 17899.00, 0.1359, '0.898', 0.1843),
(137, '137', 'MK Phone Nokia C01 Plus Iris HMD', 40.00, 2499.00, 365, 17099.00, 0.1662, '0.905', 0.1461),
(138, '138', 'MK Phone Nokia C01 Plus Iris HMD v5', 40.00, 3499.00, 365, 18099.00, 0.1525, '0.941', 0.1933),
(139, '139', 'MK Phone Nokia C01 Plus Iris v1', 40.00, 2499.00, 365, 17099.00, 0.1489, '0.923', 0.1461),
(140, '140', 'MK Phone Nokia C01 Plus Iris v4', 40.00, 3499.00, 365, 18099.00, 0.1191, '0.925', 0.1933),
(141, '141', 'MK Phone Nokia C1 2nd Edition v2', 35.00, 2499.00, 365, 15274.00, 0.0142, '0.967', 0.1636),
(142, '142', 'MK Phone Nokia C1 Plus Saf-Data v1', 35.00, 2499.00, 365, 15274.00, 0.1272, '0.946', 0.1636),
(143, '143', 'MK Phone Nokia C1 Plus v2', 35.00, 2499.00, 365, 15274.00, 0.1570, '0.949', 0.1636),
(144, '144', 'MK Phone Nokia C10 1/32 v3', 40.00, 3299.00, 365, 17899.00, 0.1397, '0.945', 0.1843),
(145, '145', 'MK Phone Nokia C20 2/16 HMD v3', 45.00, 2999.00, 365, 19424.00, 0.1412, '0.952', 0.1544),
(146, '146', 'MK Phone Nokia C20 2/16 HMD v5', 45.00, 3299.00, 365, 19724.00, 0.1237, '0.957', 0.1673),
(147, '147', 'MK Phone Nokia C20 2/16 HMD v6', 45.00, 3999.00, 365, 20424.00, 0.1113, '0.959', 0.1958),
(148, '148', 'MK Phone Nokia C20 2/16 v2', 45.00, 2999.00, 365, 19424.00, 0.1259, '0.935', 0.1544),
(149, '149', 'MK Phone Nokia C20 2/16 v7', 45.00, 3299.00, 365, 19724.00, 0.1245, '0.928', 0.1673),
(150, '150', 'MK Phone Nokia C21 2/32 HMD v11', 50.00, 3399.00, 365, 21649.00, 0.1880, '0.912', 0.1570),
(151, '151', 'MK Phone Nokia C21 2/32 HMD v12 HRA', 50.00, 3399.00, 365, 21649.00, 0.2097, '0.872', 0.1570),
(152, '152', 'MK Phone Nokia C21 2/32 HMD v6', 60.00, 4299.00, 365, 26199.00, 0.1507, '0.933', 0.1641),
(153, '153', 'MK Phone Nokia C21 2/32 v10', 50.00, 3399.00, 365, 21649.00, 0.1555, '0.917', 0.1570),
(154, '154', 'MK Phone Nokia C21 2/32 v10 HRA', 45.00, 5224.00, 365, 21649.00, 0.0626, '0.875', 0.2413),
(155, '155', 'MK Phone Nokia C21 2/32 v11 HRA', 50.00, 3399.00, 365, 21649.00, 0.1734, '0.871', 0.1570),
(156, '156', 'MK Phone Nokia C21 2/32 v2', 50.00, 3999.00, 365, 22249.00, 0.1112, '0.936', 0.1797),
(157, '157', 'MK Phone Nokia C21 2/32 v7', 60.00, 4299.00, 365, 26199.00, 0.1317, '0.925', 0.1641),
(158, '158', 'MK Phone Nokia C21 2/32 v9', 60.00, 4299.00, 365, 26199.00, 0.1499, '0.921', 0.1641),
(159, '159', 'MK Phone Nokia C21 Plus 3/32 HMD v12', 60.00, 3999.00, 365, 25899.00, 0.1473, '0.934', 0.1544),
(160, '160', 'MK Phone Nokia C21 Plus 3/32 HMD v13 HRA', 60.00, 3999.00, 365, 25899.00, 0.1009, '0.949', 0.1544),
(161, '161', 'MK Phone Nokia C21 Plus 3/32 HMD v4', 70.00, 5299.00, 365, 30849.00, 0.1104, '0.939', 0.1718),
(162, '162', 'MK Phone Nokia C21 Plus 3/32 v10', 65.00, 4499.00, 365, 28224.00, 0.1343, '0.938', 0.1594),
(163, '163', 'MK Phone Nokia C21 Plus 3/32 v11', 60.00, 3999.00, 365, 25899.00, 0.1317, '0.935', 0.1544),
(164, '164', 'MK Phone Nokia C21 Plus 3/32 v11 HMD', 65.00, 4499.00, 365, 28224.00, 0.1174, '0.965', 0.1594),
(165, '165', 'MK Phone Nokia C21 Plus 3/32 v11 HRA', 55.00, 5824.00, 365, 25899.00, 0.0487, '0.979', 0.2249),
(166, '166', 'MK Phone Nokia C21 Plus 3/32 v12 HRA', 60.00, 3999.00, 365, 25899.00, 0.1717, '0.915', 0.1544),
(167, '167', 'MK Phone Nokia C21 Plus 3/32 v2', 55.00, 4699.00, 365, 24774.00, 0.0911, '0.954', 0.1897),
(168, '168', 'MK Phone Nokia C21 Plus 3/32 v3', 70.00, 5299.00, 365, 30849.00, 0.1160, '0.94', 0.1718),
(169, '169', 'MK Phone Nokia C21 Plus 3/32 v6', 70.00, 5299.00, 365, 30849.00, 0.1175, '0.943', 0.1718),
(170, '170', 'MK Phone Nokia C22 2/64 Insurance Pilot V1', 65.00, 3199.00, 365, 26924.00, 0.1403, '0.968', 0.1188),
(171, '171', 'MK Phone Nokia C30 2/32 HMD v10', 75.00, 5499.00, 365, 32874.00, 0.0954, '0.966', 0.1673),
(172, '172', 'MK Phone Nokia C30 2/32 HMD v14', 70.00, 4699.00, 365, 30249.00, 0.1076, '0.982', 0.1553),
(173, '173', 'MK Phone Nokia C30 2/32 HMD v16', 65.00, 4299.00, 365, 28024.00, 0.0730, '0.959', 0.1534),
(174, '174', 'MK Phone Nokia C30 2/32 HMD v17 HRA', 65.00, 4299.00, 365, 28024.00, 0.2843, '0.83', 0.1534),
(175, '175', 'MK Phone Nokia C30 2/32 HMD v2', 60.00, 2999.00, 365, 24899.00, 0.1466, '0.939', 0.1204),
(176, '176', 'MK Phone Nokia C30 2/32 HMD v5', 55.00, 3999.00, 365, 24074.00, 0.0965, '0.967', 0.1661),
(177, '177', 'MK Phone Nokia C30 2/32 HMD v7', 55.00, 4299.00, 365, 24374.00, 0.1117, '0.94', 0.1764),
(178, '178', 'MK Phone Nokia C30 2/32 v1', 60.00, 2999.00, 365, 24899.00, 0.1422, '0.93', 0.1204),
(179, '179', 'MK Phone Nokia C30 2/32 v10', 75.00, 5499.00, 365, 32874.00, 0.1223, '0.937', 0.1673),
(180, '180', 'MK Phone Nokia C30 2/32 v12', 70.00, 4999.00, 365, 30549.00, 0.1254, '0.941', 0.1636),
(181, '181', 'MK Phone Nokia C30 2/32 v12 HMD', 70.00, 4999.00, 365, 30549.00, 0.0403, '0.986', 0.1636),
(182, '182', 'MK Phone Nokia C30 2/32 v13', 70.00, 4699.00, 365, 30249.00, 0.1325, '0.942', 0.1553),
(183, '183', 'MK Phone Nokia C30 2/32 v15', 65.00, 4299.00, 365, 28024.00, 0.1383, '0.933', 0.1534),
(184, '184', 'MK Phone Nokia C30 2/32 v15 HRA', 60.00, 6124.00, 365, 28024.00, 0.2985, '0.792', 0.2185),
(185, '185', 'MK Phone Nokia C30 2/32 v16 HRA', 65.00, 4299.00, 365, 28024.00, 0.1882, '0.907', 0.1534),
(186, '186', 'MK Phone Nokia C30 2/32 v8', 60.00, 3999.00, 365, 25899.00, 0.1096, '0.94', 0.1544),
(187, '187', 'MK Phone Nokia C30 2/32 v9', 75.00, 5499.00, 365, 32874.00, 0.1221, '0.936', 0.1673),
(188, '188', 'MK Phone Nokia C31 4/64 DS v7 ST Pilot', 90.00, 4099.00, 365, 36949.00, 0.1638, '0.933', 0.1109),
(189, '189', 'MK Phone Nokia C31 4/64 Insurance Pilot v1', 80.00, 3499.00, 365, 32699.00, 0.1534, '0.948', 0.1070),
(190, '190', 'MK Phone Nokia C31 4/64 v1 HRA', 60.00, 7949.00, 365, 29849.00, 0.0726, '0.998', 0.2663),
(191, '191', 'MK Phone Nokia C31 4/64 v11 HMD', 80.00, 3699.00, 365, 32899.00, 0.0937, '0.997', 0.1124),
(192, '192', 'MK Phone Nokia C31 4/64 v3', 90.00, 4099.00, 365, 36949.00, 0.1910, '0.901', 0.1109),
(193, '193', 'MK Phone Nokia C31 4/64 v3 HRA', 90.00, 4099.00, 365, 36949.00, 0.2599, '0.859', 0.1109),
(194, '194', 'MK Phone Nokia C31 4/64 v4', 85.00, 3999.00, 365, 35024.00, 0.1811, '0.902', 0.1142),
(195, '195', 'MK Phone Nokia C31 4/64 v4 HRA', 85.00, 3999.00, 365, 35024.00, 0.2249, '0.879', 0.1142),
(196, '196', 'MK Phone Nokia C31 4/64 v5 HMD', 70.00, 4299.00, 365, 29849.00, 0.0905, '0.945', 0.1440),
(197, '197', 'MK Phone Nokia C31 4/64 v6 HMD', 90.00, 4099.00, 365, 36949.00, 0.1473, '0.931', 0.1109),
(198, '198', 'MK Phone Nokia C31 4/64 v7 HMD', 85.00, 3999.00, 365, 35024.00, 0.0366, '1.0', 0.1142),
(199, '199', 'MK Phone Nokia C31 4/64 v9 HMD', 80.00, 3699.00, 365, 32899.00, 0.1995, '0.89', 0.1124),
(200, '200', 'MK Phone Nokia G10 3/32 HMD v13', 60.00, 3699.00, 365, 25599.00, 0.1399, '0.94', 0.1445),
(201, '201', 'MK Phone Nokia G10 3/32 HMD v4', 55.00, 4299.00, 365, 24374.00, 0.1085, '0.956', 0.1764),
(202, '202', 'MK Phone Nokia G10 3/32 Saf HMD v9', 65.00, 4999.00, 365, 28724.00, 0.2157, '0.937', 0.1740),
(203, '203', 'MK Phone Nokia G10 3/32 Saf-Data v3', 55.00, 3999.00, 365, 24074.00, 0.1219, '0.947', 0.1661),
(204, '204', 'MK Phone Nokia G10 3/32 v12', 60.00, 3699.00, 365, 25599.00, 0.1392, '0.933', 0.1445),
(205, '205', 'MK Phone Nokia G10 3/32 v13', 60.00, 3699.00, 365, 25599.00, 0.1476, '0.882', 0.1445),
(206, '206', 'MK Phone Nokia G10 3/32 v2', 55.00, 3999.00, 365, 24074.00, 0.1740, '0.96', 0.1661),
(207, '207', 'MK Phone Nokia G10 3/32 v8', 65.00, 4999.00, 365, 28724.00, 0.1424, '0.938', 0.1740),
(208, '208', 'MK Phone Nokia G20 4/64 Saf-Data HMD', 70.00, 4999.00, 365, 30549.00, 0.1008, '0.968', 0.1636),
(209, '209', 'MK Phone Nokia G20 4/64 Saf-Data v4', 70.00, 4999.00, 365, 30549.00, 0.1035, '0.963', 0.1636),
(210, '210', 'MK Phone Nokia G20 4/64 v3', 70.00, 4999.00, 365, 30549.00, 0.1095, '0.954', 0.1636),
(211, '211', 'MK Phone Nokia G21 4/64 HMD v11', 90.00, 5999.00, 365, 38849.00, 0.1224, '0.942', 0.1544),
(212, '212', 'MK Phone Nokia G21 4/64 HMD v14', 85.00, 5699.00, 365, 36724.00, 0.1445, '0.963', 0.1552),
(213, '213', 'MK Phone Nokia G21 4/64 HMD v16', 80.00, 5599.00, 365, 34799.00, 0.0993, '0.966', 0.1609),
(214, '214', 'MK Phone Nokia G21 4/64 HMD v17 HRA', 80.00, 5599.00, 365, 34799.00, 0.6989, '0.83', 0.1609),
(215, '215', 'MK Phone Nokia G21 4/64 HMD v19', 80.00, 4999.00, 365, 34199.00, 0.1491, '0.911', 0.1462),
(216, '216', 'MK Phone Nokia G21 4/64 HMD v19 HRA', 80.00, 4999.00, 365, 34199.00, 0.2268, '0.857', 0.1462),
(217, '217', 'MK Phone Nokia G21 4/64 HMD v5', 65.00, 4999.00, 365, 28724.00, 0.0586, '0.973', 0.1740),
(218, '218', 'MK Phone Nokia G21 4/64 HMD v8', 70.00, 4499.00, 365, 30049.00, 0.0831, '0.965', 0.1497),
(219, '219', 'MK Phone Nokia G21 4/64 v10', 90.00, 5999.00, 365, 38849.00, 0.1220, '0.95', 0.1544),
(220, '220', 'MK Phone Nokia G21 4/64 v11', 90.00, 5999.00, 365, 38849.00, 0.1357, '0.942', 0.1544),
(221, '221', 'MK Phone Nokia G21 4/64 v13', 85.00, 5699.00, 365, 36724.00, 0.1381, '0.946', 0.1552),
(222, '222', 'MK Phone Nokia G21 4/64 v15', 80.00, 5599.00, 365, 34799.00, 0.1392, '0.943', 0.1609),
(223, '223', 'MK Phone Nokia G21 4/64 v15 HRA', 70.00, 9249.00, 365, 34799.00, 0.0913, '0.981', 0.2658),
(224, '224', 'MK Phone Nokia G21 4/64 v16 HRA', 80.00, 5599.00, 365, 34799.00, 0.2192, '0.893', 0.1609),
(225, '225', 'MK Phone Nokia G21 4/64 v17 HRA', 80.00, 4999.00, 365, 34199.00, 0.2016, '0.912', 0.1462),
(226, '226', 'MK Phone Nokia G21 4/64 v19', 80.00, 4999.00, 365, 34199.00, 0.1537, '0.937', 0.1462),
(227, '227', 'MK Phone Nokia G21 4/64 v2', 65.00, 4999.00, 365, 28724.00, 0.0894, '0.964', 0.1740),
(228, '228', 'MK Phone Nokia G21 4/64 v6', 70.00, 4999.00, 365, 30549.00, 0.0935, '0.963', 0.1636),
(229, '229', 'MK Phone Nokia G21 4/64 v7', 70.00, 4499.00, 365, 30049.00, 0.1052, '0.954', 0.1497),
(230, '230', 'MK Phone Nokia G50 4/128 HMD v12', 135.00, 9499.00, 365, 58774.00, 0.1736, '0.887', 0.1616),
(231, '231', 'MK Phone Nokia G50 4/128 HMD v120 HRA', 100.00, 5999.00, 365, 42499.00, 0.1938, '0.938', 0.1412),
(232, '232', 'MK Phone Nokia G50 4/128 HMD v17', 130.00, 8499.00, 365, 55949.00, 0.0519, '0.937', 0.1519),
(233, '233', 'MK Phone Nokia G50 4/128 HMD v19', 100.00, 5999.00, 365, 42499.00, 0.0986, '0.955', 0.1412),
(234, '234', 'MK Phone Nokia G50 4/128 HMD v2', 105.00, 6999.00, 365, 45324.00, 0.0825, '0.961', 0.1544),
(235, '235', 'MK Phone Nokia G50 4/128 HMD v4', 105.00, 7999.00, 365, 46324.00, 0.1405, '0.966', 0.1727),
(236, '236', 'MK Phone Nokia G50 4/128 HMD v6', 100.00, 8999.00, 365, 45499.00, 0.1343, '0.988', 0.1978),
(237, '237', 'MK Phone Nokia G50 4/128 HMD v8', 100.00, 7999.00, 365, 44499.00, 0.0569, '0.988', 0.1798),
(238, '238', 'MK Phone Nokia G50 4/128 v1', 105.00, 6999.00, 365, 45324.00, 0.1006, '0.965', 0.1544),
(239, '239', 'MK Phone Nokia G50 4/128 v10', 140.00, 9499.00, 365, 60599.00, 0.1751, '0.903', 0.1568),
(240, '240', 'MK Phone Nokia G50 4/128 v12', 145.00, 14499.00, 273, 54084.00, 0.0016, '1.0', 0.2681),
(241, '241', 'MK Phone Nokia G50 4/128 v13', 135.00, 9499.00, 365, 58774.00, 0.1041, '0.939', 0.1616),
(242, '242', 'MK Phone Nokia G50 4/128 v14', 145.00, 14499.00, 273, 54084.00, 0.0023, '1.0', 0.2681),
(243, '243', 'MK Phone Nokia G50 4/128 v15', 135.00, 9499.00, 365, 58774.00, 0.1246, '0.926', 0.1616),
(244, '244', 'MK Phone Nokia G50 4/128 v16', 130.00, 8499.00, 365, 55949.00, 0.1137, '0.953', 0.1519),
(245, '245', 'MK Phone Nokia G50 4/128 v18', 100.00, 5999.00, 365, 42499.00, 0.1171, '0.95', 0.1412),
(246, '246', 'MK Phone Nokia G50 4/128 v18 HRA', 85.00, 11474.00, 365, 42499.00, 0.0344, '0.989', 0.2700),
(247, '247', 'MK Phone Nokia G50 4/128 v19 HRA', 100.00, 5999.00, 365, 42499.00, 0.1416, '0.937', 0.1412),
(248, '248', 'MK Phone Nokia G50 4/128 v3', 105.00, 7999.00, 365, 46324.00, 0.0916, '0.972', 0.1727),
(249, '249', 'MK Phone Nokia G50 4/128 v5', 100.00, 8999.00, 365, 45499.00, 0.1163, '0.96', 0.1978),
(250, '250', 'MK Phone Nokia G50 4/128 v7', 100.00, 7999.00, 365, 44499.00, 0.0861, '0.963', 0.1798),
(251, '251', 'MK Phone Samsung A01 v4', 50.00, 3499.00, 365, 21749.00, 0.1652, '0.926', 0.1609),
(252, '252', 'MK Phone Samsung A02 2/32 Saf-Data v1', 50.00, 3499.00, 365, 21749.00, 0.1381, '0.926', 0.1609),
(253, '253', 'MK Phone Samsung A02 2/32 Saf-Data v8', 50.00, 2999.00, 365, 21249.00, 0.1328, '0.968', 0.1411),
(254, '254', 'MK Phone Samsung A02 2GB/32GB v2', 50.00, 3499.00, 365, 21749.00, 0.1174, '0.953', 0.1609),
(255, '255', 'MK Phone Samsung A02 3/64 Saf-Data 6-M v1', 100.00, 3499.00, 180, 21499.00, 0.1558, '0.862', 0.1628),
(256, '256', 'MK Phone Samsung A02 3/64 Saf-Data v1', 55.00, 3999.00, 365, 24074.00, 0.1357, '0.934', 0.1661),
(257, '257', 'MK Phone Samsung A02 3/64 Saf-Data v9', 55.00, 3499.00, 365, 23574.00, 0.1653, '0.903', 0.1484),
(258, '258', 'MK Phone Samsung A02 3GB/64GB v1', 55.00, 3999.00, 365, 24074.00, 0.1205, '0.955', 0.1661),
(259, '259', 'MK Phone Samsung A02s v2', 55.00, 4499.00, 365, 24574.00, 0.1127, '0.96', 0.1831),
(260, '260', 'MK Phone Samsung A02S v3', 55.00, 4499.00, 365, 24574.00, 0.1257, '0.95', 0.1831),
(261, '261', 'MK Phone Samsung A03 3/32 ST Pilot v10', 60.00, 4999.00, 365, 26899.00, 0.0972, '0.968', 0.1858),
(262, '262', 'MK Phone Samsung A03 3/32 ST Pilot v14', 60.00, 3999.00, 365, 25899.00, 0.1426, '0.949', 0.1544),
(263, '263', 'MK Phone Samsung A03 3/32 v10 Promo', 70.00, 4499.00, 365, 30049.00, 0.1751, '0.914', 0.1497),
(264, '264', 'MK Phone Samsung A03 3/32 v12', 65.00, 4399.00, 365, 28124.00, 0.1602, '0.922', 0.1564),
(265, '265', 'MK Phone Samsung A03 3/32 v13', 60.00, 3999.00, 365, 25899.00, 0.1503, '0.923', 0.1544),
(266, '266', 'MK Phone Samsung A03 3/32 v13 HRA', 55.00, 5824.00, 365, 25899.00, 0.0286, '0.997', 0.2249),
(267, '267', 'MK Phone Samsung A03 3/32 v14 HRA', 60.00, 3999.00, 365, 25899.00, 0.1886, '0.899', 0.1544),
(268, '268', 'MK Phone Samsung A03 3/32 v2', 55.00, 3999.00, 365, 24074.00, 0.1337, '0.941', 0.1661),
(269, '269', 'MK Phone Samsung A03 3/32 v3', 55.00, 3999.00, 365, 24074.00, 0.1322, '0.939', 0.1661),
(270, '270', 'MK Phone Samsung A03 3/32 v5', 55.00, 4999.00, 365, 25074.00, 0.1150, '0.95', 0.1994),
(271, '271', 'MK Phone Samsung A03 3/32 v7', 60.00, 3499.00, 365, 25399.00, 0.1551, '0.918', 0.1378),
(272, '272', 'MK Phone Samsung A03 3/32 v8', 70.00, 4999.00, 365, 30549.00, 0.1552, '0.92', 0.1636),
(273, '273', 'MK Phone Samsung A03 3/32 v9', 70.00, 4999.00, 365, 30549.00, 0.1587, '0.914', 0.1636),
(274, '274', 'MK Phone Samsung A03 4/64 v3 DS', 85.00, 4799.00, 365, 35824.00, 0.1552, '0.931', 0.1340),
(275, '275', 'MK Phone Samsung A03 Core 2/32 Insurance Pilot v1', 65.00, 2999.00, 365, 26724.00, 0.1560, '0.947', 0.1122),
(276, '276', 'MK Phone Samsung A03 Core 2/32 v10', 60.00, 3999.00, 365, 25899.00, 0.1539, '0.907', 0.1544),
(277, '277', 'MK Phone Samsung A03 Core 2/32 v11', 50.00, 3299.00, 365, 21549.00, 0.3175, '0.734', 0.1531),
(278, '278', 'MK Phone Samsung A03 Core 2/32 v12', 50.00, 3499.00, 365, 21749.00, 0.1273, '0.925', 0.1609),
(279, '279', 'MK Phone Samsung A03 Core 2/32 v13', 60.00, 3999.00, 365, 25899.00, 0.1559, '0.914', 0.1544),
(280, '280', 'MK Phone Samsung A03 Core 2/32 v14 ST Pilot ', 50.00, 3999.00, 365, 22249.00, 0.1676, '0.939', 0.1797),
(281, '281', 'MK Phone Samsung A03 Core 2/32 v15', 55.00, 3499.00, 365, 23574.00, 0.1571, '0.911', 0.1484),
(282, '282', 'MK Phone Samsung A03 Core 2/32 v15 HRA', 50.00, 5324.00, 365, 23574.00, 0.2084, '0.947', 0.2258),
(283, '283', 'MK Phone Samsung A03 Core 2/32 v15 ST Pilot	', 55.00, 3999.00, 365, 24074.00, 0.1246, '0.942', 0.1661),
(284, '284', 'MK Phone Samsung A03 Core 2/32 v16 ST Pilot', 55.00, 3499.00, 365, 23574.00, 0.1411, '0.945', 0.1484),
(285, '285', 'MK Phone Samsung A03 Core 2/32 v17', 55.00, 3499.00, 365, 23574.00, 0.1365, '0.932', 0.1484),
(286, '286', 'MK Phone Samsung A03 Core 2/32 v17 HRA', 50.00, 5324.00, 365, 23574.00, 0.1618, '0.94', 0.2258),
(287, '287', 'MK Phone Samsung A03 Core 2/32 v17 ST Pilot', 70.00, 3499.00, 365, 29049.00, 0.1482, '0.943', 0.1205),
(288, '288', 'MK Phone Samsung A03 Core 2/32 v18 DS', 65.00, 3999.00, 365, 27724.00, 0.1513, '0.918', 0.1442),
(289, '289', 'MK Phone Samsung A03 Core 2/32 v18 HRA', 55.00, 3499.00, 365, 23574.00, 0.1682, '0.917', 0.1484),
(290, '290', 'MK Phone Samsung A03 Core 2/32 v18 ST Pilot', 65.00, 2999.00, 365, 26724.00, 0.1690, '0.946', 0.1122),
(291, '291', 'MK Phone Samsung A03 Core 2/32 v19 DS HRA', 55.00, 3499.00, 365, 23574.00, 0.1547, '0.921', 0.1484),
(292, '292', 'MK Phone Samsung A03 Core 2/32 v19 ST Pilot', 65.00, 3199.00, 365, 26924.00, 0.1665, '0.936', 0.1188),
(293, '293', 'MK Phone Samsung A03 Core 2/32 v2', 50.00, 2499.00, 365, 20749.00, 0.1519, '0.92', 0.1204),
(294, '294', 'MK Phone Samsung A03 Core 2/32 v20 DS', 70.00, 3499.00, 365, 29049.00, 0.1720, '0.897', 0.1205),
(295, '295', 'MK Phone Samsung A03 Core 2/32 v20 DS HRA', 65.00, 3999.00, 365, 27724.00, 0.1882, '0.9', 0.1442),
(296, '296', 'MK Phone Samsung A03 Core 2/32 v21 DS HRA', 75.00, 3499.00, 365, 30874.00, 0.2115, '0.868', 0.1133),
(297, '297', 'MK Phone Samsung A03 Core 2/32 v22 DS HRA', 70.00, 3499.00, 365, 29049.00, 0.1998, '0.884', 0.1205),
(298, '298', 'MK Phone Samsung A03 Core 2/32 v24 DS HRA', 65.00, 2999.00, 365, 26724.00, 0.1791, '0.919', 0.1122),
(299, '299', 'MK Phone Samsung A03 Core 2/32 v25 DS', 65.00, 2999.00, 365, 26724.00, 0.1637, '0.921', 0.1122),
(300, '300', 'MK Phone Samsung A03 Core 2/32 v4', 50.00, 3299.00, 365, 21549.00, 0.1265, '0.922', 0.1531),
(301, '301', 'MK Phone Samsung A03 Core 2/32 v5', 50.00, 3299.00, 365, 21549.00, 0.1225, '0.924', 0.1531),
(302, '302', 'MK Phone Samsung A03 Core 2/32 v9', 50.00, 4299.00, 365, 22549.00, 0.1046, '0.942', 0.1907),
(303, '303', 'MK Phone Samsung A03 Data Single v5', 40.00, 2499.00, 365, 17099.00, 0.1494, '0.927', 0.1461),
(304, '304', 'MK Phone Samsung A03 Dual v4', 40.00, 2499.00, 365, 17099.00, 0.1252, '0.946', 0.1461),
(305, '305', 'MK Phone Samsung A03 Micro Biz v1', 30.00, 0.00, 600, 18000.00, 0.5068, '0.799', 0.0000),
(306, '306', 'MK Phone Samsung A03 Micro Biz v4', 30.00, 0.00, 600, 18000.00, 0.4834, '0.816', 0.0000),
(307, '307', 'MK Phone Samsung A03 Micro-Biz v2', 30.00, 2200.00, 600, 20200.00, 0.0129, '0.943', 0.1089),
(308, '308', 'MK Phone Samsung A03 Saf-Data 6-M v1', 75.00, 2499.00, 180, 15999.00, 0.1249, '0.779', 0.1562),
(309, '309', 'MK Phone Samsung A03 Saf-Data v1', 40.00, 2499.00, 365, 17099.00, 0.1529, '0.924', 0.1461),
(310, '310', 'MK Phone Samsung A03 Single v3', 40.00, 2499.00, 365, 17099.00, 0.1319, '0.944', 0.1461),
(311, '311', 'MK Phone Samsung A03 v1', 40.00, 2999.00, 365, 17599.00, 0.2486, '0.807', 0.1704),
(312, '312', 'MK Phone Samsung A03S 3/32 v1', 55.00, 3999.00, 365, 24074.00, 0.1472, '0.931', 0.1661),
(313, '313', 'MK Phone Samsung A03S 3/32 v3', 55.00, 4499.00, 365, 24574.00, 0.1153, '0.95', 0.1831),
(314, '314', 'MK Phone Samsung A03S 3/32 v4', 65.00, 4999.00, 365, 28724.00, 0.1295, '0.94', 0.1740),
(315, '315', 'MK Phone Samsung A03S 3/32 v5', 65.00, 3999.00, 365, 27724.00, 0.1601, '0.918', 0.1442),
(316, '316', 'MK Phone Samsung A03S 3/32 v6', 65.00, 3999.00, 365, 27724.00, 0.1998, '0.899', 0.1442),
(317, '317', 'MK Phone Samsung A04S 4/128 ST Pilot v1', 90.00, 6399.00, 365, 39249.00, 0.0992, '0.957', 0.1630),
(318, '318', 'MK Phone Samsung A04S 4/128 ST Pilot v2', 100.00, 5299.00, 365, 41799.00, 0.1158, '0.96', 0.1268),
(319, '319', 'MK Phone Samsung A04S 4/64  Insurance Pilot v1', 85.00, 4199.00, 365, 35224.00, 0.1244, '0.96', 0.1192),
(320, '320', 'MK Phone Samsung A04S 4/64 DS v3', 95.00, 4899.00, 365, 39574.00, 0.1368, '0.932', 0.1238),
(321, '321', 'MK Phone Samsung A04S 4/64 DS v3 HRA', 95.00, 4899.00, 365, 39574.00, 0.1636, '0.911', 0.1238),
(322, '322', 'MK Phone Samsung A04S 4/64 v1', 85.00, 4899.00, 365, 35924.00, 0.1219, '0.946', 0.1364),
(323, '323', 'MK Phone Samsung A04S 4/64 v1 HRA', 75.00, 8549.00, 365, 35924.00, 0.0566, '0.992', 0.2380),
(324, '324', 'MK Phone Samsung A04S 4/64 v2 HRA', 85.00, 4899.00, 365, 35924.00, 0.1418, '0.932', 0.1364),
(325, '325', 'MK Phone Samsung A10S Dual-Sim v16', 60.00, 4499.00, 365, 26399.00, 0.0000, '0.898', 0.1704),
(326, '326', 'MK Phone Samsung A10S Grade A v1', 60.00, 3799.00, 250, 18799.00, 0.0312, '0.968', 0.2021),
(327, '327', 'MK Phone Samsung A10S Grade A v3', 60.00, 2999.00, 265, 18899.00, 0.0990, '0.943', 0.1587),
(328, '328', 'MK Phone Samsung A10S Grade B v2', 60.00, 3299.00, 225, 16799.00, 0.1716, '0.948', 0.1964),
(329, '329', 'MK Phone Samsung A10S Grade B v4', 60.00, 2499.00, 235, 16599.00, 0.1326, '0.901', 0.1506),
(330, '330', 'MK Phone Samsung A10S Saf-Data v1', 60.00, 4499.00, 365, 26399.00, 0.1160, '0.916', 0.1704),
(331, '331', 'MK Phone Samsung A10S v1 Rev A', 60.00, 1000.00, 130, 8800.00, 0.0369, '0.934', 0.1136),
(332, '332', 'MK Phone Samsung A10S v12', 60.00, 4499.00, 374, 26899.00, 0.0000, '1.0', 0.1673),
(333, '333', 'MK Phone Samsung A10S v13', 50.00, 5999.00, 365, 24249.00, 0.0000, '1.0', 0.2474),
(334, '334', 'MK Phone Samsung A10S v15', 60.00, 4499.00, 365, 26399.00, 0.1674, '0.962', 0.1704),
(335, '335', 'MK Phone Samsung A10S v18', 60.00, 4999.00, 365, 26899.00, 0.1859, '0.936', 0.1858),
(336, '336', 'MK Phone Samsung A10S v19', 60.00, 4499.00, 365, 26399.00, 0.1115, '0.958', 0.1704),
(337, '337', 'MK Phone Samsung A10S v3', 60.00, 3499.00, 365, 25399.00, 0.1420, '0.958', 0.1378),
(338, '338', 'MK Phone Samsung A11 Dual sim v4', 60.00, 4499.00, 365, 26399.00, 0.0946, '0.959', 0.1704),
(339, '339', 'MK Phone Samsung A11 Saf-Data v1', 60.00, 4499.00, 365, 26399.00, 0.1240, '0.935', 0.1704),
(340, '340', 'MK Phone Samsung A11 v1', 60.00, 4999.00, 365, 26899.00, 0.2379, '0.984', 0.1858),
(341, '341', 'MK Phone Samsung A11 v3', 60.00, 4499.00, 365, 26399.00, 0.1014, '0.963', 0.1704),
(342, '342', 'MK Phone Samsung A12 Saf-Data 6-M v1', 130.00, 4499.00, 180, 27899.00, 0.1385, '0.869', 0.1613),
(343, '343', 'MK Phone Samsung A12 Saf-Data v1', 70.00, 4999.00, 365, 30549.00, 0.1267, '0.924', 0.1636),
(344, '344', 'MK Phone Samsung A12 Saf-Data v2', 70.00, 4499.00, 365, 30049.00, 0.1361, '0.94', 0.1497),
(345, '345', 'MK Phone Samsung A12 v4', 70.00, 5499.00, 365, 31049.00, 0.1107, '0.961', 0.1771),
(346, '346', 'MK Phone Samsung A12 v9', 70.00, 4999.00, 365, 30549.00, 0.1219, '0.955', 0.1636),
(347, '347', 'MK Phone Samsung A12S v2', 65.00, 4999.00, 365, 28724.00, 0.1015, '0.961', 0.1740),
(348, '348', 'MK Phone Samsung A13 4/64 v10', 100.00, 7499.00, 365, 43999.00, 0.1546, '0.909', 0.1704),
(349, '349', 'MK Phone Samsung A13 4/64 v11 Promo', 100.00, 6999.00, 365, 43499.00, 0.1524, '0.919', 0.1609),
(350, '350', 'MK Phone Samsung A13 4/64 v11 ST Pilot', 90.00, 5499.00, 365, 38349.00, 0.1467, '0.937', 0.1434),
(351, '351', 'MK Phone Samsung A13 4/64 v12', 95.00, 5999.00, 365, 40674.00, 0.1627, '0.916', 0.1475),
(352, '352', 'MK Phone Samsung A13 4/64 v14 HRA', 90.00, 5599.00, 365, 38449.00, 0.1862, '0.903', 0.1456),
(353, '353', 'MK Phone Samsung A13 4/64 v2', 80.00, 5999.00, 365, 35199.00, 0.1111, '0.951', 0.1704),
(354, '354', 'MK Phone Samsung A13 4/64 v6', 90.00, 7499.00, 365, 40349.00, 0.1413, '0.927', 0.1859),
(355, '355', 'MK Phone Samsung A13 4/64 v7', 90.00, 5499.00, 365, 38349.00, 0.1491, '0.917', 0.1434),
(356, '356', 'MK Phone Samsung A13 4/64 v9', 100.00, 7499.00, 365, 43999.00, 0.1729, '0.89', 0.1704),
(357, '357', 'MK Phone Samsung A21 Saf-Data v1', 85.00, 5999.00, 365, 37024.00, 0.0956, '0.948', 0.1620),
(358, '358', 'MK Phone Samsung A21S Dual v3', 80.00, 5499.00, 365, 34699.00, 0.1561, '0.971', 0.1585),
(359, '359', 'MK Phone Samsung A21S Dual v4', 85.00, 5999.00, 365, 37024.00, 0.0984, '0.968', 0.1620),
(360, '360', 'MK Phone Samsung A21S single v5', 85.00, 5999.00, 365, 37024.00, 0.0897, '0.966', 0.1620),
(361, '361', 'MK Phone Samsung A21S v2', 80.00, 5499.00, 365, 34699.00, 0.1039, '0.948', 0.1585),
(362, '362', 'MK Phone Samsung A22 4/64 Saf-Data v2', 85.00, 5999.00, 365, 37024.00, 0.1262, '0.942', 0.1620),
(363, '363', 'MK Phone Samsung A22 4/64 v1', 85.00, 5999.00, 365, 37024.00, 0.1367, '0.933', 0.1620),
(364, '364', 'MK Phone Samsung A23 4/64 v10', 130.00, 9499.00, 365, 56949.00, 0.1488, '0.924', 0.1668),
(365, '365', 'MK Phone Samsung A23 4/64 v11', 140.00, 13999.00, 273, 52219.00, 0.0024, '1.0', 0.2681),
(366, '366', 'MK Phone Samsung A23 4/64 v12', 100.00, 7499.00, 365, 43999.00, 0.1018, '0.951', 0.1704),
(367, '367', 'MK Phone Samsung A23 4/64 v14 HRA', 100.00, 6999.00, 365, 43499.00, 0.1105, '0.945', 0.1609),
(368, '368', 'MK Phone Samsung A23 4/64 v2', 100.00, 7499.00, 365, 43999.00, 0.1049, '0.941', 0.1704),
(369, '369', 'MK Phone Samsung A23 4/64 v6', 100.00, 8299.00, 365, 44799.00, 0.1055, '0.945', 0.1852),
(370, '370', 'MK Phone Samsung A23 4/64 v8', 130.00, 9499.00, 365, 56949.00, 0.1378, '0.919', 0.1668),
(371, '371', 'MK Phone Samsung A23 4/64 v9', 140.00, 13999.00, 273, 52219.00, 0.1059, '0.995', 0.2681),
(372, '372', 'MK Phone Samsung A23 4/64 v9 Promo', 130.00, 8999.00, 365, 56449.00, 0.1229, '0.921', 0.1594),
(373, '373', 'MK Phone Samsung A24 4/128 Insurance Pilot v1', 135.00, 7299.00, 365, 56574.00, 0.0998, '0.975', 0.1290),
(374, '374', 'MK Phone Samsung A24 4/128 v1', 135.00, 7299.00, 365, 56574.00, 0.1291, '0.951', 0.1290),
(375, '375', 'MK Phone Samsung A24 4/128 v2 HRA', 135.00, 7299.00, 365, 56574.00, 0.1391, '0.957', 0.1290),
(376, '376', 'MK Phone Samsung A33 6/128 v4', 130.00, 9499.00, 365, 56949.00, 0.0612, '0.972', 0.1668),
(377, '377', 'MK Phone Samsung A33 6/128 v6', 170.00, 10999.00, 365, 73049.00, 0.1245, '0.901', 0.1506),
(378, '378', 'MK Phone Samsung A33 6/128 v8', 170.00, 10999.00, 365, 73049.00, 0.1165, '0.927', 0.1506),
(379, '379', 'MK Phone Samsung A33 6/128 v9', 190.00, 15999.00, 273, 67869.00, 0.0175, '1.0', 0.2357),
(380, '380', 'MK Phone Samsung A53 6/128 v2', 170.00, 13999.00, 365, 76049.00, 0.0869, '0.966', 0.1841),
(381, '381', 'MK Phone Samsung A53 6/128 v3', 170.00, 13999.00, 365, 76049.00, 0.0836, '0.956', 0.1841),
(382, '382', 'MK Phone Samsung A53 6/128 v4 HRA', 170.00, 13999.00, 365, 76049.00, 0.0245, '0.939', 0.1841),
(383, '383', 'MK Phone Samsung Galaxy A01 v2', 50.00, 3999.00, 365, 22249.00, 0.0000, '1.0', 0.1797),
(384, '384', 'MK Phone ST pilot Samsung A23 4/128 v1', 115.00, 9499.00, 365, 51474.00, 0.0649, '0.98', 0.1845),
(385, '385', 'MK Phone Tecno Spark 6 GO 2/32 v2', 45.00, 2999.00, 365, 19424.00, 0.0256, '0.971', 0.1544),
(386, '386', 'MK Motorbike Honda ACE 110 12M v12', 465.00, 14999.00, 365, 184724.00, 0.2046, '0.894', 0.0812),
(387, '387', 'MK Motorbike Honda ACE 110 16M v13', 385.00, 14999.00, 480, 199799.00, 0.2795, '0.831', 0.0751),
(388, '388', 'MK Motorbike Honda ACE 110 Grade D v1 Cash', 1.00, 20087.00, 1, 20088.00, 0.0000, '0.255', 1.0000),
(389, '389', 'MK Motorbike Honda ACE 110 HD 18M v5', 295.00, 24999.00, 550, 187249.00, 0.2634, '0.888', 0.1335),
(390, '390', 'MK Motorbike Honda ACE 110 HD 18M v9', 295.00, 24999.00, 550, 187249.00, 0.1447, '1.0', 0.1335),
(391, '391', 'MK Motorbike Honda ACE 110 LD 12M v4', 485.00, 14999.00, 365, 192024.00, 0.4512, '0.836', 0.0781),
(392, '392', 'MK Motorbike Honda ACE 110 LD v3', 385.00, 14999.00, 480, 199799.00, 0.4463, '0.775', 0.0751),
(393, '393', 'MK Motorbike Honda ACE 110 LD v7', 385.00, 14999.00, 480, 199799.00, 0.5235, '0.634', 0.0751),
(394, '394', 'M-KOPA 4(3B) v2 ', 50.00, 2999.00, 400, 22999.00, 0.0000, '0.333', 0.1304),
(395, '395', 'M-KOPA 600 (24\") v2', 100.00, 5999.00, 590, 64999.00, 0.3065, '0.69', 0.0923),
(396, '396', 'M-KOPA 600 (32\"S-Grid TV) v2 ', 100.00, 5999.00, 450, 50999.00, 0.1564, '0.95', 0.1176),
(397, '397', 'M-KOPA 600 (32\"W-Grid TV) v3', 125.00, 6999.00, 500, 69499.00, 0.4135, '0.802', 0.1007),
(398, '398', 'M-KOPA 6000 (32\") v10 LD LR', 135.00, 7999.00, 660, 97099.00, 0.5461, '0.863', 0.0824),
(399, '399', 'M-KOPA 6000 (32\") v3 LD', 150.00, 7999.00, 560, 91999.00, 0.3408, '0.879', 0.0869),
(400, '400', 'M-KOPA Phone Nokia 2.2 v6', 60.00, 2999.00, 330, 22799.00, 0.2674, '0.927', 0.1315),
(401, '401', 'M-KOPA Phone Nokia D-Sim 2.2 v12', 50.00, 3999.00, 250, 16499.00, 0.1481, '1.0', 0.2424),
(402, '402', 'M-KOPA Phone Nokia S-Sim 2.2 v13', 50.00, 3999.00, 250, 16499.00, 0.0448, '1.0', 0.2424);

-- --------------------------------------------------------

--
-- Table structure for table `basicconcepts_salesprojection`
--

CREATE TABLE `basicconcepts_salesprojection` (
  `id` bigint(20) NOT NULL,
  `product_detail` varchar(255) NOT NULL,
  `anticipated_growth` decimal(5,2) NOT NULL,
  `price_change` decimal(5,2) NOT NULL,
  `total_volume_before` int(11) NOT NULL,
  `total_volume_after` int(11) NOT NULL,
  `unit_price_before` decimal(10,2) NOT NULL,
  `unit_price_after` decimal(10,2) NOT NULL,
  `gross_revenue_before` decimal(15,2) NOT NULL,
  `gross_revenue_after` decimal(15,2) NOT NULL,
  `current_priced_cm2_before` decimal(5,2) NOT NULL,
  `current_priced_cm2_after` decimal(5,2) NOT NULL,
  `expected_cm2_revenue_before` decimal(15,2) NOT NULL,
  `expected_cm2_revenue_after` decimal(15,2) NOT NULL,
  `current_llr` decimal(5,2) NOT NULL,
  `llr_threshold_zero_sum` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(9, 'basicConcepts', 'llrpricingassumption'),
(10, 'basicConcepts', 'paymentplanprojection'),
(7, 'basicConcepts', 'productdetail'),
(8, 'basicConcepts', 'salesprojection'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-01-15 10:33:46.353190'),
(2, 'auth', '0001_initial', '2024-01-15 10:34:01.674211'),
(3, 'admin', '0001_initial', '2024-01-15 10:34:04.706118'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-01-15 10:34:04.752998'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-01-15 10:34:04.792641'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-01-15 10:34:05.497024'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-01-15 10:34:06.216008'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-01-15 10:34:06.316233'),
(9, 'auth', '0004_alter_user_username_opts', '2024-01-15 10:34:06.363117'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-01-15 10:34:06.835926'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-01-15 10:34:06.898453'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-01-15 10:34:06.948977'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-01-15 10:34:07.018451'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-01-15 10:34:07.084552'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-01-15 10:34:07.173017'),
(16, 'auth', '0011_update_proxy_permissions', '2024-01-15 10:34:07.201999'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-01-15 10:34:07.300463'),
(18, 'basicConcepts', '0001_initial', '2024-01-15 10:36:16.640462'),
(19, 'basicConcepts', '0002_alter_llrpricingassumption_cost_per_credit_and_more', '2024-01-15 10:36:17.441582'),
(20, 'sessions', '0001_initial', '2024-01-15 10:36:17.810924'),
(21, 'basicConcepts', '0003_llrpricingassumption_comment_and_more', '2024-01-15 11:46:58.707550'),
(22, 'basicConcepts', '0004_paymentplanprojection', '2024-01-18 05:56:49.197882'),
(23, 'basicConcepts', '0005_remove_paymentplanprojection_date_and_more', '2024-01-18 06:59:05.823813');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `basicconcepts_llrpricingassumption`
--
ALTER TABLE `basicconcepts_llrpricingassumption`
  ADD PRIMARY KEY (`id`),
  ADD KEY `basicConcepts_llrpri_payment_plan_id_de4c336b_fk_basicConc` (`payment_plan_id`);

--
-- Indexes for table `basicconcepts_paymentplanprojection`
--
ALTER TABLE `basicconcepts_paymentplanprojection`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `basicconcepts_productdetail`
--
ALTER TABLE `basicconcepts_productdetail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `basicconcepts_salesprojection`
--
ALTER TABLE `basicconcepts_salesprojection`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `basicconcepts_llrpricingassumption`
--
ALTER TABLE `basicconcepts_llrpricingassumption`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `basicconcepts_paymentplanprojection`
--
ALTER TABLE `basicconcepts_paymentplanprojection`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `basicconcepts_productdetail`
--
ALTER TABLE `basicconcepts_productdetail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=403;

--
-- AUTO_INCREMENT for table `basicconcepts_salesprojection`
--
ALTER TABLE `basicconcepts_salesprojection`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `basicconcepts_llrpricingassumption`
--
ALTER TABLE `basicconcepts_llrpricingassumption`
  ADD CONSTRAINT `basicConcepts_llrpri_payment_plan_id_de4c336b_fk_basicConc` FOREIGN KEY (`payment_plan_id`) REFERENCES `basicconcepts_productdetail` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
