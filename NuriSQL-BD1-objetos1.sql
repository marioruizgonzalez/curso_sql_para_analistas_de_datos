/* VISTA */
CREATE OR REPLACE VIEW vw_empleados_detalle AS
SELECT
  e.id_empleado,
  e.nombre,
  e.apellido,
  e.email,
  e.telefono,
  e.fecha_contratacion,
  e.salario,
  e.porcentaje_comision,

  p.id_puesto,
  p.titulo_puesto,
  p.salario_min,
  p.salario_max,

  d.id_departamento,
  d.nombre_departamento,

  j.id_empleado   AS id_jefe,
  (j.nombre || ' ' || j.apellido) AS nombre_jefe,

  u.id_ubicacion,
  u.direccion,
  u.codigo_postal,
  u.ciudad,
  u.estado_provincia,

  pa.id_pais,
  pa.nombre_pais,

  r.id_region,
  r.nombre_region
FROM empleados e
JOIN puestos p                 ON p.id_puesto = e.id_puesto
LEFT JOIN departamentos d      ON d.id_departamento = e.id_departamento
LEFT JOIN empleados j          ON j.id_empleado = e.id_jefe
LEFT JOIN ubicaciones u        ON u.id_ubicacion = d.id_ubicacion
LEFT JOIN paises pa            ON pa.id_pais = u.id_pais
LEFT JOIN regiones r           ON r.id_region = pa.id_region;



/* VISTA MATERIALIZADA */
CREATE MATERIALIZED VIEW mv_resumen_departamentos AS
SELECT
  d.id_departamento,
  d.nombre_departamento,
  r.nombre_region,
  pa.nombre_pais,
  u.ciudad,

  COUNT(e.id_empleado)                 AS total_empleados,
  ROUND(AVG(e.salario), 2)             AS salario_promedio,
  MIN(e.salario)                       AS salario_min,
  MAX(e.salario)                       AS salario_max
FROM departamentos d
LEFT JOIN empleados e   ON e.id_departamento = d.id_departamento
LEFT JOIN ubicaciones u ON u.id_ubicacion = d.id_ubicacion
LEFT JOIN paises pa     ON pa.id_pais = u.id_pais
LEFT JOIN regiones r    ON r.id_region = pa.id_region
GROUP BY
  d.id_departamento, d.nombre_departamento,
  r.nombre_region, pa.nombre_pais, u.ciudad;



/*  FUNCIÓN  */
CREATE OR REPLACE FUNCTION fn_antiguedad_empleado(p_id_empleado INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
  v_fecha DATE;
BEGIN
  SELECT e.fecha_contratacion
    INTO v_fecha
  FROM empleados e
  WHERE e.id_empleado = p_id_empleado;

  IF v_fecha IS NULL THEN
    RETURN NULL;
  END IF;

  RETURN EXTRACT(YEAR FROM age(current_date, v_fecha))::INT;
END;
$$;



/* PROCEDIMIENTO */
CREATE OR REPLACE PROCEDURE sp_cambiar_puesto( 
  p_id_empleado     INTEGER,
  p_nuevo_puesto    VARCHAR(10),
  p_nuevo_depto     INTEGER,
  p_fecha_inicio    DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
  v_existe INTEGER;
BEGIN
  BEGIN
    
    SELECT 1 INTO v_existe FROM empleados WHERE id_empleado = p_id_empleado;
    IF v_existe IS NULL THEN
      RETURN;
    END IF;

    SELECT 1 INTO v_existe FROM puestos WHERE id_puesto = p_nuevo_puesto;
    IF v_existe IS NULL THEN
      RETURN;
    END IF;

    IF p_nuevo_depto IS NOT NULL THEN
      SELECT 1 INTO v_existe FROM departamentos WHERE id_departamento = p_nuevo_depto;
      IF v_existe IS NULL THEN
        RETURN;
      END IF;
    END IF;

    
    UPDATE historial_puestos
       SET fecha_fin = p_fecha_inicio
     WHERE id_empleado = p_id_empleado
       AND fecha_fin = DATE '9999-12-31';

    
    INSERT INTO historial_puestos(
      id_empleado, fecha_inicio, fecha_fin, id_puesto, id_departamento
    )
    VALUES (
      p_id_empleado, p_fecha_inicio, DATE '9999-12-31',
      p_nuevo_puesto, p_nuevo_depto
    );

    
    UPDATE empleados
       SET id_puesto = p_nuevo_puesto,
           id_departamento = p_nuevo_depto
     WHERE id_empleado = p_id_empleado;

  EXCEPTION
    WHEN OTHERS THEN
  
      NULL;
  END;
END;
$$;


/*  TRIGGER  */

-- Tabla de auditoría
CREATE TABLE IF NOT EXISTS auditoria_salarios (
  id_auditoria     BIGSERIAL PRIMARY KEY,
  id_empleado      INTEGER NOT NULL,
  salario_anterior NUMERIC(8,2),
  salario_nuevo    NUMERIC(8,2),
  cambiado_en      TIMESTAMP NOT NULL DEFAULT now(),
  cambiado_por     TEXT NOT NULL DEFAULT current_user
);

--trigger
CREATE OR REPLACE FUNCTION trg_auditar_cambio_salario()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF (NEW.salario IS DISTINCT FROM OLD.salario) THEN
    INSERT INTO auditoria_salarios(id_empleado, salario_anterior, salario_nuevo)
    VALUES (OLD.id_empleado, OLD.salario, NEW.salario);
  END IF;

  RETURN NEW;
END;
$$;

--trigger
CREATE TRIGGER t_auditar_cambio_salario
BEFORE UPDATE OF salario ON empleados
FOR EACH ROW
EXECUTE FUNCTION trg_auditar_cambio_salario();

