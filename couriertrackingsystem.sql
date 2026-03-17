-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 17, 2026 at 09:05 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `couriertrackingsystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `branch_id` int(11) NOT NULL,
  `branch_location` varchar(100) NOT NULL,
  `branch_contact_no` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branch_id`, `branch_location`, `branch_contact_no`) VALUES
(1, 'Colombo Hub - Pettah', '0112233445'),
(2, 'Kandy Hub - Peradeniya', '0812233445'),
(3, 'Galle Hub - Galle Fort', '0912233445');

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

--
-- Dumping data for table `courier_shipment`
--

INSERT INTO `courier_shipment` (`courier_id`, `customer_id`, `dispatch_branch_id`, `delivery_branch_id`, `pickup_address`, `destination_address`, `weight`, `dimensions`, `package_type`, `status`) VALUES
(3, 1003, 1, 2, 'No 15, Flower Rd, Colombo 07', '45 Main Street, Kandy', 1.25, NULL, 'Documents', 'Booked'),
(4, 1003, 1, 1, NULL, 'Colombo', 15.00, NULL, '', 'Booked'),
(5, 1003, 1, 1, 'No 15, Flower Rd, Colombo 07', 'Colombo', 15.00, NULL, '', 'Booked'),
(6, 1003, 1, 1, 'No 15, Flower Rd, Colombo 07', 'Colombo', 15.00, NULL, '', 'Booked'),
(7, 1003, 1, 1, 'No 15, Flower Rd, Colombo 07', 'Colombo', 15.00, NULL, '', 'Booked'),
(8, 1003, 1, 1, 'No 15, Flower Rd, Colombo 07', 'Colombo', 5.00, NULL, '', 'Booked'),
(9, 1003, 1, 1, 'No 15, Flower Rd, Colombo 07', 'Kandy', 7.00, NULL, '', 'Booked'),
(10, 1003, 1, 1, 'No 15, Flower Rd, Colombo 07', 'Kandy', 2.50, NULL, '', 'Booked'),
(11, 1003, 1, 1, 'No 15, Flower Rd, Colombo 07', 'Kandy', 3.50, NULL, '', 'Booked');

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
(1003, 'Sender', 'Thrina Selva', 'three@example.com', '0771234567', 'No 15, Flower Rd, Colombo 07'),
(1004, 'Receiver', 'Eshani Perera', 'eshani@example.com', '0719876543', '45 Main Street, Kandy');

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
(1, 1, 'Saman Kumara', 'Admin', '0750001112'),
(2, 1, 'Bandara Silva', 'Driver', '0779998887');

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

--
-- Dumping data for table `tracking_record`
--

INSERT INTO `tracking_record` (`tracking_id`, `courier_id`, `emp_id`, `vehicle_id`, `location`, `updated_timestamp`, `status_update`) VALUES
(2, 3, 2, 1, 'Colombo 07', '2026-03-17 03:37:08', 'Package picked up from Thrinayani');

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
(1, 2, 'WP BZ-8890', 'Three-Wheeler', 300.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branch_id`);

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
  MODIFY `branch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `courier_shipment`
--
ALTER TABLE `courier_shipment`
  MODIFY `courier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1005;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tracking_record`
--
ALTER TABLE `tracking_record`
  MODIFY `tracking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `vehicle_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

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
