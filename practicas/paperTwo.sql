
--VENTAS--

-- 1. crear tablas que te adjunta el enunciado --

CREATE DATABASE ventas OWNER postgres;

CREATE TABLE cliente (  
    id SERIAL PRIMARY KEY,   
    nombre VARCHAR(25),  
    primer_apellido VARCHAR(15) NOT NULL,   
    ciudad VARCHAR(100),  
    categoria INT 
); 
    
CREATE TABLE comercial (  
    id SERIAL PRIMARY KEY,   
    nombre VARCHAR(100) NOT NULL,  
    apellido1 VARCHAR(100) NOT NULL,  
    apellido2 VARCHAR(100),  
    ciudad VARCHAR(100),  
    comision FLOAT 
);

-- 1.1 Modifique la columna nombre de la tabla cliente--
-- para que pueda almacenar cadenas de hasta 100 caracteres--
--y para que no pueda ser NULL. --

ALTER TABLE cliente ALTER COLUMN nombre TYPE VARCHAR(100);

-- 1.2. . ¿Qué comando puede ejecutar para comprobar que el 
--cambio que se ha realizado en el paso anterior se ha 
--ejecutado correctamente? 

\d cliente
--\d enseña tabla y luego el nombre de la tabla que queremos ver.

-- 1.3. Modifique el nombre de la columna primer_apellido
--y asígnele apellido1. También tendrá que permitir que pueda
--almacenar hasta 100 caracteres y que no pueda ser un valor
--NULL. 
ALTER TABLE cliente ALTER COLUMN primer_apellido TO apellido1;
ALTER TABLE cliente ALTER COLUMN apellido1 TYPE VARCHAR(100);
ALTER TABLE cliente ALTER COLUMN apellido1 SET NOT NULL;

--1.4. Añada una nueva columna a la tabla cliente para poder almacenar 
--el segundo apellido. La columna se debe llamar apellido2 debe estar 
--entre la columna apellido1 y ciudad, puede almacenar hasta 100 caracteres
--y puede ser NULL. ¿Es posible hacer esto en PostgreSQL con el comando
--ALTER TABLE? Aporte alternativas en el caso de que no se pueda.

--No se puede colocar la columna nueva en la posición que queramos, la podemos
--crear pero no posicionar.
--Una alternativa puede ser borrar toda la tabla y escribirla de nuevo en elorden que queramos.
--Otra podría ser borrar todas las columnas posteriores a nombre, aunque personalmente me parece
--demasiado trabajo, teniendo en cuenta que podemos copiar y pegar desde el texto externo antes de
--pasarlo a SQL Shell.

DROP TABLE cliente;

CREATE TABLE cliente (  
    id SERIAL PRIMARY KEY,   
    nombre VARCHAR(25),  
    apellido1 VARCHAR(15) NOT NULL,
    apellido2 VARCHAR(15), 
    ciudad VARCHAR(100),  
    categoria INT 
);

--1.5. Haga que la columna categoria solo admita enteros sin signo.
ALTER TABLE cliente ADD CONSTRAINT categoria_ck CHECK(categoria >=0);

--1.6. Elimine la columna categoria de la tabla cliente.
ALTER TABLE cliente DROP COLUMN categoria;

--1.7. Modifique la columna comision de la tabla comercial para que almacene por defecto el valor 10.
ALTER TABLE comercial ALTER COLUMN comision SET DEFAULT 10;


--PELÍCULAS--

CREATE DATABASE peliculas OWNER postgres;

CREATE TABLE genero (
    genero VARCHAR(50) CONSTRAINT genero_pk PRIMARY KEY
);

CREATE TABLE pelicula (
    codigo NUMERIC(10),
    titulo VARCHAR(30),
    año DATE,
    caratula VARCHAR(300),
    genero VARCHAR(50),
    director VARCHAR(30),

    CONSTRAINT codigo_pk PRIMARY KEY(codigo),
    --CONSTRAINT genero_fk FOREIGN KEY(genero) REFERENCES genero(genero),
    --CONSTRAINT director_fk FOREIGN KEY(director) REFERENCES director(nombre)
);

CREATE TABLE director (
    nombre VARCHAR(30),
    lugar_nacimiento VARCHAR(50),
    fecha_nacimiento DATE,

    CONSTRAINT nombre_director_pk PRIMARY KEY(nombre)
);

CREATE TABLE actor (
    nombre VARCHAR(30),
    lugar_nacimiento VARCHAR(50),
    fecha_nacimiento DATE,
    sexo CHAR(1),
    foto VARCHAR(300),

    CONSTRAINT nombre_actor_pk PRIMARY KEY(nombre),
    CONSTRAINT sexo_ck CHECK (sexo IN ('M', 'V'))
);

CREATE TABLE actor_pelicula (
    pelicula NUMERIC(10),
    actor VARCHAR(15),
    foto VARCHAR(300),
    año DATE,

    CONSTRAINT pelicula_fk FOREIGN KEY(pelicula) REFERENCES pelicula(codigo),
    CONSTRAINT actor_fk FOREIGN KEY(actor) REFERENCES actor(nombre)
);

--No puedo escribir todo de golpe, refiriendome a la FK, porque mientras las voy
--creando algunas de esas tablas no existen aún. Añadir a continuación los CONSTRAINT
--necesarios de cada tabla, menos de la última.

ALTER TABLE pelicula ADD CONSTRAINT genero_fk FOREIGN KEY(genero) REFERENCES genero(genero);

ALTER TABLE pelicula ADD CONSTRAINT director_fk FOREIGN KEY(director) REFERENCES director(nombre);

--error al escribir en las fotos con un espacio de 300 en vez de 255.
ALTER TABLE actor_pelicula ALTER COLUMN foto VARCHAR(255);

--error al escribir anyo en actor_pelicula
ALTER TABLE actor_pelicula RENAME COLUMN año TO anyo;

--error en escribir M/F
ALTER TABLE actor ALTER COLUMN sexo CHAR(1) CONSTRAINT sexo_ck CHECK (sexo IN ('M', 'V'));




--BIBLIOTECA--


CREATE DATABASE biblioteca OWNER postgres;

CREATE TABLE libro (
    isbn CHAR(13) NOT NULL,
    titulo VARCHAR(30) NOT NULL,
    autor NUMERIC(10) NOT NULL,
    nombre_editorial VARCHAR(30),
    año_edicion CHAR(4),

    CONSTRAINT libro_pk PRIMARY KEY(isbn)
    --CONSTRAINT nombre_editorial_fk FOREIGN KEY (nombre_editorial) REFERENCES editorial(nombre) ON DELETE SET NULL;
    --CONSTRAINT autor_fk FOREIGN KEY(autor) REFERENCES autor(cod_autor);
);

CREATE TABLE autor (
    cod_autor NUMERIC(10) NOT NULL,
    nombre CHAR(30) NOT NULL,
    nacionalidad VARCHAR(30),

    CONSTRAINT cod_autor_pk PRIMARY KEY(cod_autor)
);

CREATE TABLE editorial ( 
    nombre VARCHAR(30) NOT NULL,
    direccion VARCHAR(30),

    CONSTRAINT editorial_pk PRIMARY KEY(nombre)
);

CREATE TABLE socio (
    num_socio NUMERIC(5),
    nombre VARCHAR(20) NOT NULL,
    dni CHAR(9) NOT NULL,
    telefono NUMERIC(9) NOT NULL,
    direccion VARCHAR(50),

    CONSTRAINT socio_pk PRIMARY KEY(num_socio),
    CONSTRAINT dni_uq UNIQUE(dni) 
);

CREATE TABLE prestamo (
    codigo SMALLINT,
    isbn CHAR(13) NOT NULL,
    num_socio NUMERIC(5) NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,

    CONSTRAINT prestamo_pk PRIMARY KEY(codigo),
    CONSTRAINT isbn_fk FOREIGN KEY(isbn) REFERENCES libro(isbn),
    CONSTRAINT num_socio_fk FOREIGN KEY(num_socio) REFERENCES socio(num_socio)
);


--Lo mismo que en el anterior, añadir los CONSTRAINT después de escribir todas las tablas.
ALTER TABLE libro ADD CONSTRAINT nombre_editorial_fk FOREIGN KEY(nombre_editorial) REFERENCES editorial(nombre);
ALTER TABLE libro ADD CONSTRAINT autor_fk FOREIGN KEY(autor) REFERENCES autor(cod_autor);