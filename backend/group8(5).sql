-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2024 at 02:05 AM
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
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
