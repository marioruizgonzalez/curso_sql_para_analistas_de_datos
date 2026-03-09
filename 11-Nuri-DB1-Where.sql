--Comparación básica (=, <>, >, <, >=, <=)

SELECT id_empleado, nombre, apellido, id_departamento
FROM empleados
WHERE id_departamento = 30;


SELECT id_empleado, nombre, apellido, id_departamento
FROM empleados
WHERE id_departamento <> 30;


SELECT id_empleado, nombre, apellido, salario
FROM empleados
WHERE salario > 10000;


SELECT id_empleado, nombre, apellido, salario
FROM empleados
WHERE salario < 4000;


SELECT id_empleado, nombre, apellido, salario
FROM empleados
WHERE salario >= 9500;


SELECT id_empleado, nombre, apellido, salario
FROM empleados
WHERE salario <= 3800;


--Operadores lógicos (AND / OR / NOT) + precedencia + paréntesis

SELECT id_empleado, nombre, apellido, salario, id_departamento
FROM empleados
WHERE id_departamento = 20
  AND salario >= 4000
  AND salario <= 12000;


SELECT id_empleado, nombre, apellido, id_departamento
FROM empleados
WHERE id_departamento = 10
   OR id_departamento = 20
   OR id_departamento = 30;


SELECT id_empleado, nombre, apellido, id_puesto
FROM empleados
WHERE NOT id_puesto = 'SAL_REP';


SELECT id_empleado, nombre, apellido, id_departamento, salario
FROM empleados
WHERE (id_departamento = 20 OR id_departamento = 30)
  AND salario > 5000;


--Rangos (BETWEEN / NOT BETWEEN)

SELECT id_empleado, nombre, apellido, salario
FROM empleados
WHERE salario BETWEEN 3500 AND 5200;


SELECT id_empleado, nombre, apellido, salario
FROM empleados
WHERE salario NOT BETWEEN 5000 AND 10000;


--Conjuntos (IN / NOT IN) + IN(subquery) + diferencia conceptual con =

SELECT id_empleado, nombre, apellido, id_departamento
FROM empleados
WHERE id_departamento IN (10, 20, 30);


SELECT id_empleado, nombre, apellido, id_departamento
FROM empleados
WHERE id_departamento NOT IN (40, 50);


SELECT id_empleado, nombre, apellido, id_puesto
FROM empleados
WHERE id_puesto IN (
  SELECT id_puesto
  FROM puestos
  WHERE id_puesto IN ('DA_SNR', 'DA_JR', 'DS_JR')
);


--Valores nulos (IS NULL / IS NOT NULL) + por qué = NULL no funciona

SELECT id_empleado, nombre, apellido, id_jefe
FROM empleados
WHERE id_jefe IS NULL;


SELECT id_empleado, nombre, apellido, porcentaje_comision, id_jefe
FROM empleados
WHERE id_jefe IS NOT null
and porcentaje_comision is not NULL;



--Patrones de texto (LIKE / NOT LIKE) con % y _

SELECT id_empleado, nombre, apellido, email
FROM empleados
WHERE email LIKE '%nuri.com';


SELECT id_empleado, nombre, apellido, email
FROM empleados
WHERE email LIKE 'ss@nuri.com';


SELECT id_empleado, nombre, apellido, email
FROM empleados
WHERE email not LIKE 'nuri.com';


SELECT id_pais, nombre_pais
FROM paises
WHERE id_pais LIKE '__';

SELECT id_pais, nombre_pais
FROM paises
WHERE id_pais LIKE '__';




--Comparación con subqueries (= escalar, IN, NOT IN, EXISTS, NOT EXISTS)

SELECT id_empleado, nombre, apellido, id_departamento
FROM empleados
WHERE id_departamento = (
  SELECT id_departamento
  FROM empleados
  WHERE id_empleado = 100
);


SELECT id_empleado, nombre, apellido, id_departamento
FROM empleados
WHERE id_departamento IN (
  SELECT id_departamento
  FROM departamentos
  WHERE id_ubicacion IN (1000, 1001, 1002)
);


SELECT id_empleado, nombre, apellido, id_departamento
FROM empleados
WHERE id_departamento NOT IN (
  SELECT id_departamento
  FROM departamentos
  WHERE id_ubicacion IN (1000, 1001, 1002)
);


SELECT d.id_departamento, d.nombre_departamento
FROM departamentos d
WHERE EXISTS (
						  SELECT 1
						  FROM empleados e
						  WHERE e.id_departamento = d.id_departamento
);


SELECT id_departamento, nombre_departamento
FROM departamentos d
WHERE NOT EXISTS (
  SELECT 1
  FROM empleados e
  WHERE e.id_departamento = d.id_departamento
);
