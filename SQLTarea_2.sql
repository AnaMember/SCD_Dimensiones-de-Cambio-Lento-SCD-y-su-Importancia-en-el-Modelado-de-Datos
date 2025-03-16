

create database SCD;

--------------TYPE 0 --------------
-- Creación de la tabla
CREATE TABLE Producto_SCD0 (
    ProductoID INT PRIMARY KEY,
    NombreProducto VARCHAR(255),
    Categoria VARCHAR(255)
);

-- Inserción de datos
INSERT INTO Producto_SCD0 (ProductoID, NombreProducto, Categoria) VALUES (1, 'Laptop', 'Electrónica');
INSERT INTO Producto_SCD0 (ProductoID, NombreProducto, Categoria) VALUES (2, 'Libro', 'Literatura');

SELECT * FROM Producto_SCD0;


-------------TYPE 1-------------

CREATE TABLE Cliente_SCD1 (
    ClienteID INT PRIMARY KEY,
    NombreCliente VARCHAR(255),
    DireccionActual VARCHAR(255)
);

INSERT INTO Cliente_SCD1 (ClienteID, NombreCliente, DireccionActual) VALUES (1, 'Alicia Smith', 'Calle Principal 123');
INSERT INTO Cliente_SCD1 (ClienteID, NombreCliente, DireccionActual) VALUES (2, 'Roberto Johnson', 'Avenida Roble 456');

-- Ejemplo de actualización: 
UPDATE Cliente_SCD1 SET DireccionActual = 'Calle Pino 789' WHERE ClienteID = 1;

SELECT * FROM Cliente_SCD1


-------------TYPE 2---------------

CREATE TABLE Empleado_SCD2 (
    EmpleadoID INT,
    NombreEmpleado VARCHAR(255),
    Departamento VARCHAR(255),
    FechaInicioVigencia DATE,
    FechaFinVigencia DATE,
    EsActual CHAR(1) CHECK (EsActual IN ('T', 'F')), -- 'T' para True, 'F' para False
    PRIMARY KEY (EmpleadoID, FechaInicioVigencia)
);

-- Inserción de datos
INSERT INTO Empleado_SCD2 (EmpleadoID, NombreEmpleado, Departamento, FechaInicioVigencia, FechaFinVigencia, EsActual) 
VALUES (1, 'Carolina Blanco', 'Ventas', '2022-01-01', '9999-12-31', 'T');

INSERT INTO Empleado_SCD2 (EmpleadoID, NombreEmpleado, Departamento, FechaInicioVigencia, FechaFinVigencia, EsActual) 
VALUES (2, 'David Verde', 'TI', '2023-06-01', '9999-12-31', 'T');

-- Actualización simulada de SCD Tipo 2:
-- 1. Cerrar la fila anterior de Carolina Blanco
UPDATE Empleado_SCD2 
SET FechaFinVigencia = '2023-11-15', EsActual = 'F' 
WHERE EmpleadoID = 1 AND EsActual = 'T';

-- 2. Insertar la nueva fila con el cambio de departamento
INSERT INTO Empleado_SCD2 (EmpleadoID, NombreEmpleado, Departamento, FechaInicioVigencia, FechaFinVigencia, EsActual) 
VALUES (1, 'Carolina Blanco', 'Marketing', '2023-11-16', '9999-12-31', 'T');


SELECT * FROM Empleado_SCD2;


---------TYPE3----------------

CREATE TABLE Producto_SCD3 (
    ProductoID INT PRIMARY KEY,
    NombreProducto VARCHAR(255),
    PrecioActual DECIMAL(10, 2),
    PrecioAnterior DECIMAL(10, 2)
);

INSERT INTO Producto_SCD3 (ProductoID, NombreProducto, PrecioActual, PrecioAnterior) VALUES (1, 'Monitor', 200.00, NULL);
INSERT INTO Producto_SCD3 (ProductoID, NombreProducto, PrecioActual, PrecioAnterior) VALUES (2, 'Teclado', 50.00, NULL);

-- Ejemplo de actualización: 
UPDATE Producto_SCD3 SET PrecioAnterior = PrecioActual, PrecioActual = 220.00 WHERE ProductoID = 1;

SELECT * FROM Producto_SCD3;



-----------TYPE4-------------
DROP TABLE IF EXISTS Cliente_SCD4_Principal
CREATE TABLE Cliente_SCD4_Principal (
    ClienteID INT PRIMARY KEY,
    NombreCliente VARCHAR(255),
    RiesgoActualID INT,
    FOREIGN KEY (RiesgoActualID) REFERENCES Cliente_SCD4_Riesgo(RiesgoID)
);

CREATE TABLE Cliente_SCD4_Riesgo (
    RiesgoID INT PRIMARY KEY,
    NivelRiesgo VARCHAR(50),
    FechaInicio DATE,
    FechaFin DATE
);

INSERT INTO Cliente_SCD4_Riesgo (RiesgoID, NivelRiesgo, FechaInicio, FechaFin) VALUES (1, 'Bajo', '2023-01-01', '2023-06-30');
INSERT INTO Cliente_SCD4_Riesgo (RiesgoID, NivelRiesgo, FechaInicio, FechaFin) VALUES (2, 'Medio', '2023-07-01', '9999-12-31');
INSERT INTO Cliente_SCD4_Principal (ClienteID, NombreCliente, RiesgoActualID) VALUES (1, 'Carlos', 2);
INSERT INTO Cliente_SCD4_Principal (ClienteID, NombreCliente, RiesgoActualID) VALUES (2, 'Sofia', 1);

-- Ejemplo de consulta
SELECT c.ClienteID, c.NombreCliente, r.NivelRiesgo, r.FechaInicio, r.FechaFin
FROM Cliente_SCD4_Principal c
JOIN Cliente_SCD4_Riesgo r ON c.RiesgoActualID = r.RiesgoID;

SELECT * FROM Cliente_SCD4_Principal;
SELECT * FROM Cliente_SCD4_Riesgo;

