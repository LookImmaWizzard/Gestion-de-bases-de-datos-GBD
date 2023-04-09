/**************************************************************************/
/*Este script SQL crea la base de datos investigacion y todas sus tablas*/
/*************************************************************************/

/*Borramos, si existe, una base de datos anterior */
DROP DATABASE IF EXISTS investigacion;

/*Creamos la base de datos llamada solidarios */
CREATE DATABASE investigacion
CHARACTER SET utf8
COLLATE utf8_spanish_ci;

use investigacion;
/***********************/
/* TABLA: grupo */
/***********************/
CREATE TABLE grupo (
  cdgru CHAR(2) NOT NULL PRIMARY KEY,
  nombre VARCHAR(50),
  ciudad VARCHAR(20)
) ENGINE=INNODB;



/***********************/
/* TABLA: alumnado     */
/***********************/
CREATE TABLE alumnado (
  cdalu CHAR(3) NOT NULL PRIMARY KEY,
  nombre VARCHAR(30),
  fecha_alta DATE DEFAULT NULL,
  cuota_anual FLOAT(6,2) UNSIGNED,
  sexo enum ('M', 'H') not null,
  cdcoor CHAR(3) DEFAULT NULL,
  cdgru CHAR(2) NOT NULL,
  FOREIGN KEY (cdgru)
  REFERENCES grupo(cdgru)
  ON DELETE RESTRICT ON UPDATE CASCADE ,
  FOREIGN KEY (cdcoor)
  REFERENCES alumnado(cdalu)
  ON DELETE SET NULL ON UPDATE CASCADE 
) ENGINE=INNODB;



/***********************/
/* TABLA: proyecto     */
/***********************/
CREATE TABLE proyecto (
  cdpro CHAR(3) NOT NULL PRIMARY KEY,
  nombre VARCHAR(40),
  cdgru CHAR(2) NOT NULL,
  creditos tinyint,
  FOREIGN KEY (cdgru)
  REFERENCES grupo(cdgru)
  ON DELETE RESTRICT ON UPDATE CASCADE 
) ENGINE=INNODB;



/***********************/
/* TABLA: participa      */
/***********************/
CREATE TABLE participa (
  cdalu CHAR(3) NOT NULL,
  cdpro CHAR(3) NOT NULL,
  horas SMALLINT DEFAULT 0,
  PRIMARY KEY (cdalu,cdpro),
  FOREIGN KEY (cdalu)
  REFERENCES alumnado(cdalu)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (cdpro)
  REFERENCES proyecto(cdpro)
  ON DELETE CASCADE ON UPDATE CASCADE 
) ENGINE=INNODB;

/****************************************************************************************
Estas sentencias SQL insertan en las tablas de investigacion un conjunto de datos de prueba
****************************************************************************************/
USE investigacion;

/***********************/
/* TABLA: grupo */
/***********************/
INSERT INTO grupo
(cdgru,nombre,ciudad) VALUES ('01','Ciencias y Técnicas de la salud','Almería'),
 ('02','Ciencias Sociales, económicas y jurídicas','Sevilla'), ('07','Recursos Naturales y Medio Ambiente','Granada'), ('04','Biotecnologías','Málaga'),
 ('05','Agroalimentación','Granada'),('06','Humanidades','Almería'), ('03','Tecnologías de la Información y las comunicaciones','Huelva');


/***********************/
/* TABLA: alumnado     */
/***********************/
INSERT INTO alumnado
(cdalu,nombre,fecha_alta,cuota_anual,sexo,cdcoor,cdgru) VALUES ('A11','Esperanza Amarillo','1998-09-23',350, 'M', NULL,'04'),
('A03','Pedro Rojo','2000-03-07',250, 'H','A11','01'), ('C01','Juan Rojo','2005-02-03',250,'H','A03','01'),
('B02','María Azul','2011-01-09',250,'M','A03','01'),('A07','Elena Blanco','1998-04-09',300,'M','A11','02'),
('B06','Carmen Violeta','2001-02-03',300,'M','A07','02'),('C05','Alfonso Amarillo','2000-12-03',300,'H','B06','02'),
('B09','Pablo Verde','1998-10-12',400,'H','A11','03'),('C04','Ana Verde',NULL,300,'M','A07','02'),
('C08','Javier Naranja',NULL,400,'H','B09','03'),('A10','Dolores Blanco','2010-11-15',350,'M','A11','04'),
('B12','Juan Negro','2015-02-03',260,'H','A11','05'),('A13','Jesús Marrón','1999-02-21',260,'H','A11','05'),
('A14','Manuel Amarillo','2000-09-01',250,'H','A11','01');


/***********************/
/* TABLA: proyecto     */
/***********************/
INSERT INTO proyecto
(cdpro,nombre,cdgru, creditos) VALUES ('IMA','Informática y Medio Ambiente','03', 70);
INSERT INTO proyecto
(cdpro,nombre,cdgru, creditos) VALUES ('SUA','Supercomputación-Algoritmos','03', NULL);
INSERT INTO proyecto
(cdpro,nombre,cdgru, creditos) VALUES ('BAM','Biotecnología de Algas Marinas','04', 40);
INSERT INTO proyecto
(cdpro,nombre,cdgru, creditos) VALUES ('NTM','Nuevas tendencias en Marketing','02', 35);
INSERT INTO proyecto
(cdpro,nombre,cdgru, creditos) VALUES ('BBM','Bioquímica y biología molecular','01', 70);

/***********************/
/* TABLA: participa    */
/***********************/
INSERT INTO participa
(cdalu,cdpro,horas) VALUES ('C01','BAM',10),
('C08','IMA',54), ('C01','BBM',50),('C08','SUA',45),
('B09','SUA',100),('A14','BBM',100),('A11','BAM',15),
('C04','NTM',200),('A11','NTM',30),('A03','BBM', 40),
('B09','IMA',60);