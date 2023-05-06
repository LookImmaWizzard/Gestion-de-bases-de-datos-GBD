-- ------------------------------------------------------------------------------
-- Curso 2022-2023
-- IES Aguadulce
-- CFGS ASIR modalidad a distancia
-- Módulo: Gestión de Bases de Datos
-- Conjunto de datos de prueba para ambas BB.DD. de la tarea de la unidad 07 (billy_viajes_myisam y billy_viajes_innodb)
-- ------------------------------------------------------------------------------


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
