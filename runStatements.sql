-- ==========================================
-- Script: runstatements.sql
-- Descripción: Consultas estadísticas sobre vuelos y clientes
-- ==========================================

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
    EXTRACT(YEAR FROM v.fecha) AS anio,
    EXTRACT(MONTH FROM v.fecha) AS mes,
    COUNT(*) AS viajes_first_class
FROM cliente_comp cc
JOIN cliente c ON cc.id_cliente = c.id_cliente
JOIN vuelo v ON cc.id_vuelo = v.id_vuelo
WHERE cc.seccion = 'First Class'
GROUP BY c.id_cliente, c.nombre, anio, mes
HAVING COUNT(*) > 4
ORDER BY anio, mes, viajes_first_class DESC;
