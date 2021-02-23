--
-- Nueva versión de la bd empresa
--
DROP DATABASE IF EXISTS empresa2;
CREATE DATABASE empresa2 OWNER dbo_daw1_a;
--
-- Creación de tablas
--
CREATE TABLE centro (
    id  INT CONSTRAINT centro_pk PRIMARY KEY,
    nombre  VARCHAR(21) NOT NULL,		
    ubicacion  VARCHAR(22) NOT NULL	
);

CREATE TABLE departamento (
    id  INT CONSTRAINT departamento_pk PRIMARY KEY,		
    centro_id  INT NOT NULL,    		
    director_id  INT NOT NULL,			
    tipo_director  CHAR(1) NOT NULL,	                             /* P: En Propiedad. F: En Funciones */
    presupuesto  NUMERIC(9) NOT NULL,	                            /* Presupuesto anual de gasto del departamento */
    depto_id_superior  INT,		                                     /* departamento del que depende este departamento */
    nombre  VARCHAR(20) NOT NULL,
    CONSTRAINT departamento_centro_id_fk FOREIGN KEY (centro_id) 
        REFERENCES centro (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE empleado (
    id  INT CONSTRAINT empleado_pk PRIMARY KEY,			
    depto_id  INT NOT NULL,		                                            /* id de departamento */
    puesto VARCHAR(16) NOT NULL,                                            /* puesto o cargo */
    ext_tel  SMALLINT NOT NULL,                                             /* extensión telefónica */
    fecha_nac  DATE NOT NULL,	                                            /* fecha nacimiento */
    fecha_ing  DATE NOT NULL,	                                            /* fecha ingreso */	
    salario  NUMERIC(6) NOT NULL,	                                        /* salario mensual */
    comision  NUMERIC(6),					
    num_hijos  SMALLINT NOT NULL,	
    nombre  VARCHAR(16) NOT NULL,
    CONSTRAINT empleado_depto_id_fk FOREIGN KEY (depto_id) 
        REFERENCES departamento (id) ON DELETE CASCADE ON UPDATE CASCADE
);

--
-- Inserción de datos
--
INSERT INTO centro VALUES(10, 'SEDE CENTRAL', 'C/ ALCALA, 820, MADRID'),
    (20, 'RELACION CON CLIENTES', 'C/ ATOCHA, 405, MADRID');

INSERT INTO departamento VALUES(100, 10, 260, 'P', 120000, NULL, 'DIRECCION GENERAL'),
    (110, 20, 180, 'P', 15000, 100, 'DIRECCION COMERCIAL'),
    (111, 20, 180, 'F', 11000, 110, 'SECTOR INDUSTRIAL'),
    (112, 20, 270, 'P', 9000, 110, 'SECTOR SERVICIOS'),
    (120, 10, 150, 'F', 3000, 100, 'ORGANIZACION'),
    (121, 10, 150, 'P', 2000, 120, 'PERSONAL'),
    (122, 10, 350, 'P', 6000, 120, 'PROCESO DE DATOS'),
    (130, 10, 310, 'P', 2000, 100, 'FINANZAS');

INSERT INTO empleado VALUES(110, 121, 'Técnico', 350, '1949-10-11', '1970-02-15', 3100, NULL, 3, 'PONS, CESAR'),
    (120, 112, 'Administrativo', 840, '1955-06-09', '1988-10-01', 3500, 1100,  1, 'LASA, MARIO'),
    (130, 112, 'Administrativo', 810, '1965-09-09', '1989-02-01', 2900, 1100, 2, 'TEROL, LUCIANO'),
    (150, 121, 'Técnico', 340, '1950-08-10', '1968-01-15', 4400, NULL, 0, 'PEREZ, JULIO'),
    (160, 111, 'Ingeniero', 740, '1959-07-09', '1988-11-11', 3100, 1100, 2, 'AGUIRRE, AUREO'),
    (180, 110, 'Comercial', 508, '1954-10-18', '1976-03-18', 4800, 500, 2, 'PEREZ, MARCOS'),
    (190, 121, 'Administrativo', 350, '1952-05-12', '1982-02-11', 3000, NULL, 4, 'VEIGA, JULIANA'),
    (210, 100, 'Técnico', 200, '1960-09-28', '1979-01-22', 3800, NULL, 2, 'GALVEZ, PILAR'),
    (240, 111, 'Ingeniero', 760, '1962-02-26', '1986-02-04', 2800, 1000, 3, 'SANZ, LAVINIA'),
    (250, 100, 'Administrativo', 250, '1966-10-27', '1987-03-01', 4500, NULL, 0, 'ALBA, ADRIANA'),
    (260, 100, 'Director', 220, '1963-12-03', '1988-07-12', 7200, NULL, 9, 'LOPEZ, ANTONIO'),
    (270, 112, 'Administrativo', 800, '1965-05-21', '1986-09-10', 3800, 800, 3, 'GARCIA, OCTAVIO'),
    (280, 130, 'Director', 410, '1968-01-11', '1991-10-08', 2900, NULL, 5, 'FLOR, DOROTEA'),
    (285, 122, 'Operador', 620, '1969-10-25', '1988-02-15', 3800, NULL, 0, 'POLO, OTILIA'),
    (290, 120, 'Técnico', 910, '1967-11-30', '1988-02-14', 2700, NULL, 3, 'GIL, GLORIA'),
    (310, 130, 'Comercial', 480, '1966-11-21', '1991-01-15', 4200, NULL, 0, 'GARCIA, AUGUSTO'),
    (320, 122, 'Operador', 620, '1977-12-25', '1998-02-05', 4050, NULL, 2, 'SANZ, CORNELIO'),
    (330, 112, 'Administrativo', 850, '1968-08-19', '1992-03-01', 2800, 900, 0, 'DIEZ, AMELIA'),
    (350, 122, 'Operador', 610, '1959-04-13', '1994-09-10', 4500, NULL, 1, 'CAMPS, AURELIO'),
    (360, 111, 'Ingeniero', 750, '1978-10-29', '1998-10-10', 2500, 1000, 2, 'LARA, DORINDA'),
    (370, 121, 'Técnico', 360, '1977-06-22', '1997-01-20', 1900, NULL, 1, 'RUIZ, FABIOLA'),
    (380, 112, 'Administrativo', 880, '1978-03-30', '1998-01-01', 1800, NULL, 0, 'MARTIN, MICAELA'),
    (390, 110, 'Director', 500, '1976-02-19', '1996-10-08', 2150, NULL, 1, 'MORAN, CARMEN'),
    (400, 111, 'Operador', 780, '1979-08-18', '1997-11-01', 1850, NULL, 0, 'LARA, LUCRECIA'),
    (410, 122, 'Operador', 660, '1978-07-14', '1998-10-13', 1750, NULL, 0, 'MUOZ, AZUCENA'),
    (420, 130, 'Comercial', 450, '1976-10-22', '1998-11-19', 4000, NULL, 0, 'FIERRO, CLAUDIA'),
    (430, 122, 'Operador', 650, '1977-02-26', '1998-11-19', 2100, NULL, 1, 'MORA, VALERIANA'),
    (440, 111, 'Ingeniero', 760, '1976-09-26', '1996-02-28', 2100, 1000, 0, 'DURAN, LIVIA'),
    (450, 112, 'Comercial', 880, '1976-10-21', '1996-02-28', 2100, 1000, 0, 'PEREZ, SABINA'),
    (480, 111, 'Operador', 760, '1975-04-04', '1996-02-28', 2100, 1000, 1, 'PINO, DIANA'),
    (490, 112, 'Administrativo', 880, '1974-06-06', '1998-01-01', 1800, 1000, 0, 'TORRES, HORACIO'),
    (500, 111, 'Ingeniero', 750, '1975-10-08', '1997-01-01', 2000, 1000, 0, 'VAZQUEZ, HONORIA'),
    (510, 110, 'Comercial', 550, '1976-05-04', '1996-01-11', 2000, NULL, 1, 'CAMPOS, ROMULO'),
    (550, 111, 'Ingeniero', 780, '1980-01-10', '1998-01-21', 1000, 1200, 0, 'SANTOS, SANCHO');

--
-- Consultas de ejemplos de agrupamiento
--
SELECT depto_id, AVG(salario)
FROM empleado
GROUP BY depto_id;

SELECT depto_id, puesto, ROUND(AVG(salario))
FROM empleado
GROUP BY depto_id, puesto;

SELECT puesto, depto_id, ROUND(AVG(salario)) AS "Salario medio"
FROM empleado
GROUP BY puesto, depto_id;

SELECT TRUNC(salario/1000) "Miles €", COUNT(*)
FROM empleado
GROUP BY TRUNC(salario/1000);

SELECT depto_id,
    SUM(CASE WHEN puesto = 'Director' THEN 1 ELSE 0 END) AS "Director",
    SUM(CASE WHEN puesto = 'Técnico' THEN 1 ELSE 0 END) AS "Técnico",
    SUM(CASE WHEN puesto = 'Administrativo' THEN 1 ELSE 0 END) AS "Administrativo"
FROM empleado
GROUP BY depto_id;


SELECT depto_id, COUNT(*)
FROM empleado
GROUP BY depto_id;

SELECT depto_id, 
    MIN(nombre) AS "Primero", 
    MAX(nombre) AS "Último"
FROM empleado
GROUP BY depto_id;

SELECT COUNT(DISTINCT puesto) FROM empleado;

SELECT depto_id, COUNT(DISTINCT puesto) AS "Núm. puestos"
FROM empleado
GROUP BY depto_id;

SELECT puesto,
    COUNT(*) "CUANTOS",
    MIN(salario) "MÍNIMO",
    MAX(salario) "MÄXIMO"
FROM empleado
WHERE fecha_ing BETWEEN '1991-01-01' AND '1991-12-31'
GROUP BY puesto;

SELECT depto_id, COUNT(*)
FROM empleado
GROUP BY depto_id
HAVING COUNT(*) > 3;

SELECT depto_id, MAX(salario) "MAXSAL"
FROM empleado
WHERE depto_id IN (120,121)
GROUP BY depto_id;

SELECT depto_id, COUNT(*) "NUMEMP"
FROM empleado
GROUP BY depto_id
ORDER BY COUNT(*) DESC;

SELECT depto_id,
    TO_CHAR(SUM(salario), '99G999D00') "SUMSAL",
    TO_CHAR(MAX(salario), '99G999D00') "MAXSAL",
    TO_CHAR(MIN(salario), '99G999D00') "MINSAL"
FROM empleado
GROUP BY depto_id
HAVING COUNT(*) > 3
ORDER BY depto_id;

SELECT depto_id, puesto,
    COUNT(*) "NUMEMP",
    SUM(salario) "SUMSAL"
FROM empleado
WHERE puesto IN ('Ingeniero','Técnico')
GROUP BY depto_id, puesto
HAVING COUNT(*) < 2
ORDER BY depto_id;

SELECT depto_id, AVG(salario) "SALMED"
FROM empleado
WHERE puesto IN ('Técnico','Administrativo')
GROUP BY depto_id
HAVING AVG(salario) < 3000
ORDER BY depto_id;

SELECT depto_id "departamento", 
    puesto, 
    SUM(salario) "suma salarios"
FROM empleado
GROUP BY ROLLUP (depto_id, puesto)
ORDER BY depto_id, puesto;

SELECT TO_CHAR(fecha_ing, 'YYYY') "año",
    TO_NUMBER(TO_CHAR(fecha_ing, 'MM'), '99') "mes",
    COUNT(*) "núm. emp"
FROM empleado
WHERE fecha_ing >= '1996-01-01'
GROUP BY ROLLUP (TO_CHAR(fecha_ing, 'YYYY'), 
    TO_NUMBER(TO_CHAR(fecha_ing, 'MM'), '99'))
ORDER BY TO_CHAR(fecha_ing, 'YYYY'), 
    TO_NUMBER(TO_CHAR(fecha_ing, 'MM'), '99');

SELECT TO_CHAR(fecha_ing, 'YYYY') AS año,
    TO_NUMBER(TO_CHAR(fecha_ing, 'MM'), '99') AS mes,
    COUNT(*) AS "núm. emp"
FROM empleado
WHERE fecha_ing >= '1996-01-01'
GROUP BY ROLLUP (año, mes)
ORDER BY año, mes;

SELECT depto_id "departamento", 
    puesto, 
    SUM(salario) "suma salarios"
FROM empleado
GROUP BY CUBE (depto_id, puesto)
ORDER BY depto_id, puesto;

SELECT TO_CHAR(fecha_ing, 'YYYY') AS año,
    TO_CHAR(fecha_ing, 'Month') AS mes,
    COUNT(*) AS "núm. emp"
FROM empleado
WHERE fecha_ing >= '1996-01-01'
GROUP BY CUBE (año, mes)
ORDER BY año, mes;


set lc_time = "es_ES.UTF-8";
SELECT TO_CHAR(fecha_ing, 'YYYY') AS año,
    TO_CHAR(fecha_ing, 'TMMonth') AS mes,
    COUNT(*) AS "núm. emp"
FROM empleado
WHERE fecha_ing >= '1996-01-01'
GROUP BY CUBE (año, mes)
ORDER BY año, mes;

SELECT depto_id AS "departamento", 
    puesto,
    SUM(salario) "suma salarios"
FROM empleado
GROUP BY GROUPING SETS (
    (depto_id, puesto),
    (puesto)
    )
ORDER BY depto_id, puesto;