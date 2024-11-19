-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2024 at 01:30 AM
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
-- Database: `group8`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `slot` enum('slot_1','slot_2','slot_3','slot_4') DEFAULT NULL,
  `status` enum('pending','approved','rejected','cancel') DEFAULT 'pending',
  `approved_by` int(11) DEFAULT NULL,
  `booking_date` date DEFAULT NULL,
  `reason` varchar(60) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `bookings`
--
DELIMITER $$
CREATE TRIGGER `check_slot_before_insert` BEFORE INSERT ON `bookings` FOR EACH ROW BEGIN
    -- ตรวจสอบว่า slot ที่กำหนดใน bookings ตรงกับ slot ใน rooms หรือไม่
    IF NEW.slot = 'slot_1' AND (SELECT `slot_1` FROM `rooms` WHERE `id` = NEW.room_id) != 'free' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Slot 1 is not available';
    ELSEIF NEW.slot = 'slot_2' AND (SELECT `slot_2` FROM `rooms` WHERE `id` = NEW.room_id) != 'free' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Slot 2 is not available';
    ELSEIF NEW.slot = 'slot_3' AND (SELECT `slot_3` FROM `rooms` WHERE `id` = NEW.room_id) != 'free' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Slot 3 is not available';
    ELSEIF NEW.slot = 'slot_4' AND (SELECT `slot_4` FROM `rooms` WHERE `id` = NEW.room_id) != 'free' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Slot 4 is not available';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `room_name` varchar(40) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `slot_1` enum('free','pending','reserved','disabled') DEFAULT 'free',
  `slot_2` enum('free','pending','reserved','disabled') DEFAULT 'free',
  `slot_3` enum('free','pending','reserved','disabled') DEFAULT 'free',
  `slot_4` enum('free','pending','reserved','disabled') DEFAULT 'free',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `room_name`, `description`, `slot_1`, `slot_2`, `slot_3`, `slot_4`, `created_at`, `updated_at`) VALUES
(2, 'sun', 'sun', NULL, NULL, NULL, NULL, '2024-11-18 23:15:36', '2024-11-19 00:04:41'),
(3, 'Room 102', 'This is a description of Room 101', 'disabled', 'free', 'disabled', 'free', '2024-11-18 23:18:54', '2024-11-19 00:10:37'),
(4, 'Room 103', 'This is a description of Room 101', 'free', 'free', 'free', 'free', '2024-11-18 23:34:27', '2024-11-18 23:34:27'),
(5, 'Room 104', 'This is a description of Room 104', 'free', 'reserved', 'pending', 'free', '2024-11-18 23:37:51', '2024-11-18 23:37:51');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role` enum('student','staff','approver') NOT NULL DEFAULT 'student',
  `username` varchar(100) NOT NULL,
  `password` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role`, `username`, `password`, `email`, `created_at`, `updated_at`) VALUES
(1, 'student', 'aaa', '$2b$10$2SxWsq8Sz75fKLwM2n4MmebOAf6bVyxwsQE2KjhKKbTSOJgZEGTwK', 'student@lamduan.mfu.ac.th', '2024-11-18 22:43:23', '2024-11-18 22:43:23'),
(2, 'staff', 'bbb', '$2b$10$4yDtHR1Tt4kvZiKLXb6nausMtbU.oP1tGEcTbukN87iYbBJrX5q4y', 'staff@lamduan.mfu.ac.th', '2024-11-18 22:43:44', '2024-11-18 22:43:44'),
(3, 'approver', 'ccc', '$2b$10$zpCOMvjxOyrQjWjUY74Y3.mgYPfrftiYhnZw5DlMLRzFIhbqTb3PW', 'approver@lamduan.mfu.ac.th', '2024-11-18 22:43:53', '2024-11-18 22:43:53');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `set_role_before_insert` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
    IF NEW.email = 'student@lamduan.mfu.ac.th' THEN
        SET NEW.role = 'student';
    ELSEIF NEW.email = 'staff@lamduan.mfu.ac.th' THEN
        SET NEW.role = 'staff';
    ELSEIF NEW.email = 'approver@lamduan.mfu.ac.th' THEN
        SET NEW.role = 'approver';
    ELSE
        SET NEW.role = NULL;
    END IF;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_user_fk` (`user_id`),
  ADD KEY `bookings_room_fk` (`room_id`),
  ADD KEY `bookings_approver_fk` (`approved_by`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `username_2` (`username`),
  ADD UNIQUE KEY `username_3` (`username`),
  ADD UNIQUE KEY `username_4` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_approver_fk` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bookings_room_fk` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bookings_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
