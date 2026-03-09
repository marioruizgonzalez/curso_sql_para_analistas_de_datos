


/* CONSULTAR LA VISTA */

-- a) Ver 20 filas
SELECT *
FROM vw_empleados_detalle
LIMIT 20;

-- b) Filtrar por región / país / ciudad (ejemplo)
SELECT
  id_empleado, nombre, apellido, titulo_puesto,
  nombre_departamento, nombre_pais, ciudad, nombre_region,
  salario
FROM vw_empleados_detalle
WHERE nombre_region = 'Latinoamérica Andina' 
ORDER BY salario DESC NULLS LAST
LIMIT 20;

-- c) Jefe específico
SELECT
  id_empleado, nombre || ' ' || apellido AS empleado,
  nombre_jefe, nombre_departamento
FROM vw_empleados_detalle
WHERE id_jefe IS NOT NULL
ORDER BY nombre_jefe, empleado
LIMIT 30;



/* CONSULTAR LA VISTA MATERIALIZADA */

-- a) Ver resumen
SELECT *
FROM mv_resumen_departamentos
ORDER BY total_empleados DESC, salario_promedio DESC NULLS LAST;

-- b) Un departamento
SELECT *
FROM mv_resumen_departamentos
WHERE id_departamento = 60;   

-- c) Refrescar MV (bloque simple)
REFRESH MATERIALIZED VIEW mv_resumen_departamentos;





/*  PROBAR LA FUNCIÓN  */

-- a) Llamada directa (devuelve años de antigüedad)
SELECT fn_antiguedad_empleado(101) AS antiguedad_anios;

-- b) Para varios empleados
SELECT
  e.id_empleado,
  e.nombre,
  e.apellido,
  e.fecha_contratacion,
  fn_antiguedad_empleado(e.id_empleado) AS antiguedad_anios
FROM empleados e
ORDER BY antiguedad_anios DESC NULLS LAST
LIMIT 20;



/*  EJECUTAR EL PROCEDIMIENTO */


-- a) Ejecutar (CALL)
CALL sp_cambiar_puesto(
  101,         -- p_id_empleado
  'CTO',   -- p_nuevo_puesto (debe existir en puestos)
  60,          -- p_nuevo_depto  (debe existir en departamentos o NULL)
  CURRENT_DATE -- p_fecha_inicio
);

-- b) Ver cómo quedó el empleado
SELECT
  id_empleado, nombre, apellido, id_puesto, id_departamento
FROM empleados
WHERE id_empleado = 101;

-- c) Ver historial del empleado
SELECT
  id_empleado, fecha_inicio, fecha_fin, id_puesto, id_departamento
FROM historial_puestos
WHERE id_empleado = 101
ORDER BY fecha_inicio DESC;


/*  TRIGGER (auditoría de salario)  */

-- a) Ver salario antes
SELECT id_empleado, salario
FROM empleados
WHERE id_empleado = 101;

-- b) Update que dispara el trigger
UPDATE empleados
SET salario = COALESCE(salario, 0) + 1000
WHERE id_empleado = 101;

-- c) Ver auditoría generada por el trigger
SELECT
  id_auditoria,
  id_empleado,
  salario_anterior,
  salario_nuevo,
  cambiado_en,
  cambiado_por
FROM auditoria_salarios
WHERE id_empleado = 101
ORDER BY cambiado_en DESC;


