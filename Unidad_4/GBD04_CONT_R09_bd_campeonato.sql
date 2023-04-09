/**************************************************************************/
/*Este script SQL crea la base de datos campeonato y todas sus tablas*/
/*************************************************************************/

/*Borramos, si existe, una base de datos anterior */
DROP DATABASE IF EXISTS campeonato;

/*Creamos la base de datos llamada campeonato */
CREATE DATABASE campeonato;

-- ponemos en uso (activamos) la base de datos campeonato
use campeonato;

/***********************/
/* TABLA: equipo */
/***********************/
CREATE TABLE equipo (
  cdequipo CHAR(2) NOT NULL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  comunidad VARCHAR(20),
  anio_funda YEAR 
) ENGINE=INNODB;



/***********************/
/* TABLA: consursante    */
/***********************/
CREATE TABLE concursante (
  cdconcur CHAR(3) NOT NULL PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  fecha_inscri DATE DEFAULT NULL,
  cuota_inscri FLOAT UNSIGNED,
  sexo ENUM ('M', 'H') NOT NULL,
  cdidolo CHAR(3) DEFAULT NULL,
  cdequipo CHAR(2) DEFAULT NULL,
  FOREIGN KEY (cdequipo) REFERENCES equipo(cdequipo)
  ON DELETE RESTRICT 
  ON UPDATE CASCADE ,
  FOREIGN KEY (cdidolo)
  REFERENCES concursante (cdconcur)
  ON DELETE SET NULL 
  ON UPDATE CASCADE 
) ENGINE=INNODB;



/***********************/
/* TABLA: juego     */
/***********************/
CREATE TABLE juego (
  cdjuego CHAR(3) NOT NULL PRIMARY KEY,
  nombre VARCHAR(40) NOT NULL UNIQUE,
  dificultad ENUM('alta', 'media', 'baja') NOT NULL,
  megusta SMALLINT UNSIGNED,
  cdequipo CHAR(2) NOT NULL,  
  FOREIGN KEY (cdequipo) REFERENCES equipo(cdequipo)
  ON DELETE RESTRICT 
  ON UPDATE CASCADE 
) ENGINE=INNODB;



/***********************/
/* TABLA: participa    */
/***********************/
CREATE TABLE participa (
  cdconcur CHAR(3) NOT NULL,
  cdjuego CHAR(3) NOT NULL,
  fecha_inicio date NOT NULL,
  puntos SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (cdconcur,cdjuego),
  FOREIGN KEY (cdconcur) REFERENCES concursante(cdconcur)
  ON DELETE CASCADE 
  ON UPDATE CASCADE,
  FOREIGN KEY (cdjuego) REFERENCES juego(cdjuego)
  ON DELETE CASCADE 
  ON UPDATE CASCADE 
) ENGINE=INNODB;

/****************************************************************************************
Estas sentencias SQL insertan un conjunto de datos de prueba en la BD campeonato
****************************************************************************************/
USE campeonato;

/***********************/
/* TABLA: equipo */
/***********************/
INSERT INTO equipo
(cdequipo,nombre,comunidad, anio_funda) VALUES ('01','La marmota','Andalucía',2017),
 ('02','Los rebeldes','Murcia',2019), ('03','Amadeus','Galicia',2018), ('04','Aries','Asturias',2019),
 ('05','Atenea','Galicia',2019),('06','Los increibles','Andalucía',2020), ('07','El parral','Madrid',2020);


/***********************/
/* TABLA: concursante     */
/***********************/
INSERT INTO concursante
(cdconcur,nombre,fecha_inscri,cuota_inscri,sexo,cdidolo,cdequipo) VALUES 
('A22','Benita Naranja','2019-09-23',50, 'M', NULL,'04'),
('A33','Ismael Rojo','2018-03-07',45, 'H','A22','01'), ('C01','Juan Amarillo','2019-02-03',75,'H','A33','01'),
('B22','Marta Violeta','2019-01-09',45,'M','A33','01'),('A44','Elvira Blanco','2019-04-09',100,'M','A22','02'),
('B66','Sara Verde','2017-02-03',60,'M','A33','02'),('C05','Manolo Amarillo','2019-11-03',75,'H','B66','02'),
('B99','Carlos Rojo','2019-8-12',100,'H','A22','03'),('C04','Eva Verde',NULL,60,'M','A44','02'),
('C88','Javier Blanco',NULL,100,'H','B99','03'),('A10','Elena Blanco','2019-11-15',100,'M','A22','04'),
('B12','Pedro Azul','2019-02-03',60,'H','A22','05'),('A13','Javier Marrón','2019-02-21',60,'H','A22','05'),
('A14','Manuel Verde','2019-05-01',65,'H','A22','01'), ('C03','Alvaro Rojo','2018-12-03',55,'H','A33','01'),
('C02','Marta Rosa','2018-02-03',55,'M','A33','01'),('X01','Isabel Cruz','2020-03-14',50,'M',NULL,NULL),
('X02','Antonio Bernal','2020-04-014',50,'H','X01',NULL),('X03','Andrés Rojas','2020-04-23',55,'H',NULL,NULL);


/***********************/
/* TABLA: juego     */
/***********************/
INSERT INTO juego
(cdjuego,nombre,dificultad, megusta,cdequipo) 
VALUES ('LOL','League of Legends.','media',5, '03'), 
('WOW','World of Warcraft', 'baja',3,'03'),
('MUO',' MU online','alta',null,'04'),
('HAB','HABBO Hotel', 'media',4, '02'),
('GW2','Guild Wars 2.','baja',5,'01'),
('VIK', 'Vikings','media',5,'01'),
('FOE','Forge of Empires','alta',4,'06'), 
('CON','Conflict of Nations','alta',3,'03'),
('GOE','Goodgame Empire','alta',null,'01'), 
('ELV','Elvenar','baja',3,'01');

/***********************/
/* TABLA: participa    */
/***********************/
INSERT INTO participa (cdjuego,cdconcur,puntos, fecha_inicio) 
VALUES ('VIK','C01',25,'2019-04-15'),
('LOL','C88',54,'2019-01-25'), ('MUO','C01',50,'2019-03-15'),
('WOW','C88',45,'2019-05-15'), ('FOE','B99',10, '2019-09-15'),
('FOE','A14',35,'2019-03-15'),('VIK','A22',25,'2019-04-15'),
('HAB','C04',200, '2019-03-25'),('HAB','A22',30, '2019-06-15'),
('MUO','A33', 40, '2019-03-25'), ('LOL','B99',60,'2019-01-15'), 
('GOE','C03',20, '2019-05-10'), ('FOE','C02',60,'2019-02-15'),
('GW2','C03',20, '2019-02-10'), ('CON','C01',60,'2019-02-15'),
('VIK','A14',25, '2019-05-10'), ('CON','C02',60,'2019-02-15');
