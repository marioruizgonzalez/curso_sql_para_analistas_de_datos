--query implicito 

SELECT * FROM empleados;

--query explicito

select
	id_empleado,
	nombre,
	apellido,
	email
from
	empleados
limit 2;

--::::::::::::::::::::::::::::::::::::::::::::::::::::

--uso del alias

SELECT 'hola mundo' as "saludo"
FROM empleados;

SELECT
   nombre as "usuario",
   telefono as "contacto",
   2+4 as "operacion"
FROM empleados;

--::::::::::::::::::::::::::::::::::::::::::::::::::::

--uso del where... Proximo capitulo

SELECT *
FROM empleados
LIMIT 10;

SELECT id_empleado, nombre, apellido, id_departamento
FROM empleados
WHERE id_departamento = 30;

--::::::::::::::::::::::::::::::::::::::::::::::::::::

--uso del order by 

SELECT *
FROM empleados
LIMIT 10;

SELECT id_empleado, nombre, apellido, salario
FROM empleados
ORDER BY salario DESC;

SELECT id_empleado, apellido, nombre
FROM empleados
ORDER BY apellido ASC;

--::::::::::::::::::::::::::::::::::::::::::::::::::::

--uso del distinct 

SELECT *
FROM empleados;

SELECT DISTINCT id_jefe
FROM empleados;

SELECT DISTINCT id_departamento
FROM empleados
ORDER BY id_departamento;

--::::::::::::::::::::::::::::::::::::::::::::::::::::

--concatenacion basica

SELECT *
FROM empleados;

SELECT
  id_empleado, 
   nombre || ' ' || apellido || ' ' || nombre AS nombre_completo
FROM empleados;

--::::::::::::::::::::::::::::::::::::::::::::::::::::

--uso del case

SELECT *
FROM empleados
LIMIT 10;

SELECT
  id_empleado,
  nombre,
  apellido,
  salario,
  CASE
    WHEN salario >= 10000 THEN 'Alta'
    WHEN salario >= 5000  THEN 'Media'
    ELSE 'Baja'
  END AS banda_salarial_case,
  CASE
    WHEN (id_jefe is null) THEN 'jefe'
    WHEN (id_jefe is not null)  THEN 'empleado'
    ELSE 'Nada'
  END AS puesto_case
FROM empleados;

--::::::::::::::::::::::::::::::::::::::::::::::::::::

--ejemplo de group by / having 

SELECT *
FROM empleados;

SELECT count(*)
FROM empleados;

SELECT
  id_departamento as grupo,
  COUNT(*) AS total_empleados_en_el_grupo
FROM empleados
GROUP BY id_departamento
having COUNT(*)=2;

SELECT
  id_departamento,
  COUNT(*) AS total_empleados
FROM empleados
GROUP BY id_departamento
HAVING COUNT(*) = 5;



