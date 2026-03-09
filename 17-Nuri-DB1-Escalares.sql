
-- ---------------------------------------------------------
-- Funciones escalares para limpieza de datos
-- Base 1 Nuri Data Science
-- Curso "SQL para analistas de datos"
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 1) UPPER / LOWER - Normalizar capitalización
-- ---------------------------------------------------------

SELECT nombre, apellido
FROM empleados;

SELECT UPPER(nombre)    AS nombre_mayus,
       LOWER(apellido)  AS apellido_minus
FROM empleados;


-- ---------------------------------------------------------
-- 2) TRIM - Eliminar espacios al inicio y al final
-- ---------------------------------------------------------

SELECT email
FROM empleados;

SELECT TRIM(email) AS email_limpio
FROM empleados;


-- ---------------------------------------------------------
-- 3) LTRIM / RTRIM - Eliminar espacios solo a un lado
-- ---------------------------------------------------------

SELECT LTRIM(email) AS sin_espacios_izq,
       RTRIM(email) AS sin_espacios_der
FROM empleados;


-- ---------------------------------------------------------
-- 4) LENGTH - Medir longitud de un texto
-- ---------------------------------------------------------

SELECT nombre, apellido
FROM empleados;

SELECT nombre,
       apellido,
       LENGTH(nombre)   AS largo_nombre,
       LENGTH(apellido) AS largo_apellido
FROM empleados;


-- ---------------------------------------------------------
-- 5) CONCAT - Unir columnas de texto
-- ---------------------------------------------------------

SELECT nombre, apellido
FROM empleados;

SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo
FROM empleados;


-- ---------------------------------------------------------
-- 6) REPLACE - Reemplazar parte de un texto
-- ---------------------------------------------------------

SELECT telefono
FROM empleados;

SELECT telefono,
       REPLACE(telefono, ' ', '') AS telefono_sin_espacios
FROM empleados;


-- ---------------------------------------------------------
-- 7) SUBSTRING - Extraer parte de un texto
-- ---------------------------------------------------------

SELECT email
FROM empleados;

SELECT email,
       SUBSTRING(email FROM 1 FOR 5) AS primeros_5
FROM empleados;


-- ---------------------------------------------------------
-- 8) LEFT / RIGHT - Extraer caracteres desde un extremo
-- ---------------------------------------------------------

SELECT email
FROM empleados;

SELECT email,
       LEFT(email, 5)  AS inicio_email,
       RIGHT(email, 8) AS dominio_aprox
FROM empleados;


-- ---------------------------------------------------------
-- 9) POSITION / STRPOS - Encontrar posición de un carácter
-- ---------------------------------------------------------

SELECT email
FROM empleados;

SELECT email,
       STRPOS(email, '@') AS posicion_arroba
FROM empleados;


-- ---------------------------------------------------------
-- 10) ROUND - Redondear números decimales
-- ---------------------------------------------------------

SELECT salario
FROM empleados;

SELECT salario,
       ROUND(salario, 0) AS salario_redondeado
FROM empleados;


-- ---------------------------------------------------------
-- 11) CEIL / FLOOR - Redondear hacia arriba o abajo
-- ---------------------------------------------------------

SELECT salario
FROM empleados;

SELECT salario,
       CEIL(salario / 1000.0)  AS miles_arriba,
       FLOOR(salario / 1000.0) AS miles_abajo
FROM empleados;


-- ---------------------------------------------------------
-- 12) ABS - Valor absoluto (útil para diferencias)
-- ---------------------------------------------------------

SELECT id_empleado,
       salario,
       salario_min,
       salario_max
FROM empleados
JOIN puestos USING (id_puesto);

SELECT id_empleado,
       salario,
       salario_min,
       ABS(salario - salario_min) AS diferencia_al_minimo
FROM empleados
JOIN puestos USING (id_puesto);


-- ---------------------------------------------------------
-- 13) COALESCE - Reemplazar valores NULL
-- ---------------------------------------------------------

SELECT id_empleado, porcentaje_comision
FROM empleados;

SELECT id_empleado,
       COALESCE(porcentaje_comision, 0) AS comision
FROM empleados;


-- ---------------------------------------------------------
-- 14) NULLIF - Convertir un valor específico en NULL
-- ---------------------------------------------------------

SELECT id_empleado,
       NULLIF(porcentaje_comision, 0) AS comision_real
FROM empleados;


-- ---------------------------------------------------------
-- 15) CAST - Convertir tipo de dato
-- ---------------------------------------------------------

SELECT id_empleado, salario
FROM empleados;

SELECT id_empleado,
       CAST(salario AS INTEGER)    AS salario_entero,
       CAST(id_empleado AS TEXT)   AS id_como_texto
FROM empleados;


-- ---------------------------------------------------------
-- 16) TO_CHAR - Formatear número o fecha como texto
-- ---------------------------------------------------------

SELECT salario, fecha_contratacion
FROM empleados;

SELECT salario,
       TO_CHAR(salario, 'FM$999,999.00')    AS salario_formato,
       TO_CHAR(fecha_contratacion, 'DD/MM/YYYY') AS fecha_formato
FROM empleados;


-- ---------------------------------------------------------
-- 17) EXTRACT - Extraer partes de una fecha
-- ---------------------------------------------------------

SELECT fecha_contratacion
FROM empleados;

SELECT fecha_contratacion,
       EXTRACT(YEAR  FROM fecha_contratacion) AS anio,
       EXTRACT(MONTH FROM fecha_contratacion) AS mes,
       EXTRACT(DAY   FROM fecha_contratacion) AS dia
FROM empleados;


-- ---------------------------------------------------------
-- 18) AGE - Calcular tiempo transcurrido
-- ---------------------------------------------------------

SELECT id_empleado, fecha_contratacion
FROM empleados;

SELECT id_empleado,
       fecha_contratacion,
       AGE(CURRENT_DATE, fecha_contratacion) AS antiguedad
FROM empleados;


-- ---------------------------------------------------------
-- 19) CURRENT_DATE / NOW - Fecha y hora actual
-- ---------------------------------------------------------

SELECT id_empleado,
       fecha_contratacion,
       CURRENT_DATE AS hoy,
       CURRENT_DATE - fecha_contratacion AS dias_trabajados
FROM empleados;


-- ---------------------------------------------------------
-- 20) CASE - Clasificar valores con lógica condicional
-- ---------------------------------------------------------

SELECT id_empleado, salario
FROM empleados;

SELECT id_empleado,
       salario,
       CASE
         WHEN salario >= 10000 THEN 'Alto'
         WHEN salario >=  5000 THEN 'Medio'
         ELSE                       'Bajo'
       END AS rango_salarial
FROM empleados;
