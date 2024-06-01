-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2024 at 07:56 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `1920snkrs`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `isActive` tinyint(1) DEFAULT 1,
  `datecreated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `username`, `email`, `password`, `isActive`, `datecreated`) VALUES
(8693, 'jame', 'jame@sco.com', '$2y$10$xM1OmghT7NC/0KTED9ZsjeZYNOdsPSMlhB5NWEWezoz2VC2w8xkfy', 1, '2024-04-29 07:26:02');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `prod_size` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `updated_on` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `userid`, `product_id`, `prod_size`, `quantity`, `updated_on`) VALUES
(26, 60433, 19, '37', 1, '2024-06-01 16:27:56'),
(27, 60431, 19, '36', 1, '2024-06-01 16:29:06');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `CategoryID` int(11) NOT NULL,
  `CategoryName` varchar(255) NOT NULL,
  `Description` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`CategoryID`, `CategoryName`, `Description`, `CreatedAt`) VALUES
(1, 'Men', 'Men Originals', '2024-05-23 06:19:25'),
(2, 'Women', 'Women Originals', '2024-05-23 06:19:25'),
(3, 'Kids', 'Kiddo', '2024-05-23 06:20:49'),
(4, 'Sports', 'Sportswear', '2024-05-23 06:20:49'),
(5, 'Unisex', 'For men and women', '2024-05-23 06:21:03');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `Product_id` int(11) NOT NULL,
  `prod_name` varchar(255) NOT NULL,
  `Description` text DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL,
  `ImageURL` varchar(255) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `sizes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`Product_id`, `prod_name`, `Description`, `Price`, `ImageURL`, `CreatedAt`, `sizes`) VALUES
(1, 'Sneaker 1', 'For casual and basketball ', '8999.00', 'assets/product/product-2.jpg', '2024-05-19 12:30:53', '41,42,43, 44'),
(5, 'Sneka 2', 'safasfg', '2999.00', 'assets/product/product-1.jpg', '2024-05-19 15:51:38', '41,42,43'),
(6, 'Jordan', 'saf', '2422.00', 'assets/product/product-3.jpg', '2024-05-20 14:38:13', '41,42,43'),
(19, 'Nike Shoe', 'Nisi quis eleifend quam adipiscing vitae proin sagittis nisl. Amet cursus sit amet dictum sit amet justo donec. Odio eu feugiat pretium nibh. Sollicitudin nibh sit amet commodo nulla facilisi. Dictum sit amet justo donec. Commodo nulla facilisi nullam vehicula. Mauris augue neque gravida in. Amet consectetur adipiscing elit duis. Nunc faucibus a pellentesque sit amet porttitor eget. Sodales neque sodales ut etiam sit amet. Maecenas sed enim ut sem viverra aliquet eget. Ut faucibus pulvinar elementum integer enim neque volutpat.', '1999.00', 'assets/product/demo.jpg', '2024-05-24 20:50:48', '36,37,36,37,38,39'),
(22, 'Shoe Product', 'Very nice', '1999.00', 'assets/product/demo4.jpg', '2024-05-31 17:01:19', '36,37'),
(23, 'Pasig Shoe', 'Bobby vs Vico', '2999.00', 'assets/product/demo3.jpg', '2024-05-31 17:04:33', '36,37,36'),
(24, 'Sneaker Product', 'Sneaker Product Description', '2999.00', 'assets/product/demo2.jpg', '2024-05-31 17:24:31', '36,37'),
(25, 'Nikey', 'Nikey shoe', '1999.00', 'assets/product/demo2.jpg', '2024-05-31 17:27:33', '36,36,39');

-- --------------------------------------------------------

--
-- Table structure for table `product_data`
--

CREATE TABLE `product_data` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `isNew` tinyint(1) DEFAULT 1,
  `onDiscount` tinyint(1) DEFAULT 0,
  `Discount` decimal(5,2) DEFAULT 0.00,
  `DiscountExpirationDate` date DEFAULT NULL,
  `CategoryID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_data`
--

INSERT INTO `product_data` (`id`, `product_id`, `isNew`, `onDiscount`, `Discount`, `DiscountExpirationDate`, `CategoryID`) VALUES
(1124, 5, 1, 0, '0.00', NULL, 1),
(1245, 1, 1, 1, '20.00', '2024-05-25', 4),
(1246, 6, 1, 1, '30.00', '2024-05-29', 4),
(1250, 19, 1, 1, '20.00', NULL, 1),
(1253, 22, 1, 0, '0.00', NULL, 1),
(1254, 23, 1, 1, '99.00', NULL, 5),
(1255, 24, 1, 1, '30.00', NULL, 4),
(1256, 25, 1, 0, '0.00', NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `product_inventory`
--

CREATE TABLE `product_inventory` (
  `inventory_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `prod_size` varchar(10) NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `out_of_stock_datetime` datetime DEFAULT NULL,
  `replenished_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_inventory`
--

INSERT INTO `product_inventory` (`inventory_id`, `product_id`, `prod_size`, `stock`, `out_of_stock_datetime`, `replenished_datetime`) VALUES
(1, 24, '', 5, NULL, NULL),
(2, 25, '', 2, NULL, NULL),
(3, 6, '', 3, NULL, NULL),
(4, 19, '', 3, NULL, NULL),
(5, 23, '', 3, NULL, NULL),
(6, 22, '', 3, NULL, NULL),
(7, 5, '', 3, NULL, NULL),
(8, 1, '', 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sizes`
--

CREATE TABLE `sizes` (
  `size_id` int(11) NOT NULL,
  `sizes_all` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sizes`
--

INSERT INTO `sizes` (`size_id`, `sizes_all`) VALUES
(1, '36'),
(2, '37'),
(3, '36'),
(4, '37'),
(5, '38'),
(6, '39'),
(7, '40'),
(8, '41'),
(9, '42'),
(10, '43'),
(11, '44'),
(12, '45');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userid` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `datecreated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userid`, `username`, `email`, `password`, `datecreated`) VALUES
(60431, 'quizquest1', 'botewod322@deligy.com', '$2y$10$09D8.t5YOQMJ4dKKVIotS.PnhQ68WzxPZz9HiU6pqpqolUF3JQYv6', '2024-05-06 03:29:56'),
(60432, 'test', 'test@gmail.com', '$2y$10$Uj.EzYJBHcdfZk9G46k6YeEVpGa8YkH/rt8S.01.b5kdUv8L93MTe', '2024-05-24 21:34:24'),
(60433, 'jame', 'bjamewel29@gmail.com', '$2y$10$dGZEe0NXmRrApi6Qikq4QOYq7jFbA0yUOGhS/MwnR8/8DDzIO7nT6', '2024-06-01 10:50:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`CategoryID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`Product_id`);

--
-- Indexes for table `product_data`
--
ALTER TABLE `product_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `FK_Category` (`CategoryID`);

--
-- Indexes for table `product_inventory`
--
ALTER TABLE `product_inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `sizes`
--
ALTER TABLE `sizes`
  ADD PRIMARY KEY (`size_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8694;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `Product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `product_data`
--
ALTER TABLE `product_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1257;

--
-- AUTO_INCREMENT for table `product_inventory`
--
ALTER TABLE `product_inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `sizes`
--
ALTER TABLE `sizes`
  MODIFY `size_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60434;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`Product_id`);

--
-- Constraints for table `product_data`
--
ALTER TABLE `product_data`
  ADD CONSTRAINT `FK_Category` FOREIGN KEY (`CategoryID`) REFERENCES `category` (`CategoryID`),
  ADD CONSTRAINT `product_data_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`Product_id`) ON DELETE CASCADE;

--
-- Constraints for table `product_inventory`
--
ALTER TABLE `product_inventory`
  ADD CONSTRAINT `product_inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`Product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
