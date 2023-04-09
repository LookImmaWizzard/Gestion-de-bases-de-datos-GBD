/**************************************************************************/
/*Este script SQL crea la base de datos campeonato y todas sus tablas*/
/*************************************************************************/

/*Borramos, si existe, una base de datos anterior */
DROP DATABASE IF EXISTS campeonato;

/*Creamos la base de datos llamada campeonato */
CREATE DATABASE campeonato;

-- ponemos en uso (activamos) la base de datos campeonato
use campeonato;

-- TABLA concursante
CREATE TABLE concursante (
  cdconcur CHAR(3) NOT NULL PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  fecha_inscri DATE,
  cuota_inscri FLOAT,
  sexo ENUM ('M', 'H') NOT NULL,
  cdidolo CHAR(3) DEFAULT NULL,
  cdequipo CHAR(2) DEFAULT NULL  
) ENGINE=INNODB;

-- TABLA equipo
CREATE TABLE equipo (
  cdequipo CHAR(2) NOT NULL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  comunidad VARCHAR(20),
  anio_funda YEAR 
) ENGINE=INNODB;

-- TABLA participa
CREATE TABLE participa (
  cdconcur CHAR(3) NOT NULL,
  cdjuego CHAR(3) NOT NULL,
  fecha_inicio date NOT NULL,
  puntos SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (cdconcur,cdjuego)  
) ENGINE=INNODB;

-- TABLA juego
CREATE TABLE juego (
  cdjuego CHAR(3) NOT NULL PRIMARY KEY,
  nombre VARCHAR(40) NOT NULL UNIQUE,
  dificultad ENUM('alta', 'media', 'baja') NOT NULL,
  megusta SMALLINT UNSIGNED,
  cdequipo CHAR(2) NOT NULL  
) ENGINE=INNODB;

-- AÑADIMOS RESTRICCIONES DE CLAVE FORÁNEA

-- a TABLA  concursante
ALTER TABLE concursante
ADD FOREIGN KEY (cdequipo) REFERENCES equipo(cdequipo)
  ON DELETE RESTRICT 
  ON UPDATE CASCADE,
ADD FOREIGN KEY (cdidolo) REFERENCES concursante (cdconcur)
  ON DELETE SET NULL 
  ON UPDATE CASCADE;
  
-- a TABLA participa 
ALTER TABLE participa
ADD FOREIGN KEY (cdconcur) REFERENCES concursante(cdconcur)
  ON DELETE CASCADE 
  ON UPDATE CASCADE,
ADD FOREIGN KEY (cdjuego) REFERENCES juego(cdjuego)
  ON DELETE CASCADE 
  ON UPDATE CASCADE;

-- a TABLA juego
ALTER TABLE juego
ADD FOREIGN KEY (cdequipo) REFERENCES equipo(cdequipo)
  ON DELETE RESTRICT 
  ON UPDATE CASCADE; 