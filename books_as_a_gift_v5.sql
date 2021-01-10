-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 10, 2021 at 08:06 PM
-- Server version: 5.7.32-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `books_as_a_gift`
--

-- --------------------------------------------------------

--
-- Table structure for table `Books`
--

CREATE TABLE `Books` (
  `id` int(11) NOT NULL,
  `userId` varchar(128) NOT NULL,
  `userEmail` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `author` varchar(50) NOT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  `volumeOrIssue` varchar(25) DEFAULT NULL,
  `language` varchar(25) NOT NULL,
  `publicationDate` varchar(5) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `countryId` int(11) NOT NULL,
  `cityId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `image` longtext,
  `active` tinyint(1) NOT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `City`
--

CREATE TABLE `City` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `countryId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `City`
--

INSERT INTO `City` (`id`, `name`, `countryId`) VALUES
(1, 'Мариуполь', 1),
(2, 'Москва', 2),
(3, 'Киев', 1),
(4, 'Минск', 3),
(5, 'Токио', 5),
(6, 'Киото', 5),
(7, 'Петербург', 2),
(8, 'Детройт', 4),
(9, 'Нью-Йорк', 4),
(10, 'Лондон', 6),
(11, 'Бристоль', 6),
(14, 'Ташкент', 7),
(15, 'Париж', 8);

-- --------------------------------------------------------

--
-- Table structure for table `Country`
--

CREATE TABLE `Country` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Country`
--

INSERT INTO `Country` (`id`, `name`) VALUES
(1, 'Украина'),
(2, 'Россия'),
(3, 'Беларусь'),
(4, 'США'),
(5, 'Япония'),
(6, 'Великобритания'),
(7, 'Узбекистан'),
(8, 'Франция');

-- --------------------------------------------------------

--
-- Table structure for table `Languages`
--

CREATE TABLE `Languages` (
  `id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `priority` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Languages`
--

INSERT INTO `Languages` (`id`, `name`, `priority`) VALUES
(1, 'English', 1),
(2, 'Русский', 2);

-- --------------------------------------------------------

--
-- Table structure for table `Requests`
--

CREATE TABLE `Requests` (
  `id` int(11) NOT NULL,
  `bookId` int(11) NOT NULL,
  `userEmail` varchar(50) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Type`
--

CREATE TABLE `Type` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Type`
--

INSERT INTO `Type` (`id`, `name`) VALUES
(1, 'отдам'),
(2, 'дам почитать'),
(3, 'личная');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Books`
--
ALTER TABLE `Books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `countryId` (`countryId`),
  ADD KEY `cityId` (`cityId`),
  ADD KEY `typeId` (`typeId`),
  ADD KEY `user_id_idx` (`userId`),
  ADD KEY `Books_ibfk_4` (`language`);

--
-- Indexes for table `City`
--
ALTER TABLE `City`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country_id` (`countryId`);

--
-- Indexes for table `Country`
--
ALTER TABLE `Country`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Languages`
--
ALTER TABLE `Languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Requests`
--
ALTER TABLE `Requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`bookId`);

--
-- Indexes for table `Type`
--
ALTER TABLE `Type`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Books`
--
ALTER TABLE `Books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `City`
--
ALTER TABLE `City`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `Country`
--
ALTER TABLE `Country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `Languages`
--
ALTER TABLE `Languages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `Requests`
--
ALTER TABLE `Requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Type`
--
ALTER TABLE `Type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Books`
--
ALTER TABLE `Books`
  ADD CONSTRAINT `Books_ibfk_1` FOREIGN KEY (`countryId`) REFERENCES `Country` (`id`),
  ADD CONSTRAINT `Books_ibfk_2` FOREIGN KEY (`cityId`) REFERENCES `City` (`id`),
  ADD CONSTRAINT `Books_ibfk_3` FOREIGN KEY (`typeId`) REFERENCES `Type` (`id`);

--
-- Constraints for table `City`
--
ALTER TABLE `City`
  ADD CONSTRAINT `City_ibfk_1` FOREIGN KEY (`countryId`) REFERENCES `Country` (`id`);

--
-- Constraints for table `Requests`
--
ALTER TABLE `Requests`
  ADD CONSTRAINT `Requests_ibfk_1` FOREIGN KEY (`bookId`) REFERENCES `Books` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
