-- phpMyAdmin SQL Dump
-- version 6.0.0-dev+20250914.f72491a1c0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 17, 2025 at 12:52 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `football_aiartfc`
--

-- --------------------------------------------------------

--
-- Table structure for table `pemain`
--

CREATE TABLE `pemain` (
  `id_pemain` int NOT NULL,
  `nama` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `negara` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemain`
--

INSERT INTO `pemain` (`id_pemain`, `nama`, `negara`) VALUES
(1, 'Oscar Altamirano', 'Argentina'),
(2, 'Akram Amri', 'Tunisia'),
(3, 'Ahmad Ali Ramdan', 'Indonesia'),
(4, 'Rubén Venegas', 'Spanyol'),
(5, 'Rico Fangmu Santoso', 'Indonesia'),
(6, 'Irvan Iswanto', 'Indonesia'),
(7, 'Sani Ejindu', 'Nigeria'),
(8, 'Tomas Jedinak', 'Ceko'),
(9, 'Christover Wirtz Riekey', 'Jerman'),
(10, 'Nicolás Martínez', 'Argentina'),
(11, 'Anjer Laksana', 'Indonesia'),
(12, 'Luigi Cesaroni', 'Italia'),
(13, 'Jonathan Echeverry', 'Kolombia'),
(14, 'Guntur Santo', 'Indonesia'),
(15, 'Heri Sudrajat', 'Indonesia'),
(16, 'Ricky Suhendar', 'Indonesia'),
(17, 'Ghislain Mbom', 'Kamerun'),
(18, 'Ari Raditya', 'Indonesia'),
(19, 'Taryana Kurnia', 'Indonesia'),
(20, 'Jair van der Wal', 'Belanda'),
(21, 'Rachmat Pratama', 'Indonesia'),
(22, 'Manuel Real', 'Argentina'),
(23, 'Yanuar Ghofur', 'Indonesia'),
(24, 'Burhanudin Sainyakit', 'Indonesia'),
(25, 'Marcel Melunovic', 'Swiss'),
(26, 'Juan Revi Firmansyah', 'Indonesia'),
(27, 'Farid Zaenal', 'Indonesia'),
(28, 'Rogerio Carloto', 'Brasil'),
(29, 'Elvis Pineda', 'Nikaragua'),
(30, 'Paulino Alcántara', 'Filipina'),
(31, 'Nico Sæs Bergmân', 'Georgia'),
(32, 'Ragnarlðth Fredrinn', 'Norwegia'),
(33, 'Mykhailo Mudryk El Dear God', 'Ukraina'),
(34, 'Vladimir Darius Zyz', 'Rusia'),
(35, 'Mohd Khairol Azrin Mohd Yusof', 'Malaysia'),
(36, 'Oswald Oyarzabal Gattaz', 'Meksiko'),
(37, 'Wijaya Minamoto', 'Jepang'),
(38, 'Arrrasji Irrrad', 'Filipina'),
(39, 'Endrick Sousa Wa Bisakah', 'Wales'),
(40, 'Budiono Siregar', 'Indonesia'),
(41, 'Eduardo Rueda', 'Spanyol'),
(42, 'Lava La Kuza', 'Italia'),
(43, 'Marcel Juan Sinulingga', 'Indonesia'),
(44, 'Pero Nuzzle Beckenbauer', 'Jerman'),
(45, 'Rachid Hmouda', 'Maroko'),
(46, 'Arthur Fibonacci', 'Italia'),
(47, 'Zeth Harsono', 'Indonesia'),
(48, 'Kadek Nugraha Nasution', 'Indonesia'),
(49, 'Cole Palmer', 'Inggris'),
(50, 'Gianluca Kolczynski', 'Prancis'),
(51, 'Paul Fitzgerald', 'Irlandia'),
(52, 'Azizal Alimuddin Aulia Putra', 'Indonesia'),
(53, 'Yagesya Omega Fernando', 'Indonesia'),
(54, 'Nestor Genta Onanamaru', 'Pantai Gading'),
(55, 'Kingsley Yoroo', 'Prancis'),
(56, 'Yandri Main', 'Indonesia'),
(57, 'Chicira No Ciro Ciro', 'Kamerun'),
(58, 'Ayka Beanta Ancur', 'Indonesia'),
(59, 'Khoirul Bähnyindir', 'Turki'),
(60, 'Nathan Pepper', 'Australia'),
(61, 'Alexander der Kaizer', 'Jerman'),
(62, 'Charlie Merchant', 'Inggris'),
(63, 'Billy Agiana Sinaga', 'Indonesia'),
(64, 'Zulkifli Erlangga', 'Indonesia'),
(65, 'Emiliano Salomón', 'Argentina'),
(66, 'Angga Komang', 'Indonesia'),
(67, 'John Benny Diks Bakarbessy', 'Belanda'),
(68, 'Alexander Gattaz', 'Meksiko'),
(69, 'Martis Gelap', 'Belanda'),
(70, 'Rikaki Mekata', 'Jepang'),
(71, 'Noor Gunawan', 'Indonesia'),
(72, 'Aryan Kumar', 'India'),
(73, 'Yohanes Netherite', 'Indonesia'),
(74, 'Favian Eri Nathanael', 'Indonesia'),
(75, 'Hawk Tuah', 'Malaysia'),
(76, 'Frince Miguel Davizsta', 'Spanyol'),
(77, 'Ïmüt Amba', 'Amerika Serikat'),
(78, 'Svalbard Jan Mayen', 'Norwegia'),
(79, 'Heriadi Arus', 'Indonesia'),
(80, 'Zaneover Reynhard', 'Australia'),
(81, 'Fenryr Aditia Rauvann', 'Indonesia'),
(82, 'Kevin Havertz Riekey Jr', 'Jerman'),
(83, 'Mahsun Andrianto', 'Indonesia'),
(84, 'Biclösaph Never', 'Jerman'),
(85, 'Torino Dazex Ferran', 'Spanyol'),
(86, 'Amick Foulon', 'Prancis'),
(87, 'Hassan Gyoukeraz', 'Maroko'),
(88, 'A-Min Kim', 'Korea Selatan'),
(89, 'Lord Snowley', 'Inggris'),
(90, 'Luis Karkurumo Beaz', 'Brasil'),
(91, 'Vincént La Delma', 'Prancis'),
(92, 'Mofenake Decko Inzaghi', 'Italia'),
(93, 'Aswar Ohee', 'Indonesia'),
(94, 'Irvan Rusfandi', 'Indonesia'),
(189, 'Budiqono Silupamandi', 'Indonesia'),
(190, 'Dedick Maticoli', 'Brasil'),
(191, 'Rio Rizal', 'Indonesia'),
(192, 'Saiful Rimba', 'Indonesia'),
(193, 'Francesco Fahrenwald\r\n', 'Jerman'),
(194, 'Exzhellend Klyze Conceição\r\n', 'Portugal');

-- --------------------------------------------------------

--
-- Table structure for table `posisi`
--

CREATE TABLE `posisi` (
  `id_posisi` int NOT NULL,
  `kode` varchar(5) COLLATE utf8mb4_general_ci NOT NULL,
  `nama` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posisi`
--

INSERT INTO `posisi` (`id_posisi`, `kode`, `nama`) VALUES
(1, 'GK', 'Goalkeeper'),
(2, 'CB', 'Center Back'),
(3, 'LB', 'Left Back'),
(4, 'RB', 'Right Back'),
(5, 'CDM', 'Centre Defensive Midfielder'),
(6, 'CM', 'Centre Midfielder'),
(7, 'CAM', 'Centre Attacking Midfielder'),
(8, 'LM', 'Left Midfielder'),
(9, 'RM', 'Right Midfielder'),
(10, 'LWF', 'Left Wing Forward'),
(11, 'RWF', 'Right Wing Forward'),
(12, 'ST', 'Striker');

-- --------------------------------------------------------

--
-- Table structure for table `posisi_pemain`
--

CREATE TABLE `posisi_pemain` (
  `id_pemain` int NOT NULL,
  `id_posisi` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posisi_pemain`
--

INSERT INTO `posisi_pemain` (`id_pemain`, `id_posisi`) VALUES
(1, 1),
(19, 1),
(34, 1),
(43, 1),
(54, 1),
(70, 1),
(89, 1),
(94, 1),
(193, 1),
(2, 2),
(3, 2),
(15, 2),
(21, 2),
(22, 2),
(23, 2),
(28, 2),
(42, 2),
(44, 2),
(50, 2),
(61, 2),
(65, 2),
(67, 2),
(68, 2),
(76, 2),
(83, 2),
(93, 2),
(190, 2),
(2, 3),
(3, 3),
(24, 3),
(32, 3),
(57, 3),
(76, 3),
(81, 3),
(85, 3),
(2, 4),
(3, 4),
(27, 4),
(36, 4),
(53, 4),
(59, 4),
(68, 4),
(72, 4),
(76, 4),
(84, 4),
(192, 4),
(7, 5),
(26, 5),
(37, 5),
(40, 5),
(44, 5),
(45, 5),
(46, 5),
(51, 5),
(55, 5),
(61, 5),
(71, 5),
(73, 5),
(74, 5),
(79, 5),
(80, 5),
(191, 5),
(5, 6),
(6, 6),
(7, 6),
(20, 6),
(31, 6),
(33, 6),
(37, 6),
(41, 6),
(46, 6),
(49, 6),
(52, 6),
(55, 6),
(60, 6),
(61, 6),
(73, 6),
(74, 6),
(75, 6),
(78, 6),
(79, 6),
(80, 6),
(82, 6),
(90, 6),
(189, 6),
(7, 7),
(9, 7),
(12, 7),
(16, 7),
(33, 7),
(35, 7),
(39, 7),
(49, 7),
(52, 7),
(62, 7),
(64, 7),
(74, 7),
(86, 7),
(87, 7),
(194, 7),
(9, 8),
(13, 8),
(29, 8),
(31, 8),
(32, 8),
(47, 8),
(69, 8),
(81, 8),
(82, 8),
(85, 8),
(88, 8),
(4, 9),
(8, 9),
(14, 9),
(36, 9),
(37, 9),
(48, 9),
(63, 9),
(68, 9),
(72, 9),
(84, 9),
(90, 9),
(91, 9),
(9, 10),
(10, 10),
(17, 10),
(32, 10),
(38, 10),
(47, 10),
(69, 10),
(82, 10),
(85, 10),
(10, 11),
(16, 11),
(18, 11),
(48, 11),
(63, 11),
(77, 11),
(84, 11),
(87, 11),
(90, 11),
(91, 11),
(10, 12),
(11, 12),
(16, 12),
(18, 12),
(25, 12),
(30, 12),
(35, 12),
(39, 12),
(48, 12),
(56, 12),
(58, 12),
(66, 12),
(92, 12);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pemain`
--
ALTER TABLE `pemain`
  ADD PRIMARY KEY (`id_pemain`);

--
-- Indexes for table `posisi`
--
ALTER TABLE `posisi`
  ADD PRIMARY KEY (`id_posisi`),
  ADD UNIQUE KEY `kode` (`kode`);

--
-- Indexes for table `posisi_pemain`
--
ALTER TABLE `posisi_pemain`
  ADD PRIMARY KEY (`id_pemain`,`id_posisi`),
  ADD KEY `id_posisi` (`id_posisi`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pemain`
--
ALTER TABLE `pemain`
  MODIFY `id_pemain` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=195;

--
-- AUTO_INCREMENT for table `posisi`
--
ALTER TABLE `posisi`
  MODIFY `id_posisi` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `posisi_pemain`
--
ALTER TABLE `posisi_pemain`
  ADD CONSTRAINT `posisi_pemain_ibfk_1` FOREIGN KEY (`id_pemain`) REFERENCES `pemain` (`id_pemain`) ON DELETE CASCADE,
  ADD CONSTRAINT `posisi_pemain_ibfk_2` FOREIGN KEY (`id_posisi`) REFERENCES `posisi` (`id_posisi`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
