-- =========================================================
-- Base 1 Nuri Data Science
-- Curso "SQL para analistas de datos"
-- =========================================================

-- 1) TABLAS BASE

-- REGIONES
CREATE TABLE regiones (
  id_region    INTEGER PRIMARY KEY,
  nombre_region VARCHAR(25)
);

-- PAISES
CREATE TABLE paises (
  id_pais      CHAR(2) PRIMARY KEY,
  nombre_pais  VARCHAR(40),
  id_region    INTEGER REFERENCES regiones(id_region)
);

-- UBICACIONES
CREATE TABLE ubicaciones (
  id_ubicacion     INTEGER PRIMARY KEY,
  direccion        VARCHAR(40),
  codigo_postal    VARCHAR(12),
  ciudad           VARCHAR(30) NOT NULL,
  estado_provincia VARCHAR(25),
  id_pais          CHAR(2) REFERENCES paises(id_pais)
);

-- DEPARTAMENTOS
CREATE TABLE departamentos (
  id_departamento     INTEGER PRIMARY KEY,
  nombre_departamento VARCHAR(30) NOT NULL,
  id_gerente          INTEGER,
  id_ubicacion        INTEGER REFERENCES ubicaciones(id_ubicacion)
);

-- PUESTOS
CREATE TABLE puestos (
  id_puesto     VARCHAR(10) PRIMARY KEY,
  titulo_puesto VARCHAR(35) NOT NULL,
  salario_min   INTEGER,
  salario_max   INTEGER
);

-- EMPLEADOS
CREATE TABLE empleados (
  id_empleado      INTEGER PRIMARY KEY,
  nombre           VARCHAR(20),
  apellido         VARCHAR(25) NOT NULL,
  email            VARCHAR(25) NOT NULL UNIQUE,
  telefono         VARCHAR(20),
  fecha_contratacion DATE NOT NULL,
  id_puesto        VARCHAR(10) NOT NULL REFERENCES puestos(id_puesto),
  salario          NUMERIC(8,2),
  porcentaje_comision NUMERIC(4,2),
  id_jefe          INTEGER REFERENCES empleados(id_empleado),
  id_departamento  INTEGER REFERENCES departamentos(id_departamento),

  CONSTRAINT chk_empleados_salario
    CHECK (salario IS NULL OR salario > 0),

  CONSTRAINT chk_empleados_comision
    CHECK (
      porcentaje_comision IS NULL
      OR (porcentaje_comision >= 0 AND porcentaje_comision <= 1)
    )
);

-- HISTORIAL DE PUESTOS
CREATE TABLE historial_puestos (
  id_empleado      INTEGER NOT NULL REFERENCES empleados(id_empleado),
  fecha_inicio     DATE NOT NULL,
  fecha_fin        DATE NOT NULL,
  id_puesto        VARCHAR(10) NOT NULL REFERENCES puestos(id_puesto),
  id_departamento  INTEGER REFERENCES departamentos(id_departamento),

  CONSTRAINT pk_historial_puestos
    PRIMARY KEY (id_empleado, fecha_inicio),

  CONSTRAINT chk_historial_fechas
    CHECK (fecha_fin > fecha_inicio)
);


ALTER TABLE departamentos
  ADD CONSTRAINT fk_departamentos_gerente
  FOREIGN KEY (id_gerente) REFERENCES empleados(id_empleado);

-- 3) ÍNDICES ÚTILES (para prácticas SQL)

CREATE INDEX idx_empleados_id_departamento ON empleados(id_departamento);
CREATE INDEX idx_empleados_id_puesto       ON empleados(id_puesto);
CREATE INDEX idx_empleados_id_jefe         ON empleados(id_jefe);

CREATE INDEX idx_departamentos_id_ubicacion ON departamentos(id_ubicacion);

CREATE INDEX idx_ubicaciones_id_pais ON ubicaciones(id_pais);

CREATE INDEX idx_paises_id_region ON paises(id_region);

CREATE INDEX idx_historial_id_puesto       ON historial_puestos(id_puesto);
CREATE INDEX idx_historial_id_departamento ON historial_puestos(id_departamento);

-- =========================================================
-- Datos HR "LatAm" para PostgreSQL (sin schema)
-- Orden de carga: regiones -> paises -> ubicaciones -> puestos
--               -> departamentos -> empleados -> historial_puestos
-- =========================================================

-- REGIONES
INSERT INTO regiones (id_region, nombre_region) VALUES
  (1, 'Latinoamérica Norte'),
  (2, 'Latinoamérica Andina'),
  (3, 'Latinoamérica Cono Sur'),
  (4, 'Caribe');

-- PAISES
INSERT INTO paises (id_pais, nombre_pais, id_region) VALUES
  ('MX', 'México', 1),
  ('GT', 'Guatemala', 1),
  ('SV', 'El Salvador', 1),
  ('HN', 'Honduras', 1),
  ('CR', 'Costa Rica', 1),
  ('PA', 'Panamá', 1),

  ('CO', 'Colombia', 2),
  ('PE', 'Perú', 2),
  ('EC', 'Ecuador', 2),
  ('BO', 'Bolivia', 2),

  ('CL', 'Chile', 3),
  ('AR', 'Argentina', 3),
  ('UY', 'Uruguay', 3),
  ('PY', 'Paraguay', 3),

  ('DO', 'República Dominicana', 4),
  ('PR', 'Puerto Rico', 4);

-- UBICACIONES
INSERT INTO ubicaciones (id_ubicacion, direccion, codigo_postal, ciudad, estado_provincia, id_pais) VALUES
  (1000, 'Av. Reforma 250',           '06600', 'Ciudad de México', 'CDMX', 'MX'),
  (1001, 'Blvd. Kukulkán Km 9.5',     '77500', 'Cancún',          'Quintana Roo', 'MX'),
  (1002, 'Av. Chapultepec 120',       '44100', 'Guadalajara',     'Jalisco', 'MX'),

  (1100, 'Calle 26 # 69-76',          '111071','Bogotá',          'Cundinamarca', 'CO'),
  (1101, 'Av. El Poblado 100',        '050021','Medellín',        'Antioquia', 'CO'),

  (1200, 'Av. Javier Prado 550',      '15036', 'Lima',            'Lima', 'PE'),
  (1300, 'Av. 9 de Octubre 200',      '090313','Guayaquil',       'Guayas', 'EC'),

  (1400, 'Av. Providencia 1500',      '7500000','Santiago',       'Región Metropolitana', 'CL'),
  (1500, 'Av. Corrientes 1200',       'C1043', 'Buenos Aires',    'CABA', 'AR'),

  (1600, 'Av. Winston Churchill 50',  '10101', 'Santo Domingo',   'Distrito Nacional', 'DO'),
  (1700, 'Avenida Balboa 300',        '0801',  'Ciudad de Panamá','Panamá', 'PA');

-- PUESTOS (mix: data/tech + áreas clásicas HR)
INSERT INTO puestos (id_puesto, titulo_puesto, salario_min, salario_max) VALUES
  ('CEO',     'Director General',                  9000, 20000),
  ('CTO',     'Director de Tecnología',            8000, 18000),

  ('HR_MGR',  'Gerente de Recursos Humanos',       4000,  9000),
  ('HR_ANL',  'Analista de Recursos Humanos',      2000,  4500),

  ('FIN_MGR', 'Gerente de Finanzas',               4500, 10000),
  ('ACC',     'Contador',                          2200,  5500),

  ('SAL_MGR', 'Gerente Comercial',                 4500, 11000),
  ('SAL_REP', 'Ejecutivo Comercial',               1800,  4500),

  ('DS_SNR',  'Científico de Datos Senior',        6000, 14000),
  ('DS_JR',   'Científico de Datos Junior',        2500,  6000),
  ('DA_SNR',  'Analista de Datos Senior',          3500,  8500),
  ('DA_JR',   'Analista de Datos Junior',          1800,  4000),

  ('DE_SNR',  'Ingeniero de Datos Senior',         5500, 13000),
  ('DE_JR',   'Ingeniero de Datos Junior',         2500,  6000),

  ('SWE_SNR', 'Ingeniero de Software Senior',      5000, 12000),
  ('SWE_JR',  'Ingeniero de Software Junior',      2000,  5000),

  ('PM',      'Product Manager',                   4500, 11000),
  ('MKT',     'Especialista de Marketing',         2000,  5000),
  ('CS',      'Customer Success',                  1800,  4200);

-- DEPARTAMENTOS
INSERT INTO departamentos (id_departamento, nombre_departamento, id_gerente, id_ubicacion) VALUES
  (10, 'Dirección General',            NULL, 1000),
  (20, 'Tecnología',                   NULL, 1000),
  (30, 'Datos y Analítica',            NULL, 1100),
  (40, 'Finanzas',                     NULL, 1500),
  (50, 'Recursos Humanos',             NULL, 1002),
  (60, 'Comercial',                    NULL, 1700),
  (70, 'Marketing',                    NULL, 1400),
  (80, 'Customer Success',             NULL, 1200);

-- EMPLEADOS
-- Convención:
-- - emails únicos
-- - porcentaje_comision solo para Comercial (SAL_REP / SAL_MGR)
-- - id_jefe y id_departamento coherentes
INSERT INTO empleados (
  id_empleado, nombre, apellido, email, telefono,
  fecha_contratacion, id_puesto, salario, porcentaje_comision,
  id_jefe, id_departamento
) VALUES
  -- Dirección
  (100, 'Mario',   'Ruiz',      'mruiz@nuri.com',          '+52 55 1000 0100', DATE '2021-02-01', 'CEO',     18000.00, NULL, NULL, 10),
  (101, 'Valeria', 'Santos',    'vsantos@nuri.com',        '+52 55 1000 0101', DATE '2021-03-15', 'CTO',     16000.00, NULL, 100,  20),
  (102, 'Sofía',   'Gutiérrez', 'sgutierrez@nuri.com',     '+52 55 1000 0102', DATE '2021-06-10', 'PM',      10000.00, NULL, 100,  10),

  -- Tecnología (reporta a CTO=101)
  (110, 'Diego',   'Hernández', 'dhernandez@nuri.com',     '+52 55 2000 0110', DATE '2022-01-10', 'SWE_SNR', 11000.00, NULL, 101,  20),
  (111, 'Camila',  'Paredes',   'cparedes@nuri.com',       '+52 55 2000 0111', DATE '2022-05-02', 'SWE_JR',   4200.00, NULL, 110,  20),
  (112, 'Bruno',   'Silva',     'bsilva@nuri.com',         '+57 1 2000 0112',  DATE '2023-03-20', 'SWE_JR',   3800.00, NULL, 110,  20),

  -- Datos y Analítica (líder data reporta a CTO para simplificar)
  (120, 'Andrea',  'López',     'alopez@nuri.com',         '+57 1 3000 0120',  DATE '2022-02-07', 'DE_SNR',  12000.00, NULL, 101,  30),
  (121, 'Javier',  'Quispe',    'jquispe@nuri.com',        '+51 1 3000 0121',  DATE '2022-08-15', 'DA_SNR',   8200.00, NULL, 120,  30),
  (122, 'Fernanda','Rojas',     'frojas@nuri.com',         '+56 2 3000 0122',  DATE '2023-01-09', 'DS_JR',    5200.00, NULL, 121,  30),
  (123, 'Mateo',   'Vargas',    'mvargas@nuri.com',        '+54 11 3000 0123', DATE '2023-07-03', 'DA_JR',    3500.00, NULL, 121,  30),
  (124, 'Lucía',   'Carranza',  'lcarranza@nuri.com',      '+51 1 3000 0124',  DATE '2024-04-22', 'DE_JR',    5600.00, NULL, 120,  30),

  -- Finanzas (reporta a CEO=100)
  (130, 'Emiliano','Pérez',     'eperez@nuri.com',         '+54 11 4000 0130', DATE '2021-11-01', 'FIN_MGR',  9500.00, NULL, 100,  40),
  (131, 'Renata',  'Méndez',    'rmendez@nuri.com',        '+52 55 4000 0131', DATE '2022-03-14', 'ACC',      4800.00, NULL, 130,  40),

  -- RH (reporta a CEO=100)
  (140, 'Paola',   'Castillo',  'pcastillo@nuri.com',      '+52 33 5000 0140', DATE '2022-02-01', 'HR_MGR',   7800.00, NULL, 100,  50),
  (141, 'Nicolás', 'Morales',   'nmorales@nuri.com',       '+52 33 5000 0141', DATE '2023-02-13', 'HR_ANL',   3800.00, NULL, 140,  50),

  -- Comercial (reporta a CEO=100)
  (150, 'Daniela', 'Cabrera',   'dcabrera@nuri.com',       '+507 3000 0150',   DATE '2022-06-06', 'SAL_MGR',  9800.00, 0.08, 100,  60),
  (151, 'Carlos',  'Navarro',   'cnavarro@nuri.com',       '+507 3000 0151',   DATE '2023-05-08', 'SAL_REP',  3500.00, 0.12, 150,  60),
  (152, 'Mariana', 'Benítez',   'mbenitez@nuri.com',       '+57 1 6000 0152',  DATE '2024-01-15', 'SAL_REP',  3200.00, 0.10, 150,  60),

  -- Marketing (reporta a PM=102)
  (160, 'Iván',    'Suárez',    'isuarez@nuri.com',        '+56 2 7000 0160',  DATE '2023-09-04', 'MKT',      4200.00, NULL, 102,  70),

  -- Customer Success (reporta a PM=102)
  (170, 'Ana',     'Peña',      'apena@nuri.com',          '+51 1 8000 0170',  DATE '2023-10-02', 'CS',       3600.00, NULL, 102,  80);

-- Ahora que existen empleados, asignamos gerentes de departamentos
UPDATE departamentos SET id_gerente = 100 WHERE id_departamento = 10; -- Dirección General
UPDATE departamentos SET id_gerente = 101 WHERE id_departamento = 20; -- Tecnología
UPDATE departamentos SET id_gerente = 120 WHERE id_departamento = 30; -- Datos y Analítica
UPDATE departamentos SET id_gerente = 130 WHERE id_departamento = 40; -- Finanzas
UPDATE departamentos SET id_gerente = 140 WHERE id_departamento = 50; -- RH
UPDATE departamentos SET id_gerente = 150 WHERE id_departamento = 60; -- Comercial
UPDATE departamentos SET id_gerente = 160 WHERE id_departamento = 70; -- Marketing
UPDATE departamentos SET id_gerente = 170 WHERE id_departamento = 80; -- Customer Success

-- HISTORIAL DE PUESTOS (cambios de rol)
INSERT INTO historial_puestos (
  id_empleado, fecha_inicio, fecha_fin, id_puesto, id_departamento
) VALUES
  (111, DATE '2022-05-02', DATE '2023-05-01', 'SWE_JR', 20),
  (111, DATE '2023-05-01', DATE '2024-05-01', 'SWE_JR', 20),

  (122, DATE '2023-01-09', DATE '2024-01-09', 'DS_JR', 30),

  (151, DATE '2023-05-08', DATE '2024-05-08', 'SAL_REP', 60),

  (160, DATE '2023-09-04', DATE '2024-09-04', 'MKT', 70);