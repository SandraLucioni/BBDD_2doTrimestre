# Ejercicios SELECT unitabla. Hoja 1

## Creación de la BD empresa

    CREATE DATABASE empresa OWNER dbo_daw1_a;

## Definición de la tabla empleado

```
empresa=> \d empleado
                                Table "public.empleado"
            Column             |         Type          | Collation | Nullable | Default 
-------------------------------+-----------------------+-----------+----------+---------
 codigo_empleado               | integer               |           | not null | 
 codigo_departamento           | integer               |           | not null | 
 extension_telefonica_empleado | smallint              |           | not null | 
 fecha_nacimiento_empleado     | date                  |           | not null | 
 fecha_ingreso_empleado        | date                  |           | not null | 
 salario_base_empleado         | numeric               |           | not null | 
 comision_empleado             | numeric               |           |          | 
 numero_hijos_empleado         | smallint              |           | not null | 
 nombre_empleado               | character varying(16) |           | not null | 
Indexes:
    "empleado_pkey" PRIMARY KEY, btree (codigo_empleado)
Foreign-key constraints:
    "trabaja_en" FOREIGN KEY (codigo_departamento) REFERENCES departamento(codigo_departamento) ON UPDATE CASCADE ON DELETE CASCADE
```



## Ejercicio 1
Mostrar toda la información de la tabla `empleado`.

```sql
SELECT * FROM empleado;
```
Resultado:
```
empresa=> select * from empleado;

 codigo_empleado | codigo_departamento | extension_telefonica_empleado | fecha_nacimiento_empleado | fecha_ingreso_empleado | salario_base_empleado | comision_empleado | numero_hijos_empleado | nombre_empleado  
-----------------+---------------------+-------------------------------+---------------------------+------------------------+-----------------------+-------------------+-----------------------+------------------
             110 |                 121 |                           350 | 1949-10-11                | 1970-02-15             |                  3100 |                   |                     3 | PONS, CESAR
             120 |                 112 |                           840 | 1955-06-09                | 1988-10-01             |                  3500 |              1100 |                     1 | LASA, MARIO
(... últimas 2 líneas)
             550 |                 111 |                           780 | 1980-01-10                | 1998-01-21             |                  1000 |              1200 |                     0 | SANTOS, SANCHO
(34 rows)
```

## Ejercicio 2


