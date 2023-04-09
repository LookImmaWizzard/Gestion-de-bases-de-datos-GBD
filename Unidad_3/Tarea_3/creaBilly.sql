/*Ismael Carrasco Cubero*/
CREATE DATABASE Billy;

use Billy;

CREATE table Vendedor (
    DNI varchar(9) primary key,
    Nombre text(20),
    Ap1 text(20),
    Ap2 text(20),
    Email text(50),
    DNIjefe varchar(9),
    CONSTRAINT 
        FOREIGN KEY (DNIjefe) REFERENCES Vendedor (DNI)
        ON UPDATE CASCADE

)ENGINE=InnoDB;

CREATE TABLE Articulo (
    Cod INT(10) primary key,
    DNIVend varchar(9),
    Descripcion text(60) NOT NULL,
    FechaAlta date,
    PVP decimal(5, 2) NOT NULL,
    CONSTRAINT ´dni_dnivend´
        FOREIGN KEY (DNIVend) REFERENCES Vendedor (DNI)
        ON DELETE SET NULL
        ON UPDATE CASCADE

)ENGINE=InnoDB;

CREATE TABLE Planta (
    Codart INT(10) primary key,
    NombreCienti text(50) NOT NULL,
    Interior ENUM('DentroSoleado','FueraSombra'),
    Color text(10),
    CONSTRAINT ´Cod_planta_cod_articulo´
        FOREIGN KEY (Codart) REFERENCES Articulo (Cod)
        ON DELETE CASCADE
        ON UPDATE CASCADE

)ENGINE=InnoDB;

CREATE TABLE Flor (
    Codart INT(10) primary key,
    TiempoEnDias INT(5) NOT NULL,
    CONSTRAINT ´Codart_cod´ 
        FOREIGN key (Codart) REFERENCES Articulo (Cod)
            ON DELETE CASCADE
            ON UPDATE CASCADE

)ENGINE=InnoDB;

ALTER TABLE Flor ADD INDEX(Codart);

CREATE TABLE Compuesta (
    CodFlor INT(10),
    ColorRGBColor INT(10)

)ENGINE=InnoDB;

CREATE TABLE Color (
    ColorRGB INT(10),
    Descripcion VARCHAR(50) primary key NOT NULL 

)ENGINE=InnoDB;

ALTER TABLE Color ADD INDEX(ColorRGB);


ALTER TABLE Compuesta 
ADD CONSTRAINT ´Compuesta_pk´ 
        PRIMARY KEY (CodFlor,ColorRGBColor);


ALTER TABLE Compuesta
    ADD CONSTRAINT ´ColRGBCol_ColRGB´
        FOREIGN KEY (ColorRGBColor) REFERENCES Color (ColorRGB)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    ADD CONSTRAINT
        FOREIGN KEY (CodFlor) REFERENCES Flor (Codart)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

CREATE TABLE Adorno (
    Codart INT(10) primary key,
    Peso VARCHAR(5),
    CONSTRAINT ´Codart_CodAdorno´
        FOREIGN KEY (Codart) REFERENCES Articulo (Cod)
            ON DELETE CASCADE
            ON UPDATE CASCADE

)ENGINE=InnoDB;

CREATE TABLE Constituido (
    CodAdorno INT(10),
    CodMaterial INT(10)

)ENGINE=InnoDB;

CREATE TABLE Material (
    CodMat INT(10) PRIMARY KEY,
    Resistencia INT DEFAULT(0),
    Color VARCHAR(10),
    Inflamabilidad VARCHAR(10),
        CONSTRAINT ´Not_negative´
            CHECK ((Resistencia >=0))

)ENGINE=InnoDB;

ALTER TABLE Constituido
    ADD CONSTRAINT ´Pk_constituido´
        PRIMARY KEY (CodAdorno,CodMaterial),
    ADD CONSTRAINT
        FOREIGN KEY (CodAdorno) REFERENCES Adorno (Codart)
        ON DELETE NO ACTION
        ON UPDATE CASCADE;

CREATE TABLE Suministra (
    CodMat INT(10) PRIMARY KEY,
    CifProv VARCHAR(15) UNIQUE,
    CONSTRAINT
        FOREIGN KEY (CodMat) REFERENCES Material (CodMat)
            ON DELETE CASCADE
            ON UPDATE CASCADE

)ENGINE=InnoDB;

CREATE TABLE Proveedor (
    CIF VARCHAR(15) PRIMARY KEY,
    NumTel INT(9) UNIQUE,
    Nombre VARCHAR(10) NOT NULL

)ENGINE=InnoDB;

ALTER TABLE Suministra
    ADD CONSTRAINT ´CIF_CIFprov´
        FOREIGN KEY (CifProv) REFERENCES Proveedor (CIF)
            ON DELETE CASCADE;

CREATE TABLE Telefono (
    Nmuero INT(9) PRIMARY KEY,
    Pais VARCHAR(20) NOT NULL,
    Internacional ENUM('SI','NO')

)ENGINE=InnoDB;

ALTER TABLE Proveedor
    ADD CONSTRAINT ´numtel_numprov´
        FOREIGN KEY (NumTel) REFERENCES Telefono (Nmuero)
            ON DELETE SET NULL
            ON UPDATE CASCADE;

/*HE ELEGIDO EL MOTOR INNODB, PUESTO QUE SEGUN MI BUSQUEDA,
SOPORTA TABLAS DE TRANSACCION SEGURA Y BLOQUEO DE FILA CON GESTION DE CLAVES AJENAS*/


/*FIN DEL SCRIPT

NO ESTARA PERFECTO, PERO HA SIDO DIVERTIDO :)

CREO QUE LA PROXIMA VEZ, DECLARARE PRIMERO TODAS LAS TABLAS CON SUS COLUMNAS
Y UNA VEZ CREADAS LAS CONFIGURARE MEDIANTE ALTER TABLE

*/