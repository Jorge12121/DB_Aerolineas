-- ==========================================
-- Script: dbCreate.sql
-- Descripción: Creación de base de datos para gestión de vuelos
-- ==========================================

-- 1. Crear base de datos
--CREATE DATABASE vuelos_db;


-- ==========================================
-- 2. Creación de tablas
-- ==========================================

-- Tabla Compañía
CREATE TABLE compania (
    id_compania SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla Modelo
CREATE TABLE modelo (
    id_modelo SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT CHECK (capacidad > 0)
);

-- Tabla Avión
CREATE TABLE avion (
    id_avion SERIAL PRIMARY KEY,
    id_modelo INT NOT NULL REFERENCES modelo(id_modelo),
    id_compania INT NOT NULL REFERENCES compania(id_compania),
    anio_ingreso SMALLINT CHECK (anio_ingreso >= 1950 AND anio_ingreso <= EXTRACT(YEAR FROM CURRENT_DATE))
);

-- Tabla Empleado
CREATE TABLE empleado (
    id_empleado SERIAL PRIMARY KEY,
    id_compania INT NOT NULL REFERENCES compania(id_compania),
    sueldo NUMERIC(12,2) CHECK (sueldo >= 0),
    cargo VARCHAR(50) NOT NULL,
    fecha_contratacion DATE NOT NULL
);

-- Tabla Vuelo
CREATE TABLE vuelo (
    id_vuelo SERIAL PRIMARY KEY,
    origen VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    id_empleado INT NOT NULL REFERENCES empleado(id_empleado),
    id_compania INT NOT NULL REFERENCES compania(id_compania),
    id_avion INT NOT NULL REFERENCES avion(id_avion),
    fecha DATE NOT NULL
);

-- Tabla Cliente
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nacionalidad VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    edad SMALLINT CHECK (edad BETWEEN 0 AND 120),
    id_compania INT REFERENCES compania(id_compania)
);

-- Tabla Cliente_comp (compras/viajes de clientes)
CREATE TABLE cliente_comp (
    id_comp SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES cliente(id_cliente),
    id_vuelo INT NOT NULL REFERENCES vuelo(id_vuelo),
    seccion VARCHAR(50) CHECK (seccion IN ('Economy','Business','First Class')),
    costo NUMERIC(12,2) CHECK (costo >= 0)
);

-- ==========================================
-- 3. Índices adicionales (para optimizar consultas)
-- ==========================================
CREATE INDEX idx_cliente_nacionalidad ON cliente(nacionalidad);
CREATE INDEX idx_vuelo_fecha ON vuelo(fecha);
CREATE INDEX idx_clientecomp_seccion ON cliente_comp(seccion);
CREATE INDEX idx_empleado_cargo ON empleado(cargo);
CREATE INDEX idx_avion_compania_anio ON avion(id_compania, anio_ingreso);
