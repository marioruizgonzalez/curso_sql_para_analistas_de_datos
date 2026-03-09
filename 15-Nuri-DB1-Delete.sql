
-- ---------------------------------------------------------
-- EJEMPLO 1: DELETE simple con WHERE (con verificación)
-- ---------------------------------------------------------
SELECT id_empleado, nombre, apellido
FROM empleados
WHERE id_empleado = 170;

DELETE FROM empleados
WHERE id_empleado = 170;

SELECT id_empleado, nombre, apellido
FROM empleados
WHERE id_empleado = 170;


-- ---------------------------------------------------------
-- EJEMPLO 2: DELETE con IN
-- Eliminar empleados con ciertos puestos
-- ---------------------------------------------------------
SELECT id_empleado, nombre, id_puesto
FROM empleados
WHERE id_puesto IN ('DA_JR', 'DS_JR');

DELETE FROM empleados
WHERE id_puesto IN ('DA_JR', 'DS_JR');


-- ---------------------------------------------------------
-- EJEMPLO 3: DELETE con rango (BETWEEN)
-- ---------------------------------------------------------
SELECT id_empleado, nombre, salario
FROM empleados
WHERE salario < 3500;

DELETE FROM empleados
WHERE salario < 3500;


-- ---------------------------------------------------------
-- EJEMPLO 4: DELETE con IS NULL
-- ---------------------------------------------------------
SELECT id_empleado, nombre, id_jefe
FROM empleados
WHERE id_jefe IS NULL;

DELETE FROM empleados
WHERE id_jefe IS NULL;


-- ---------------------------------------------------------
-- EJEMPLO 5: DELETE con subquery (IN)
-- ---------------------------------------------------------
SELECT id_empleado, nombre
FROM empleados
WHERE id_empleado IN (
  SELECT id_empleado
  FROM historial_puestos
);

DELETE FROM empleados
WHERE id_empleado IN (
  SELECT id_empleado
  FROM historial_puestos
);


-- ---------------------------------------------------------
-- EJEMPLO 6: DELETE con NOT EXISTS
-- Eliminar departamentos sin empleados
-- ---------------------------------------------------------
SELECT id_departamento, nombre_departamento
FROM departamentos d
WHERE NOT EXISTS (
  SELECT 1
  FROM empleados e
  WHERE e.id_departamento = d.id_departamento
);

DELETE FROM departamentos d
WHERE NOT EXISTS (
  SELECT 1
  FROM empleados e
  WHERE e.id_departamento = d.id_departamento
);





-- ---------------------------------------------------------
-- EJEMPLO 7: DELETE SIN WHERE (PELIGRO)
-- NO ejecutar en entorno real sin intención clara
-- ---------------------------------------------------------
DELETE FROM empleados;



