-- =====================================================
-- 1) Enteros a texto
-- =====================================================
SELECT
  id_empleado,
  id_empleado::TEXT        AS id_empleado_texto,
  id_departamento,
  id_departamento::TEXT    AS id_departamento_texto
FROM vw_empleados_detalle;


-- =====================================================
-- 2) Números a texto 
-- =====================================================
SELECT
  id_empleado,
  nombre,
  apellido,
  salario,
  salario::TEXT                AS salario_texto,
  porcentaje_comision,
  porcentaje_comision::TEXT    AS comision_texto
FROM vw_empleados_detalle;


-- =====================================================
-- 3) Anidado
-- =====================================================

SELECT
  id_empleado,
  nombre,
  apellido,
  salario,
  salario::INTEGER::TEXT AS salario_entero
FROM vw_empleados_detalle;


-- =====================================================
-- 4) Fecha a texto (mostrar fecha como string)
-- =====================================================
SELECT
  id_empleado,
  nombre,
  apellido,
  fecha_contratacion,
  fecha_contratacion::TEXT AS fecha_texto
FROM vw_empleados_detalle;


-- =====================================================
-- 5) Texto a VARCHAR(n)
-- =====================================================
SELECT
  id_empleado,
  CAST(email AS VARCHAR(25))   AS email_varchar_25,
  CAST(telefono AS VARCHAR(20)) AS telefono_varchar_20
FROM vw_empleados_detalle;


-- =====================================================
-- 6) Texto a CHAR(n) (códigos fijos)
-- =====================================================
SELECT
  id_empleado,
  CAST(id_pais AS CHAR(2))   AS id_pais_char2,
  CAST(id_puesto AS CHAR(10)) AS id_puesto_char10
FROM vw_empleados_detalle;


-- =====================================================
-- 7) Texto a NUMERIC
-- =====================================================
SELECT
  id_empleado,
  nombre,
  apellido,
  CAST('5000.00' AS NUMERIC(8,2)) AS umbral_salario
FROM vw_empleados_detalle;


-- =====================================================
-- 8) Texto a DATE 
-- =====================================================
SELECT
  id_empleado,
  nombre,
  apellido,
  CAST(fecha_contratacion::TEXT AS DATE) AS fecha_referencia
FROM vw_empleados_detalle;



