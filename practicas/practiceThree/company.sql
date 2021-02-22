DROP DATABASE IF EXISTS empresa;
CREATE DATABASE empresa OWNER dbo_daw1_a;

/* shift + alt para seleccionar por zonas */

CREATE TABLE centro (
    codigo_centro  INTEGER NOT NULL,
    nombre_centro  VARCHAR(21) NOT NULL,		/* Nombre de centro de trabajo */
    ubicacion  VARCHAR(22) NOT NULL				/* Ubicacion del centro de trabajo */
);

CREATE TABLE departamento (
    codigo_departamento  INTEGER NOT NULL,		/* Cdigo del departamento */
    codigo_centro  INTEGER NOT NULL,    		/* Cdigo del centro de trabajo en el que est el departamento */
    codigo_director  INTEGER NOT NULL,			/* Cdigo del empleado que es director de este departamento */
    tipo_director  CHAR NOT NULL,				/* Tipo de director del departamento. P: En Propiedad. F: En Funciones */
    presupuesto_departamento  DECIMAL NOT NULL,	/* Presupuesto anual de gasto del departamento en euros */
    codigo_departamento_superior  INTEGER,		/* Cdigo del departamento del que depende este departamento */
    nombre_departamento  VARCHAR(20) NOT NULL	/* Nombre del departamento */
);

CREATE TABLE empleado (
    codigo_empleado  INTEGER NOT NULL,			        /* Cdigo del empleado */
    codigo_departamento  INTEGER NOT NULL,		        /* Cdigo del departamento en el que trabaja el empleado */
    extension_telefonica_empleado  SMALLINT NOT NULL,   /* Extensin telefnica compartida con otros empleados que utiliza el empleado */
    fecha_nacimiento_empleado  DATE NOT NULL,	        /* Fecha de nacimiento del empleado */
    fecha_ingreso_empleado  DATE NOT NULL,		        /* Fecha de ingreso del empleado en la empresa */
    salario_base_empleado  DECIMAL NOT NULL,	        /* Salario base mensual del empleado en euros. El salario total es el salario base ms la comisin */
    comision_empleado  DECIMAL,					        /* Comisin variable mensual en euros de los empleados que la tienen */
    numero_hijos_empleado  SMALLINT NOT NULL,	        /* Nmero de hijos del empleado */
    nombre_empleado  VARCHAR(16) NOT NULL    	        /* Nombre del empleado */
);

ALTER TABLE centro ADD
PRIMARY KEY ( codigo_centro );

ALTER TABLE departamento ADD
PRIMARY KEY ( codigo_departamento );

ALTER TABLE empleado ADD
PRIMARY KEY ( codigo_empleado );

ALTER TABLE departamento 
ADD CONSTRAINT pertenece_a FOREIGN KEY (codigo_centro) 
    REFERENCES centro (codigo_centro) 
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE empleado 
ADD CONSTRAINT trabaja_en FOREIGN KEY (codigo_departamento) 
    REFERENCES departamento (codigo_departamento) 
    ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO centro VALUES(10, 'SEDE CENTRAL', 'C/ ALCALA, 820, MADRID');
INSERT INTO centro VALUES(20, 'RELACION CON CLIENTES', 'C/ ATOCHA, 405, MADRID');

INSERT INTO departamento VALUES(100, 10, 260, 'P', 120000, NULL, 'DIRECCION GENERAL');
INSERT INTO departamento VALUES(110, 20, 180, 'P', 15000, 100, 'DIRECCION COMERCIAL');
INSERT INTO departamento VALUES(111, 20, 180, 'F', 11000, 110, 'SECTOR INDUSTRIAL');
INSERT INTO departamento VALUES(112, 20, 270, 'P', 9000, 110, 'SECTOR SERVICIOS');
INSERT INTO departamento VALUES(120, 10, 150, 'F', 3000, 100, 'ORGANIZACION');
INSERT INTO departamento VALUES(121, 10, 150, 'P', 2000, 120, 'PERSONAL');
INSERT INTO departamento VALUES(122, 10, 350, 'P', 6000, 120, 'PROCESO DE DATOS');
INSERT INTO departamento VALUES(130, 10, 310, 'P', 2000, 100, 'FINANZAS');

INSERT INTO empleado VALUES(110, 121, 350, '1949-10-11', '1970-02-15', 3100, NULL, 3, 'PONS, CESAR'),
            (120, 112, 840, '1955-06-09', '1988-10-01', 3500, 1100,  1, 'LASA, MARIO'),
            (130, 112, 810, '1965-09-09', '1989-02-01', 2900, 1100, 2, 'TEROL, LUCIANO'),
            (150, 121, 340, '1950-08-10', '1968-01-15', 4400, NULL, 0, 'PEREZ, JULIO'),
            (160, 111, 740, '1959-07-09', '1988-11-11', 3100, 1100, 2, 'AGUIRRE, AUREO'),
            (180, 110, 508, '1954-10-18', '1976-03-18', 4800, 500, 2, 'PEREZ, MARCOS'),
            (190, 121, 350, '1952-05-12', '1982-02-11', 3000, NULL, 4, 'VEIGA, JULIANA'),
            (210, 100, 200, '1960-09-28', '1979-01-22', 3800, NULL, 2, 'GALVEZ, PILAR'),
            (240, 111, 760, '1962-02-26', '1986-02-04', 2800, 1000, 3, 'SANZ, LAVINIA'),
            (250, 100, 250, '1966-10-27', '1987-03-01', 4500, NULL, 0, 'ALBA, ADRIANA'),
            (260, 100, 220, '1963-12-03', '1988-07-12', 7200, NULL, 9, 'LOPEZ, ANTONIO'),
            (270, 112, 800, '1965-05-21', '1986-09-10', 3800, 800, 3, 'GARCIA, OCTAVIO'),
            (280, 130, 410, '1968-01-11', '1991-10-08', 2900, NULL, 5, 'FLOR, DOROTEA'),
            (285, 122, 620, '1969-10-25', '1988-02-15', 3800, NULL, 0, 'POLO, OTILIA'),
            (290, 120, 910, '1967-11-30', '1988-02-14', 2700, NULL, 3, 'GIL, GLORIA'),
            (310, 130, 480, '1966-11-21', '1991-01-15', 4200, NULL, 0, 'GARCIA, AUGUSTO'),
            (320, 122, 620, '1977-12-25', '1998-02-05', 4050, NULL, 2, 'SANZ, CORNELIO'),
            (330, 112, 850, '1968-08-19', '1992-03-01', 2800, 900, 0, 'DIEZ, AMELIA'),
            (350, 122, 610, '1959-04-13', '1994-09-10', 4500, NULL, 1, 'CAMPS, AURELIO'),
            (360, 111, 750, '1978-10-29', '1998-10-10', 2500, 1000, 2, 'LARA, DORINDA'),
            (370, 121, 360, '1977-06-22', '1997-01-20', 1900, NULL, 1, 'RUIZ, FABIOLA'),
            (380, 112, 880, '1978-03-30', '1998-01-01', 1800, NULL, 0, 'MARTIN, MICAELA'),
            (390, 110, 500, '1976-02-19', '1996-10-08', 2150, NULL, 1, 'MORAN, CARMEN'),
            (400, 111, 780, '1979-08-18', '1997-11-01', 1850, NULL, 0, 'LARA, LUCRECIA'),
            (410, 122, 660, '1978-07-14', '1998-10-13', 1750, NULL, 0, 'MUOZ, AZUCENA'),
            (420, 130, 450, '1976-10-22', '1998-11-19', 4000, NULL, 0, 'FIERRO, CLAUDIA'),
            (430, 122, 650, '1977-02-26', '1998-11-19', 2100, NULL, 1, 'MORA, VALERIANA'),
            (440, 111, 760, '1976-09-26', '1996-02-28', 2100, 1000, 0, 'DURAN, LIVIA'),
            (450, 112, 880, '1976-10-21', '1996-02-28', 2100, 1000, 0, 'PEREZ, SABINA'),
            (480, 111, 760, '1975-04-04', '1996-02-28', 2100, 1000, 1, 'PINO, DIANA'),
            (490, 112, 880, '1974-06-06', '1998-01-01', 1800, 1000, 0, 'TORRES, HORACIO'),
            (500, 111, 750, '1975-10-08', '1997-01-01', 2000, 1000, 0, 'VAZQUEZ, HONORIA'),
            (510, 110, 550, '1976-05-04', '1996-01-11', 2000, NULL, 1, 'CAMPOS, ROMULO'),
            (550, 111, 780, '1980-01-10', '1998-01-21', 1000, 1200, 0, 'SANTOS, SANCHO');


-- 1. Mostrar toda la información de la tabla empleado.  -->
SELECT * FROM empleado;

-- 2. Mostrar códigos de departamento distintos de la tabla empleado. -->
SELECT codigo_departamento FROM empleado;

-- 3. Listar los empleados en el orden ascendente de sus salarios. -->
SELECT nombre_empleado, SUM(salario_base_empleado + COALESCE(comision_empleado, 0)) as salario_total FROM empleado
GROUP BY nombre_empleado
ORDER BY salario_total ASC;

-- 4. Muestra el nombre y fecha de nacimiento de todos los empleados.  -->
SELECT nombre_empleado, fecha_nacimiento_empleado FROM empleado;

-- 5. Muestre los nombres de todos los empleados que trabajan en FINANZAS y reciben un salario de más de 1500.  -->
SELECT nombre_empleado FROM empleado
WHERE codigo_departamento = 130 AND salario_base_empleado > 1500;
-- 6. Muestre el número y el nombres de los empleados que ganan comisiones.  -->
SELECT codigo_empleado, nombre_empleado FROM empleado
WHERE comision_empleado IS NOT NULL;

--7. Mostrar el nombre de los empleados que no ganan ninguna comisión. -->
SELECT nombre_empleado, salario_base_empleado FROM empleado
WHERE comision_empleado IS NULL;

-- 8. Muestre el nombre de los empleados que trabajan como FINANZAS, ORGANIZACION o PROCESO DE DATOS y su salario más de 3000.  -->
SELECT nombre_empleado, codigo_departamento, SUM(salario_base_empleado + COALESCE(comision_empleado, 0)) as salario_total 
FROM empleado
WHERE codigo_departamento = 130
OR codigo_departamento = 120
OR codigo_departamento= 122
AND salario_total > 3000
GROUP BY nombre_empleado;

-- 9. Muestre la lista de empleados que se han unido a la empresa antes del 30 de junio de 1.990 o después del 31 de diciembre de 1.997. -->
SELECT fecha_ingreso_empleado FROM empleado
WHERE fecha_ingreso_empleado < '1990-06-30'
OR fecha_ingreso_empleado > '1997-12-31';

-- 10. Mostrar la fecha actual.  -->
SELECT CURRENT_DATE ;

-- 11. Listado de los detalles de los empleados en orden ascendente de los departamentos y descendiente de la fecha de ingreso. -->
SELECT codigo_empleado, nombre_empleado, codigo_departamento, fecha_ingreso_empleado 
FROM empleado
ORDER BY codigo_departamento ASC,
    fecha_ingreso_empleado DESC;

-- 12. ¿Que empleados se unieron antes de 1.991?. -->
SELECT codigo_empleado, nombre_empleado, fecha_ingreso_empleado FROM empleado
WHERE fecha_ingreso_empleado < '1991-01-01';

-- 13. Código, nombre, salario de todos los empleados que no tienen hijos. -->
SELECT codigo_empleado, nombre_empleado, SUM(salario_base_empleado + COALESCE(comision_empleado, 0)) as salario_total, numero_hijos_empleado
FROM empleado
WHERE numero_hijos_empleado = 0
GROUP BY nombre_empleado, codigo_empleado;

-- 14. Muestra todos los detalles de los empleados cuya comision es mayor que su salario. -->
SELECT codigo_empleado, nombre_empleado, comision_empleado FROM empleado
WHERE comision_empleado > salario_base_empleado;

-- 15. Empleados en el orden ascendente de departamento de aquellos empleados que se incorporaron después de la segunda mitad de 1.998. -->
SELECT codigo_empleado, nombre_empleado, codigo_departamento FROM empleado
WHERE fecha_ingreso_empleado BETWEEN '1998-06-01' AND '1998-12-31'
ORDER BY codigo_departamento ASC;

-- 16. Liste el nombre, salario y el número de meses en la compañía de los empleados que su salario diario es mayor que 70. -->
SELECT nombre_empleado,
    ROUND(SUM(salario_base_empleado + COALESCE(comision_empleado, 0))/30, 2) as salario_diario,
    date_part('year', age(now(), fecha_ingreso_empleado))*12 + EXTRACT(month from age(now(), fecha_ingreso_empleado)) as meses
FROM empleado
WHERE ROUND((salario_base_empleado + COALESCE(comision_empleado, 0)/30),2) >= 70.00
GROUP BY nombre_empleado, meses;

-- 17. Enumere los empleados que son "ORGANIZACION" o "PROCESO DE DATOS" en orden descendiente de su nombre.  -->
SELECT nombre_empleado, codigo_departamento FROM empleado
WHERE codigo_departamento = 120 
OR codigo_departamento = 122
ORDER BY nombre_empleado DESC;

-- 18. Enumere los empleados que trabajan para el DEPARTAMENTO 110 o 120. -->
SELECT codigo_empleado, nombre_empleado, codigo_departamento FROM empleado
WHERE codigo_departamento = 110
OR codigo_departamento = 120; 

-- 19. Enumere los empleados que se unieron en el mes de agosto. -->
SELECT nombre_empleado, fecha_ingreso_empleado FROM empleado
WHERE EXTRACT(MONTH FROM fecha_ingreso_empleado) = 08;

-- 20. Liste los empleados cuyo salario anual está entre 25.000 y 35.000. -->
SELECT nombre_empleado,
    SUM((salario_base_empleado + COALESCE(comision_empleado, 0))*12) as salario_total_anual
FROM empleado
WHERE ((salario_base_empleado + COALESCE(comision_empleado, 0))*12) BETWEEN 25000 AND 35000
GROUP BY nombre_empleado;

-- 21. Nombres de empleados que tienen cinco caracteres en sus nombres. -->
SELECT nombre_empleado 
FROM empleado
WHERE nombre_empleado LIKE '%, _____';

-- 22. Nombres de empleados que comienzan con "A" y con 7 caracteres. -->
SELECT nombre_empleado FROM empleado
WHERE nombre_empleado LIKE '%, A______';

-- 23. Empleados que cuya tercera letra del apellido es una "R". -->
SELECT nombre_empleado FROM empleado
WHERE nombre_empleado LIKE '__R%';

-- 24. Cinco nombres de empleados cuyo apellido comienza con "G" y termina con "Z". -->
SELECT nombre_empleado FROM empleado
WHERE nombre_empleado LIKE 'G%Z%'

-- 25. Haz una lista de los empleados que se unieron en el mes cuyo segunda letra es una "A".  -->
abril = 4, agosto= 9

SELECT nombre_empleado, fecha_ingreso_empleado FROM empleado
WHERE EXTRACT( MONTH FROM fecha_ingreso_empleado) = 04 
OR EXTRACT( MONTH FROM fecha_ingreso_empleado) = 09;

-- 26. Enumere los empleados cuyo salario es un número de cuatro dígitos que empieza por 2.  -->
SELECT nombre_empleado, SUM(salario_base_empleado + COALESCE(comision_empleado, 0)) as salario_total
FROM empleado
WHERE CAST(salario_base_empleado + COALESCE(comision_empleado, 0) as TEXT) LIKE '2___'
GROUP BY nombre_empleado;

-- 27. Enumere los empleados que no pertenecen al departamento 111. -->
SELECT codigo_empleado, codigo_departamento FROM empleado
WHERE CAST(codigo_departamento as TEXT) NOT LIKE '111';

-- 28. Enumere todos los empleados excepto "DIRECCION" y "ORGANIZACION" en orden ascendente de salarios. -->
SELECT codigo_empleado, nombre_empleado, SUM(salario_base_empleado + COALESCE(comision_empleado, 0)) as salario_total
FROM empleado
WHERE codigo_departamento <> 110 AND codigo_departamento <> 100 AND codigo_departamento <> 120
GROUP BY codigo_empleado, nombre_empleado
ORDER BY salario_base_empleado + COALESCE(comision_empleado, 0) ASC;

-- 29. Enumere todos los empleados que se unieron antes o después de 1.996, pero no en 1.996. --
SELECT nombre_empleado, fecha_ingreso_empleado
FROM empleado
WHERE EXTRACT(YEAR FROM fecha_ingreso_empleado) <> 1996; 

-- 30. Enumere los empleados que se unieron en cualquier año pero que no en el mes de marzo. --
SELECT nombre_empleado, fecha_ingreso_empleado
FROM empleado
WHERE EXTRACT(MONTH FROM fecha_ingreso_empleado) <> 03; 

-- 31. Enumere los empleados de departamento 111 o 112 y que ingresaron en la compañía en 1.996. --
SELECT codigo_empleado, nombre_empleado, codigo_departamento, fecha_ingreso_empleado
FROM empleado
WHERE EXTRACT(YEAR FROM fecha_ingreso_empleado) = 1996
AND codigo_departamento BETWEEN 111 AND 112; 

-- 32. Muestra los nombres de los empleados que no trabajan como ORGANIZACION. --
SELECT nombre_empleado FROM empleado
WHERE codigo_departamento <> 120;

-- 33. Muestre los nombres de los empleados que no trabajan como ORGANIZACION o DIRECCION. --
SELECT nombre_empleado FROM empleado
WHERE NOT codigo_departamento = 120
AND NOT codigo_departamento = 110
AND NOT codigo_departamento = 100;

-- 34. Muestra el número total de empleados que trabajan en la empresa. --
SELECT COUNT(nombre_empleado) FROM empleado;

-- 35. Muestra el salario total que se paga a todos los empleados. --
SELECT SUM(salario_base_empleado + COALESCE(comision_empleado, 0)) as salario_total
FROM empleado;

-- 36. Muestra el salario máximo, salario mínimo y el salario promedio de la tabla empleado. --
SELECT ROUND(AVG(salario_base_empleado + COALESCE(comision_empleado, 0)), 2) as media_salario,
    MAX(salario_base_empleado + COALESCE(comision_empleado, 0)) as salario_maximo,
    MIN(salario_base_empleado + COALESCE(comision_empleado, 0)) as salario_minimo
FROM empleado;

-- 37. Muestra el salario máximo que se paga a un empleado de FINANZAS. --
SELECT MAX(salario_base_empleado + COALESCE(comision_empleado, 0)) as salario_maximo
FROM empleado
WHERE codigo_departamento = 130;

-- 38. Muestra el salario mínimo que se paga a cualquier DIRECTOR. --
SELECT MIN(salario_base_empleado + COALESCE(comision_empleado, 0)) as salario_minimo
FROM empleado
WHERE codigo_departamento = 110
OR codigo_departamento = 100;

-- 39. Muestra el salario promedio del colectivo de empleados con hijos. --
SELECT ROUND(AVG(salario_base_empleado + COALESCE(comision_empleado, 0)), 2) as media_salario
FROM empleado
WHERE numero_hijos_empleado >=1;

-- 40. Muestre el total de salarios de los empleados sin hijos. --
SELECT ROUND(AVG(salario_base_empleado + COALESCE(comision_empleado, 0)), 2) as media_salario
FROM empleado
WHERE numero_hijos_empleado = 0;

-- 41. Obtener por orden creciente una relación de todos los números de extensiones telefónicas de los empleados. --
SELECT codigo_empleado, extension_telefonica_empleado
FROM empleado
ORDER BY extension_telefonica_empleado ASC;

-- 42. Hallar la comisión, nombre y salario de los empleados con más de tres hijos, clasificados por comisión, y dentro de comisión por orden alfabético del nombre. 3 filas. --
SELECT comision_empleado, nombre_empleado, SUM(salario_base_empleado + COALESCE(comision_empleado, 0)) as salario_total
FROM empleado
WHERE numero_hijos_empleado = 3
AND comision_empleado IS NOT NULL
GROUP BY comision_empleado, nombre_empleado
ORDER BY nombre_empleado ASC;

-- 43. Llamemos presupuesto medio mensual de un departamento al resultado de dividir su
--presupuesto anual entre 12. Supongamos que se decide aumentar los presupuestos
--medios mensuales de todos los departamentos en un 7,23% a partir del mes de
--octubre inclusive. Para los departamentos cuyo presupuesto mensual medio es de
--más de 700€, hallar por orden alfabético el nombre de departamento, su presupuesto
--inicial, su incremento y su presupuesto anual total después del incremento. La
--dirección general, la primera, ha de resultar en 122169 (128676 es incorrecto) El
--último es Sector Servicios con 9162.675. --
SELECT nombre_departamento,
    ROUND(presupuesto_departamento/12, 3) as presupuesto_mensual, 
    ROUND( (presupuesto_departamento/12) * 1.0723, 3 ) as presupuesto_mensual_con_incremento,
    ROUND( ((presupuesto_departamento/12) * 1.0723) - (presupuesto_departamento/12), 3) as incremento,
    ROUND( presupuesto_departamento + ((((presupuesto_departamento/12) * 1.0723) - (presupuesto_departamento/12))*3) , 3) as presupuesto_final
FROM departamento
WHERE (presupuesto_departamento/12) > 700
GROUP BY nombre_departamento, presupuesto_departamento
ORDER BY nombre_departamento ASC;


-- 44. Muestra el campo nombre_empleado completo de todos los empleados, pero
--ordenado por su nombre. Pista: usar función que busque la posición de un carácter en
--una cadena. 34 filas, empezando por Alba, Adriana y acabando por Mora, Valeriana.--
SELECT nombre_empleado
FROM empleado
ORDER BY SUBSTRING(nombre_empleado, '[^ ]* (.*)') ASC;

-- 45. Hallar, por orden alfabético, los nombres de los empleados tales que si se les da una
--gratificación de 100 € por hijo, el total de esta gratificación no supera a la décima parte
--del salario. 29 filas. La primera es Aguirre, Aureo. La última es Vazquez, Honoria.--
SELECT nombre_empleado,
    numero_hijos_empleado,
    ROUND((salario_base_empleado/10), 3) AS gratificacion_no_superar,
    (numero_hijos_empleado*100) AS gratificacion 
FROM empleado
WHERE (numero_hijos_empleado*100) < (salario_base_empleado/10)
ORDER BY nombre_empleado ASC;


-- 46. Hallar por orden alfabético los nombres y salarios de empleados de los departamentos
--110 y 111 que o bien no tengan hijos o bien su salario por hijo supere a 1.000€. 10
--filas, empezando por Aguirre, Aureo, seguido por Perez Marcos y finalizando con
--Santos, Sancho.--
SELECT nombre_empleado,
    codigo_departamento,
    SUM(salario_base_empleado + COALESCE(comision_empleado, 0)) AS salario_total,
    ROUND((salario_base_empleado + COALESCE(comision_empleado, 0))/1000, 1) AS hijos_por_salario,
    numero_hijos_empleado
FROM empleado
WHERE codigo_departamento = 110 
OR codigo_departamento = 111
GROUP BY nombre_empleado, codigo_departamento, numero_hijos_empleado, hijos_por_salario
ORDER BY SUBSTRING(nombre_empleado, '[^ ]* (.*)') ASC;
    


-- 47. Obtener los nombres y sueldos de los empleados que hayan empezado a trabajar en
--la empresa el año 1997 en adelante o durante el año 1976, por orden alfabético 11
--filas, comenzando por Fierro, Claudia, acabando por Torres, Horacio y conteniendo a
--Perez, Marcos. --
SELECT nombre_empleado, 
    SUM(salario_base_empleado + COALESCE(comision_empleado, 0)) AS salario_total,
    EXTRACT(YEAR from fecha_ingreso_empleado) AS año_ingreso
FROM empleado
WHERE EXTRACT(YEAR from fecha_ingreso_empleado) >= 1997
OR EXTRACT(YEAR from fecha_ingreso_empleado) = 1976
GROUP BY nombre_empleado, año_ingreso
ORDER BY nombre_empleado ASC;

