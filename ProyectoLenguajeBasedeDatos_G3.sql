-- Creacion de la tabla Hoteles
CREATE TABLE Hoteles (
 ID_Hotel NUMBER PRIMARY KEY,
 Nombre VARCHAR2(100),
 Direccion VARCHAR2(200),
 Ciudad VARCHAR2(100),
 Pais VARCHAR2(100),
 Estrellas NUMBER
);

-- Creacion de la tabla Clientes
CREATE TABLE Clientes (
 ID_Cliente NUMBER PRIMARY KEY,
 Nombre VARCHAR2(100),
 Apellido VARCHAR2(100),
 CorreoElectronico VARCHAR2(100),
 Telefono VARCHAR2(20)
);

-- Creacion de la tabla Reservaciones
CREATE TABLE Reservaciones (
 ID_Reservacion NUMBER PRIMARY KEY,
 ID_Hotel NUMBER,
 ID_Cliente NUMBER,
 Fecha_inicio DATE,
 Fecha_fin DATE,
 Habitacion_asignada VARCHAR2(50),
 FOREIGN KEY (ID_Hotel) REFERENCES Hoteles(ID_Hotel),
 FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Creacion de la tabla Reservaciones_Restaurantes
CREATE TABLE Reservaciones_Restaurantes (
 ID_Reservacion NUMBER,
 Fecha DATE,
 Hora TIMESTAMP,
 Numero_de_personas NUMBER,
 PRIMARY KEY (ID_Reservacion, Fecha, Hora), -- Definir una clave primaria compuesta
 FOREIGN KEY (ID_Reservacion) REFERENCES Reservaciones(ID_Reservacion)
);

-- Creacion de la tabla Tipos_de_Habitaciones
CREATE TABLE Tipos_de_Habitaciones (
 ID_Tipo_Habitacion NUMBER PRIMARY KEY,
 Descripcion VARCHAR2(100),
 Precio_por_noche NUMBER(10, 2),
 Capacidad NUMBER
);

-- Creacion de la tabla Reservaciones_Habitaciones
CREATE TABLE Reservaciones_Habitaciones (
 ID_Reservacion_Habitacion NUMBER PRIMARY KEY,
 ID_Reservacion NUMBER,
 ID_Tipo_Habitacion NUMBER,
 Cantidad NUMBER,
 Precio NUMBER(10, 2),
 FOREIGN KEY (ID_Reservacion) REFERENCES Reservaciones(ID_Reservacion),
 FOREIGN KEY (ID_Tipo_Habitacion) REFERENCES Tipos_de_Habitaciones(ID_Tipo_Habitacion)
);

-- Creacion de la tabla Servicios_Adicionales
CREATE TABLE Servicios_Adicionales (
 ID_Servicio NUMBER PRIMARY KEY,
 ID_Hotel NUMBER, -- Agregar esta linea para relacionar el servicio con un hotel
 Nombre VARCHAR2(100),
 Precio NUMBER(10, 2),
 FOREIGN KEY (ID_Hotel) REFERENCES Hoteles(ID_Hotel) -- Agregar esta linea para la clave externa
);

-- Creacion de la tabla Reservaciones_Servicios_Adicionales
CREATE TABLE Reservaciones_Servicios_Adicionales (
 ID_Reservacion_Servicio NUMBER PRIMARY KEY,
 ID_Reservacion NUMBER,
 ID_Servicio NUMBER,
 Cantidad NUMBER,
 FOREIGN KEY (ID_Reservacion) REFERENCES Reservaciones(ID_Reservacion),
 FOREIGN KEY (ID_Servicio) REFERENCES Servicios_Adicionales(ID_Servicio)
);

-- Creacion de la tabla Empleados
CREATE TABLE Empleados (
 ID_Empleado NUMBER PRIMARY KEY,
 Nombre VARCHAR2(100),
 Apellido VARCHAR2(100),
 Cargo VARCHAR2(100),
 Fecha_contratacion DATE,
 ID_Hotel NUMBER,
 FOREIGN KEY (ID_Hotel) REFERENCES Hoteles(ID_Hotel)
);

-- Creacion de la tabla Historial_Reservaciones
CREATE TABLE Historial_Reservaciones (
 ID_Historial NUMBER PRIMARY KEY,
 ID_Reservacion NUMBER,
 Fecha_modificacion TIMESTAMP,
 Comentario VARCHAR2(4000),
 FOREIGN KEY (ID_Reservacion) REFERENCES Reservaciones(ID_Reservacion)
);

-- Creacion de la tabla Facturas
CREATE TABLE Facturas (
 ID_Factura NUMBER PRIMARY KEY,
 ID_Reservacion NUMBER,
 Fecha_emision DATE,
 Total NUMBER(10, 2),
 FOREIGN KEY (ID_Reservacion) REFERENCES Reservaciones(ID_Reservacion)
);

-- Creacion de la tabla Comentarios_Hotel
CREATE TABLE Comentarios_Hotel (
 ID_Comentario NUMBER PRIMARY KEY,
 ID_Hotel NUMBER,
 ID_Cliente NUMBER,
 Comentario VARCHAR2(4000),
 Puntuacion NUMBER,
 Fecha DATE,
 FOREIGN KEY (ID_Hotel) REFERENCES Hoteles(ID_Hotel),
 FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Creacion de secuencias para las tablas que requieren un campo autoincrementable
CREATE SEQUENCE seq_Historial_Reservaciones START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_Facturas START WITH 1 INCREMENT BY 1;

-- Procedimientos almacenados

--1. Agregar un nuevo cliente
CREATE OR REPLACE PROCEDURE Insertar_Cliente (
  p_ID_Cliente IN NUMBER,
  p_Nombre IN VARCHAR2,
  p_Apellido IN VARCHAR2,
  p_CorreoElectronico IN VARCHAR2,
  p_Telefono IN VARCHAR2
) AS
BEGIN
  INSERT INTO Clientes (ID_Cliente, Nombre, Apellido, CorreoElectronico, Telefono)
  VALUES (p_ID_Cliente, p_Nombre, p_Apellido, p_CorreoElectronico, p_Telefono);
END;
/

--2. Buscar habitaciones disponibles en un hotel para un rango de fechas
CREATE OR REPLACE PROCEDURE Buscar_Habitaciones_Disponibles (
  p_ID_Hotel IN NUMBER,
  p_Fecha_inicio IN DATE,
  p_Fecha_fin IN DATE,
  p_Resultado OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN p_Resultado FOR
    SELECT TH.ID_Tipo_Habitacion, TH.Descripcion, 
           COUNT(RH.ID_Reservacion_Habitacion) AS Disponibles
    FROM Tipos_de_Habitaciones TH
    LEFT JOIN Reservaciones_Habitaciones RH ON TH.ID_Tipo_Habitacion = RH.ID_Tipo_Habitacion
    LEFT JOIN Reservaciones R ON RH.ID_Reservacion = R.ID_Reservacion
    WHERE TH.ID_Tipo_Habitacion NOT IN (
      SELECT RH.ID_Tipo_Habitacion
      FROM Reservaciones_Habitaciones RH
      JOIN Reservaciones R ON RH.ID_Reservacion = R.ID_Reservacion
      WHERE R.ID_Hotel = p_ID_Hotel
      AND (R.Fecha_inicio <= p_Fecha_fin AND R.Fecha_fin >= p_Fecha_inicio)
    )
    GROUP BY TH.ID_Tipo_Habitacion, TH.Descripcion;
END;
/


--3. Obtener la lista de servicios adicionales de un hotel
CREATE OR REPLACE PROCEDURE Obtener_Servicios_Adicionales_Hotel (
  p_ID_Hotel IN NUMBER,          -- Parametro de entrada: ID del hotel
  p_Resultado OUT SYS_REFCURSOR  -- Parametro de salida: Cursor para los resultados
) AS
BEGIN
  -- Abrir el cursor para la consulta
  OPEN p_Resultado FOR
    SELECT SA.ID_Servicio, SA.Nombre, SA.Precio
    FROM Servicios_Adicionales SA
    WHERE SA.ID_Hotel = p_ID_Hotel;
END;
/


--4. Realizar una nueva reservacion
CREATE OR REPLACE PROCEDURE Realizar_Reservacion (
  p_ID_Hotel IN NUMBER,
  p_ID_Cliente IN NUMBER,
  p_Fecha_inicio IN DATE,
  p_Fecha_fin IN DATE,
  p_Habitacion_asignada IN VARCHAR2
) AS
BEGIN
  INSERT INTO Reservaciones (ID_Hotel, ID_Cliente, Fecha_inicio, Fecha_fin, Habitacion_asignada)
  VALUES (p_ID_Hotel, p_ID_Cliente, p_Fecha_inicio, p_Fecha_fin, p_Habitacion_asignada);
END;
/

--5. Actualizar la informacion de un cliente
CREATE OR REPLACE PROCEDURE Actualizar_Cliente (
  p_ID_Cliente IN NUMBER,
  p_Nombre IN VARCHAR2,
  p_Apellido IN VARCHAR2,
  p_CorreoElectronico IN VARCHAR2,
  p_Telefono IN VARCHAR2
) AS
BEGIN
  UPDATE Clientes
  SET Nombre = p_Nombre, Apellido = p_Apellido, CorreoElectronico = p_CorreoElectronico,
      Telefono = p_Telefono
  WHERE ID_Cliente = p_ID_Cliente;
END;
/

--6. Eliminar una reservacion por ID
CREATE OR REPLACE PROCEDURE Eliminar_Reservacion_Por_ID (
  p_ID_Reservacion IN NUMBER
) AS
BEGIN
  DELETE FROM Reservaciones
  WHERE ID_Reservacion = p_ID_Reservacion;
END;
/

--7. Obtener el total de una factura por ID de reservacion
CREATE OR REPLACE PROCEDURE Obtener_Total_Factura (
  p_ID_Reservacion IN NUMBER,           -- Parametro de entrada: ID de la reservacion
  p_Total OUT NUMBER                    -- Parametro de salida: Total de la factura
) AS
BEGIN
  -- Consultar el total de la factura y almacenarlo en el parametro de salida
  SELECT Total
  INTO p_Total
  FROM Facturas
  WHERE ID_Reservacion = p_ID_Reservacion;
EXCEPTION
  -- Manejo de excepciones si no se encuentra el registro
  WHEN NO_DATA_FOUND THEN
    p_Total := NULL; -- Asignar NULL si no se encuentra la factura
END;
/


--8. Agregar un nuevo empleado
CREATE OR REPLACE PROCEDURE Insertar_Empleado (
  p_ID_Empleado IN NUMBER,
  p_Nombre IN VARCHAR2,
  p_Apellido IN VARCHAR2,
  p_Cargo IN VARCHAR2,
  p_Fecha_contratacion IN DATE,
  p_ID_Hotel IN NUMBER
) AS
BEGIN
  INSERT INTO Empleados (ID_Empleado, Nombre, Apellido, Cargo, Fecha_contratacion, ID_Hotel)
  VALUES (p_ID_Empleado, p_Nombre, p_Apellido, p_Cargo, p_Fecha_contratacion, p_ID_Hotel);
END;
/

--9. Eliminar un servicio adicional de un hotel
CREATE OR REPLACE PROCEDURE Eliminar_Servicio_Adicional (
  p_ID_Servicio IN NUMBER
) AS
BEGIN
  DELETE FROM Servicios_Adicionales
  WHERE ID_Servicio = p_ID_Servicio;
END;
/

--10. Actualizar la información de una reserva
CREATE OR REPLACE PROCEDURE Actualizar_Reserva (
  p_ID_Reservacion IN NUMBER,
  p_Fecha_inicio IN DATE,
  p_Fecha_fin IN DATE,
  p_Habitacion_asignada IN VARCHAR2
) AS
BEGIN
  UPDATE Reservaciones
  SET Fecha_inicio = p_Fecha_inicio, Fecha_fin = p_Fecha_fin, Habitacion_asignada = p_Habitacion_asignada
  WHERE ID_Reservacion = p_ID_Reservacion;
END;
/

--11. Agregar una nueva factura
CREATE OR REPLACE PROCEDURE Insertar_Factura (
  p_ID_Factura IN NUMBER,
  p_ID_Reservacion IN NUMBER,
  p_Fecha_emision IN DATE,
  p_Total IN NUMBER
) AS
BEGIN
  INSERT INTO Facturas (ID_Factura, ID_Reservacion, Fecha_emision, Total)
  VALUES (p_ID_Factura, p_ID_Reservacion, p_Fecha_emision, p_Total);
END;
/

--12. Agregar un nuevo comentario de hotel
CREATE OR REPLACE PROCEDURE Insertar_Comentario_Hotel (
  p_ID_Comentario IN NUMBER,
  p_ID_Hotel IN NUMBER,
  p_ID_Cliente IN NUMBER,
  p_Comentario IN VARCHAR2,
  p_Puntuacion IN NUMBER,
  p_Fecha IN DATE
) AS
BEGIN
  INSERT INTO Comentarios_Hotel (ID_Comentario, ID_Hotel, ID_Cliente, Comentario, Puntuacion, Fecha)
  VALUES (p_ID_Comentario, p_ID_Hotel, p_ID_Cliente, p_Comentario, p_Puntuacion, p_Fecha);
END;
/

-- Vistas

-- 1. Vista de Reservaciones Detalladas
-- Esta vista muestra los detalles de las reservaciones, incluyendo el nombre del hotel y del cliente, junto con las fechas y la habitación asignada.
CREATE VIEW Vista_Reservaciones_Detalladas AS
SELECT R.ID_RESERVACION,  -- ID de la reservación
       H.Nombre AS Nombre_Hotel,  -- Nombre del hotel
       C.Nombre AS Nombre_Cliente,  -- Nombre del cliente
       R.Fecha_inicio,  -- Fecha de inicio de la reservación
       R.Fecha_fin,  -- Fecha de fin de la reservación
       R.HABITACION_ASIGNADA  -- Habitación asignada (corrige el nombre aquí)
FROM Reservaciones R
JOIN Hoteles H ON R.ID_Hotel = H.ID_Hotel  -- Une la tabla de Reservaciones con Hoteles para obtener el nombre del hotel.
JOIN Clientes C ON R.ID_Cliente = C.ID_Cliente;  -- Une la tabla de Reservaciones con Clientes para obtener el nombre del cliente.

-- Consulta de la vista Vista_Reservaciones_Detalladas
-- Recupera todas las reservaciones desde la vista creada, ordenadas por la fecha de inicio en orden descendente.
SELECT *
FROM Vista_Reservaciones_Detalladas
ORDER BY Fecha_inicio DESC;

-- 2. Vista de Facturas de Reservaciones
-- Esta vista proporciona información sobre las facturas relacionadas con las reservaciones, incluyendo el nombre del cliente y la fecha de emisión.
CREATE VIEW Vista_Facturas_Reservaciones AS
SELECT F.ID_Factura,  -- ID de la factura
       R.ID_RESERVACION,  -- ID de la reservación (ajustado aquí)
       C.Nombre AS Nombre_Cliente,  -- Nombre del cliente
       F.Fecha_emision,  -- Fecha de emisión de la factura (ajustado aquí)
       F.Total  -- Monto total de la factura
FROM Facturas F
JOIN Reservaciones R ON F.ID_RESERVACION = R.ID_RESERVACION  -- Une la tabla de Facturas con Reservaciones.
JOIN Clientes C ON R.ID_Cliente = C.ID_Cliente;

-- Consulta de la vista Vista_Facturas_Reservaciones
-- Recupera todas las facturas desde la vista creada, ordenadas por la fecha de emisión en orden descendente.
SELECT *
FROM Vista_Facturas_Reservaciones
ORDER BY Fecha_emisión DESC;

-- 3. Vista de Empleados por Hotel
-- Esta vista muestra información sobre los empleados de cada hotel, incluyendo el nombre del hotel en el que trabajan.
CREATE VIEW Vista_Empleados_Por_Hotel AS
SELECT E.ID_Empleado,  -- ID del empleado
       E.Nombre,  -- Nombre del empleado
       E.Apellido,  -- Apellido del empleado
       E.Cargo,  -- Cargo del empleado
       H.Nombre AS Nombre_Hotel  -- Nombre del hotel donde trabaja el empleado
FROM Empleados E
JOIN Hoteles H ON E.ID_Hotel = H.ID_Hotel;  -- Une la tabla de Empleados con Hoteles para obtener el nombre del hotel.

-- Consulta de la vista Vista_Empleados_Por_Hotel
-- Recupera todos los empleados desde la vista creada, ordenados por el nombre del hotel.
SELECT *
FROM Vista_Empleados_Por_Hotel
ORDER BY Nombre_Hotel;

-- 4. Vista de Comentarios Recientes
-- Esta vista proporciona información sobre los comentarios recientes hechos por los clientes sobre los hoteles.
CREATE VIEW Vista_Comentarios_Recientes AS
SELECT CH.ID_Comentario,  -- ID del comentario
       H.Nombre AS Nombre_Hotel,  -- Nombre del hotel
       C.Nombre AS Nombre_Cliente,  -- Nombre del cliente
       CH.Comentario,  -- Texto del comentario
       CH.Puntuacion,  -- Puntuación del comentario (ajustado aquí)
       CH.Fecha  -- Fecha en la que se hizo el comentario
FROM Comentarios_Hotel CH
JOIN Hoteles H ON CH.ID_Hotel = H.ID_Hotel  -- Une la tabla de Comentarios con Hoteles.
JOIN Clientes C ON CH.ID_Cliente = C.ID_Cliente;

-- Consulta de la vista Vista_Comentarios_Recientes
-- Recupera todos los comentarios desde la vista creada, ordenados por la fecha en orden descendente.
SELECT *
FROM Vista_Comentarios_Recientes
ORDER BY Fecha DESC;

-- 5. Vista de Reservaciones y Comentarios
-- Esta vista muestra las reservaciones junto con los comentarios que los clientes han hecho sobre los hoteles en los que se han alojado.
CREATE VIEW Vista_Reservaciones_y_Comentarios AS
SELECT R.ID_RESERVACION,  -- ID de la reservación (ajustado aquí)
       R.Fecha_inicio,  -- Fecha de inicio de la reservación
       R.Fecha_fin,  -- Fecha de fin de la reservación
       H.Nombre AS Nombre_Hotel,  -- Nombre del hotel
       C.Nombre AS Nombre_Cliente,  -- Nombre del cliente
       CH.Comentario AS Comentario_Cliente,  -- Comentario hecho por el cliente
       CH.Puntuacion AS Puntuacion_Comentario  -- Puntuación del comentario (ajustado aquí)
FROM Reservaciones R
JOIN Hoteles H ON R.ID_Hotel = H.ID_Hotel  -- Une la tabla de Reservaciones con Hoteles.
JOIN Clientes C ON R.ID_Cliente = C.ID_Cliente  -- Une la tabla de Reservaciones con Clientes.
JOIN Comentarios_Hotel CH ON R.ID_Hotel = CH.ID_Hotel AND R.ID_Cliente = CH.ID_Cliente;

-- Consulta de la vista Vista_Reservaciones_y_Comentarios
-- Recupera todas las reservaciones junto con los comentarios desde la vista creada, ordenadas por la fecha de inicio de la reservación en orden descendente.
SELECT *
FROM Vista_Reservaciones_y_Comentarios
ORDER BY Fecha_inicio DESC;



