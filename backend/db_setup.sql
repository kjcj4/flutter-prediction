-- Crear base de datos
CREATE DATABASE predicciones_db;

-- Crear usuario
CREATE USER mi_usuario WITH PASSWORD 'mi_password';

-- Dar permisos
GRANT ALL PRIVILEGES ON DATABASE predicciones_db TO mi_usuario;

-- Ejemplo tabla de historial
\c predicciones_db

CREATE TABLE historial (
    id SERIAL PRIMARY KEY,
    entrada JSONB NOT NULL,
    prediccion VARCHAR(255) NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
