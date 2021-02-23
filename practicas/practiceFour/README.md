# Ejercicios SELECT agrupamiento. Hoja 2


## Definición de la tabla centro

```sql
empresa2=# \d centro
                           Tabla ½public.centro╗
  Columna  |         Tipo          | Ordenamiento | Nulable  | Por omisi¾n
-----------+-----------------------+--------------+----------+-------------
 id        | integer               |              | not null |
 nombre    | character varying(21) |              | not null |
 ubicacion | character varying(22) |              | not null |
═ndices:
    "centro_pk" PRIMARY KEY, btree (id)
Referenciada por:
    TABLE "departamento" CONSTRAINT "departamento_centro_id_fk" FOREIGN KEY (centro_id) REFERENCES centro(id) ON UPDATE CASCADE ON DELETE CASCADE
```

## Definición de la tabla empleado

```sql
empresa2=> \d empleado
                      Table "public.empleado"
  Column   |         Type          | Collation | Nullable | Default 
-----------+-----------------------+-----------+----------+---------
 id        | integer               |           | not null | 
 depto_id  | integer               |           | not null | 
 puesto    | character varying(16) |           | not null | 
 ext_tel   | smallint              |           | not null | 
 fecha_nac | date                  |           | not null | 
 fecha_ing | date                  |           | not null | 
 salario   | numeric(6,0)          |           | not null | 
 comision  | numeric(6,0)          |           |          | 
 num_hijos | smallint              |           | not null | 
 nombre    | character varying(16) |           | not null | 
Indexes:
    "empleado_pk" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "empleado_depto_id_fk" FOREIGN KEY (depto_id) REFERENCES departamento(id) ON UPDATE CASCADE ON DELETE CASCADE
```

## Definición de la tabla departamento

```sql
empresa2=# \d departamento
                            Tabla ½public.departamento╗
      Columna      |         Tipo          | Ordenamiento | Nulable  | Por omisi¾n
-------------------+-----------------------+--------------+----------+-------------
 id                | integer               |              | not null |
 centro_id         | integer               |              | not null |
 director_id       | integer               |              | not null |
 tipo_director     | character(1)          |              | not null |
 presupuesto       | numeric(9,0)          |              | not null |
 depto_id_superior | integer               |              |          |
 nombre            | character varying(20) |              | not null |
═ndices:
    "departamento_pk" PRIMARY KEY, btree (id)
Restricciones de llave forßnea:
    "departamento_centro_id_fk" FOREIGN KEY (centro_id) REFERENCES centro(id) ON UPDATE CASCADE ON DELETE CASCADE
Referenciada por:
    TABLE "empleado" CONSTRAINT "empleado_depto_id_fk" FOREIGN KEY (depto_id) REFERENCES departamento(id) ON UPDATE CASCADE ON DELETE CASCADE
```


## Ejercicio 1
**Mostrar el número de departamento, cuantos empleados trabajan en el y la suma de los salarios para todos los departamentos que aparece en la tabla `empleado`.**

```sql
SELECT depto_id AS "departamento",
    COUNT(*) AS "núm. emp",
    SUM(salario) AS "suma salarios"
FROM empleado
GROUP BY depto_id;
```

Resultado:
```sql
empresa2=> SELECT depto_id AS "departamento",
empresa2->     COUNT(*) AS "núm. emp",
empresa2->     SUM(salario) AS "suma salarios"
empresa2-> FROM empleado
empresa2-> GROUP BY depto_id;
 departamento | núm. emp | suma salarios 
--------------+----------+---------------
          112 |        7 |         18700
          121 |        4 |         12400
          120 |        1 |          2700
          111 |        8 |         17450
          100 |        3 |         15500
          122 |        5 |         16200
          110 |        3 |          8950
          130 |        3 |         11100
(8 rows)
```

## Ejercicio 2
**Mostrar el número y la suma de sus salarios de los empleados que no están adscritos a ningún departamento.**

>No entiendo muy bien la pregunta, ya que todos tienen que estar adscritos en algún departamento porque `depto_id` es NOT NULL  por lo que es imposible que alguien no esté clasificado. Por lo tanto he decidido que voy a hacer la suma de todos los empleados.

```sql
SELECT id,
    depto_id,
    SUM(salario + COALESCE(comision, 0)) AS salario_total
FROM empleado
WHERE depto_id = 0
GROUP BY id, depto_id;
```

Resultado como se pedía:
```sql
empresa2=# SELECT id,
empresa2-#     depto_id,
empresa2-#     SUM(salario + COALESCE(comision, 0)) AS salario_total
empresa2-# FROM empleado
empresa2-# WHERE depto_id = 0
empresa2-# GROUP BY id, depto_id;
 id | depto_id | salario_total
----+----------+---------------
(0 filas)
```

```sql
SELECT id,
    depto_id,
    SUM(salario + COALESCE(comision, 0)) AS salario_total
FROM empleado
GROUP BY id, depto_id;
```

Resultado según mi deducción:
```sql
empresa2=# SELECT id,
empresa2-#     depto_id,
empresa2-#     SUM(salario + COALESCE(comision, 0)) AS salario_total
empresa2-# FROM empleado
empresa2-# GROUP BY id, depto_id;
 id  | depto_id | salario_total
-----+----------+---------------
 550 |      111 |          2200
 190 |      121 |          3000
 350 |      122 |          4500
 180 |      110 |          5300
-- Más --
 150 |      121 |          4400
 380 |      112 |          1800
 130 |      112 |          4000
 270 |      112 |          4600
(34 filas)
```

## Ejercicio 3
**Hacer un informe que muestre el número, máximo y mínimo salario de los empleados en función de su puesto de trabajo, de aquellos puestos que tengan mas de 3 empleados.**

```sql
SELECT depto_id,
    COUNT(*) AS numero_empleados,
    SUM(salario + COALESCE(comision, 0)) AS salario_total,
    MAX(salario + COALESCE(comision, 0)) AS salario_maximo,
    MIN(salario + COALESCE(comision, 0)) AS salario_minimo
FROM empleado
GROUP BY depto_id
HAVING COUNT(*) > 3;
```
Resultado:
```sql
empresa2=# SELECT depto_id,
empresa2-#     COUNT(*) AS numero_empleados,
empresa2-#     SUM(salario + COALESCE(comision, 0)) AS salario_total,
empresa2-#     MAX(salario + COALESCE(comision, 0)) AS salario_maximo,
empresa2-#     MIN(salario + COALESCE(comision, 0)) AS salario_minimo
empresa2-# FROM empleado
empresa2-# GROUP BY depto_id
empresa2-# HAVING COUNT(*) > 3;
 depto_id | numero_empleados | salario_total | salario_maximo | salario_minimo
----------+------------------+---------------+----------------+----------------
      112 |                7 |         24600 |           4600 |           1800
      121 |                4 |         12400 |           4400 |           1900
      111 |                8 |         24750 |           4200 |           1850
      122 |                5 |         16200 |           4500 |           1750
(4 filas)
```

## Ejercicio 4
**Mostrar el número de empleados y el salario medio de los puestos 'Técnico' o 'Administrativo'.**

```sql
SELECT depto_id,
    COUNT(*) AS numero_empleados,
    ROUND(AVG(salario + COALESCE(comision, 0)), 3) AS salario_medio
FROM empleado
WHERE puesto = 'Técnico'
OR puesto = 'Administrativo'
GROUP BY depto_id;
```

Resultado:
```sql
empresa2=# SELECT depto_id,
empresa2-#     COUNT(*) AS numero_empleados,
empresa2-#     ROUND(AVG(salario + COALESCE(comision, 0)), 3) AS salario_medio
empresa2-# FROM empleado
empresa2-# WHERE puesto = 'Técnico'
empresa2-# OR puesto = 'Administrativo'
empresa2-# GROUP BY depto_id;
 depto_id | numero_empleados | salario_medio
----------+------------------+---------------
      100 |                2 |      4150.000
      112 |                6 |      3583.333
      120 |                1 |      2700.000
      121 |                4 |      3100.000
(4 filas)
```

## Ejercicio 5
**Mostrar el número de empleados, el mínimo y el máximo salario de los empleados que han ingresado en la compañía organizados por año.**

```sql
SELECT
    EXTRACT(YEAR FROM fecha_ing) AS año_ingreso,
    COUNT(*) AS numero_empleados,
    MAX(salario + COALESCE(comision, 0)) AS salario_maximo,
    MIN(salario + COALESCE(comision, 0)) AS salario_minimo
FROM empleado
GROUP BY depto_id, año_ingreso
ORDER BY EXTRACT(YEAR FROM fecha_ing) DESC;
```

Resultado:
```sql
empresa2=# SELECT
empresa2-#     EXTRACT(YEAR FROM fecha_ing) AS año_ingreso,
empresa2-#     COUNT(*) AS numero_empleados,
empresa2-#     MAX(salario + COALESCE(comision, 0)) AS salario_maximo,
empresa2-#     MIN(salario + COALESCE(comision, 0)) AS salario_minimo
empresa2-# FROM empleado
empresa2-# GROUP BY depto_id, año_ingreso
empresa2-# ORDER BY EXTRACT(YEAR FROM fecha_ing) DESC;
 año_ingreso | numero_empleados | salario_maximo | salario_minimo
-------------+------------------+----------------+----------------
        1998 |                1 |           4000 |           4000
        1998 |                3 |           4050 |           1750
        1998 |                2 |           2800 |           1800
        1998 |                2 |           3500 |           2200
-- Más --
        1979 |                1 |           3800 |           3800
        1976 |                1 |           5300 |           5300
        1970 |                1 |           3100 |           3100
        1968 |                1 |           4400 |           4400
(26 filas)
```

## Ejercicio 6
**Confeccionar una lista que muestre los códigos de los departamentos que tienen mas de 5 empleados.**

```sql
SELECT depto_id,
    COUNT(*) as numero_empleados
FROM empleado
GROUP BY depto_id
HAVING COUNT(*) > 5;
```

Resultado:
```sql
empresa2=# SELECT depto_id,
empresa2-#     COUNT(*) as numero_empleados
empresa2-# FROM empleado
empresa2-# GROUP BY depto_id
empresa2-# HAVING COUNT(*) > 5;
 depto_id | numero_empleados
----------+------------------
      112 |                7
      111 |                8
(2 filas)

```

## Ejercicio 7
**Mostrar los puestos que tienen un salario medio entre 3000 y 5000 y lo tienen mas de 3 empleados.**

```sql
SELECT depto_id,
    COUNT(*) as numero_empleados,
    ROUND(AVG(salario + COALESCE(comision, 0)), 3) AS salario_medio
FROM empleado
WHERE (salario + COALESCE(comision, 0))BETWEEN 3000 AND 5000
GROUP BY depto_id
HAVING COUNT(*) > 3;
```

Resultado:
```sql
empresa2=# SELECT depto_id,
empresa2-#     COUNT(*) as numero_empleados,
empresa2-#     ROUND(AVG(salario + COALESCE(comision, 0)), 3) AS salario_medio
empresa2-# FROM empleado
empresa2-# WHERE (salario + COALESCE(comision, 0))BETWEEN 3000 AND 5000
empresa2-# GROUP BY depto_id
empresa2-# HAVING COUNT(*) > 3;
 depto_id | numero_empleados | salario_medio
----------+------------------+---------------
      111 |                6 |      3450.000
      112 |                5 |      4000.000
(2 filas)
```

## Ejercicio 8
**Realizar un informe que muestre el número de directores en funciones por cada centro de trabajo.**

```sql
SELECT
    COUNT(*) as numero_direcctores,
    tipo_director,
    centro_id
FROM departamento
WHERE tipo_director = 'F'
GROUP BY tipo_director, centro_id
ORDER BY centro_id;
```

Resultado:
```sql
empresa2=# SELECT COUNT(*) as numero_direcctores,
empresa2-#     tipo_director,
empresa2-#     centro_id
empresa2-# FROM departamento
empresa2-# WHERE tipo_director = 'F'
empresa2-# GROUP BY tipo_director, centro_id
empresa2-# ORDER BY centro_id;
 numero_direcctores | tipo_director | centro_id
--------------------+---------------+-----------
                  1 | F             |        10
                  1 | F             |        20
(2 filas)
```

## Ejercicio 9
**Número de departamentos que dependen de otros por cada centro de trabajo. El resultado debe mostrar también los totales por centro y departamento.**   

>Lo que he entendido es que aparezcan cuántos departamentos depende de otro, mirando la tabla `departamento` y sus comentarios y la Base de Datos, hay uno por departamento. Además de los totales por cada uno, que sigue siendo 1, añado la suma total por centro y suma de los dos. Ordenados por número de centro.

```sql
SELECT centro_id,
    id,
    COUNT(depto_id_superior) as num_depto_dependiente,
    COUNT(*) as num_depto_por_centro
FROM departamento
GROUP BY ROLLUP(centro_id, id)
ORDER BY centro_id;
```

Resultado:
```sql
empresa2=# SELECT centro_id,
empresa2-#     id,
empresa2-#     COUNT(depto_id_superior) as num_depto_dependiente,
empresa2-#     COUNT(*) as num_depto_por_centro
empresa2-# FROM departamento
empresa2-# GROUP BY ROLLUP(centro_id, id)
empresa2-# ORDER BY centro_id;
 centro_id | id  | num_depto_dependiente | num_depto_por_centro
-----------+-----+-----------------------+----------------------
        10 | 100 |                     0 |                    1
        10 | 120 |                     1 |                    1
        10 | 121 |                     1 |                    1
        10 | 122 |                     1 |                    1
        10 | 130 |                     1 |                    1
        10 |     |                     4 |                    5
        20 | 110 |                     1 |                    1
        20 | 111 |                     1 |                    1
        20 | 112 |                     1 |                    1
        20 |     |                     3 |                    3
           |     |                     7 |                    8
(11 filas)
```




