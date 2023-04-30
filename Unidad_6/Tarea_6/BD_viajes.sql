
/**************************************************************************/
/*Este script SQL crea la base de datos viajes y todas sus tablas*/
/*************************************************************************/

/*Borramos, si existe, una base de datos anterior */

DROP DATABASE IF EXISTS viajes;
--
-- Base de datos: VIAJES
--
CREATE DATABASE viajes 
;

USE viajes;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla `mayorista`
--

CREATE TABLE IF NOT EXISTS mayorista (
  codmay char(4) NOT NULL, 
  nombre varchar(40) DEFAULT NULL,
  PRIMARY KEY (codmay)
) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE IF NOT EXISTS categoria (
  codcate char(5) NOT NULL, 
  nombre varchar(40) DEFAULT NULL,
  PRIMARY KEY (codcate)
) ENGINE=InnoDB;



--
-- Estructura de tabla para la tabla `viaje`
--

CREATE TABLE IF NOT EXISTS viaje (
  codvia int(11) NOT NULL, 
  nombre varchar(60)   NOT NULL,
  mayori char(4)  NOT NULL,
  catego char(5) not null,
  fecha_salida DATE not null,
  plazas smallint(6) default 0,
  ocupadas smallint(6) DEFAULT 0,
  PRIMARY KEY (codvia),
  FOREIGN KEY (mayori) REFERENCES mayorista(codmay)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
  FOREIGN KEY (catego) REFERENCES categoria(codcate)
  ON DELETE RESTRICT
  ON UPDATE CASCADE
  
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE IF NOT EXISTS cliente (
  nif char(9)  NOT NULL,
  nombre varchar(35)  NOT NULL,
  email varchar(30)  NOT NULL UNIQUE,
  fecha_alta DATE,
  puntos smallint not null default 0,
  PRIMARY KEY (nif)
) ENGINE=InnoDB;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE IF NOT EXISTS reserva(
  id int(11) NOT NULL,
  nif char(9) NOT NULL,
  cod_viaje int(11) NOT NULL,
  fecha_reserva DATE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (cod_viaje) 
  REFERENCES viaje (codvia) 
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
  FOREIGN KEY (nif) 
  REFERENCES cliente (nif) 
  ON DELETE RESTRICT
  ON UPDATE CASCADE
) ENGINE=InnoDB;


--
-- Volcar los datos para la tabla `categoria`
--

INSERT INTO categoria VALUES
('CRUC', 'Crucero'),
('SAFA', 'Safari'),
('EURO', 'Europa'),
('LATI', 'Latinoamérica'),
('ASIA', 'Asia');

--
-- Volcar los datos para la tabla `mayorista`
--

INSERT INTO mayorista VALUES
('CLA', 'Claratours'),
('SAK', 'Saki Cruceros'),
('SOL', 'Soltours'),
('MEN', 'Mentetours'),
('PIK', 'Piki Cruceros');


--
-- Volcar datos para la tabla `viaje`
--

INSERT INTO viaje  VALUES
(1, 'Islas Baleares','CLA', 'EURO', '2023-07-03', 2, 0),
(2, 'China', 'CLA','ASIA', '2023-07-13',1, 0),
(3, 'Vietnam ','MEN', 'ASIA','2023-08-05', 3, 0),
(4, 'Islas griegas', 'SAK','CRUC', '2023-07-05',2, 1),
(5, 'Fiordos Noruegos', 'PIK','CRUC','2023-07-01', 2, 0),
(6, 'Cataratas Iguazu','SOL','LATI','2023-08-15',2, 0),
(7, 'Patagonia', 'CLA', 'LATI','2023-12-15',1, 1),
(8, 'Yucatán', 'SOL','LATI','2023-07-16', 1, 0),
(9, 'Italia', 'CLA','EURO', '2023-07-25',1, 0),
(10, 'Inglaterra', 'CLA','EURO','2023-08-03', 2, 1),
(11, 'Costa Rica', 'CLA', 'LATI','2023-08-10', 1, 0),
(12, 'Francia', 'MEN', 'EURO','2023-08-01', 2, 0),
(13, 'Alemania', 'CLA', 'EURO','2023-08-10', 1, 1);


--
-- Volcar la base de datos para la tabla `cliente`
--

INSERT INTO cliente VALUES
('23727319S', 'Belén Sánchez Pardo', 'bsp@gmail.com','2020-02-24',100),
('43229482E', 'Ana Moreno López', 'aml@gmail.com','2019-03-15',50),
('62877137F', 'Eva Luque Martínez', 'elm@gmail.com','2010-04-20',20),
('74381725T', 'Francisco Ojeda Rodríguez', 'for@gmail.com','2022-06-24',30),
('10101010X', 'pruebasX','pruebasx@gmail.com','2016-01-20',0),
('20202020y', 'pruebasY','pruebasy@gmail.com','2017-11-10',0);

--
-- Volcar los datos para la tabla `reserva`
--

INSERT INTO reserva (id, nif, cod_viaje, fecha_reserva) VALUES
(1, '62877137F', 4, '2023-02-02'),
(2, '23727319S', 7, '2023-03-03'),
(3, '74381725T', 10, '2023-03-05'),
(4, '62877137F', 13, '2023-03-05')
;
