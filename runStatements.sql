-- ==========================================
-- Script: runstatements.sql
-- Descripción: Consultas estadísticas sobre vuelos y clientes
-- ==========================================


-- ==========================================
-- 1. Lugares al que más viajan los chilenos por año (últimos 4 años)
-- ==========================================
SELECT 
    EXTRACT(YEAR FROM v.fecha) AS anio,
    v.destino,
    COUNT(*) AS cantidad_viajes
FROM cliente c
JOIN cliente_comp cc ON c.id_cliente = cc.id_cliente
JOIN vuelo v ON cc.id_vuelo = v.id_vuelo
WHERE c.nacionalidad = 'Chile'
  AND v.fecha >= (CURRENT_DATE - INTERVAL '4 years')
GROUP BY anio, v.destino
ORDER BY anio, cantidad_viajes DESC;
-- ==========================================
-- 2. Secciones de vuelos más compradas por argentinos
-- ==========================================
SELECT 
    cc.seccion,
    COUNT(*) AS cantidad_compras
FROM cliente c
JOIN cliente_comp cc ON c.id_cliente = cc.id_cliente
WHERE c.nacionalidad = 'Argentina'
GROUP BY cc.seccion
ORDER BY cantidad_compras DESC;

-- =======================
-- 3. Lista mensual de países que más gastan en volar (últimos 4 años)
-- =======================
SELECT
    EXTRACT(YEAR FROM v.fecha) AS anio,
    EXTRACT(MONTH FROM v.fecha) AS mes,
    c.nacionalidad,
    SUM(cc.costo) AS total_gastado
FROM cliente_comp cc
JOIN cliente c ON cc.id_cliente = c.id_cliente
JOIN vuelo v ON cc.id_vuelo = v.id_vuelo
WHERE v.fecha >= (CURRENT_DATE - INTERVAL '4 years')
GROUP BY anio, mes, c.nacionalidad
ORDER BY anio, mes, total_gastado DESC;

-- =======================
-- 4. Lista de pasajeros que viajan en “First Class” más de 4 veces al mes
-- =======================
SELECT 
    c.id_cliente,
    c.nombre,
    EXTRACT(YEAR FROM v.fecha) AS año,
    EXTRACT(MONTH FROM v.fecha) AS mes,
    COUNT(*) AS cantidad_viajes_first_class
FROM cliente_comp cc
JOIN vuelo v ON cc.id_vuelo = v.id_vuelo
JOIN cliente c ON cc.id_cliente = c.id_cliente
WHERE cc.seccion = 'First Class'
GROUP BY c.id_cliente, c.nombre, EXTRACT(YEAR FROM v.fecha), EXTRACT(MONTH FROM v.fecha)
HAVING COUNT(*) > 4;

-- =======================
-- 9. Lista anual de compañías que en promedio han pagado más a sus empleados (últimos 10 años)
-- =======================
WITH promedios AS (
  SELECT
    gs.anio,
    comp.id_compania,
    comp.nombre AS compania,
    AVG(e.sueldo) AS promedio_sueldo
  FROM generate_series((EXTRACT(YEAR FROM CURRENT_DATE)::int - 9), EXTRACT(YEAR FROM CURRENT_DATE)::int) AS gs(anio)
  JOIN empleado e ON e.fecha_contratacion <= make_date(gs.anio, 12, 31)
  JOIN compania comp ON e.id_compania = comp.id_compania
  GROUP BY gs.anio, comp.id_compania, comp.nombre
),
ranked AS (
  SELECT
    anio,
    compania,
    ROUND(promedio_sueldo::numeric, 2) AS promedio_sueldo,
    RANK() OVER (PARTITION BY anio ORDER BY promedio_sueldo DESC) AS rnk
  FROM promedios
)
SELECT anio, compania, promedio_sueldo
FROM ranked
WHERE rnk = 1
ORDER BY anio;

-- =======================
-- 10. Modelo de avión más usado por compañía durante el 2021
-- =======================
WITH usos AS (
  SELECT
    comp.id_compania,
    comp.nombre AS compania,
    m.id_modelo,
    m.nombre AS modelo,
    COUNT(*) AS vuelos_2021
  FROM vuelo v
  JOIN avion a ON v.id_avion = a.id_avion
  JOIN modelo m ON a.id_modelo = m.id_modelo
  JOIN compania comp ON v.id_compania = comp.id_compania
  WHERE EXTRACT(YEAR FROM v.fecha) = 2021
  GROUP BY comp.id_compania, comp.nombre, m.id_modelo, m.nombre
),
ranked AS (
  SELECT
    id_compania,
    compania,
    modelo,
    vuelos_2021,
    RANK() OVER (PARTITION BY id_compania ORDER BY vuelos_2021 DESC) AS rnk
  FROM usos
)
SELECT id_compania, compania, modelo, vuelos_2021
FROM ranked
WHERE rnk = 1
ORDER BY compania;