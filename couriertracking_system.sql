-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 17, 2026 at 05:50 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `couriertracking_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `branch_id` int(11) NOT NULL,
  `branch_manager_id` int(11) NOT NULL,
  `branch_location` varchar(100) NOT NULL,
  `branch_contact_no` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branch_id`, `branch_manager_id`, `branch_location`, `branch_contact_no`) VALUES
(1, 119, 'Colombo', '0112172068'),
(2, 120, 'Kandy', '0112459823'),
(3, 121, 'Anuradhapura', '0112568329'),
(4, 122, 'Kegalle', '0112789052'),
(5, 123, 'Kurunegala', '0112675424'),
(6, 124, 'Galle', '0112675424'),
(7, 125, 'Jaffna', '0112567389'),
(8, 126, 'Badulla', '0112789035'),
(9, 127, 'Trincomalee', '0112789035');

-- --------------------------------------------------------

--
-- Table structure for table `courier_shipment`
--

CREATE TABLE `courier_shipment` (
  `courier_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `dispatch_branch_id` int(11) NOT NULL,
  `delivery_branch_id` int(11) NOT NULL,
  `pickup_address` varchar(255) DEFAULT NULL,
  `destination_address` varchar(255) DEFAULT NULL,
  `weight` decimal(6,2) NOT NULL,
  `dimensions` varchar(255) DEFAULT NULL,
  `package_type` enum('Food','Electronic','Glass','Household Item','Business_Supplies','Documents','Chemicals','Other') NOT NULL,
  `status` enum('Booked','Picked Up','In Transit','Out for Delivery','Delivered') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `customer_type` enum('Sender','Receiver') NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `customer_phone` varchar(15) DEFAULT NULL,
  `customer_address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `customer_type`, `customer_name`, `customer_email`, `customer_phone`, `customer_address`) VALUES
(1, 'Sender', 'Silva WT', 'silva25@gmail.com', '0712390411', '200/1 Jayagath road, Pannipitiya.'),
(2, 'Sender', 'Perera DL', 'pereradl@gmail.com', '0724559081', '34/K 1st lane, Maharagama'),
(3, 'Receiver', 'Jagath Bandara', 'jagathb23@gmail.com', '0774901836', '128/Y Galle Road, Moratuwa'),
(4, 'Sender', 'Anura Weerasiri', 'weerasiri@gmail.com', '0752990187', '75/1 Kandy Road, Kegalle'),
(5, 'Receiver', 'Amali Perera', 'amali13@gmail.com', '0755628745', '28/G Silva Road, Katunayaka'),
(6, 'Sender', 'Shahani Kariyawasam', 'shehanik@gmail.com', '0714978962', 'No.512,Jaya Road ,Nugegoda '),
(7, 'Receiver', 'Muthusami Selvam', 'selvam56@gmail.com', '0713467894', 'No.89,Kalvam Road,Mannar '),
(8, 'Sender', 'Mohomad Aslam', 'mohomadaslam@gmail.com', '0761430256', '156/D,Azarl Place,Haputale '),
(9, 'Sender', 'Pushpakumara Ranasinhe', 'pushpakumara@gmail.com', '0722818681', '467/1/K ,Samanpura, Anuradhapura'),
(10, 'Receiver', 'Dulith Weerakumara', 'weera24@gmail.com', '0723189183', '290/A ,Main Road, Ja-Ela');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(11) NOT NULL,
  `emp_branch_id` int(11) NOT NULL,
  `emp_name` varchar(100) NOT NULL,
  `emp_role` enum('Driver','Admin','Staff') NOT NULL,
  `emp_contact_no` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `emp_branch_id`, `emp_name`, `emp_role`, `emp_contact_no`) VALUES
(101, 1, 'Silva KW', 'Staff', '0771234567'),
(102, 1, 'Nimal Perera', 'Driver', '0712345678'),
(103, 2, 'Kamal Fernando', 'Staff', '0779876543'),
(104, 2, 'Saman Silva', 'Driver', '0719876543'),
(105, 3, 'Arjun Gamini', 'Staff', '0768952823'),
(106, 3, 'Shehan Silva', 'Driver', '0723562345'),
(107, 4, 'Chamini Wickramasuriya', 'Staff', '0716784345'),
(108, 4, 'Jagath Withna', 'Driver', '0778905431'),
(109, 5, 'Sewmini Suriyakumari', 'Staff', '0719042932'),
(110, 5, 'Charles Perera', 'Driver', '0719305313'),
(111, 6, 'Saman Mayadunna', 'Staff', '0782304178'),
(112, 6, 'Piyadasa Sirisena', 'Driver', '0771459342'),
(113, 7, 'Sugath Bandara', 'Staff', '0758231023'),
(114, 7, 'Sugath Bandara', 'Driver', '0758231023'),
(115, 8, 'Chanuka Fernando', 'Staff', '0729031971'),
(116, 8, 'Nalin Athanayaka', 'Driver', '0718945637'),
(117, 8, 'Kumara Dahanayaka', 'Staff', '0774190328'),
(118, 9, 'Wickum Jayaweera', 'Driver', '0719362856'),
(119, 1, 'Suryakumara Rajaputhra', 'Admin', '0779834243'),
(120, 2, 'Shamal Wickramasinghe', 'Admin', '0723167833'),
(121, 3, 'Jithmini Jayasuriya', 'Admin', '0719324389'),
(122, 4, 'Harini Perera', 'Admin', '0771903732'),
(123, 5, 'Silva SM', 'Admin', '0772897134'),
(124, 6, 'Sayuru Shenal', 'Admin', '0782452801'),
(125, 7, 'Kavindi Fernando', 'Admin', '0762931922'),
(126, 8, 'Heshan Perera', 'Admin', '0729021543'),
(127, 9, 'Mohomad Abdull', 'Admin', '0745124245');

-- --------------------------------------------------------

--
-- Table structure for table `tracking_record`
--

CREATE TABLE `tracking_record` (
  `tracking_id` int(11) NOT NULL,
  `courier_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `updated_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `status_update` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `vehicle_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `vehicle_reg_no` varchar(20) NOT NULL,
  `vehicle_type` enum('Lorry','Bike','Three-Wheeler','Van') NOT NULL,
  `capacity_kg` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`vehicle_id`, `emp_id`, `vehicle_reg_no`, `vehicle_type`, `capacity_kg`) VALUES
(201, 102, 'HU 1289', 'Bike', 5.00),
(202, 104, 'NB 6798', 'Van', 250.00),
(203, 106, 'BFI 2368', 'Three-Wheeler', 100.00),
(204, 108, 'LB 7890', 'Lorry', 500.00),
(205, 110, 'BFI 7020', 'Bike', 5.00),
(206, 112, 'LG 8751', 'Lorry', 500.00),
(207, 114, 'AFW 4518', 'Three-Wheeler', 100.00),
(208, 116, 'JA 3926', 'Lorry', 500.00),
(209, 118, 'BJW 2951', 'Bike', 5.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branch_id`),
  ADD KEY `fk_branch_manager` (`branch_manager_id`);

--
-- Indexes for table `courier_shipment`
--
ALTER TABLE `courier_shipment`
  ADD PRIMARY KEY (`courier_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `dispatch_branch_id` (`dispatch_branch_id`),
  ADD KEY `delivery_branch_id` (`delivery_branch_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `customer_email` (`customer_email`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `emp_branch_id` (`emp_branch_id`);

--
-- Indexes for table `tracking_record`
--
ALTER TABLE `tracking_record`
  ADD PRIMARY KEY (`tracking_id`),
  ADD KEY `courier_id` (`courier_id`),
  ADD KEY `emp_id` (`emp_id`),
  ADD KEY `vehicle_id` (`vehicle_id`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`vehicle_id`),
  ADD UNIQUE KEY `vehicle_reg_no` (`vehicle_reg_no`),
  ADD KEY `emp_id` (`emp_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `branch`
--
ALTER TABLE `branch`
  MODIFY `branch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `courier_shipment`
--
ALTER TABLE `courier_shipment`
  MODIFY `courier_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2147483648;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT for table `tracking_record`
--
ALTER TABLE `tracking_record`
  MODIFY `tracking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `vehicle_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=210;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `branch`
--
ALTER TABLE `branch`
  ADD CONSTRAINT `fk_branch_manager` FOREIGN KEY (`branch_manager_id`) REFERENCES `employee` (`emp_id`);

--
-- Constraints for table `courier_shipment`
--
ALTER TABLE `courier_shipment`
  ADD CONSTRAINT `courier_shipment_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `courier_shipment_ibfk_2` FOREIGN KEY (`dispatch_branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `courier_shipment_ibfk_3` FOREIGN KEY (`delivery_branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE CASCADE;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`emp_branch_id`) REFERENCES `branch` (`branch_id`);

--
-- Constraints for table `tracking_record`
--
ALTER TABLE `tracking_record`
  ADD CONSTRAINT `tracking_record_ibfk_1` FOREIGN KEY (`courier_id`) REFERENCES `courier_shipment` (`courier_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tracking_record_ibfk_2` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tracking_record_ibfk_3` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`vehicle_id`) ON DELETE CASCADE;

--
-- Constraints for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
