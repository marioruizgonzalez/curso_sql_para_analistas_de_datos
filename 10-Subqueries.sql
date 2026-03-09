-- 1) Query simple a una vista materializada

SELECT
  mv.id_departamento,
  mv.nombre_departamento,
  mv.nombre_region,
  mv.nombre_pais,
  mv.ciudad
FROM mv_resumen_departamentos mv;



-- 2) Subuery como columna

SELECT
  mv.id_departamento,
  mv.nombre_departamento,
  (
    SELECT vw.id_jefe
    FROM vw_empleados_detalle vw
    where vw.id_jefe is not null
    limit 1
  ) AS id_jefe_del_departamento
FROM mv_resumen_departamentos mv;



-- 3) Subquery como tabla (FROM)

SELECT
  t.id_departamento,
  t.nombre_departamento,
  t.nombre_pais,
  t.ciudad
FROM (
		  SELECT
		    id_departamento,
		    nombre_departamento,
		    nombre_pais,
		    ciudad
		  FROM mv_resumen_departamentos
) t;



-- 4) Subquery en las condicion (WHERE)

SELECT
  id_departamento,
  nombre_departamento,
  nombre_region,
  nombre_pais,
  ciudad
FROM mv_resumen_departamentos
WHERE id_departamento IN (
						  SELECT distinct id_departamento
						  FROM vw_empleados_detalle
						);



-- 5) Query a una vista materializada

SELECT
  id_departamento,
  nombre_departamento,
  nombre_region,
  nombre_pais,
  ciudad
FROM mv_resumen_departamentos
WHERE id_departamento IN (
					  SELECT id_departamento
					  FROM vw_empleados_detalle
					  WHERE id_pais IN (
										    SELECT id_pais
										    FROM vw_empleados_detalle
										  )
) and id_departamento IN (
					  SELECT id_departamento
					  FROM vw_empleados_detalle
					  WHERE id_pais IN (
										    SELECT id_pais
										    FROM vw_empleados_detalle
										  )
);
