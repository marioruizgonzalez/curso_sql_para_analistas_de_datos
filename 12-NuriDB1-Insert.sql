select * from empleados;
--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

--Para que sirve?
--Donde lo encontramos?
--Que tan comun es que lo ocupemos? 

-- 1) Qué es INSERT: crear una fila nueva (caso simple)
INSERT INTO empleados (
  id_empleado, nombre, apellido, email, telefono,
  fecha_contratacion, id_puesto, salario, porcentaje_comision,
  id_jefe, id_departamento
) VALUES (
  200, 'Julia', 'Serrano', 'jserrano@nuri.com', '+52 55 9000 0200',
  DATE '2024-06-01', 'DA_JR', 3900.00, NULL,
  121, 30
);

--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

-- 2) Sintaxis mínima obligatoria (misma idea, otra fila)
INSERT INTO empleados (id_empleado, nombre, apellido, email, fecha_contratacion, id_puesto, salario, id_departamento)
VALUES (201, 'Hugo', 'Ríos', 'hrios@nuri.com', DATE '2024-06-10', 'SWE_JR', 4100.00, 20);

--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

-- 3) INSERT sin lista de columnas (NO recomendado)
INSERT INTO regiones 
VALUES (9, 'Región de Prueba');

--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

-- 4) Tipos de valores (literales, NULL, DATE)
INSERT INTO ubicaciones (
  id_ubicacion, direccion, codigo_postal, ciudad, id_pais
) VALUES (
  1800, 'Calle Demo 123', '01010', 'Ciudad Demo', 'MX'
);

--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

-- 5) Columnas NOT NULL: ejemplo que FALLA (apellido es NOT NULL)
INSERT INTO empleados (id_empleado, nombre, apellido, email, fecha_contratacion, id_puesto, salario, id_departamento)
VALUES (202, 'SinApellido', NULL, 'sinapellido@nuri.com', DATE '2024-06-11', 'QA_JR', 3000.00, 20);

-- 6) Constraints: PRIMARY KEY/UNIQUE/CHECK/FK (ejemplos que FALLAN)
INSERT INTO empleados (id_empleado, nombre, apellido, email, fecha_contratacion, id_puesto, salario, id_departamento)
VALUES (203, 'Clon', 'Ruiz', 'mruiz@nuri.com', DATE '2024-06-12', 'DA_JR', 3200.00, 30);

-- 7) CHECK porcentaje_comision entre 0 y 1 (aquí 1.50)
INSERT INTO empleados (
  id_empleado, nombre, apellido, email, fecha_contratacion, id_puesto, salario, porcentaje_comision, id_jefe, id_departamento
) VALUES (
  205, 'Error', 'Comision', 'errorcomision@nuri.com', DATE '2024-06-12', 'SAL_REP', 3000.00, 1.50, 150, 60
);

-- 8) Claves foráneas (FK): ejemplo que FALLA (id_puesto no existe)
INSERT INTO empleados (id_empleado, nombre, apellido, email, fecha_contratacion, id_puesto, salario, id_departamento)
VALUES (206, 'Error', 'FK', 'errorfk@nuri.com', DATE '2024-06-13', 'NO_EXISTE', 3000.00, 20);

--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

-- 9) Insert de varias filas (multi-row insert)
INSERT INTO paises (id_pais, nombre_pais, id_region)
VALUES
  ('ZZ', 'ZetaLand', 1),
  ('YY', 'YpsilonLand', 2);


--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

-- 10) INSERT con subquery (INSERT ... SELECT)
INSERT INTO departamentos (id_departamento, nombre_departamento, id_gerente, id_ubicacion)
SELECT
  d.id_departamento + 1000,
  d.nombre_departamento || ' (Copia)',
  NULL,
  d.id_ubicacion
FROM departamentos d
WHERE d.id_departamento IN (10, 20, 30);


--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

-- 11) Errores comunes: columnas y valores no coinciden (FALLA)

INSERT INTO regiones (id_region, nombre_region)
VALUES (11);

INSERT INTO persona(nombre, edad)
VALUES ('juan', 22, 2000);

insert
	into
	persona
(nombre,
	apellido,
	edad,
	direccion)
values ('juan',
'ruiz',
22,
null);