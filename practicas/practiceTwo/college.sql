
-- Se desea implementar el siguiente esquema de base de datos en una universidad. --

-- Crear tablas.--

CREATE TABLE alumno(
    id NUMERIC(6),
    nombre VARCHAR(40),
    direccion VARCHAR(40),
    telefono VARCHAR(12),

    CONSTRAINT id_alumno_pk PRIMARY KEY(id)
);

CREATE TABLE asignatura(
    id NUMERIC(6),
    nombre VARCHAR(50),
    num_horas NUMERIC(4),
    precio NUMERIC(4),
    id_departamento NUMERIC(4),

    CONSTRAINT id_asignatura_pk PRIMARY KEY(id),
    CONSTRAINT num_horas_ck CHECK (num_horas BETWEEN 1 AND 100),
    CONSTRAINT id_departamento_fk FOREIGN KEY(id_departamento) REFERENCES departamento(id)
);

CREATE TABLE departamento(
    id NUMERIC(4),
    nombre VARCHAR(40),

    CONSTRAINT id_departamento_pk PRIMARY KEY(id)
);

CREATE TABLE calificacion(
    id_alumno NUMERIC(6),
    id_asignatura NUMERIC(6),
    fecha DATE,
    calificacion NUMERIC(4,2),

    UNIQUE (id_alumno, id_asignatura),
    CONSTRAINT id_alumno_calificacion_fk FOREIGN KEY (id_alumno) REFERENCES alumno(id),
    CONSTRAINT id_asignatura_calificacion_fk FOREIGN KEY(id_asignatura) REFERENCES asignatura(id),
    CONSTRAINT calificacion_ck CHECK(calificacion BETWEEN 0 AND 10)
);

ALTER TABLE asignatura ADD CONSTRAINT id_departamento_fk FOREIGN KEY(id_departamento) REFERENCES departamento(id);


--Insertar al alumnos:--

INSERT INTO alumno VALUES (1, 'SANCHEZ HERMOSILLA, ALBERTO','HIGUERUELAS 12', 654782615), (2, 'ALBA TORDESILLAS, ANA MARIA', 'PICASSO 112', 632487559), (3, 'TORRES ALMAGRO, GUILLERMO', 'ALCALA 415', 651235674), (4, 'TORRES ALMAGRO, GUILLERMO', 'ALCALA 415', 651235674);

--Insertar las siguientes asignaturas y departamentos:--
INSERT INTO departamento (id, nombre) VALUES (1,'PROGRAMACION'), (2, 'SISTEMAS OPERATIVOS'), (3, 'BASES DE DATOS');

INSERT INTO asignatura(id, nombre, num_horas, precio, id_departamento) 
VALUES (1,'FUNDAMENTOS DE LA PROGRAMACION', 100, 350.00, 1), (2, 'ELEMENTOS DE HARDWARE', 75, 200.00, 2), (3, 'PROGRAMACION AVANZADA EN JAVA', 100, 400.00, 1), (4, 'SISTEMAS OPERATIVOS MONOPUESTO', 100, 245.00, 2), (5, 'IMPLANTACION DE BASES DE DATOS', 90, 300.00, 3), (6, 'BASES DE DATOS NO RELACIONALES', 100, 800.00, 3);

--Registrar las siguientes matrículas. Es decir, insertar en la tabla CALIFICACION los datos sin
--aún la fecha y la calificación (NULL).

INSERT INTO calificacion(id_alumno, id_asignatura)
VALUES (2, 4), (1, 3), (3, 6), (1, 2), (2, 5), (3, 1), (3, 4);

--Matricular al siguiente alumno en ‘SISTEMAS OPERATIVOS MONOPUESTO’ e ‘IMPLANTACION DE BASES DE DATOS’. Usar los correspondientes asignatura_id para las asignaturas. --

INSERT INTO alumno VALUES (5, 'ROMERO CIFUENTES, ELENA', 'MARCELO USERA 24', 624155975);
INSERT INTO calificacion VALUES (5, 5, '2021-02-09', NULL);

-- Configurar todas las fechas de las calificaciones a ‘01/06/2021’. Para ello usar la función de conversión de cadenas a fechas TO_DATE(‘1/6/2021’).

UPDATE calificacion
SET fecha = TO_DATE('01/06/2021', 'DD/MM/YY');

-- Configurar la calificación de la asignatura ‘ELEMENTOS DE HARDWARE’ a 6,25 al alumno cuyo id es igual a uno. --

UPDATE calificacion
SET calificacion = 6.25
WHERE id_alumno=1 AND id_asignatura = 2;

--Asignar al alumno ‘TORRES ALMAGRO, GUILLERMO’ una nota de 7.50 en ‘FUNDAMENTOS DE PROGRAMACION’.--

UPDATE calificacion
SET calificacion = 7.5
WHERE id_alumno = 3 AND id_asignatura = 1;

--Dar aprobado general en la asignatura ‘BASES DE DATOS NO RELACIONALES’.

UPDATE calificacion
SET calificacion = 5
WHERE calificacion IS NULL;

--11. Añadir a la base de datos la asignatura ‘PROGRAMACIÓN EN PYTHON’, con 200 horas de duración, un precio de 500,00 y adscrita al departamento cuyo id es 1.

INSERT INTO asignatura VALUES (7, 'PROGRAMACION EN PHYTON', 100, 500.00, 1);

--Matricular en ‘PROGRAMACIÓN EN PYTHON’ a los alumnos cuyo id es uno, tres y cinco.

INSERT INTO calificacion VALUES(1, 7, NULL, '11/02/2021'), (3, 7, NULL, '11/02/2021'), (5, 7, NULL, '11/02/2021');

--Actualizar los precios de las matrículas. Aumentar su precio un 5%.

UPDATE asignatura
SET precio = ROUND(precio * 1.05, 2);

--Aumentar un 10% adicional a las asignaturas con menos de 100 horas lectivas.

UPDATE asignatura
SET precio = ROUND(precio * 1.1, 2)
WHERE num_horas < 100;

--Reducir el precio de la matrícula 50,00 a las asignaturas adscritas al departamento ‘BASES DE DATOS’.

UPDATE asignatura
SET precio = precio - 50.00
WHERE id_departamento = 3;

--Establecer las calificaciones no actualizadas (NULL) a cero. Usar la clausula ‘calificacion IS NULL’.

UPDATE calificacion
SET calificacion = 0
WHERE calificacion IS NULL;

--Realizar los cambios necesarios para eliminar el departamento ‘BASES DE DATOS’ y asignar las asignaturas que dirige a ‘PROGRAMACION’.

UPDATE asignatura
SET id_departamento = 1
WHERE id_departamento = 3; 

DELETE FROM departamento WHERE id = 3;

