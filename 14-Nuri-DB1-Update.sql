
-- ---------------------------------------------------------
-- EJEMPLO 1: UPDATE simple de una columna (con verificación)
-- ---------------------------------------------------------
SELECT id_empleado, nombre, telefono
FROM empleados
WHERE id_empleado = 123;

UPDATE empleados
SET telefono = '+54 11 9999 9999'
WHERE id_empleado = 123;

SELECT id_empleado, nombre, telefono
FROM empleados
WHERE id_empleado = 123;


-- ---------------------------------------------------------
-- EJEMPLO 2: UPDATE de varias columnas
-- ---------------------------------------------------------

SELECT id_empleado, nombre, telefono, salario, id_puesto
FROM empleados
WHERE id_empleado = 123;

UPDATE empleados
SET id_puesto = 'DA_SNR',
    salario   = 8500.00
WHERE id_empleado = 123;

-- ---------------------------------------------------------
-- EJEMPLO 3: UPDATE con IN
-- ---------------------------------------------------------

SELECT id_empleado, nombre, telefono, id_departamento
FROM empleados;

UPDATE empleados
SET id_departamento = 30
WHERE id_empleado IN (122, 123, 124);

SELECT id_empleado, nombre, telefono
FROM empleados
WHERE id_empleado IN (122, 123, 124);

-- ---------------------------------------------------------
-- EJEMPLO 4: UPDATE con IS NULL (2 condiciones)
-- ---------------------------------------------------------

SELECT *
FROM empleados;

UPDATE empleados
SET id_jefe = 120
WHERE id_jefe IS NULL
  AND id_departamento = 10;
  
SELECT *
FROM empleados;

-- ---------------------------------------------------------
-- EJEMPLO 5: UPDATE usando subquery (correlacionado + LIMIT)
-- ---------------------------------------------------------

SELECT *
FROM empleados;

UPDATE empleados
SET id_departamento = (
					  SELECT hp.id_departamento
					  FROM historial_puestos hp
					  WHERE hp.id_empleado = empleados.id_empleado
					  ORDER BY hp.fecha_inicio DESC
					  LIMIT 1
					)
WHERE id_empleado IN (
					  SELECT id_empleado
					  FROM historial_puestos
					);

SELECT *
FROM empleados;

-- ---------------------------------------------------------
-- EJEMPLO 6: UPDATE asignando NULL
-- ---------------------------------------------------------

SELECT *
FROM empleados
WHERE id_puesto NOT IN ('SAL_REP', 'SAL_MGR');

UPDATE empleados
SET porcentaje_comision = null
WHERE id_puesto NOT IN ('SAL_REP', 'SAL_MGR');

-- ---------------------------------------------------------
-- EJEMPLO 7: Patrón recomendado SELECT -> UPDATE -> SELECT
-- ---------------------------------------------------------

UPDATE empleados
SET salario = 3000;

SELECT *
FROM empleados;








