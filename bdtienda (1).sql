-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-07-2023 a las 15:48:18
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdtienda`
--
CREATE DATABASE IF NOT EXISTS `bdtienda` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `bdtienda`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `calcular_promedio_precios_articulos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `calcular_promedio_precios_articulos` (OUT `promedio` DECIMAL(10,2))   BEGIN
    SELECT AVG(PrecioUnidad) INTO promedio FROM articulos;
END$$

DROP PROCEDURE IF EXISTS `categorizar_platillos_por_precio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `categorizar_platillos_por_precio` ()   BEGIN
    DECLARE precio_maximo DECIMAL(10, 2);
    DECLARE precio_minimo DECIMAL(10, 2);

    -- Obtener el precio máximo y mínimo
    SELECT MAX(PrecioUnidad), MIN(PrecioUnidad) INTO precio_maximo, precio_minimo FROM articulos;

    -- Categorizar los platillos por precio
    SELECT 
        Descripcion,
        PrecioUnidad,
        CASE
            WHEN PrecioUnidad >= precio_maximo - (precio_maximo - precio_minimo) / 3 THEN 'Caro'
            WHEN PrecioUnidad <= precio_minimo + (precio_maximo - precio_minimo) / 3 THEN 'Económico'
            ELSE 'Medio'
        END AS Categoria
    FROM articulos;
END$$

DROP PROCEDURE IF EXISTS `encontrar_articulos_extremos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `encontrar_articulos_extremos` (OUT `articulo_mas_caro` VARCHAR(255), OUT `articulo_mas_barato` VARCHAR(255))   BEGIN
    -- Artículo más caro
    SELECT Descripcion INTO articulo_mas_caro
    FROM articulos
    WHERE PrecioUnidad = (SELECT MAX(PrecioUnidad) FROM articulos);
    
    -- Artículo más barato
    SELECT Descripcion INTO articulo_mas_barato
    FROM articulos
    WHERE PrecioUnidad = (SELECT MIN(PrecioUnidad) FROM articulos);
END$$

DROP PROCEDURE IF EXISTS `SPdetalle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPdetalle` (`fac` CHAR(8), `coda` CHAR(6), `can` INT)   BEGIN
insert into facdet values (fac,coda, can);
update articulos set stock= stock -can where idarticulo=coda;
END$$

DROP PROCEDURE IF EXISTS `SPFACTURA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPFACTURA` (IN `codc` CHAR(8), IN `tot` NUMERIC(8,1))   BEGIN
declare nro int;
declare fac char(8);
select ifnull(max(nrofactura),0) + 1  from faccab into nro;
set fac = lpad(nro,8,'0');
insert into faccab values (fac,current_date(),codc,tot);
select fac;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

DROP TABLE IF EXISTS `articulos`;
CREATE TABLE `articulos` (
  `IdArticulo` char(6) NOT NULL,
  `IdCategoria` char(5) NOT NULL,
  `Descripcion` varchar(30) NOT NULL,
  `PrecioUnidad` decimal(8,1) NOT NULL,
  `Stock` int(11) NOT NULL,
  `Imagen` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`IdArticulo`, `IdCategoria`, `Descripcion`, `PrecioUnidad`, `Stock`, `Imagen`) VALUES
('01', 'CAT01', 'Cassoulet', '39.0', 32, '20.png'),
('02', 'CAT01', 'Blanqueta de ternera', '55.0', 11, '23.png'),
('03', 'CAT01', 'Ancas de rana', '96.0', 4, '21.png'),
('04', 'CAT01', 'El croque-monsieur', '50.0', 17, '22.png'),
('05', 'CAT01', 'El gratin dauphinois', '80.0', 14, '25.png'),
('06', 'CAT01', 'Buey bourguignon', '85.0', 6, '26.png'),
('07', 'CAT01', 'Pot-au-feu', '62.0', 18, '24.png'),
('08', 'CAT01', 'Bullabesa', '34.0', 15, '27.png'),
('09', 'CAT01', 'Coq au vin', '44.0', 24, '28.png'),
('10', 'CAT02', 'Papa a la Huancaina', '34.0', 24, '91.png'),
('11', 'CAT02', 'Arroz con Pollo', '29.0', 30, '92.png'),
('12', 'CAT02', 'Causa Rellena', '19.0', 35, '93.png'),
('13', 'CAT02', 'Lomo Saltado', '34.0', 30, '94.png'),
('14', 'CAT02', 'Juane Selvático', '26.0', 25, '95.png'),
('15', 'CAT02', 'Picarones Costeños', '29.0', 20, '96.png'),
('16', 'CAT02', 'Pachamanca', '62.0', 35, '97.png'),
('17', 'CAT02', 'Rocoto Relleno', '25.0', 30, '98.png'),
('18', 'CAT02', 'Papa Rellena', '21.0', 30, '99.png'),
('19', 'CAT03', 'Pescado Bonito Frito', '45.0', 15, '51.png'),
('20', 'CAT03', 'Chicharron de Calamar', '36.0', 13, '52.png'),
('21', 'CAT03', 'Sopa de camarones', '54.0', 20, '53.png'),
('22', 'CAT03', 'Jalea Marina', '63.0', 20, '54.png'),
('23', 'CAT03', 'Arroz con Mariscos', '27.0', 10, '55.png'),
('24', 'CAT03', 'Chicharron de Pescado', '42.0', 20, '56.png'),
('25', 'CAT03', 'Ceviche Peruano Sabor original', '89.0', 22, '57.png'),
('26', 'CAT03', 'Chupe de Camaron', '44.0', 25, '59.png'),
('27', 'CAT03', 'Langostinos en Salsa', '44.0', 25, '58.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias` (
  `IdCategoria` char(5) NOT NULL,
  `Descripcion` varchar(30) NOT NULL,
  `Imagen` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`IdCategoria`, `Descripcion`, `Imagen`) VALUES
('CAT01', 'Platillos a la Carta', '29.png'),
('CAT02', 'Menú Sabor Criollo', '44.png'),
('CAT03', 'Menú Marino Peruano', '45.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `IdCliente` char(8) NOT NULL,
  `Apellidos` varchar(30) NOT NULL,
  `Nombres` varchar(30) NOT NULL,
  `Direccion` varchar(30) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Edad` int(11) NOT NULL,
  `PassWord` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`IdCliente`, `Apellidos`, `Nombres`, `Direccion`, `Email`, `Edad`, `PassWord`) VALUES
('admin', 'admin', 'admin', '*******', '*****@***.com', 99, 'admin'),
('hubab', 'syed ali ore', 'hubab', 'Av.aviacion', 'hubab@hotmail.com', 25, '1598'),
('Marlene', 'Ruiz', 'Marlene', 'AV.AREQUIPA 1045', 'jmendez@yahoo.es', 25, '000000'),
('Olga', 'Tañon', 'Olga', 'Av la Rumba 360', 'pdiaz@yahoo.es', 23, '123456'),
('Pedro', 'Chavez', 'Pedro', 'Av Los Manzanos 360', 'perez@yahoo.es', 39, '123456');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `CodEmp` int(11) NOT NULL,
  `NomEmp` varchar(30) DEFAULT NULL,
  `DNI_Emp` int(11) DEFAULT NULL,
  `RUC_Emp` varchar(30) DEFAULT NULL,
  `AreaEmp` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`CodEmp`, `NomEmp`, `DNI_Emp`, `RUC_Emp`, `AreaEmp`) VALUES
(1, 'Victor', 8107282, '1008107282', 'Gerencia'),
(2, 'Diana', 41738642, '1041738642', 'Cocina'),
(3, 'Davis', 44122062, '1044122062', 'Cocina'),
(4, 'Juan', 48131154, '1048131154', 'Logistica'),
(5, 'Hubab', 9876531, '10019876531', 'Administracion'),
(6, 'Tekito Fokito', 78456132, '1078456132', 'Laboral'),
(7, 'Aquiles Mamani ', 97485118, '1097485118', 'Transporte'),
(8, 'Armando Esteban Quito', 96328417, '1096328417', 'Chef');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `faccab`
--

DROP TABLE IF EXISTS `faccab`;
CREATE TABLE `faccab` (
  `NroFactura` char(8) NOT NULL,
  `FechaFactura` datetime NOT NULL,
  `IdCliente` char(8) NOT NULL,
  `MontoTotal` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `faccab`
--

INSERT INTO `faccab` (`NroFactura`, `FechaFactura`, `IdCliente`, `MontoTotal`) VALUES
('00000001', '2023-07-15 00:00:00', 'CLI00001', '19'),
('00000002', '2023-07-15 00:00:00', 'CLI00001', '38'),
('00000003', '2023-07-15 00:00:00', 'CLI00001', '940'),
('00000004', '2023-07-15 00:00:00', '11111', '352'),
('00000005', '2023-07-21 00:00:00', 'Pedro', '39'),
('00000006', '2023-07-21 00:00:00', 'Pedro', '34'),
('00000007', '2023-07-21 00:00:00', 'Pedro', '39'),
('00000008', '2023-07-21 00:00:00', 'Pedro', '39'),
('00000009', '2023-07-21 00:00:00', 'Pedro', '55'),
('00000010', '2023-07-21 00:00:00', 'Pedro', '80'),
('00000011', '2023-07-21 00:00:00', 'Pedro', '50'),
('00000012', '2023-07-21 00:00:00', 'Pedro', '96'),
('00000013', '2023-07-21 00:00:00', 'Pedro', '44'),
('00000014', '2023-07-21 00:00:00', 'Pedro', '80'),
('00000015', '2023-07-21 00:00:00', 'Pedro', '85'),
('00000016', '2023-07-21 00:00:00', 'Pedro', '60'),
('00000017', '2023-07-21 00:00:00', 'Pedro', '36'),
('00000018', '2023-07-21 00:00:00', '', '0'),
('00000019', '2023-07-21 00:00:00', 'Marlene', '38');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facdet`
--

DROP TABLE IF EXISTS `facdet`;
CREATE TABLE `facdet` (
  `NroFactura` char(8) NOT NULL,
  `IdArticulo` char(6) NOT NULL,
  `Cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facdet`
--

INSERT INTO `facdet` (`NroFactura`, `IdArticulo`, `Cantidad`) VALUES
('00000001', 'ART02', 1),
('00000002', 'ART02', 2),
('00000003', 'CHA01', 5),
('00000004', 'CHA02', 4),
('00000005', '01', 1),
('00000006', 'ART10', 1),
('00000007', '01', 1),
('00000008', '01', 1),
('00000009', '02', 1),
('00000010', '05', 1),
('00000011', '04', 1),
('00000012', '03', 1),
('00000013', '09', 1),
('00000014', '05', 1),
('00000015', '06', 1),
('00000016', 'ART20', 1),
('00000017', '20', 1),
('00000019', '12', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_delivery`
--

DROP TABLE IF EXISTS `personal_delivery`;
CREATE TABLE `personal_delivery` (
  `CodPD` int(11) NOT NULL,
  `NomPD` varchar(30) DEFAULT NULL,
  `DNI_PD` int(11) DEFAULT NULL,
  `RUC_PD` char(15) DEFAULT NULL,
  `Estado` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personal_delivery`
--

INSERT INTO `personal_delivery` (`CodPD`, `NomPD`, `DNI_PD`, `RUC_PD`, `Estado`) VALUES
(1, 'JHON', 76232865, '1076232865', 'LIBRE'),
(2, 'NAYSHA', 45632865, '1045632865', 'EN ENTREGA'),
(3, 'CARLOS', 12332865, '1012332865', 'LIBRE'),
(4, 'ROBERT', 36932865, '1036932865', 'EN ENTREGA'),
(5, 'RONALD', 53213578, '1053213578', 'LIBRE');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`IdArticulo`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`IdCategoria`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`IdCliente`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`CodEmp`);

--
-- Indices de la tabla `faccab`
--
ALTER TABLE `faccab`
  ADD PRIMARY KEY (`NroFactura`);

--
-- Indices de la tabla `facdet`
--
ALTER TABLE `facdet`
  ADD PRIMARY KEY (`NroFactura`,`IdArticulo`);

--
-- Indices de la tabla `personal_delivery`
--
ALTER TABLE `personal_delivery`
  ADD PRIMARY KEY (`CodPD`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
