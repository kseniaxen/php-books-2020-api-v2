-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:3306
-- Время создания: Фев 15 2020 г., 19:23
-- Версия сервера: 5.7.29-0ubuntu0.18.04.1
-- Версия PHP: 7.2.24-0ubuntu0.18.04.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `books_as_a_gift`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Books`
--

CREATE TABLE `Books` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `author` varchar(50) NOT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `description` varchar(100) NOT NULL,
  `countryId` int(11) NOT NULL,
  `cityId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `image` longtext,
  `active` tinyint(1) NOT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Books`
--

INSERT INTO `Books` (`id`, `title`, `author`, `genre`, `description`, `countryId`, `cityId`, `typeId`, `image`, `active`, `updatedAt`) VALUES
(1, 'title1', 'author1', 'genre1', 'description1', 1, 1, 1, '', 1, '2020-02-15 07:38:01'),
(2, 'title2', 'author2', '', 'description2', 2, 2, 2, '', 0, '2020-02-15 07:55:15'),
(4, 'title4', 'author4', '-', 'description4', 2, 2, 1, '', 1, '2020-02-15 10:31:00'),
(6, 'title6', 'author6', '-', 'description6', 1, 2, 2, '', 1, '2020-02-15 10:31:38'),
(7, 'title7', 'author7', '-', 'description7', 1, 2, 2, '', 1, '2020-02-15 10:31:52'),
(9, 'title8-2', 'author8', '-', 'description8', 1, 2, 2, '', 1, '2020-02-15 15:26:19'),
(10, 'title10', 'author2', '-', 'description10', 1, 1, 1, '', 1, '2020-02-15 15:47:15');

-- --------------------------------------------------------

--
-- Структура таблицы `City`
--

CREATE TABLE `City` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `City`
--

INSERT INTO `City` (`id`, `name`, `country_id`) VALUES
(1, 'Мариуполь', 1),
(2, 'Москва', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `Country`
--

CREATE TABLE `Country` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Country`
--

INSERT INTO `Country` (`id`, `name`) VALUES
(1, 'Украина'),
(2, 'Россия');

-- --------------------------------------------------------

--
-- Структура таблицы `Type`
--

CREATE TABLE `Type` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Type`
--

INSERT INTO `Type` (`id`, `name`) VALUES
(1, 'дарю'),
(2, 'дам почитать');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Books`
--
ALTER TABLE `Books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `countryId` (`countryId`),
  ADD KEY `cityId` (`cityId`),
  ADD KEY `typeId` (`typeId`);

--
-- Индексы таблицы `City`
--
ALTER TABLE `City`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country_id` (`country_id`);

--
-- Индексы таблицы `Country`
--
ALTER TABLE `Country`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `Type`
--
ALTER TABLE `Type`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Books`
--
ALTER TABLE `Books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT для таблицы `City`
--
ALTER TABLE `City`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `Country`
--
ALTER TABLE `Country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `Type`
--
ALTER TABLE `Type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Books`
--
ALTER TABLE `Books`
  ADD CONSTRAINT `Books_ibfk_1` FOREIGN KEY (`countryId`) REFERENCES `Country` (`id`),
  ADD CONSTRAINT `Books_ibfk_2` FOREIGN KEY (`cityId`) REFERENCES `City` (`id`),
  ADD CONSTRAINT `Books_ibfk_3` FOREIGN KEY (`typeId`) REFERENCES `Type` (`id`);

--
-- Ограничения внешнего ключа таблицы `City`
--
ALTER TABLE `City`
  ADD CONSTRAINT `City_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `Country` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
