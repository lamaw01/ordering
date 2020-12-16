-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 16, 2020 at 06:22 PM
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
(78, '1923', '2020-12-16 14:17:30'),
(79, '299', '2020-12-16 14:17:49'),
(80, '680', '2020-12-16 14:24:24'),
(81, '245', '2020-12-16 14:30:08'),
(82, '509', '2020-12-16 14:42:46'),
(83, '299', '2020-12-16 14:50:08'),
(84, '680', '2020-12-16 15:34:31'),
(85, '925', '2020-12-16 16:56:02'),
(86, '245', '2020-12-16 17:00:38'),
(87, '544', '2020-12-16 17:13:13');

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
  MODIFY `cartid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `checkout`
--
ALTER TABLE `checkout`
  MODIFY `orderid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

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
