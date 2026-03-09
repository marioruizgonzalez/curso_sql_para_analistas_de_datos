

UPDATE empleados SET salario = 18000.00 WHERE id_empleado = 100;
UPDATE empleados SET salario = 16000.00 WHERE id_empleado = 101;
UPDATE empleados SET salario = 10000.00 WHERE id_empleado = 102;
UPDATE empleados SET salario = 11000.00 WHERE id_empleado = 110;
UPDATE empleados SET salario = 4200.00  WHERE id_empleado = 111;
UPDATE empleados SET salario = 3800.00  WHERE id_empleado = 112;
UPDATE empleados SET salario = 12000.00 WHERE id_empleado = 120;
UPDATE empleados SET salario = 8200.00  WHERE id_empleado = 121;
UPDATE empleados SET salario = 5200.00  WHERE id_empleado = 122;
UPDATE empleados SET salario = 3500.00  WHERE id_empleado = 123;
UPDATE empleados SET salario = 5600.00  WHERE id_empleado = 124;
UPDATE empleados SET salario = 9500.00  WHERE id_empleado = 130;
UPDATE empleados SET salario = 4800.00  WHERE id_empleado = 131;
UPDATE empleados SET salario = 7800.00  WHERE id_empleado = 140;
UPDATE empleados SET salario = 3800.00  WHERE id_empleado = 141;
UPDATE empleados SET salario = 9800.00  WHERE id_empleado = 150;
UPDATE empleados SET salario = 3500.00  WHERE id_empleado = 151;
UPDATE empleados SET salario = 3200.00  WHERE id_empleado = 152;
UPDATE empleados SET salario = 4200.00  WHERE id_empleado = 160;
UPDATE empleados SET salario = 3600.00  WHERE id_empleado = 170;

  
-- ---------------------------------------------------------
-- 1) COUNT(*) - Total de empleados
-- ---------------------------------------------------------

SELECT *
FROM empleados
where id_empleado >140;

SELECT COUNT(nombre) AS total_empleados
FROM empleados
where id_empleado >140;


-- ---------------------------------------------------------
-- 2) COUNT(columna) - Ignora NULL
-- ---------------------------------------------------------

SELECT porcentaje_comision
FROM empleados;

SELECT COUNT(porcentaje_comision) AS empleados_con_comision
FROM empleados;


-- ---------------------------------------------------------
-- 3) COUNT(DISTINCT)
-- ---------------------------------------------------------

SELECT id_departamento
FROM empleados;

SELECT COUNT(DISTINCT id_departamento) AS departamentos_con_empleados
FROM empleados;


-- ---------------------------------------------------------
-- 4) SUM - Masa salarial total
-- ---------------------------------------------------------

SELECT salario
FROM empleados;

SELECT SUM(salario) AS masa_salarial_total
FROM empleados;


-- ---------------------------------------------------------
-- 5) AVG - Salario promedio general
-- ---------------------------------------------------------

SELECT *
FROM empleados;


SELECT AVG(salario) AS salario_promedio, 45*45 as operacion
FROM empleados;


-- ---------------------------------------------------------
-- 6) MIN - Salario mínimo
-- ---------------------------------------------------------

SELECT salario
FROM empleados;

SELECT MIN(salario) AS salario_minimo
FROM empleados;


-- ---------------------------------------------------------
-- 7) MAX - Salario máximo
-- ---------------------------------------------------------

SELECT salario
FROM empleados;

SELECT MAX(salario) AS salario_maximo
FROM empleados;


-- ---------------------------------------------------------
-- 8) AVG + GROUP BY - Promedio por departamento
-- ---------------------------------------------------------
SELECT id_departamento,
	   salario
FROM empleados;

SELECT id_departamento,
       AVG(salario) AS salario_promedio
FROM empleados
GROUP BY id_departamento;


-- ---------------------------------------------------------
-- 9) Varias agregadas juntas por departamento
-- ---------------------------------------------------------
SELECT id_departamento,
       COUNT(*)      AS total_empleados,
       SUM(salario)  AS masa_salarial,
       AVG(salario)  AS salario_promedio,
       MIN(salario)  AS salario_min,
       MAX(salario)  AS salario_max
FROM empleados
GROUP BY id_departamento;


-- ---------------------------------------------------------
-- 10) COUNT por puesto
-- ---------------------------------------------------------
SELECT id_puesto,
       COUNT(*) AS total_empleados
FROM empleados
GROUP BY id_puesto;
