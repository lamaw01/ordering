-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 15, 2020 at 11:33 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ordering`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cartid` int(11) NOT NULL,
  `menuid` varchar(250) NOT NULL,
  `menuname` varchar(250) NOT NULL,
  `menuprice` varchar(250) NOT NULL,
  `cartdatecreated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cartid`, `menuid`, `menuname`, `menuprice`, `cartdatecreated`) VALUES
(3, '8', 'Fisherman`s Platter', '795.00', '2020-12-15 22:32:38'),
(4, '10', 'Sriracha garlic chicken wings', '210.00', '2020-12-15 22:32:40');

-- --------------------------------------------------------

--
-- Table structure for table `checkout`
--

CREATE TABLE `checkout` (
  `orderid` int(11) NOT NULL,
  `summary` varchar(250) NOT NULL,
  `orderdatecreated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `checkout`
--

INSERT INTO `checkout` (`orderid`, `summary`, `orderdatecreated`) VALUES
(1, '700', '2020-12-15 18:39:50'),
(31, '3284', '2020-12-15 20:47:22'),
(32, '3284', '2020-12-15 20:47:27'),
(33, '3284', '2020-12-15 20:59:29'),
(34, '3284', '2020-12-15 21:01:21'),
(35, '680', '2020-12-15 21:21:59'),
(36, '680', '2020-12-15 21:25:02'),
(37, '680', '2020-12-15 21:30:13'),
(38, '680', '2020-12-15 21:30:26'),
(39, '1479', '2020-12-15 21:33:37'),
(40, '1479', '2020-12-15 21:33:48'),
(41, '1479', '2020-12-15 21:33:53'),
(42, '1479', '2020-12-15 21:34:09'),
(43, '1479', '2020-12-15 21:34:25'),
(44, '885', '2020-12-15 21:39:54'),
(45, '1094', '2020-12-15 21:59:10'),
(46, '299', '2020-12-15 21:59:42'),
(47, '2593', '2020-12-15 22:00:46'),
(48, '560', '2020-12-15 22:02:14'),
(49, '1094', '2020-12-15 22:04:01'),
(50, '1094', '2020-12-15 22:05:09'),
(51, '1274', '2020-12-15 22:12:57'),
(52, '1879', '2020-12-15 22:15:38'),
(53, '1879', '2020-12-15 22:15:50'),
(54, '1060', '2020-12-15 22:17:49'),
(55, '564', '2020-12-15 22:18:21'),
(56, '795', '2020-12-15 22:20:58'),
(57, '4138', '2020-12-15 22:23:58'),
(58, '680', '2020-12-15 22:30:46'),
(59, '3707', '2020-12-15 22:32:00');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `menuid` int(11) NOT NULL,
  `menuname` varchar(250) NOT NULL,
  `menudescription` varchar(250) NOT NULL,
  `menuprice` varchar(250) NOT NULL,
  `menuimg` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`menuid`, `menuname`, `menudescription`, `menuprice`, `menuimg`) VALUES
(1, 'Bigby`s Riblets', 'Still our very own signature smoky barbequed ribs in bite size pieces', '299.00', 'img (1).jpg'),
(2, 'Belly Buster', 'The ultimate combo of our famous barbecued Baby back ribs, grilled Rodeo Chops and smoky pork belly. Served in one heapi', '680.00', 'img (2).jpg'),
(3, 'Buenos Nachos', 'Stack of crispy corn chips with cheese sauce, mexican beef and salsa fresca.', '245.00', 'img (3).jpg'),
(4, 'Chili flappers', 'Specially marinated and glazed chicken wings, served with a touch of sweet and spice.', '199.00', 'img (4).jpg'),
(5, 'Creole Pasta', 'A pasta combination of ham, chicken, sausage and shrimps in sweet and spicy red tomato sauce.', '295.00', 'img (5).jpg'),
(6, 'Dippy Doodle Doo', 'Golden breaded chicken strips with honey mustard sauce.', '205.00', 'img (6).jpg'),
(7, 'Emperor Caesar`s - with Grilled chicken', 'Crisp romaine and iceberg lettuce tossed with our signature Bigby\'s cheamy caesar\'s dressing, parmessan cheese, bacon bi', '265.00', 'img (7).jpg'),
(8, 'Fisherman`s Platter', 'Try our seafood sampler of one hefty portion of tortilla-crusted golden fish fillet, squiggly rings and two sticks of fi', '795.00', 'img (8).jpg'),
(9, 'Grilled Rodeo chops - Full', 'Specially marinated pork chops grilled nice and easy, served with rice and your choice of cranberry sauce or pan gravy.', '299.00', 'img (9).jpg'),
(10, 'Sriracha garlic chicken wings', 'If you love the hot Sriracha sauce, try these chicken wings with a kick! Crispy, hot and saucy - all in one dish to sati', '210.00', 'img (10).jpg');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`) VALUES
(1, 'janrey', 'lamaw');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cartid`);

--
-- Indexes for table `checkout`
--
ALTER TABLE `checkout`
  ADD PRIMARY KEY (`orderid`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`menuid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cartid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `checkout`
--
ALTER TABLE `checkout`
  MODIFY `orderid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `menuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
