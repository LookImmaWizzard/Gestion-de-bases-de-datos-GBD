/*ISMAEL CARRASCO CUBERO*/

/*Creacion de la base de datos*/

/*Borramos, si existe, una base de datos anterior */

DROP DATABASE IF EXISTS viajes;
--
-- Base de datos: VIAJES
--
CREATE DATABASE viajes;

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

/*ACTIVIDADES*/

/*1) Una función almacenada que devuelva el total de viajes encontrados para una determinada categoría
y a partir de un determinado mes. A la función se le pasa el nombre de la categoría o un patrón y el número del mes.
La función se llamará fa_busca_viajes.*/

drop function if exists fa_busca_viajes;
DELIMITER //
CREATE FUNCTION fa_busca_viajes (categoria varchar(50), mes int)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE total INT;
SELECT count(*) from viaje where catego like categoria and month(fecha_salida) >= mes into total;
return total;
END//
DELIMITER ;

select fa_busca_viajes('%eur%',5) 'viajes europa, mes 5';

select fa_busca_viajes('%cru%',6) 'cruceros, mes 6';

/*2) Un procedimiento almacenado llamado pa_busca_catego que muestra los nombres de viajes de una determinada categoría
y a partir de un determinado mes,
indicando el código, nombre, categoría, mayorista, fecha de salida y las plazas disponibles de cada viaje.*/

drop procedure if exists pa_busca_catego;
delimiter //
create procedure pa_busca_catego(
	in categoria varchar(50), 
	in mes int,
	out total int)
begin
	select codvia, nombre, catego, mayori, fecha_salida, plazas
    from viaje
    where catego like categoria and month(fecha_salida) >= mes;
    set total = fa_busca_viajes(categoria, mes);

end
//
delimiter ;

call pa_busca_catego('%c%r%c%', 7, @total);
select @total;
/*NO SE SI ESTA HECHO A PROPOSITO PARA QUE ESTA PRUEBA NO ENCUENTRE NADA O ES UNA EQUIVOCACION
PERO OBVIAMENTE ESA LLAMADA AL PROCEDIMIENTO NO VA A ENCONTRAR NADA PUESTO QUE EL PATRON PRETENDE BUSCAR ALGO SIMILAR A CRUCERO
PERO EL VALOR DE CATEGO SOLO CONTIENE CRUC
UN PATRON VALIDO SERIA: call pa_busca_catego('%c%r%c%', 7, @total);*/

call pa_busca_catego('%Eur%', 6, @total);
select @total;

/*3) Un procedimiento con nombre pa_hacer_reserva que permita insertar reservas*/

drop proced if exists pa_hacer_reserva;
delimiter //
create procedure pa_hacer_reserva(
	in idreserva int(11),
	in nifcli char(9),
	in codviaje int(11),
	out codigo int(1)
	)
begin
	set @codigo = 0;
	set @ahora = DATE(CURDATE());
	set @ocu = (select ocupadas from viaje
		where codvia = codviaje);
	set @plaz = (select plazas from viaje
		where codvia = codviaje);

	if @ocu >= @plaz then
		set codigo = 0;
        
	elseif idreserva = (select id from reserva where id = idreserva) then 
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Error de Duplicidad de clave';
	else 
		UPDATE viaje SET ocupadas = ocupadas + 1 WHERE codvia = codviaje;
		insert into reserva (id,nif,cod_viaje,fecha_reserva) values (idreserva,nifcli,codviaje,@ahora);
        set codigo = 1;

	end if;
end//

delimiter ;
-- Viaje que se puede reservar (el 1)
call pa_hacer_reserva(14,'23727319S',1,@codigo);
select @codigo;
select * from reserva;
select * from viaje;

-- Viaje que no se puede reservar (el 7)
call pa_hacer_reserva(15,'23727319S',7,@codigo);
select @codigo;
select * from reserva;
select * from viaje;

-- Control del error de clave duplicada en reserva con un viaje que sí se podría reservar
call pa_hacer_reserva(3,'23727319S',2,@codigo);
select @codigo;
select * from reserva;
select * from viaje;

/*4) Un trigger denominado t_insertar_reserva que al hacer una reserva de viaje para un cliente
actualice sus puntos de forma automática*/

drop trigger if exists t_insertar_reserva;
delimiter //
create trigger t_insertar_reserva
after insert on reserva
for each row
begin
set @cat = (select catego from viaje v
			inner join reserva r on r.cod_viaje=v.codvia
			where v.codvia=new.cod_viaje and r.id=new.id);
if @cat = 'CRUC' or @cat = 'SAFA' -- NO HAY EN LA TABLA VIAJES NINGUN VIAJE CON CATEGORIA SAFARI, PERO LO AÑADO IGUAL
	then update cliente set puntos = puntos +50
		where nif = new.nif;
        
elseif @cat = 'ASIA' or @cat = 'LATI'
	then update cliente set puntos = puntos +30
		where nif = new.nif;

elseif @cat = 'EURO'
	then update cliente set puntos = puntos +20
		where nif = new.nif;
        
else update cliente set puntos = puntos +0;

set @cat = NULL;
        
end if;
end//
delimiter ;

-- Reserva de un viaje crucero (el 5)
call pa_hacer_reserva(50,'10101010x',5,@codigo);
select @codigo;
select * from reserva;
select * from cliente;

-- Reserva de un viaje a Asia (el 3)
call pa_hacer_reserva(51,'10101010x',3,@codigo);
select @codigo;
select * from reserva;
select * from cliente;

-- Reserva de un viaje a Europa (el 12)
call pa_hacer_reserva(52,'10101010x',12,@codigo);
select @codigo;
select * from reserva;
select * from cliente;

-- Otras pruebas propias para comprobar que funciona con otro cliente
call pa_hacer_reserva(60,'23727319S',4,@codigo);
call pa_hacer_reserva(61,'23727319S',2,@codigo);
call pa_hacer_reserva(62,'23727319S',3,@codigo);

/*5) Un trigger llamado t_insertar_viaje y asociado a la tabla VIAJE que controle la inserción de viajes*/

drop trigger if exists t_insertar_viaje;
delimiter //
create trigger t_insertar_viaje
before insert on viaje
for each row
begin

	if new.ocupadas not like 0 or new.ocupadas is null
	then 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Un viaje nuevo debe tener ocupadas a 0';
	end if;

	if new.plazas <0 or new.plazas is null
    then
		set new.plazas = 0;
    end if;
   
   set @cod = (select codvia from viaje order by codvia desc limit 1);
     set new.codvia = @cod + 1;

end//
delimiter ;

-- Inserta viaje con valores adecuados
insert into viaje values (0,'Azores','CLA','EURO','2023-07-15',2,0);
select * from viaje;

-- Inserta viaje con plazas negativas
insert into viaje values (0,'Selva Negra','CLA','EURO','2023-07-15',-2,0);
select * from viaje;

-- Inserta viaje con plazas a null
insert into viaje values (0, 'Filipinas','SOL','ASIA','2023-06-20',null,0);
select * from viaje;

-- Inserta viaje con ocupadas a 2
insert into viaje values (0, 'Japón','MEN','ASIA','2023-06-20',2,2);
select * from viaje;

-- Inserta viaje con ocupadas a null
insert into viaje values (0, 'Caribe','SAK','CRUC','2023-06-20',2,null);
select * from viaje;

-- ultimos dos viajes modificados para que sean aceptados a modo de prueba
insert into viaje values (0, 'Japón','MEN','ASIA','2023-06-20',2,0);
select * from viaje;

insert into viaje values (0, 'Caribe','SAK','CRUC','2023-06-20',2,0);
select * from viaje;

/*6) Un trigger denominado t_modifica_clientes que permita llevar una auditoría
 de la tabla CLIENTE, registrando la fecha, hora y usuario que realiza una modificación
 en la tabla CLIENTE. Interesa guardar los datos antiguos y nuevos de los clientes modificados, 
 así como la fecha, hora y usuario que lo modificó.*/

 drop table if exists auditoria_cliente;
 create table auditoria_cliente (
	codaudit int (5) auto_increment,
	fecha_modificacion datetime,
    modificador varchar (35),
	old_nif char(9)  NOT NULL,
	old_nombre varchar(35)  NOT NULL,
	old_email varchar(30)  NOT NULL,
	old_fecha_alta DATE,
	old_puntos smallint not null default 0,
    new_nif char(9)  NOT NULL,
	new_nombre varchar(35)  NOT NULL,
	new_email varchar(30)  NOT NULL,
	new_fecha_alta DATE,
	new_puntos smallint not null default 0,
primary key (codaudit)
)
ENGINE=InnoDB;
 
drop trigger if exists t_modifica_clientes;
delimiter //
create trigger t_modifica_clientes
after update on cliente
for each row
begin
    
		insert into auditoria_cliente (fecha_modificacion, modificador, old_nif, old_nombre, old_email, old_fecha_alta,
										old_puntos, new_nif, new_nombre, new_email, new_fecha_alta, new_puntos)
								values (now(), current_user(), old.nif, old.nombre, old.email, old.fecha_alta, 
										old.puntos, new.nif, new.nombre, new.email, new.fecha_alta, new.puntos)
;
    
end//
delimiter ;

insert into cliente values ('12345678A', 'Juan Sánchez García', 'jsg@gmail.com', curdate(), 10);
select * from cliente;

update cliente
set email = 'otro@gmail.com'
where nif ='12345678A';

-- Otra prueba de mi cosecha para comprobar que funciona correctamente autoincrement en codaudit
update cliente 
set nombre = 'Zoraida Galvez Cantueso'
where nif = '10101010X';

select * from cliente;
select * from auditoria_cliente;