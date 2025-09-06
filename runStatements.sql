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