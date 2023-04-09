/*COMIENZO DEL SCRIPT*/

/*CREACION DE LA BASE DE DATOS Y SUS TABLAS*/

drop database if exists Tarea5IsmaelCarrasco;
create database Tarea5IsmaelCarrasco CHARACTER SET = utf8mb4 ;
use Tarea5IsmaelCarrasco;

drop table if exists cliente;
create table cliente(

dni varchar(9) primary key,
nombre varchar(40),
ap1 varchar(40),
ap2 varchar(40),
calle varchar(100),
numero int unsigned,
puerta varchar(20),
cp int,
localidad varchar(80),
provincia varchar(40),
pais varchar(40) default 'España'


)CHARACTER SET = utf8mb4 ;


DROP TABLE IF EXISTS Libro;
CREATE TABLE Libro(

Codigo int primary key,
Signatura varchar(30) not null,
Autor varchar(150),
Titulo varchar(250),
Precio numeric(5,2) 

)CHARACTER SET = utf8mb4;


Drop Table if exists Factura;
Create Table Factura(

Codigo int primary key auto_increment,
DNICliente varchar(9),
Fecha date,
Total numeric(6,2) default 0,
Pagada boolean default False,
Constraint FK_DNICliente_a_Factura foreign key (DNICliente) references Cliente(DNI) on delete cascade on update cascade

)CHARACTER SET = utf8mb4;
/*SI BIEN EN LA CREACION DEL SCRIPT PONE QUE LA COLUMNA PAGADA ES TIPO BOOLEAN, MYSQLWORKBENCH TOMA LA COLUMNA COMO TIPO DE DATO TINYINT... DESCONOZCO LA RAZON*/

Drop Table if exists LineaFactura;
Create Table LineaFactura(

Codigo int primary key auto_increment,
CodFactura int not null,
CodLibro int not null,
Unidades int default 1 , -- Es el número de ejemplares que compra
Constraint FK_CodFactura_Factura foreign key (CodFactura) references Factura(Codigo) on delete cascade on update cascade,
Constraint FK_CodLibro_Libro foreign key (CodLibro) references Libro(Codigo) on delete cascade on update cascade

)CHARACTER SET = utf8mb4;

/*SENTENCIAS DE TRABAJO CON LA BASE DE DATOS*/

/*IMPORTACION DE LOS DATOS*/

/*TABLA CLIENTE*/
LOAD DATA
INFILE "c:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\clientes.csv"
INTO TABLE cliente
-- charset utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;

/*TABLA FACTURA*/
LOAD DATA
INFILE "c:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\facturas.csv"
INTO TABLE factura
-- charset utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;

/*TABLA LIBRO*/
LOAD DATA
INFILE "c:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\libros.csv"
INTO TABLE libro
-- charset utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;

/*TABLA LINEAFACTURA*/
LOAD DATA
INFILE "c:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\lineasfacturas.csv"
INTO TABLE LineaFactura
-- charset utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;

/*COMPROBAR QUE SE HAN AÑADIDO LOS DATOS*/
SELECT * FROM cliente;
SELECT * FROM factura;
SELECT * FROM libro;
SELECT * FROM lineafactura;

/*CREACION DE LA TABLA FACTURACOMPLETA*/
DROP TABLE IF EXISTS FACTURACOMPLETA;
CREATE TABLE facturacompleta(
    codigo INT primary key auto_increment,
    DNICliente varchar(9),
    Fecha date,
    Total numeric(6,2) default 0,
    Pagada boolean default False,
    NombreCliente varchar(30),
    Constraint FK_DNICliente_a_Factura_completa foreign key (DNICliente) references cliente(DNI) on delete cascade on update cascade)
    CHARACTER SET = utf8mb4;

/*COMPROBAR QUE LA TABLA SE HA CREADO Y ESTA VACIA*/
SELECT * FROM FACTURACOMPLETA;

/*LLENAR LA NUEVA TABLA CON SUS DATOS*/
INSERT INTO FACTURACOMPLETA
(SELECT fa.codigo, fa.DNICliente, fa.Fecha, fa.Total, fa.Pagada, cli.Nombre
FROM factura fa
INNER JOIN cliente cli on fa.DNICliente=cli.dni
ORDER BY fa.codigo);

/*COMPROBAR QUE SE HAN AÑADIDO LOS DATOS*/
SELECT * FROM FACTURACOMPLETA;

/*COMPROBAR PRECIO ORIGINAL DE LOS LIBROS*/
SELECT codigo, Titulo, precio
FROM libro
WHERE precio >30;

/*AUMENTAR EL PRECIO DE LOS LIBROS UN 10%*/
UPDATE Libro
SET Precio = precio*1.10
WHERE precio >30;

/*COMOPROBAR QUE EL PRECIO SE HA INCREMENTADO*/
SELECT codigo, Titulo, precio
FROM libro
WHERE precio >30;

/*VISUALIZAR LOS LIBROS CAROS*/
SELECT codigo, Titulo, precio
FROM libro
WHERE codigo
NOT IN
(SELECT li.codigo
FROM libro li
INNER JOIN lineafactura lf ON li.codigo=lf.CodLibro
)
AND precio >50;

/*BORRADO DE LOS LIBROS CONSIDERADOS CAROS*/
DELETE FROM libro
WHERE precio >50
AND codigo NOT IN
(SELECT * FROM
(SELECT li.codigo
FROM libro li
INNER JOIN lineafactura lf ON li.codigo=lf.CodLibro) AS libroscaros);

/*COMPROBAR SI SE HAN BORRADO LOS LIBROS*/
SELECT codigo, Titulo, precio
FROM libro
WHERE codigo
NOT IN
(SELECT li.codigo
FROM libro li
INNER JOIN lineafactura lf ON li.codigo=lf.CodLibro
)
AND precio >50;

/*AÑADIR PRECION CON IVA A LA TABLA FACTURA*/
CREATE TEMPORARY TABLE totalfacturas
AS 
SELECT lf.CodFactura AS codigf, (sum(li.precio * lf.unidades))*1.04 AS total_iva_inc
FROM libro li
INNER JOIN lineafactura lf ON li.codigo=lf.Codigo
GROUP BY CodFactura;

UPDATE Factura
SET total = (SELECT total_iva_inc
FROM totalfacturas
WHERE codigo = codigf);

DROP TABLE totalfacturas;

/*COMPROBAR QUE SE HA AÑADIDO EL IMPORTE*/
SELECT Codigo, total
FROM factura
WHERE total IS NOT NULL;

/*USO DE TRANSACCIONES*/

/*VISUALIZAR CLIENTES DEL CODIGO POSTAL Y EL IMPORTE DE SUS COMPRAS*/
SELECT nombre, ap1, provincia, localidad, cp, fa.total AS total_factura
FROM cliente
INNER JOIN factura fa ON dni=DNICliente
WHERE cp='36213';
/*MY CODIGO POSTAL ES 14014, PERO SE VE QUE EN CORDOBA NO GUSTA LEER :p*/

/*REBAJAR 15% A LOS CLIENTES DEL CODIGO POSTAL*/
BEGIN;
UPDATE Factura
SET Total=(Total*0.85)
WHERE DNICliente IN 
(SELECT dni FROM cliente
WHERE cp='36213');

/*COMPROBAR QUE EL PRECIO SE HA REDUCIDO*/
SELECT nombre, ap1, provincia, localidad, cp, fa.total AS total_factura
FROM cliente
INNER JOIN factura fa ON dni=DNICliente
WHERE cp='36213';

/*AÑADIR COLUMNA A LA TABLA CLIENTE*/
BEGIN;
ALTER TABLE cliente 
ADD COLUMN llevacomprados INT;

/*AÑADIR EL NUMERO DE LIBROS QUE LLEVAN COMPRADOS A LA COLUMNA RECIEN CREADA*/
BEGIN;
CREATE TEMPORARY TABLE comprados
SELECT fa.DNICliente, lf.CodFactura, cli.llevacomprados, sum(lf.unidades) AS nlibros
FROM cliente cli
INNER JOIN factura fa ON cli.dni=fa.DNICliente
INNER JOIN lineafactura lf ON fa.Codigo=lf.CodFactura
GROUP BY cli.dni;

BEGIN;
UPDATE cliente
INNER JOIN comprados ON cliente.dni=comprados.DNICliente
SET cliente.llevacomprados=comprados.nlibros
WHERE cliente.dni LIKE comprados.DNICliente;

DROP TABLE comprados;

/*VISUALIZAR EL RECUENTO DE LIBROS DE LOS CLIENTES QUE HAN COMPRADO ALGUNO*/
SELECT * FROM cliente
WHERE llevacomprados
IS NOT NULL;

/*VISUALIZAR SI LAS FACTURAS DE LOS CLIENTES DEL CP ESTAN PAGADAS*/
SELECT dni, cp, fa.total, fa.Pagada
FROM cliente
INNER JOIN factura fa ON dni=fa.DNICliente
WHERE cp LIKE 36213;

/*PONER LAS FACTURAS COMO PAGADAS*/
BEGIN;
UPDATE factura
INNER JOIN cliente cli ON cli.dni=DNICliente
SET pagada='1'
WHERE cp LIKE 36213;
/*TAL Y COMO HE COMENTADO AL PRINCIPIO DEL SCRIPT, WORKBENCH TOMA EL TIPO DE DATO DE LA COLUMNA PAGADAS COMO TINYINT, ASI QUE DADO QUE EN TEORIA ES UN BOOLEAN HE ASUMIDO UN VALOR DE 1 TRUE Y 0 FALSE*/

/*COMPROBAR QUE LAS FACTURAS CONSTAN COMO PAGADAS*/
SELECT dni, cp, fa.total, fa.Pagada
FROM cliente
INNER JOIN factura fa ON dni=fa.DNICliente
WHERE cp LIKE 36213;

/*CALCULAR EL AGUJERO EN MI BOLSILLO*/
SELECT sum(total) AS voy_a_pagar
FROM factura
INNER JOIN cliente cli on DNICliente=cli.dni
WHERE cli.cp='36213';

/*DEJAR TODO COMO ESTABA*/
ROLLBACK;
/*NOTA IMPORTANTE: HE DESCUBIERTO POR LAS MALAS QUE SI LA MAQUINA DE MYSQL SERVER, SE RENICIA, APAGA, O EL SERVICIO SE CUELGA Y HA DE SER REINICIADO O DETENIDO, TODAS LAS TRANSACCIONES SE APLICAN AUTOMATICAMENTE Y GUARDAN LOS CAMBIOS AUNQUE AUNQUE NO SE EJECUTE LA SENTENCIA COMMIT. POR LO QUE AL HACER ROLLBACK SOLO SE ME HAN DESHECHO LOS CAMBIOS EJECUTADOS DESDE EL ULTIMO INICIO DEL SERVIDOR MSYQL. AL PRINCIPIO NO ENTENDIA POR QUE, PUESTO QUE NO HE EJECUTADO EN NINGUN MOMENTO LA ORDEN COMMIT, PERO SEGUN ALGUNAS ENTRADAS EN STACKOVERFLOW Y OTROS FOROS, ES UN PROBLEMA COMUN*/

/*COMPROBAR QUE ALMENOS ALGUNOS CAMBIOS HAN DESAPARECIDO*/
SELECT dni, cp, fa.total, fa.pagada
FROM cliente
INNER JOIN factura fa ON dni=fa.DNICliente
WHERE cp LIKE 36213;