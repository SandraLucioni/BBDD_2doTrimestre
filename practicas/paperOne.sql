-- 1. --

CREATE DATABASE tienda OWNER postgres;

CREATE TABLE comprador (
     cif_comprador VARCHAR(11),
     nombre_social VARCHAR(30) UNIQUE,
     domicilio_social VARCHAR(30),
     localidad VARCHAR(30),
     c_postal VARCHAR(5),
     telefono VARCHAR(9) NOT NULL,

     CONSTRAINT cif_comprador_pk PRIMARY KEY (cif_comprador),
     CONSTRAINT nombre_social_uq UNIQUE (nombre_social)
);

CREATE TABLE articulo (
     referencia_articulo VARCHAR(12),
     descripcion_articulo VARCHAR(30), 
     precio_unidad NUMERIC(6,2),
     iva NUMERIC(2),
     existencias_actuales NUMERIC(5) DEFAULT 0,

     CONSTRAINT iva_ck CHECK (iva BETWEEN 5 AND 25),
     CONSTRAINT articulos_pk PRIMARY KEY (referencia_articulo)
);

CREATE TABLE factura (
     num_factura NUMERIC(6),
     fecha_factura DATE DEFAULT'01/01/2005, DD/MM/YY',
     cif_cliente VARCHAR(11),

     CONSTRAINT facturas_pk PRIMARY KEY (num_factura)
);

CREATE TABLE linea_factura (
     num_factura NUMERIC(6),
     referencia_articulo VARCHAR(12),
     unidades NUMERIC(3),

     CONSTRAINT linea_factura_pk PRIMARY KEY (referencia_articulo, num_factura),
     CONSTRAINT linea_factura_fk FOREIGN KEY (num_factura) REFERENCES factura(num_factura)
     ON DELETE CASCADE,
     CONSTRAINT fk_linea_factura FOREIGN KEY (referencia_articulo) REFERENCES articulos(referencia_articulo)
);

-- 1.2 --
ALTER TABLE factura ADD COLUMN cod_oficina numeric(4);

-- 1.3 --
ALTER TABLE factura ADD CONSTRAINT cif_cliente FOREIGN KEY (cif_cliente) REFERENCES comprador(cif_comprador);

-- 1.4 --
ALTER TABLE comprador RENAME COLUMN c_postal TO codigo_postal VARCHAR(5);

-- 1.5 --
ALTER TABLE factura ADD CONSTRAINT cod_oficina CHECK (cod_oficina BETWEEN 1 AND 1000);


-- 2. --

DROP TABLE tienda [CASCADE]

CREATE TABLE comprador (
     cif_comprador VARCHAR(11),
     nombre_social VARCHAR(30) UNIQUE,
     domicilio_social VARCHAR(30),
     localidad VARCHAR(30),
     codigo_postal VARCHAR(5),
     telefono VARCHAR(9) NOT NULL,

     CONSTRAINT cif_comprador_pk PRIMARY KEY (cif_comprador),
     CONSTRAINT nombre_social_uq UNIQUE (nombre_social)
);

CREATE TABLE articulo (
     referencia_articulo VARCHAR(12),
     descripcion_articulo VARCHAR(30),
     precio_unidad NUMERIC(6,2),
     iva NUMERIC(2),
     existencias_actuales NUMERIC(5) DEFAULT 0,

     CONSTRAINT iva_ck CHECK (iva BETWEEN 5 AND 25),
     CONSTRAINT articulos_pk PRIMARY KEY (referencia_articulo)
);

CREATE TABLE factura (
     num_factura NUMERIC(6),
     cod_oficina NUMERIC(4),
     fecha_factura DATE DEFAULT'01/01/2005, DD/MM/YY',
     cif_cliente VARCHAR(11),

     CONSTRAINT factura_pk PRIMARY KEY (num_factura),
     CONSTRAINT cif_cliente FOREIGN KEY (cif_cliente) REFERENCES comprador(cif_comprador),
     CONSTRAINT cod_oficina CHECK (cod_oficina BETWEEN 1 AND 1000)
     
);

CREATE TABLE linea_factura (
     num_factura NUMERIC(6),
     referencia_articulo VARCHAR(12),
     unidades NUMERIC(3),

     CONSTRAINT linea_factura_pk PRIMARY KEY (referencia_articulo, num_factura),
     CONSTRAINT linea_factura_fk FOREIGN KEY (num_factura) REFERENCES factura(num_factura)
     ON DELETE CASCADE,
     CONSTRAINT linea_factura_fk FOREIGN KEY (referencia_articulo) REFERENCES articulos(referencia_articulo)
);



-- 3. sin restricciones --
DROP TABLE tienda

CREATE DATABASE centro_comercial OWNER postgres;

CREATE TABLE comprador_1 (
     cif_comprador VARCHAR(11),
     nombre_social VARCHAR(30),
     domicilio_social VARCHAR(30),
     localidad VARCHAR(30),
     c_postal VARCHAR(5),
     telefono VARCHAR(9),
);

CREATE TABLE articulo_1 (
     referencia_articulo VARCHAR(12),
     descripcion_articulo VARCHAR(30),
     precio_unidad NUMERIC(6,2),
     iva NUMERIC(2),
     existencias_actuales NUMERIC(5),
);

CREATE TABLE factura_1 (
     factura_no NUMERIC(6),
     fecha_factura DATE,
     cif_cliente VARCHAR(11),
);

CREATE TABLE linea_factura_1 (
     factura_no NUMERIC(6),
     referencia_articulo VARCHAR(12),
     unidades NUMERIC(3)
);


-- 3.2 --

CREATE TABLE comprador_2 (
     cif_comprador VARCHAR(11),
     nombre_social VARCHAR(30),
     domicilio_social VARCHAR(30) UNIQUE,
     localidad VARCHAR(30),
     c_postal VARCHAR(5),
     telefono VARCHAR(9) NOT NULL,

     CONSTRAINT cif_comprador_pk PRIMARY KEY (cif_comprador)
     CONSTRAINT nombre_social_uq UNIQUE (nombre_social),
);

CREATE TABLE articulo_2 (
     referencia_articulo VARCHAR(12),
     descripcion_articulo VARCHAR(30),
     precio_unidad NUMERIC (6,2),
     iva NUMERIC (2), intervalo entre 5 y 25
     existencias_actuales numeric(5) DEFAULT 0,

     CONSTRAINT referencia_articulo_pk PRIMARY KEY (referencia_articulo),
     CONSTRAINT iva_ck CHECK (iva BETWEEN 5 AND 25)
);

CREATE TABLE factura_2 (
     num_factura NUMERIC(6),
     fecha_factura DATE,
     cif_cliente VARCHAR(11),
     
     CONSTRAINT cif_cliente_fk FOREIGN KEY REFERENCES comprador_2(cif_comprador),
     CONSTRAINT num_factura_pk PRIMARY KEY(num_factura)
);



-- 3.3. --

CREATE TABLE comprador_3 (
     cif_comprador VARCHAR(11),
     nombre_social varchar(30),
     domicilio_social varchar(30),
     localidad varchar(30),
     c_postal varchar(5),
     telefono varchar(9),

     CONSTRAINT cif_comprador_pk PRIMARY KEY (cif_comprador),
     CONSTRAINT nombre_social_uq UNIQUE (nombre_social)
);

CREATE TABLE factura_3 (
     num_factutra NUMERIC(6),
     fecha_factura DATE DEFAULT ('01/01/2005, DD/MM/YY'),

     CONSTRAINT factura_pk PRIMARY KEY (num_factura),
     CONSTRAINT cif_cliente_fk FOREIGN KEY (cif_cliente) REFERENCES comprador_3(cif_comprador)
);

-- 3.4. --

ALTER TABLE factura_1 ADD CONSTRAINT num_factura_1_pk PRIMARY KEY(num_factura);

-- 3.5. --

ALTER TABLE linea_factura_1  ADD CONSTRAINT linea_factura_1_fk FOREIGN KEY(num_factura) REFERENCES facturas_1(num_factura);

-- 3.6. --
ALTER TABLE articulo_1 ADD CONSTRAINT uq_articulo_descripcion_1 UNIQUE(descripcion_articulo);

-- 3.7 --
ALTER TABLE comprador_1 ALTER COLUMN telefono [SET DATA] TYPE NUMERIC;
--ALTER COLUMN telefono TYPE INT USING (telefono::INT);--


--Comprobar en sql --


