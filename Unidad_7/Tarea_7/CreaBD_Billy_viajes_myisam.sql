-- ------------------------------------------------------------------------------
-- Curso 2022-2023
-- IES Aguadulce
-- CFGS ASIR modalidad a distancia
-- Módulo: Gestión de Bases de Datos
-- Diseño de la base de datos billy_MyISAM viajes en la tarea de la unidad 07
-- ------------------------------------------------------------------------------

-- Se borra, si existe, la base de datos billy_MyISAM
DROP DATABASE IF EXISTS billy_viajes_MyISAM;

-- Se crea la base de datos vacía
CREATE DATABASE billy_viajes_MyISAM;

-- Se pone en uso la base de datos recién creada
USE billy_viajes_MyISAM;

-- Estructura de tabla para la tabla `mayorista`
--

CREATE TABLE IF NOT EXISTS mayorista (
  codmay char(4) NOT NULL, 
  nombre varchar(40) DEFAULT NULL,
  PRIMARY KEY (codmay)
)ENGINE=MyISAM;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla `categoria`
--
CREATE TABLE IF NOT EXISTS categoria (
  codcate char(5) NOT NULL, 
  nombre varchar(40) DEFAULT NULL,
  PRIMARY KEY (codcate)
)ENGINE=MyISAM;

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
  PRIMARY KEY (codvia)
  
)ENGINE=MyISAM;

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
)ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva`
--

CREATE TABLE IF NOT EXISTS reserva(
  id int(11) NOT NULL,
  nif char(9) NOT NULL,
  cod_viaje int(11) NOT NULL,
  fecha_reserva DATE NOT NULL,
  PRIMARY KEY (id)
  )ENGINE=MyISAM;


-- ------------------------------------------------------------
-- Fin del script de creación de la base de datos billy_viajes_MyISAM
-- ------------------------------------------------------------

