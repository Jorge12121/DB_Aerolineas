-- ==========================================
-- Script: loadData.sql
-- Descripción: Inserción de datos iniciales
-- ==========================================

-- =======================
-- Insertar compañías
-- =======================
INSERT INTO compania (nombre) VALUES
('AeroChile'),
('SkyEurope'),
('GlobalWings'),
('PacificAir');

-- =======================
-- Insertar modelos de aviones
-- =======================
INSERT INTO modelo (nombre, capacidad) VALUES
('Boeing 737', 180),
('Airbus A320', 200),
('Boeing 787 Dreamliner', 300),
('Airbus A350', 350);

-- =======================
-- Insertar aviones
-- =======================
INSERT INTO avion (id_modelo, id_compania, anio_ingreso) VALUES
(1, 1, 2015),
(2, 1, 2018),
(3, 2, 2020),
(4, 3, 2021),
(1, 4, 2017);

-- =======================
-- Insertar empleados (pilotos principalmente)
-- =======================
INSERT INTO empleado (id_compania, sueldo, cargo, fecha_contratacion) VALUES
(1, 3500, 'Piloto', '2018-05-10'),
(1, 2000, 'Copiloto', '2019-08-15'),
(2, 4000, 'Piloto', '2017-03-21'),
(3, 3800, 'Piloto', '2019-01-11'),
(4, 4200, 'Piloto', '2020-06-01');

-- =======================
-- Insertar vuelos (2022-2025)
-- =======================
INSERT INTO vuelo (origen, destino, id_empleado, id_compania, id_avion, fecha) VALUES
('Santiago', 'Madrid', 1, 1, 1, '2022-02-10'),
('Paris', 'Tokyo', 3, 2, 3, '2022-02-15'),
('Berlin', 'Rome', 4, 3, 4, '2022-02-20'),
('New York', 'London', 5, 4, 5, '2022-02-11'),
('Dubai', 'Sydney', 3, 2, 3, '2022-02-25'),
('London', 'New York', 1, 1, 2, '2024-05-30'),
('Tokyo', 'Paris', 4, 3, 4, '2025-02-19'),
('Rome', 'Berlin', 5, 4, 5, '2025-03-22'),
('Madrid', 'Santiago', 1, 1, 1, '2025-04-18'),
('Sydney', 'Dubai', 3, 2, 3, '2025-06-12'),
('Berlin', 'Madrid', 4, 3, 4, '2025-03-01'),
('Madrid', 'Berlin', 4, 3, 4, '2025-03-02'),
('Berlin', 'Paris', 4, 3, 4, '2025-03-03'),
('Paris', 'Berlin', 4, 3, 4, '2025-03-04'),
('Berlin', 'Rome', 4, 3, 4, '2025-03-05');


-- =======================
-- Insertar clientes
-- =======================
INSERT INTO cliente (nacionalidad, nombre, edad, id_compania) VALUES
('Chile', 'Carlos Pérez', 34, 1),
('USA', 'Alice Johnson', 40, 2),
('France', 'Marie Dupont', 29, 2),
('Germany', 'Hans Müller', 45, 3),
('Italy', 'Sofia Rossi', 31, 3),
('Japan', 'Akira Tanaka', 37, 2),
('China', 'Li Wei', 28, 3),
('Brazil', 'Ana Silva', 33, 1),
('UK', 'David Smith', 42, 4),
('UAE', 'Fatima Khan', 36, 4);

-- =======================
-- Insertar compras/viajes (cliente_comp)
-- =======================
-- Alice (USA) - gasta mucho en First Class
INSERT INTO cliente_comp (id_cliente, id_vuelo, seccion, costo) VALUES
(2, 1, 'First Class', 2200),
(2, 2, 'First Class', 2500),
(2, 3, 'First Class', 3200),
(2, 4, 'First Class', 2100),
(2, 5, 'First Class', 2600),
(4, 11, 'First Class', 1500),
(4, 12, 'First Class', 1600),
(4, 13, 'First Class', 1700),
(4, 14, 'First Class', 1800),
(4, 15, 'First Class', 1900);

-- Carlos (Chile) - gastos variados
INSERT INTO cliente_comp (id_cliente, id_vuelo, seccion, costo) VALUES
(1, 1, 'Economy', 950),
(1, 9, 'Business', 1500),
(1, 6, 'First Class', 2200);

-- Marie (France) - Economy
INSERT INTO cliente_comp (id_cliente, id_vuelo, seccion, costo) VALUES
(3, 2, 'Economy', 1200),
(3, 7, 'Economy', 1300),
(3, 1, 'Economy', 800);

-- Hans (Germany) - First Class más de 4 veces en un mes
INSERT INTO cliente_comp (id_cliente, id_vuelo, seccion, costo) VALUES
(4, 3, 'First Class', 1500),
(4, 8, 'First Class', 1600),
(4, 1, 'First Class', 2000),
(4, 6, 'First Class', 2100),
(4, 7, 'First Class', 2300);

-- Sofía (Italy) - Business normalito
INSERT INTO cliente_comp (id_cliente, id_vuelo, seccion, costo) VALUES
(5, 3, 'Business', 600),
(5, 8, 'Business', 650);

-- Akira (Japan) - Business y First
INSERT INTO cliente_comp (id_cliente, id_vuelo, seccion, costo) VALUES
(6, 2, 'Business', 1400),
(6, 7, 'First Class', 2500),
(6, 5, 'First Class', 3100);

-- Li Wei (China) - Economy
INSERT INTO cliente_comp (id_cliente, id_vuelo, seccion, costo) VALUES
(7, 2, 'Economy', 1200),
(7, 7, 'Economy', 1300);

-- Ana (Brazil) - First Class frecuentes (>4 en un mes)
INSERT INTO cliente_comp (id_cliente, id_vuelo, seccion, costo) VALUES
(8, 4, 'First Class', 2100),
(8, 6, 'First Class', 2000),
(8, 9, 'First Class', 2200),
(8, 7, 'First Class', 2300),
(8, 10, 'First Class', 2400);

-- David (UK) - viajes variados
INSERT INTO cliente_comp (id_cliente, id_vuelo, seccion, costo) VALUES
(9, 1, 'Business', 1200),
(9, 6, 'First Class', 2100);

-- Fatima (UAE) - gasto alto en First
INSERT INTO cliente_comp (id_cliente, id_vuelo, seccion, costo) VALUES
(10, 5, 'First Class', 3000),
(10, 10, 'Business', 1500),
(10, 7, 'First Class', 3200);

