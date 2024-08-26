
-- Creación de secuencias para las tablas que requieren un campo autoincrementable
CREATE SEQUENCE seq_Hoteles START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_Clientes START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_Reservaciones START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_Reservaciones_Restaurantes START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_Tipos_de_Habitaciones START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_Reservaciones_Habitaciones START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_Servicios_Adicionales START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_Reservaciones_Servicios_Adicionales START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_Empleados START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_Historial_Reservaciones START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_Facturas START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_Comentarios_Hotel START WITH 1 INCREMENT BY 1;

-- Creación de las tablas con IDs autogenerados

-- Tabla Hoteles
CREATE TABLE Hoteles (
 ID_Hotel NUMBER DEFAULT seq_Hoteles.NEXTVAL PRIMARY KEY,
 Nombre VARCHAR2(100),
 Direccion VARCHAR2(200),
 Ciudad VARCHAR2(100),
 Pais VARCHAR2(100),
 Estrellas NUMBER
);

-- Tabla Clientes
CREATE TABLE Clientes (
 ID_Cliente NUMBER DEFAULT seq_Clientes.NEXTVAL PRIMARY KEY,
 Nombre VARCHAR2(100),
 Apellido VARCHAR2(100),
 Correo_electronico VARCHAR2(100),
 Telefono VARCHAR2(20)
);

-- Tabla Reservaciones
CREATE TABLE Reservaciones (
 ID_Reservacion NUMBER DEFAULT seq_Reservaciones.NEXTVAL PRIMARY KEY,
 ID_Hotel NUMBER,
 ID_Cliente NUMBER,
 Fecha_inicio DATE,
 Fecha_fin DATE,
 Habitacion_asignada VARCHAR2(50),
 FOREIGN KEY (ID_Hotel) REFERENCES Hoteles(ID_Hotel),
 FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Tabla Reservaciones_Restaurantes
CREATE TABLE Reservaciones_Restaurantes (
 ID_Reservacion_Restaurante NUMBER DEFAULT seq_Reservaciones_Restaurantes.NEXTVAL PRIMARY KEY,
 ID_Reservacion NUMBER,
 Fecha DATE,
 Hora VARCHAR2(5),
 Numero_de_personas NUMBER,
 FOREIGN KEY (ID_Reservacion) REFERENCES Reservaciones(ID_Reservacion)
);

-- Tabla Tipos_de_Habitaciones
CREATE TABLE Tipos_de_Habitaciones (
 ID_Tipo_Habitacion NUMBER DEFAULT seq_Tipos_de_Habitaciones.NEXTVAL PRIMARY KEY,
 Descripcion VARCHAR2(100),
 Precio_por_noche NUMBER(10, 2),
 Capacidad NUMBER
);

-- Tabla Reservaciones_Habitaciones
CREATE TABLE Reservaciones_Habitaciones (
 ID_Reservacion_Habitacion NUMBER DEFAULT seq_Reservaciones_Habitaciones.NEXTVAL PRIMARY KEY,
 ID_Reservacion NUMBER,
 ID_Tipo_Habitacion NUMBER,
 Cantidad NUMBER,
 Precio NUMBER(10, 2),
 FOREIGN KEY (ID_Reservacion) REFERENCES Reservaciones(ID_Reservacion),
 FOREIGN KEY (ID_Tipo_Habitacion) REFERENCES Tipos_de_Habitaciones(ID_Tipo_Habitacion)
);

-- Tabla Servicios_Adicionales
CREATE TABLE Servicios_Adicionales (
 ID_Servicio NUMBER DEFAULT seq_Servicios_Adicionales.NEXTVAL PRIMARY KEY,
 ID_Hotel NUMBER, 
 Nombre VARCHAR2(100),
 Precio NUMBER(10, 2),
 FOREIGN KEY (ID_Hotel) REFERENCES Hoteles(ID_Hotel)
);

-- Tabla Reservaciones_Servicios_Adicionales
CREATE TABLE Reservaciones_Servicios_Adicionales (
 ID_Reservacion_Servicio NUMBER DEFAULT seq_Reservaciones_Servicios_Adicionales.NEXTVAL PRIMARY KEY,
 ID_Reservacion NUMBER,
 ID_Servicio NUMBER,
 Cantidad NUMBER,
 FOREIGN KEY (ID_Reservacion) REFERENCES Reservaciones(ID_Reservacion),
 FOREIGN KEY (ID_Servicio) REFERENCES Servicios_Adicionales(ID_Servicio)
);

-- Tabla Empleados
CREATE TABLE Empleados (
 ID_Empleado NUMBER DEFAULT seq_Empleados.NEXTVAL PRIMARY KEY,
 Nombre VARCHAR2(100),
 Apellido VARCHAR2(100),
 Cargo VARCHAR2(100),
 Fecha_contratacion DATE,
 ID_Hotel NUMBER,
 FOREIGN KEY (ID_Hotel) REFERENCES Hoteles(ID_Hotel)
);

-- Tabla Historial_Reservaciones
CREATE TABLE Historial_Reservaciones (
 ID_Historial NUMBER DEFAULT seq_Historial_Reservaciones.NEXTVAL PRIMARY KEY,
 ID_Reservacion NUMBER,
 Fecha_modificacion TIMESTAMP,
 Comentario VARCHAR2(4000),
 FOREIGN KEY (ID_Reservacion) REFERENCES Reservaciones(ID_Reservacion)
);

-- Tabla Facturas
CREATE TABLE Facturas (
 ID_Factura NUMBER DEFAULT seq_Facturas.NEXTVAL PRIMARY KEY,
 ID_Reservacion NUMBER,
 Fecha_emision DATE,
 Total NUMBER(10, 2),
 FOREIGN KEY (ID_Reservacion) REFERENCES Reservaciones(ID_Reservacion)
);

-- Tabla Comentarios_Hotel
CREATE TABLE Comentarios_Hotel (
 ID_Comentario NUMBER DEFAULT seq_Comentarios_Hotel.NEXTVAL PRIMARY KEY,
 ID_Hotel NUMBER,
 ID_Cliente NUMBER,
 Comentario VARCHAR2(4000),
 Puntuacion NUMBER,
 Fecha DATE,
 FOREIGN KEY (ID_Hotel) REFERENCES Hoteles(ID_Hotel),
 FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Inserciones Hoteles
INSERT INTO Hoteles (Nombre, Direccion, Ciudad, Pais, Estrellas)
VALUES ('Hotel Playa Tamarindo', 'Playa Tamarindo', 'Tamarindo', 'Costa Rica', 4);

-- Inserciones Clientes
INSERT INTO Clientes (Nombre, Apellido, Correo_electronico, Telefono)
VALUES ('Luis', 'Gómez', 'luis.gomez@gmail.com', '506-8888-7777');

INSERT INTO Clientes (Nombre, Apellido, Correo_electronico, Telefono)
VALUES ('Maria', 'Rojas', 'maria.rojas@gmail.com', '506-7777-8888');

INSERT INTO Clientes (Nombre, Apellido, Correo_electronico, Telefono)
VALUES ('David', 'Muñoz', 'david.munoz@gmail.com', '506-6666-5555');

INSERT INTO Clientes (Nombre, Apellido, Correo_electronico, Telefono)
VALUES ('Ana', 'Fernández', 'ana.fernandez@gmail.com', '506-5555-4444');

INSERT INTO Clientes (Nombre, Apellido, Correo_electronico, Telefono)
VALUES ('Carlos', 'Hernández', 'carlos.hernandez@gmail.com', '506-4444-3333');

-- Inserciones Reservaciones
INSERT INTO Reservaciones (ID_Hotel, ID_Cliente, Fecha_inicio, Fecha_fin, Habitacion_asignada)
VALUES (1, 1, TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2024-08-05', 'YYYY-MM-DD'), '101');

INSERT INTO Reservaciones (ID_Hotel, ID_Cliente, Fecha_inicio, Fecha_fin, Habitacion_asignada)
VALUES (1, 2, TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-09-03', 'YYYY-MM-DD'), '202');

INSERT INTO Reservaciones (ID_Hotel, ID_Cliente, Fecha_inicio, Fecha_fin, Habitacion_asignada)
VALUES (1, 3, TO_DATE('2024-10-10', 'YYYY-MM-DD'), TO_DATE('2024-10-15', 'YYYY-MM-DD'), '303');

INSERT INTO Reservaciones (ID_Hotel, ID_Cliente, Fecha_inicio, Fecha_fin, Habitacion_asignada)
VALUES (1, 4, TO_DATE('2024-11-20', 'YYYY-MM-DD'), TO_DATE('2024-11-25', 'YYYY-MM-DD'), '404');

INSERT INTO Reservaciones (ID_Hotel, ID_Cliente, Fecha_inicio, Fecha_fin, Habitacion_asignada)
VALUES (1, 5, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-05', 'YYYY-MM-DD'), '505');

-- Inserciones Reservaciones_Restaurantes
INSERT INTO Reservaciones_Restaurantes (ID_Reservacion, Fecha, Hora, Numero_de_personas)
VALUES (1, TO_DATE('2024-08-02', 'YYYY-MM-DD'), '20:00', 4);

INSERT INTO Reservaciones_Restaurantes (ID_Reservacion, Fecha, Hora, Numero_de_personas)
VALUES (2, TO_DATE('2024-09-02', 'YYYY-MM-DD'), '11:00', 2);

INSERT INTO Reservaciones_Restaurantes (ID_Reservacion, Fecha, Hora, Numero_de_personas)
VALUES (3, TO_DATE('2024-10-11', 'YYYY-MM-DD'), '12:00', 3);

INSERT INTO Reservaciones_Restaurantes (ID_Reservacion, Fecha, Hora, Numero_de_personas)
VALUES (4, TO_DATE('2024-11-21', 'YYYY-MM-DD'), '22:00', 6);

INSERT INTO Reservaciones_Restaurantes (ID_Reservacion, Fecha, Hora, Numero_de_personas)
VALUES (5, TO_DATE('2024-12-02', 'YYYY-MM-DD'), '10:00', 5);

-- Inserciones Tipos_de_Habitaciones
INSERT INTO Tipos_de_Habitaciones (Descripcion, Precio_por_noche, Capacidad)
VALUES ('Standard', 80.00, 2);

INSERT INTO Tipos_de_Habitaciones (Descripcion, Precio_por_noche, Capacidad)
VALUES ('Deluxe', 120.00, 2);

INSERT INTO Tipos_de_Habitaciones (Descripcion, Precio_por_noche, Capacidad)
VALUES ('Suite', 180.00, 4);

INSERT INTO Tipos_de_Habitaciones (Descripcion, Precio_por_noche, Capacidad)
VALUES ('Suite Familiar', 230.00, 5);

INSERT INTO Tipos_de_Habitaciones (Descripcion, Precio_por_noche, Capacidad)
VALUES ('Suite Familiar Plus', 450.00, 6);

-- Inserciones Reservaciones_Habitaciones
INSERT INTO Reservaciones_Habitaciones (ID_Reservacion, ID_Tipo_Habitacion, Cantidad, Precio)
VALUES (1, 1, 1, 80.00);

INSERT INTO Reservaciones_Habitaciones (ID_Reservacion, ID_Tipo_Habitacion, Cantidad, Precio)
VALUES (2, 2, 1, 120.00);

INSERT INTO Reservaciones_Habitaciones (ID_Reservacion, ID_Tipo_Habitacion, Cantidad, Precio)
VALUES (3, 3, 1, 180.00);

INSERT INTO Reservaciones_Habitaciones (ID_Reservacion, ID_Tipo_Habitacion, Cantidad, Precio)
VALUES (4, 4, 1, 230.00);

INSERT INTO Reservaciones_Habitaciones (ID_Reservacion, ID_Tipo_Habitacion, Cantidad, Precio)
VALUES (5, 5, 1, 450.00);

-- Inserciones Servicios_Adicionales
INSERT INTO Servicios_Adicionales (ID_Hotel, Nombre, Precio)
VALUES (1, 'Spa', 40.00);

INSERT INTO Servicios_Adicionales (ID_Hotel, Nombre, Precio)
VALUES (1, 'Gimnasio', 25.00);

INSERT INTO Servicios_Adicionales (ID_Hotel, Nombre, Precio)
VALUES (1, 'Traslado al Aeropuerto', 20.00);

INSERT INTO Servicios_Adicionales (ID_Hotel, Nombre, Precio)
VALUES (1, 'Desayuno', 12.00);

INSERT INTO Servicios_Adicionales (ID_Hotel, Nombre, Precio)
VALUES (1, 'Estacionamiento', 8.00);

-- Inserciones Reservaciones_Servicios_Adicionales
INSERT INTO Reservaciones_Servicios_Adicionales (ID_Reservacion, ID_Servicio, Cantidad)
VALUES (1, 1, 1);

INSERT INTO Reservaciones_Servicios_Adicionales (ID_Reservacion, ID_Servicio, Cantidad)
VALUES (2, 2, 1);

INSERT INTO Reservaciones_Servicios_Adicionales (ID_Reservacion, ID_Servicio, Cantidad)
VALUES (3, 3, 1);

INSERT INTO Reservaciones_Servicios_Adicionales (ID_Reservacion, ID_Servicio, Cantidad)
VALUES (4, 4, 1);

INSERT INTO Reservaciones_Servicios_Adicionales (ID_Reservacion, ID_Servicio, Cantidad)
VALUES (5, 5, 1);

-- Inserciones Empleados
INSERT INTO Empleados (Nombre, Apellido, Cargo, Fecha_contratacion, ID_Hotel)
VALUES ('Alice', 'Johnson', 'Manager', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1);

INSERT INTO Empleados (Nombre, Apellido, Cargo, Fecha_contratacion, ID_Hotel)
VALUES ('Jorge', 'Salazar', 'Recepcionista', TO_DATE('2020-01-15', 'YYYY-MM-DD'), 1);

INSERT INTO Empleados (Nombre, Apellido, Cargo, Fecha_contratacion, ID_Hotel)
VALUES ('Sergio', 'Cruz', 'Cocinero', TO_DATE('2021-07-10', 'YYYY-MM-DD'), 1);

INSERT INTO Empleados (Nombre, Apellido, Cargo, Fecha_contratacion, ID_Hotel)
VALUES ('Mariana', 'Gutiérrez', 'Limpieza de habitación', TO_DATE('2022-05-05', 'YYYY-MM-DD'), 1);

INSERT INTO Empleados (Nombre, Apellido, Cargo, Fecha_contratacion, ID_Hotel)
VALUES ('Ricardo', 'Pérez', 'Jardinero', TO_DATE('2018-12-12', 'YYYY-MM-DD'), 1);

-- Inserciones Facturas
INSERT INTO Facturas (ID_Reservacion, Fecha_emision, Total)
VALUES (1, SYSDATE, 150.00);

INSERT INTO Facturas (ID_Reservacion, Fecha_emision, Total)
VALUES (2, SYSDATE, 180.00);

INSERT INTO Facturas (ID_Reservacion, Fecha_emision, Total)
VALUES (3, SYSDATE, 220.00);

INSERT INTO Facturas (ID_Reservacion, Fecha_emision, Total)
VALUES (4, SYSDATE, 275.00);

INSERT INTO Facturas (ID_Reservacion, Fecha_emision, Total)
VALUES (5, SYSDATE, 550.00);

-- Inserciones Comentarios_hotel
INSERT INTO Comentarios_hotel (ID_Hotel, ID_Cliente, Comentario, Fecha)
VALUES (1, 1, 'Excelente servicio y habitación limpia.', TO_DATE('2024-08-03', 'YYYY-MM-DD'));

INSERT INTO Comentarios_hotel (ID_Hotel, ID_Cliente, Comentario, Fecha)
VALUES (1, 2, 'Buena ubicación pero el desayuno podría mejorar.', TO_DATE('2024-09-02', 'YYYY-MM-DD'));

INSERT INTO Comentarios_hotel (ID_Hotel, ID_Cliente, Comentario, Fecha)
VALUES (1, 3, 'Muy buen lugar para pasar unas vacaciones.', TO_DATE('2024-10-12', 'YYYY-MM-DD'));

INSERT INTO Comentarios_hotel (ID_Hotel, ID_Cliente, Comentario, Fecha)
VALUES (1, 4, 'Habitación espaciosa pero el wifi era lento.', TO_DATE('2024-11-23', 'YYYY-MM-DD'));

INSERT INTO Comentarios_hotel (ID_Hotel, ID_Cliente, Comentario, Fecha)
VALUES (1, 5, 'Excelente relación calidad-precio.', TO_DATE('2024-12-03', 'YYYY-MM-DD'));



-- Procedimientos almacenados

--1. Agregar un nuevo cliente
CREATE OR REPLACE PROCEDURE Insertar_Cliente (
  p_ID_Cliente IN NUMBER,
  p_Nombre IN VARCHAR2,
  p_Apellido IN VARCHAR2,
  p_Correo_Electronico IN VARCHAR2,
  p_Telefono IN VARCHAR2
) AS
BEGIN
  INSERT INTO Clientes (ID_Cliente, Nombre, Apellido, Correo_Electronico, Telefono)
  VALUES (p_ID_Cliente, p_Nombre, p_Apellido, p_Correo_Electronico, p_Telefono);
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
  p_ID_Hotel IN NUMBER,          -- Parámetro de entrada: ID del hotel
  p_Resultado OUT SYS_REFCURSOR  -- Parámetro de salida: Cursor para los resultados
) AS
BEGIN
  -- Abrir el cursor para la consulta
  OPEN p_Resultado FOR
    SELECT SA.ID_Servicio, SA.Nombre, SA.Precio
    FROM Servicios_Adicionales SA
    WHERE SA.ID_Hotel = p_ID_Hotel;
END;
/


--4. Realizar una nueva reservación
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

--5. Actualizar la información de un cliente
CREATE OR REPLACE PROCEDURE Actualizar_Cliente (
  p_ID_Cliente IN NUMBER,
  p_Nombre IN VARCHAR2,
  p_Apellido IN VARCHAR2,
  p_Correo_Electronico IN VARCHAR2,
  p_Telefono IN VARCHAR2
) AS
BEGIN
  UPDATE Clientes
  SET Nombre = p_Nombre, Apellido = p_Apellido, Correo_Electronico = p_Correo_Electronico,
      Telefono = p_Telefono
  WHERE ID_Cliente = p_ID_Cliente;
END;
/

--6. Eliminar una reservación por ID
CREATE OR REPLACE PROCEDURE Eliminar_Reservacion_Por_ID (
  p_ID_Reservacion IN NUMBER
) AS
BEGIN
  DELETE FROM Reservaciones
  WHERE ID_Reservacion = p_ID_Reservacion;
END;
/

--7. Obtener el total de una factura por ID de reservación
CREATE OR REPLACE PROCEDURE Obtener_Total_Factura (
  p_ID_Reservacion IN NUMBER,           -- Parámetro de entrada: ID de la reservación
  p_Total OUT NUMBER                    -- Parámetro de salida: Total de la factura
) AS
BEGIN
  -- Consultar el total de la factura y almacenarlo en el parámetro de salida
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

--9. Buscar empleados por hotel y cargo
-- Crear o reemplazar procedimiento con REF CURSOR
CREATE OR REPLACE PROCEDURE Buscar_Empleados_Por_Hotel_Y_Cargo (
  p_ID_Hotel IN NUMBER,          -- Parámetro de entrada: ID del hotel
  p_Cargo IN VARCHAR2,           -- Parámetro de entrada: Cargo
  p_Resultado OUT SYS_REFCURSOR  -- Parámetro de salida: Cursor para los resultados
) AS
BEGIN
  -- Abrir el cursor para la consulta
  OPEN p_Resultado FOR
    SELECT Nombre, Apellido
    FROM Empleados
    WHERE ID_Hotel = p_ID_Hotel AND Cargo = p_Cargo;
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

--Funciones

--1. Función que devuelve el nombre y la dirección de un hotel dado un ID de reservación
CREATE OR REPLACE FUNCTION Obtener_Hotel_Por_Reservacion(ID_Reservacion IN NUMBER) 
RETURN SYS_REFCURSOR  -- Devuelve un cursor para manejar múltiples filas
AS
  v_cursor SYS_REFCURSOR;  -- Declara un cursor
BEGIN
  OPEN v_cursor FOR  -- Abre el cursor y ejecuta la consulta
  SELECT H.Nombre, H.Direccion  -- Selecciona el nombre y la dirección del hotel
  FROM Hoteles H  -- Tabla de hoteles
  INNER JOIN Reservaciones R ON H.ID_Hotel = R.ID_Hotel  -- Une con la tabla de reservaciones por ID de hotel
  WHERE R.ID_Reservacion = ID_Reservacion;  -- Filtra por el ID de reservación dado
  
  RETURN v_cursor;  -- Retorna el cursor con los resultados
END;
/

-- Uso de la función para obtener los datos del hotel de una reservación específica
VARIABLE cur REFCURSOR;
EXEC :cur := Obtener_Hotel_Por_Reservacion(1);  -- Ejecuta la función con un ID de reservación
PRINT cur;  -- Muestra los resultados

--2. Función que devuelve el nombre completo de un cliente dado un ID de reservación
CREATE OR REPLACE FUNCTION Obtener_Cliente_Por_Reservacion(ID_Reservacion IN NUMBER) 
RETURN SYS_REFCURSOR  -- Devuelve un cursor para manejar múltiples filas
AS
  v_cursor SYS_REFCURSOR;  -- Declara un cursor
BEGIN
  OPEN v_cursor FOR  -- Abre el cursor y ejecuta la consulta
  SELECT C.Nombre || ' ' || C.Apellido AS Nombre_Completo  -- Concatenar nombre y apellido del cliente
  FROM Clientes C  -- Tabla de clientes
  INNER JOIN Reservaciones R ON C.ID_Cliente = R.ID_Cliente  -- Une con la tabla de reservaciones por ID de cliente
  WHERE R.ID_Reservacion = ID_Reservacion;  -- Filtra por el ID de reservación dado
  
  RETURN v_cursor;  -- Retorna el cursor con los resultados
END;
/

-- Uso de la función para obtener el nombre completo de un cliente por reservación
VARIABLE cur REFCURSOR;
EXEC :cur := Obtener_Cliente_Por_Reservacion(1);  -- Ejecuta la función con un ID de reservación
PRINT cur;  -- Muestra los resultados

--3. Función que devuelve el total de una factura dado un ID de reservación
CREATE OR REPLACE FUNCTION Obtener_Total_Factura_Por_Reservacion(ID_Reservacion IN NUMBER) 
RETURN NUMBER  -- Devuelve un número (total de la factura)
AS
  v_Total NUMBER(10, 2);  -- Declara una variable para almacenar el total
BEGIN
  SELECT Total INTO v_Total  -- Asigna el total de la factura a la variable
  FROM Facturas  -- Tabla de facturas
  WHERE ID_Reservacion = ID_Reservacion;  -- Filtra por el ID de reservación dado
  
  RETURN v_Total;  -- Retorna el total de la factura
END;
/

-- Uso de la función para obtener el total de una factura por reservación
SELECT Obtener_Total_Factura_Por_Reservacion(1) AS Total_Factura FROM DUAL;  -- Ejecuta la función y muestra el total


--4. Función que devuelve el cargo de un empleado dado su nombre completo
CREATE OR REPLACE FUNCTION Obtener_Cargo_Empleado_Por_Nombre_Completo(Nombre IN VARCHAR2, Apellido IN VARCHAR2) 
RETURN VARCHAR2  -- Devuelve un valor de texto (cargo del empleado)
AS
  v_Cargo VARCHAR2(100);  -- Declara una variable para almacenar el cargo
BEGIN
  SELECT Cargo INTO v_Cargo  -- Asigna el cargo a la variable
  FROM Empleados  -- Tabla de empleados
  WHERE Nombre = Nombre AND Apellido = Apellido;  -- Filtra por el nombre y apellido dados
  
  RETURN v_Cargo;  -- Retorna el cargo del empleado
END;
/

-- Uso de la función para obtener el cargo de un empleado por su nombre completo
SELECT Obtener_Cargo_Empleado_Por_Nombre_Completo('Maria', 'Lopez') AS Cargo FROM DUAL;  -- Ejecuta la función y muestra el cargo


--5. Función que devuelve el historial de modificaciones de una reservación dada su ID
CREATE OR REPLACE FUNCTION Obtener_Historial_Reservacion(ID_Reservacion IN NUMBER) 
RETURN SYS_REFCURSOR  -- Devuelve un cursor para manejar múltiples filas
AS
  v_cursor SYS_REFCURSOR;  -- Declara un cursor
BEGIN
  OPEN v_cursor FOR  -- Abre el cursor y ejecuta la consulta
  SELECT Fecha_modificacion, Comentario  -- Selecciona la fecha de modificación y el comentario
  FROM Historial_Reservaciones  -- Tabla de historial de reservaciones
  WHERE ID_Reservacion = ID_Reservacion;  -- Filtra por el ID de reservación dado
  
  RETURN v_cursor;  -- Retorna el cursor con los resultados
END;
/

-- Uso de la función para obtener el historial de una reservación específica
VARIABLE cur REFCURSOR;
EXEC :cur := Obtener_Historial_Reservacion(1);  -- Ejecuta la función con un ID de reservación
PRINT cur;  -- Muestra los resultados

--6. Función que devuelve la cantidad total de reservaciones hechas por un cliente dado su ID
CREATE OR REPLACE FUNCTION Obtener_Total_Reservaciones_Por_Cliente(ID_Cliente IN NUMBER) 
RETURN NUMBER  -- Devuelve un número (cantidad de reservaciones)
AS
  v_Total_Reservaciones NUMBER;  -- Declara una variable para almacenar el total de reservaciones
BEGIN
  SELECT COUNT(*) INTO v_Total_Reservaciones  -- Cuenta la cantidad de reservaciones del cliente
  FROM Reservaciones  -- Tabla de reservaciones
  WHERE ID_Cliente = ID_Cliente;  -- Filtra por el ID del cliente dado
  
  RETURN v_Total_Reservaciones;  -- Retorna la cantidad total de reservaciones
END;
/

-- Uso de la función para obtener el total de reservaciones de un cliente
SELECT Obtener_Total_Reservaciones_Por_Cliente(1) AS Total_Reservaciones FROM DUAL;  -- Ejecuta la función y muestra el total


--7. Función que devuelve el promedio de puntuaciones de los comentarios de un hotel dado su ID
CREATE OR REPLACE FUNCTION Obtener_Promedio_Puntuacion_Por_Hotel(ID_Hotel IN NUMBER) 
RETURN NUMBER  -- Devuelve un número (promedio de puntuaciones)
AS
  v_Promedio_Puntuacion NUMBER(5, 2);  -- Declara una variable para almacenar el promedio
BEGIN
  SELECT AVG(Puntuacion) INTO v_Promedio_Puntuacion  -- Calcula el promedio de las puntuaciones
  FROM Comentarios_Hotel  -- Tabla de comentarios del hotel
  WHERE ID_Hotel = ID_Hotel;  -- Filtra por el ID del hotel dado
  
  RETURN v_Promedio_Puntuacion;  -- Retorna el promedio de puntuaciones
END;
/

-- Uso de la función para obtener el promedio de puntuaciones de un hotel
SELECT Obtener_Promedio_Puntuacion_Por_Hotel(1) AS Promedio_Puntuacion FROM DUAL;  -- Ejecuta la función y muestra el promedio



-- Paquetes

-- Declaración del paquete para la gestión de reservas
CREATE OR REPLACE PACKAGE Gestion_Reservas AS
  -- Procedimiento para crear una nueva reservación
  PROCEDURE Crear_Reservacion(ID_Cliente IN NUMBER, ID_Hotel IN NUMBER, Fecha_inicio IN DATE, Fecha_fin IN DATE);
  
  -- Procedimiento para actualizar las fechas de una reservación existente
  PROCEDURE Actualizar_Fechas_Reservacion(ID_Reservacion IN NUMBER, Nueva_Fecha_inicio IN DATE, Nueva_Fecha_fin IN DATE);
  
  -- Procedimiento para cancelar una reservación
  PROCEDURE Cancelar_Reservacion(ID_Reservacion IN NUMBER);
END Gestion_Reservas;
/

--1. Implementación del paquete para la gestión de reservas
CREATE OR REPLACE PACKAGE BODY Gestion_Reservas AS
  -- Implementación del procedimiento para crear una nueva reservación
  PROCEDURE Crear_Reservacion(ID_Cliente IN NUMBER, ID_Hotel IN NUMBER, Fecha_inicio IN DATE, Fecha_fin IN DATE) IS
  BEGIN
    INSERT INTO Reservaciones (ID_Cliente, ID_Hotel, Fecha_inicio, Fecha_fin)
    VALUES (ID_Cliente, ID_Hotel, Fecha_inicio, Fecha_fin);
  END Crear_Reservacion;
  
  -- Implementación del procedimiento para actualizar las fechas de una reservación existente
  PROCEDURE Actualizar_Fechas_Reservacion(ID_Reservacion IN NUMBER, Nueva_Fecha_inicio IN DATE, Nueva_Fecha_fin IN DATE) IS
  BEGIN
    UPDATE Reservaciones
    SET Fecha_inicio = Nueva_Fecha_inicio, Fecha_fin = Nueva_Fecha_fin
    WHERE ID_Reservacion = ID_Reservacion;
  END Actualizar_Fechas_Reservacion;
  
  -- Implementación del procedimiento para cancelar una reservación
  PROCEDURE Cancelar_Reservacion(ID_Reservacion IN NUMBER) IS
  BEGIN
    DELETE FROM Reservaciones WHERE ID_Reservacion = ID_Reservacion;
  END Cancelar_Reservacion;
END Gestion_Reservas;
/


--2. Paquete GESTION_CLIENTES: Este paquete gestiona las operaciones CRUD (Crear, Leer, Actualizar, Eliminar) para la tabla de clientes.

CREATE OR REPLACE PACKAGE Gestion_Clientes AS
  -- Procedimiento para agregar un nuevo cliente
  PROCEDURE Agregar_Cliente(Nombre IN VARCHAR2, Apellido IN VARCHAR2, Correo_Electronico IN VARCHAR2);
  
  -- Procedimiento para actualizar los datos de un cliente existente
  PROCEDURE Actualizar_Cliente(ID_Cliente IN NUMBER, Nuevo_Nombre IN VARCHAR2, Nuevo_Apellido IN VARCHAR2, Nuevo_Correo_Electronico IN VARCHAR2);
  
  -- Procedimiento para eliminar un cliente
  PROCEDURE Eliminar_Cliente(ID_Cliente IN NUMBER);
END Gestion_Clientes;
/

-- Implementación del paquete para la gestión de clientes
CREATE OR REPLACE PACKAGE BODY Gestion_Clientes AS
  -- Implementación del procedimiento para agregar un nuevo cliente
  PROCEDURE Agregar_Cliente(Nombre IN VARCHAR2, Apellido IN VARCHAR2, Correo_Electronico IN VARCHAR2) IS
  BEGIN
    -- Inserta un nuevo registro en la tabla Clientes
    INSERT INTO Clientes (Nombre, Apellido, Correo_Electronico)
    VALUES (Nombre, Apellido, Correo_Electronico);
  END Agregar_Cliente;
  
  -- Implementación del procedimiento para actualizar los datos de un cliente existente
  PROCEDURE Actualizar_Cliente(ID_Cliente IN NUMBER, Nuevo_Nombre IN VARCHAR2, Nuevo_Apellido IN VARCHAR2, Nuevo_Correo_Electronico IN VARCHAR2) IS
  BEGIN
    -- Actualiza la información del cliente basado en su ID
    UPDATE Clientes
    SET Nombre = Nuevo_Nombre, Apellido = Nuevo_Apellido, Correo_Electronico = Nuevo_Correo_Electronico
    WHERE Clientes.ID_Cliente = ID_Cliente;
  END Actualizar_Cliente;
  
  -- Implementación del procedimiento para eliminar un cliente
  PROCEDURE Eliminar_Cliente(ID_Cliente IN NUMBER) IS
  BEGIN
    -- Elimina el cliente de la tabla Clientes basado en su ID
    DELETE FROM Clientes WHERE Clientes.ID_Cliente = ID_Cliente;
  END Eliminar_Cliente;
END Gestion_Clientes;
/


--3. Paquete para la gestión de hoteles
CREATE OR REPLACE PACKAGE Gestion_Hoteles AS
  -- Procedimiento para agregar un nuevo hotel
  PROCEDURE Agregar_Hotel(Nombre IN VARCHAR2, Direccion IN VARCHAR2, Ciudad IN VARCHAR2, Pais IN VARCHAR2, Estrellas IN NUMBER);
  
  -- Procedimiento para actualizar los datos de un hotel existente
  PROCEDURE Actualizar_Hotel(ID_Hotel IN NUMBER, Nuevo_Nombre IN VARCHAR2, Nueva_Direccion IN VARCHAR2, Nueva_Ciudad IN VARCHAR2, Nuevo_Pais IN VARCHAR2, Nuevas_Estrellas IN NUMBER);
  
  -- Procedimiento para eliminar un hotel
  PROCEDURE Eliminar_Hotel(ID_Hotel IN NUMBER);
END Gestion_Hoteles;
/

-- Implementación del paquete para la gestión de hoteles
CREATE OR REPLACE PACKAGE BODY Gestion_Hoteles AS
  -- Implementación del procedimiento para agregar un nuevo hotel
  PROCEDURE Agregar_Hotel(Nombre IN VARCHAR2, Direccion IN VARCHAR2, Ciudad IN VARCHAR2, Pais IN VARCHAR2, Estrellas IN NUMBER) IS
  BEGIN
    INSERT INTO Hoteles (Nombre, DIRECCIÓN, Ciudad, PAÍS, Estrellas)
    VALUES (Nombre, Direccion, Ciudad, Pais, Estrellas);
  END Agregar_Hotel;
  
  -- Implementación del procedimiento para actualizar los datos de un hotel existente
  PROCEDURE Actualizar_Hotel(ID_Hotel IN NUMBER, Nuevo_Nombre IN VARCHAR2, Nueva_Direccion IN VARCHAR2, Nueva_Ciudad IN VARCHAR2, Nuevo_Pais IN VARCHAR2, Nuevas_Estrellas IN NUMBER) IS
  BEGIN
    UPDATE Hoteles
    SET Nombre = Nuevo_Nombre, DIRECCIÓN = Nueva_Direccion, Ciudad = Nueva_Ciudad, PAÍS = Nuevo_Pais, Estrellas = Nuevas_Estrellas
    WHERE ID_Hotel = ID_Hotel;
  END Actualizar_Hotel;
  
  -- Implementación del procedimiento para eliminar un hotel
  PROCEDURE Eliminar_Hotel(ID_Hotel IN NUMBER) IS
  BEGIN
    DELETE FROM Hoteles WHERE ID_Hotel = ID_Hotel;
  END Eliminar_Hotel;
END Gestion_Hoteles;
/


--4. Declaración del paquete para la gestión de servicios adicionales
CREATE OR REPLACE PACKAGE Gestion_Servicios_Adicionales AS
  -- Procedimiento para agregar un nuevo servicio adicional
  PROCEDURE Agregar_Servicio(ID_Hotel IN NUMBER, Nombre_Servicio IN VARCHAR2, Precio IN NUMBER);
  
  -- Procedimiento para actualizar un servicio adicional existente
  PROCEDURE Actualizar_Servicio(ID_Servicio IN NUMBER, Nuevo_Nombre_Servicio IN VARCHAR2, Nuevo_Precio IN NUMBER);
  
  -- Procedimiento para eliminar un servicio adicional
  PROCEDURE Eliminar_Servicio(ID_Servicio IN NUMBER);
END Gestion_Servicios_Adicionales;
/

-- Implementación del paquete para la gestión de servicios adicionales
CREATE OR REPLACE PACKAGE BODY Gestion_Servicios_Adicionales AS
  -- Implementación del procedimiento para agregar un nuevo servicio adicional
  PROCEDURE Agregar_Servicio(ID_Hotel IN NUMBER, Nombre_Servicio IN VARCHAR2, Precio IN NUMBER) IS
  BEGIN
    INSERT INTO Servicios_Adicionales (ID_Hotel, Nombre, Precio)
    VALUES (ID_Hotel, Nombre_Servicio, Precio);
  END Agregar_Servicio;
  
  -- Implementación del procedimiento para actualizar un servicio adicional existente
  PROCEDURE Actualizar_Servicio(ID_Servicio IN NUMBER, Nuevo_Nombre_Servicio IN VARCHAR2, Nuevo_Precio IN NUMBER) IS
  BEGIN
    UPDATE Servicios_Adicionales
    SET Nombre = Nuevo_Nombre_Servicio, Precio = Nuevo_Precio
    WHERE ID_Servicio = ID_Servicio;
  END Actualizar_Servicio;
  
  -- Implementación del procedimiento para eliminar un servicio adicional
  PROCEDURE Eliminar_Servicio(ID_Servicio IN NUMBER) IS
  BEGIN
    DELETE FROM Servicios_Adicionales WHERE ID_Servicio = ID_Servicio;
  END Eliminar_Servicio;
END Gestion_Servicios_Adicionales;
/



--5. Declaración del paquete para la gestión de facturación
CREATE OR REPLACE PACKAGE Gestion_Facturacion AS
  -- Procedimiento para generar una nueva factura
  -- Parámetros:
  -- ID_Reservacion: Identificador de la reservación asociada
  -- Monto_Total: Monto total de la nueva factura
  PROCEDURE Generar_Factura(ID_Reservacion IN NUMBER, Monto_Total IN NUMBER);
  
  -- Procedimiento para actualizar el monto de una factura existente
  -- Parámetros:
  -- ID_Factura: Identificador de la factura a actualizar
  -- Nuevo_Monto_Total: Nuevo monto total de la factura
  PROCEDURE Actualizar_Factura(ID_Factura IN NUMBER, Nuevo_Monto_Total IN NUMBER);
  
  -- Procedimiento para eliminar una factura
  -- Parámetro:
  -- ID_Factura: Identificador de la factura a eliminar
  PROCEDURE Eliminar_Factura(ID_Factura IN NUMBER);
END Gestion_Facturacion;
/

-- Implementación del paquete para la gestión de facturación
CREATE OR REPLACE PACKAGE BODY Gestion_Facturacion AS
  -- Implementación del procedimiento para generar una nueva factura
  PROCEDURE Generar_Factura(ID_Reservacion IN NUMBER, Monto_Total IN NUMBER) IS
  BEGIN
    -- Inserta una nueva fila en la tabla Facturas con la fecha actual
    INSERT INTO Facturas (ID_Reservacion, Total, Fecha_emision)
    VALUES (ID_Reservacion, Monto_Total, SYSDATE);
  END Generar_Factura;
  
  -- Implementación del procedimiento para actualizar el monto de una factura existente
  PROCEDURE Actualizar_Factura(ID_Factura IN NUMBER, Nuevo_Monto_Total IN NUMBER) IS
  BEGIN
    -- Actualiza el monto total de una factura específica en la tabla Facturas
    UPDATE Facturas
    SET Total = Nuevo_Monto_Total
    WHERE ID_Factura = ID_Factura;
  END Actualizar_Factura;
  
  -- Implementación del procedimiento para eliminar una factura
  PROCEDURE Eliminar_Factura(ID_Factura IN NUMBER) IS
  BEGIN
    -- Elimina la fila correspondiente de la tabla Facturas
    DELETE FROM Facturas WHERE ID_Factura = ID_Factura;
  END Eliminar_Factura;
  
END Gestion_Facturacion;
/


--Triggers

--1. Trigger para registrar modificaciones en el historial de reservaciones
CREATE OR REPLACE TRIGGER Modificar_Historial_Reservaciones
AFTER UPDATE ON Reservaciones
FOR EACH ROW
BEGIN
  -- Inserta una nueva entrada en Historial_Reservaciones cada vez que se actualiza una reservación
  INSERT INTO Historial_Reservaciones (ID_Reservacion, Fecha_modificacion, Comentario)
  VALUES (:NEW.ID_Reservacion, SYSDATE, 'Reservación modificada.');
END;
/


--2. Trigger para actualizar el total de la factura después de una inserción de reservación
CREATE OR REPLACE TRIGGER Actualizar_Total_Factura
AFTER INSERT ON Reservaciones
FOR EACH ROW
DECLARE
  v_Total NUMBER(10, 2);
BEGIN
  -- Calcula el total de la factura basado en la reservación recién insertada
  SELECT SUM(Precio) INTO v_Total
  FROM Reservaciones_Habitaciones
  WHERE ID_Reservacion = :NEW.ID_Reservacion;
  
  -- Inserta la nueva factura con el monto calculado
  INSERT INTO Facturas (ID_Reservacion, Fecha_emision, Total)
  VALUES (:NEW.ID_Reservacion, SYSDATE, v_Total);
END;
/


--3. Trigger para evitar la eliminación de reservaciones con facturas asociadas
CREATE OR REPLACE TRIGGER Evitar_Eliminacion_Reservación_Con_Factura
BEFORE DELETE ON Reservaciones
FOR EACH ROW
DECLARE
  v_Count NUMBER;
BEGIN
  -- Verifica si la reservación a eliminar tiene facturas asociadas
  SELECT COUNT(*)
  INTO v_Count
  FROM Facturas
  WHERE ID_Reservacion = :OLD.ID_Reservacion;

  IF v_Count > 0 THEN
    -- Lanza un error si la reservación tiene facturas asociadas
    RAISE_APPLICATION_ERROR(-20001, 'No se puede eliminar una reservación con una factura asociada.');
  END IF;
END;
/


--4. Trigger para actualizar la fecha de fin de la reservación si se modifica la fecha de inicio
CREATE OR REPLACE TRIGGER Actualizar_Fecha_Fin
BEFORE UPDATE OF Fecha_inicio ON Reservaciones
FOR EACH ROW
BEGIN
  -- Actualiza la fecha de fin a una semana después de la nueva fecha de inicio
  :NEW.Fecha_fin := :NEW.Fecha_inicio + INTERVAL '7' DAY;
END;
/


--5. Trigger para actualizar el total de la factura después de una actualización en la tabla de reservaciones
CREATE OR REPLACE TRIGGER Actualizar_Total_Factura_Despues_Actualizacion
AFTER UPDATE ON Reservaciones
FOR EACH ROW
DECLARE
  v_Total DECIMAL(10, 2);
BEGIN
  -- Recalcula el total de la factura basándose en la información actualizada de la reservación
  SELECT SUM(Precio)
  INTO v_Total
  FROM Reservaciones_Habitaciones
  WHERE ID_Reservacion = :NEW.ID_Reservacion;

  -- Actualiza el total en la tabla de facturas
  UPDATE Facturas
  SET Total = v_Total
  WHERE ID_Reservacion = :NEW.ID_Reservacion;
END;
/


-- Cursores

--1. Cursor para obtener todos los clientes
DECLARE
  CURSOR c_Clientes IS
    SELECT ID_Cliente, Nombre, Apellido, Correo_Electronico
    FROM Clientes;
  
  v_ID_Cliente Clientes.ID_Cliente%TYPE;
  v_Nombre Clientes.Nombre%TYPE;
  v_Apellido Clientes.Apellido%TYPE;
  v_Correo_Electronico Clientes.Correo_Electronico%TYPE;
BEGIN
  OPEN c_Clientes;
  LOOP
    FETCH c_Clientes INTO v_ID_Cliente, v_Nombre, v_Apellido, v_Correo_Electronico;
    EXIT WHEN c_Clientes%NOTFOUND;
    -- Procesar cada registro aquí
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_ID_Cliente || ', Nombre: ' || v_Nombre || ', Apellido: ' || v_Apellido || ', Correo: ' || v_Correo_Electronico);
  END LOOP;
  CLOSE c_Clientes;
END;
/

--2. Cursor para obtener todas las reservaciones de un cliente específico

DECLARE
  p_ID_Cliente NUMBER := 1; -- ID del cliente para filtrar

  -- Declaración del cursor para seleccionar las reservaciones del cliente
  CURSOR c_Reservaciones IS
    SELECT ID_Reservacion, Fecha_inicio, Fecha_fin, ID_Hotel
    FROM Reservaciones
    WHERE ID_Cliente = p_ID_Cliente;

  -- Variables para almacenar los datos obtenidos del cursor
  v_ID_Reservacion Reservaciones.ID_Reservacion%TYPE;
  v_Fecha_inicio Reservaciones.Fecha_inicio%TYPE;
  v_Fecha_fin Reservaciones.Fecha_fin%TYPE;
  v_ID_Hotel Reservaciones.ID_Hotel%TYPE;

BEGIN
  -- Abrir el cursor
  OPEN c_Reservaciones;

  -- Loop para recorrer cada fila del cursor
  LOOP
    -- Obtener una fila del cursor en las variables
    FETCH c_Reservaciones INTO v_ID_Reservacion, v_Fecha_inicio, v_Fecha_fin, v_ID_Hotel;

    -- Salir del loop si no hay más filas
    EXIT WHEN c_Reservaciones%NOTFOUND;

    -- Procesar cada registro aquí
    DBMS_OUTPUT.PUT_LINE('ID Reservación: ' || v_ID_Reservacion || ', Inicio: ' || v_Fecha_inicio || ', Fin: ' || v_Fecha_fin || ', Hotel: ' || v_ID_Hotel);
  END LOOP;

  -- Cerrar el cursor
  CLOSE c_Reservaciones;
END;
/


--3. Cursor para obtener todos los hoteles en una ciudad específica
DECLARE
  p_Ciudad VARCHAR2(100) := 'Madrid'; -- Ciudad para filtrar
  CURSOR c_Hoteles IS
    SELECT ID_Hotel, Nombre, Dirección, País, Estrellas
    FROM Hoteles
    WHERE Ciudad = p_Ciudad;
  
  v_ID_Hotel Hoteles.ID_Hotel%TYPE;
  v_Nombre Hoteles.Nombre%TYPE;
  v_Dirección Hoteles.Dirección%TYPE;
  v_País Hoteles.País%TYPE;
  v_Estrellas Hoteles.Estrellas%TYPE;
BEGIN
  OPEN c_Hoteles;
  LOOP
    FETCH c_Hoteles INTO v_ID_Hotel, v_Nombre, v_Dirección, v_País, v_Estrellas;
    EXIT WHEN c_Hoteles%NOTFOUND;
    -- Procesar cada registro aquí
    DBMS_OUTPUT.PUT_LINE('ID Hotel: ' || v_ID_Hotel || ', Nombre: ' || v_Nombre || ', Dirección: ' || v_Dirección || ', País: ' || v_País || ', Estrellas: ' || v_Estrellas);
  END LOOP;
  CLOSE c_Hoteles;
END;
/


--4. Cursor para obtener los comentarios de un hotel específico

DECLARE
  p_ID_Hotel NUMBER := 1; -- ID del hotel para filtrar

  -- Declaración del cursor para seleccionar los comentarios del hotel
  CURSOR c_Comentarios IS
    SELECT ID_Comentario, ID_Cliente, Comentario, Puntuacion, Fecha
    FROM Comentarios_Hotel
    WHERE ID_Hotel = p_ID_Hotel;

  -- Variables para almacenar los datos obtenidos del cursor
  v_ID_Comentario Comentarios_Hotel.ID_Comentario%TYPE;
  v_ID_Cliente Comentarios_Hotel.ID_Cliente%TYPE;
  v_Comentario Comentarios_Hotel.Comentario%TYPE;
  v_Puntuacion Comentarios_Hotel.Puntuacion%TYPE;
  v_Fecha Comentarios_Hotel.Fecha%TYPE;

BEGIN
  -- Abrir el cursor
  OPEN c_Comentarios;

  -- Loop para recorrer cada fila del cursor
  LOOP
    -- Obtener una fila del cursor en las variables
    FETCH c_Comentarios INTO v_ID_Comentario, v_ID_Cliente, v_Comentario, v_Puntuacion, v_Fecha;

    -- Salir del loop si no hay más filas
    EXIT WHEN c_Comentarios%NOTFOUND;

    -- Procesar cada registro aquí
    DBMS_OUTPUT.PUT_LINE('ID Comentario: ' || v_ID_Comentario || ', Cliente: ' || v_ID_Cliente || ', Comentario: ' || v_Comentario || ', Puntuación: ' || v_Puntuacion || ', Fecha: ' || v_Fecha);
  END LOOP;

  -- Cerrar el cursor
  CLOSE c_Comentarios;
END;
/

--5. Cursor para obtener las reservaciones con un total mayor a un monto específico
DECLARE
  p_Monto_Minimo NUMBER := 1000; -- Monto mínimo para filtrar

  -- Declaración del cursor para seleccionar reservaciones con facturas cuyo total es mayor al monto mínimo
  CURSOR c_Reservaciones IS
    SELECT R.ID_Reservacion, F.Total
    FROM Reservaciones R
    JOIN Facturas F ON R.ID_Reservacion = F.ID_Reservacion
    WHERE F.Total > p_Monto_Minimo;

  -- Variables para almacenar los datos obtenidos del cursor
  v_ID_Reservacion Reservaciones.ID_Reservacion%TYPE;
  v_Total Facturas.Total%TYPE;

BEGIN
  -- Abrir el cursor
  OPEN c_Reservaciones;

  -- Loop para recorrer cada fila del cursor
  LOOP
    -- Obtener una fila del cursor en las variables
    FETCH c_Reservaciones INTO v_ID_Reservacion, v_Total;

    -- Salir del loop si no hay más filas
    EXIT WHEN c_Reservaciones%NOTFOUND;

    -- Procesar cada registro aquí
    DBMS_OUTPUT.PUT_LINE('ID Reservación: ' || v_ID_Reservacion || ', Total: ' || v_Total);
  END LOOP;

  -- Cerrar el cursor
  CLOSE c_Reservaciones;
END;
/


--6. Cursor para obtener empleados por cargo específico
DECLARE
  p_Cargo VARCHAR2(100) := 'Recepcionista'; -- Cargo para filtrar
  CURSOR c_Empleados IS
    SELECT ID_Empleado, Nombre, Apellido
    FROM Empleados
    WHERE Cargo = p_Cargo;
  
  v_ID_Empleado Empleados.ID_Empleado%TYPE;
  v_Nombre Empleados.Nombre%TYPE;
  v_Apellido Empleados.Apellido%TYPE;
BEGIN
  OPEN c_Empleados;
  LOOP
    FETCH c_Empleados INTO v_ID_Empleado, v_Nombre, v_Apellido;
    EXIT WHEN c_Empleados%NOTFOUND;
    -- Procesar cada registro aquí
    DBMS_OUTPUT.PUT_LINE('ID Empleado: ' || v_ID_Empleado || ', Nombre: ' || v_Nombre || ', Apellido: ' || v_Apellido);
  END LOOP;
  CLOSE c_Empleados;
END;
/


--7. Cursor para obtener las reservaciones con fechas en el rango de un mes específico
DECLARE
  p_Mes DATE := TO_DATE('2024-05-01', 'YYYY-MM-DD'); -- Mes para filtrar
  p_Inicio DATE := TRUNC(p_Mes, 'MM'); -- Primer día del mes
  p_Fin DATE := LAST_DAY(p_Mes); -- Último día del mes

  -- Declaración del cursor para seleccionar reservaciones cuyo inicio esté en el mes especificado
  CURSOR c_Reservaciones IS
    SELECT ID_Reservacion, Fecha_inicio, Fecha_fin
    FROM Reservaciones
    WHERE Fecha_inicio BETWEEN p_Inicio AND p_Fin;

  -- Variables para almacenar los datos obtenidos del cursor
  v_ID_Reservacion Reservaciones.ID_Reservacion%TYPE;
  v_Fecha_inicio Reservaciones.Fecha_inicio%TYPE;
  v_Fecha_fin Reservaciones.Fecha_fin%TYPE;

BEGIN
  -- Abrir el cursor
  OPEN c_Reservaciones;

  -- Loop para recorrer cada fila del cursor
  LOOP
    -- Obtener una fila del cursor en las variables
    FETCH c_Reservaciones INTO v_ID_Reservacion, v_Fecha_inicio, v_Fecha_fin;

    -- Salir del loop si no hay más filas
    EXIT WHEN c_Reservaciones%NOTFOUND;

    -- Procesar cada registro aquí
    DBMS_OUTPUT.PUT_LINE('ID Reservación: ' || v_ID_Reservacion || ', Inicio: ' || v_Fecha_inicio || ', Fin: ' || v_Fecha_fin);
  END LOOP;

  -- Cerrar el cursor
  CLOSE c_Reservaciones;
END;
/

CREATE OR REPLACE PROCEDURE Actualizar_Puntuacion_Comentario (
  p_ID_Comentario IN NUMBER,
  p_Nueva_Puntuacion IN NUMBER
)
IS
BEGIN
  -- Actualizar la puntuación del comentario
  UPDATE Comentarios_Hotel
  SET Puntuacion = p_Nueva_Puntuacion
  WHERE ID_Comentario = p_ID_Comentario;

  -- Confirmar la actualización
  DBMS_OUTPUT.PUT_LINE('Puntuación actualizada con éxito');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al actualizar la puntuación: ' || SQLERRM);
END;


CREATE OR REPLACE PROCEDURE Buscar_Reservaciones_Por_Cliente (
  p_ID_Cliente IN NUMBER
)
IS
  CURSOR c_Reservaciones IS
    SELECT ID_Reservacion, ID_Hotel, Fecha_inicio, Fecha_fin, Habitacion_asignada
    FROM Reservaciones
    WHERE ID_Cliente = p_ID_Cliente;
BEGIN
  -- Recorrer las reservaciones del cliente
  FOR r IN c_Reservaciones LOOP
    DBMS_OUTPUT.PUT_LINE('Reservación: ' || r.ID_Reservacion || ', Hotel: ' || r.ID_Hotel || ', Desde: ' || r.Fecha_inicio || ' Hasta: ' || r.Fecha_fin || ', Habitación: ' || r.Habitacion_asignada);
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al buscar reservaciones: ' || SQLERRM);
END;



CREATE OR REPLACE PROCEDURE Registrar_Historial_Reservacion (
  p_ID_Reservacion IN NUMBER,
  p_Comentario IN VARCHAR2
)
IS
BEGIN
  -- Insertar el historial de la reservación
  INSERT INTO Historial_Reservaciones (ID_Historial, ID_Reservacion, Fecha_modificacion, Comentario)
  VALUES (seq_Historial_Reservaciones.NEXTVAL, p_ID_Reservacion, SYSTIMESTAMP, p_Comentario);

  -- Confirmar la inserción
  DBMS_OUTPUT.PUT_LINE('Historial de reservación registrado con éxito');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al registrar el historial: ' || SQLERRM);
END;



CREATE OR REPLACE PROCEDURE Calcular_Total_Facturacion_Cliente (
  p_ID_Cliente IN NUMBER
)
IS
  v_Total NUMBER := 0;
BEGIN
  -- Calcular el total de facturación para un cliente
  SELECT SUM(Total)
  INTO v_Total
  FROM Facturas f
  JOIN Reservaciones r ON f.ID_Reservacion = r.ID_Reservacion
  WHERE r.ID_Cliente = p_ID_Cliente;

  -- Mostrar el total
  DBMS_OUTPUT.PUT_LINE('Total de facturación para el cliente: ' || v_Total);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al calcular la facturación: ' || SQLERRM);
END;



CREATE OR REPLACE PROCEDURE Buscar_Comentarios_Hotel (
  p_ID_Hotel IN NUMBER
)
IS
  CURSOR c_Comentarios IS
    SELECT Comentario, Puntuacion, Fecha
    FROM Comentarios_Hotel
    WHERE ID_Hotel = p_ID_Hotel;
BEGIN
  -- Recorrer los comentarios del hotel
  FOR r IN c_Comentarios LOOP
    DBMS_OUTPUT.PUT_LINE('Comentario: ' || r.Comentario || ', Puntuación: ' || r.Puntuacion || ', Fecha: ' || r.Fecha);
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al buscar comentarios: ' || SQLERRM);
END;



CREATE OR REPLACE PROCEDURE Actualizar_Capacidad_Habitacion (
  p_ID_Tipo_Habitacion IN NUMBER,
  p_Nueva_Capacidad IN NUMBER
)
IS
BEGIN
  -- Actualizar la capacidad de la habitación
  UPDATE Tipos_de_Habitaciones
  SET Capacidad = p_Nueva_Capacidad
  WHERE ID_Tipo_Habitacion = p_ID_Tipo_Habitacion;

  -- Confirmar la actualización
  DBMS_OUTPUT.PUT_LINE('Capacidad de la habitación actualizada con éxito');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al actualizar la capacidad: ' || SQLERRM);
END;



CREATE OR REPLACE PROCEDURE Insertar_Tipo_Habitacion (
  p_Descripcion IN VARCHAR2,
  p_Precio IN NUMBER,
  p_Capacidad IN NUMBER
)
IS
BEGIN
  -- Insertar el nuevo tipo de habitación
  INSERT INTO Tipos_de_Habitaciones (ID_Tipo_Habitacion, Descripcion, Precio_por_noche, Capacidad)
  VALUES (seq_Tipos_de_Habitaciones.NEXTVAL, p_Descripcion, p_Precio, p_Capacidad);

  -- Confirmar la inserción
  DBMS_OUTPUT.PUT_LINE('Tipo de habitación insertado con éxito');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al insertar el tipo de habitación: ' || SQLERRM);
END;




CREATE OR REPLACE PROCEDURE Actualizar_Cargo_Empleado (
  p_ID_Empleado IN NUMBER,
  p_Nuevo_Cargo IN VARCHAR2
)
IS
BEGIN
  -- Actualizar el cargo del empleado
  UPDATE Empleados
  SET Cargo = p_Nuevo_Cargo
  WHERE ID_Empleado = p_ID_Empleado;

  -- Confirmar la actualización
  DBMS_OUTPUT.PUT_LINE('Cargo del empleado actualizado con éxito');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al actualizar el cargo: ' || SQLERRM);
END;



CREATE OR REPLACE PROCEDURE Eliminar_Servicio_Adicional (
  p_ID_Servicio IN NUMBER
)
IS
BEGIN
  -- Eliminar el servicio adicional
  DELETE FROM Servicios_Adicionales
  WHERE ID_Servicio = p_ID_Servicio;

  -- Confirmar la eliminación
  DBMS_OUTPUT.PUT_LINE('Servicio adicional eliminado con éxito');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al eliminar el servicio adicional: ' || SQLERRM);
END;



CREATE OR REPLACE PROCEDURE Buscar_Empleados_Por_Hotel (
  p_ID_Hotel IN NUMBER
)
IS
  CURSOR c_Empleados IS
    SELECT ID_Empleado, Nombre, Apellido, Cargo
    FROM Empleados
    WHERE ID_Hotel = p_ID_Hotel;
BEGIN
  -- Recorrer los empleados del hotel
  FOR r IN c_Empleados LOOP
    DBMS_OUTPUT.PUT_LINE('Empleado: ' || r.Nombre || ' ' || r.Apellido || ', Cargo: ' || r.Cargo);
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al buscar empleados: ' || SQLERRM);
END;




CREATE OR REPLACE PROCEDURE Actualizar_Fecha_Emision_Factura (
  p_ID_Factura IN NUMBER,
  p_Nueva_Fecha IN DATE
)
IS
BEGIN
  -- Actualizar la fecha de emisión de la factura
  UPDATE Facturas
  SET Fecha_emision = p_Nueva_Fecha
  WHERE ID_Factura = p_ID_Factura;

  -- Confirmar la actualización
  DBMS_OUTPUT.PUT_LINE('Fecha de emisión de la factura actualizada con éxito');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al actualizar la fecha de emisión: ' || SQLERRM);
END;



CREATE OR REPLACE PROCEDURE Actualizar_Habitacion_Reservacion (
  p_ID_Reservacion IN NUMBER,      -- ID de la reservación que se desea actualizar
  p_Nueva_Habitacion IN VARCHAR2   -- Nueva habitación asignada
)
IS
BEGIN
  -- Intentar actualizar la habitación asignada de la reservación
  UPDATE Reservaciones
  SET Habitacion_asignada = p_Nueva_Habitacion
  WHERE ID_Reservacion = p_ID_Reservacion;

  -- Confirmar que la actualización se realizó correctamente
  IF SQL%ROWCOUNT = 0 THEN
    -- Si ninguna fila fue afectada, lanzar un error
    RAISE_APPLICATION_ERROR(-20001, 'No se encontró la reservación con el ID proporcionado.');
  ELSE
    -- Si la actualización fue exitosa, mostrar un mensaje de confirmación
    DBMS_OUTPUT.PUT_LINE('Habitación de la reservación actualizada con éxito');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    -- Manejo de cualquier error que ocurra durante la ejecución
    DBMS_OUTPUT.PUT_LINE('Error al actualizar la habitación: ' || SQLERRM);
END;


CREATE OR REPLACE PROCEDURE Actualizar_Precio_Servicio (
  p_ID_Servicio IN NUMBER,      -- ID del servicio adicional que se desea actualizar
  p_Nuevo_Precio IN NUMBER      -- Nuevo precio del servicio adicional
)
IS
BEGIN
  -- Intentar actualizar el precio del servicio adicional
  UPDATE Servicios_Adicionales
  SET Precio = p_Nuevo_Precio
  WHERE ID_Servicio = p_ID_Servicio;

  -- Confirmar que la actualización se realizó correctamente
  IF SQL%ROWCOUNT = 0 THEN
    -- Si ninguna fila fue afectada, lanzar un error
    RAISE_APPLICATION_ERROR(-20002, 'No se encontró el servicio adicional con el ID proporcionado.');
  ELSE
    -- Si la actualización fue exitosa, mostrar un mensaje de confirmación
    DBMS_OUTPUT.PUT_LINE('Precio del servicio actualizado con éxito');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    -- Manejo de cualquier error que ocurra durante la ejecución
    DBMS_OUTPUT.PUT_LINE('Error al actualizar el precio del servicio: ' || SQLERRM);
END;


CREATE OR REPLACE VIEW Reservaciones_Por_Mes AS
SELECT 
    TO_CHAR(Fecha_inicio, 'YYYY-MM') AS Mes, -- Convertir la fecha de inicio a un formato de año-mes
    COUNT(*) AS Numero_Reservaciones -- Contar el número de reservaciones por mes
FROM 
    Reservaciones
GROUP BY 
    TO_CHAR(Fecha_inicio, 'YYYY-MM') -- Agrupar por el formato año-mes
ORDER BY 
    Mes; -- Ordenar por mes en orden cronológico

BEGIN
    -- Intentar acceder a la vista
    SELECT * FROM Reservaciones_Por_Mes;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de cualquier error que ocurra durante la ejecución
        DBMS_OUTPUT.PUT_LINE('Error al consultar la vista Reservaciones_Por_Mes: ' || SQLERRM);
END;



CREATE OR REPLACE VIEW Servicios_Por_Hotel AS
SELECT 
    H.Nombre AS Nombre_Hotel, -- Nombre del hotel donde se ofrece el servicio
    SA.Nombre AS Servicio, -- Nombre del servicio adicional
    SA.Precio -- Precio del servicio adicional
FROM 
    Servicios_Adicionales SA
JOIN 
    Hoteles H ON SA.ID_Hotel = H.ID_Hotel; -- Relacionar los servicios adicionales con los hoteles

BEGIN
    -- Intentar acceder a la vista
    SELECT * FROM Servicios_Por_Hotel;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de cualquier error que ocurra durante la ejecución
        DBMS_OUTPUT.PUT_LINE('Error al consultar la vista Servicios_Por_Hotel: ' || SQLERRM);
END;



CREATE OR REPLACE VIEW Clientes_Con_Reservaciones_Activas AS
SELECT 
    C.Nombre, -- Nombre del cliente
    C.Apellido, -- Apellido del cliente
    C.Correo_electronico, -- Correo electrónico del cliente
    R.Fecha_inicio, -- Fecha de inicio de la reservación
    R.Fecha_fin -- Fecha de fin de la reservación
FROM 
    Clientes C
JOIN 
    Reservaciones R ON C.ID_Cliente = R.ID_Cliente -- Relacionar clientes con sus reservaciones
WHERE 
    R.Fecha_fin >= SYSDATE; -- Mostrar sólo las reservaciones cuya fecha de fin es posterior o igual a hoy

BEGIN
    -- Intentar acceder a la vista
    SELECT * FROM Clientes_Con_Reservaciones_Activas;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de cualquier error que ocurra durante la ejecución
        DBMS_OUTPUT.PUT_LINE('Error al consultar la vista Clientes_Con_Reservaciones_Activas: ' || SQLERRM);
END;



CREATE OR REPLACE VIEW Hoteles_Mas_De_Tres_Estrellas AS
SELECT 
    Nombre, -- Nombre del hotel
    Ciudad, -- Ciudad donde está ubicado el hotel
    País, -- País donde está ubicado el hotel
    Estrellas -- Número de estrellas del hotel
FROM 
    Hoteles
WHERE 
    Estrellas > 3; -- Filtrar para mostrar solo hoteles con más de 3 estrellas

BEGIN
    -- Intentar acceder a la vista
    SELECT * FROM Hoteles_Mas_De_Tres_Estrellas;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de cualquier error que ocurra durante la ejecución
        DBMS_OUTPUT.PUT_LINE('Error al consultar la vista Hoteles_Mas_De_Tres_Estrellas: ' || SQLERRM);
END;


CREATE OR REPLACE VIEW Facturas_Altas AS
SELECT 
    F.ID_Factura, -- ID de la factura
    F.Fecha_emision, -- Fecha en que se emitió la factura
    F.Total, -- Monto total de la factura
    R.ID_Reservacion, -- ID de la reservación asociada a la factura
    C.Nombre AS Cliente, -- Nombre del cliente
    C.Apellido AS Apellido_Cliente -- Apellido del cliente
FROM 
    Facturas F
JOIN 
    Reservaciones R ON F.ID_Reservacion = R.ID_Reservacion -- Relacionar facturas con reservaciones
JOIN 
    Clientes C ON R.ID_Cliente = C.ID_Cliente -- Relacionar reservaciones con clientes
WHERE 
    F.Total > 1000; -- Filtrar para mostrar solo facturas con un monto superior a 1000 unidades monetarias

BEGIN
    -- Intentar acceder a la vista
    SELECT * FROM Facturas_Altas;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de cualquier error que ocurra durante la ejecución
        DBMS_OUTPUT.PUT_LINE('Error al consultar la vista Facturas_Altas: ' || SQLERRM);
END;


CREATE OR REPLACE NONEDITIONABLE FUNCTION Obtener_Hotel_Por_Reservacion(ID_Reservacion IN NUMBER) 
RETURN SYS_REFCURSOR
AS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
  SELECT H.Nombre, H.Dirección
  FROM Hoteles H
  INNER JOIN Reservaciones R ON H.ID_Hotel = R.ID_Hotel
  WHERE R.ID_Reservacion = ID_Reservacion;

  RETURN v_cursor;
EXCEPTION
  WHEN OTHERS THEN
    -- Manejo de errores general
    RAISE_APPLICATION_ERROR(-20001, 'Error al obtener el hotel por la reservación: ' || SQLERRM);
END;


CREATE OR REPLACE FUNCTION Insertar_Hotel(
  p_Nombre IN VARCHAR2,  -- Nombre del hotel
  p_Direccion IN VARCHAR2,  -- Dirección del hotel
  p_Ciudad IN VARCHAR2,  -- Ciudad del hotel
  p_Pais IN VARCHAR2,  -- País del hotel
  p_Estrellas IN NUMBER  -- Número de estrellas del hotel
) RETURN NUMBER  -- Devuelve el ID del hotel insertado
AS
  v_ID_Hotel NUMBER;  -- Variable para almacenar el ID del nuevo hotel
BEGIN
  -- Inserta el nuevo hotel en la tabla Hoteles
  INSERT INTO Hoteles (ID_Hotel, Nombre, Dirección, Ciudad, País, Estrellas)
  VALUES (seq_Hoteles.NEXTVAL, p_Nombre, p_Direccion, p_Ciudad, p_Pais, p_Estrellas)
  RETURNING ID_Hotel INTO v_ID_Hotel;  -- Obtiene el ID del hotel insertado
  
  RETURN v_ID_Hotel;  -- Retorna el ID del hotel
EXCEPTION
  WHEN OTHERS THEN
    -- Manejo de errores general
    RAISE_APPLICATION_ERROR(-20001, 'Error al insertar el hotel: ' || SQLERRM);
END;


CREATE OR REPLACE FUNCTION Obtener_Hotel(
  p_ID_Hotel IN NUMBER  -- ID del hotel que se quiere obtener
) RETURN SYS_REFCURSOR  -- Devuelve un cursor para manejar múltiples filas
AS
  v_cursor SYS_REFCURSOR;  -- Declara el cursor
BEGIN
  -- Abre el cursor para seleccionar la información del hotel
  OPEN v_cursor FOR
  SELECT Nombre, Dirección, Ciudad, País, Estrellas
  FROM Hoteles
  WHERE ID_Hotel = p_ID_Hotel;
  
  RETURN v_cursor;  -- Retorna el cursor con la información del hotel
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    -- Manejo de caso donde no se encuentra el hotel
    RAISE_APPLICATION_ERROR(-20002, 'No se encontró el hotel con ID ' || p_ID_Hotel);
  WHEN OTHERS THEN
    -- Manejo de errores general
    RAISE_APPLICATION_ERROR(-20003, 'Error al obtener el hotel: ' || SQLERRM);
END;



CREATE OR REPLACE FUNCTION Actualizar_Hotel(
  p_ID_Hotel IN NUMBER,  -- ID del hotel que se quiere actualizar
  p_Nombre IN VARCHAR2,  -- Nuevo nombre del hotel
  p_Direccion IN VARCHAR2,  -- Nueva dirección del hotel
  p_Ciudad IN VARCHAR2,  -- Nueva ciudad del hotel
  p_Pais IN VARCHAR2,  -- Nuevo país del hotel
  p_Estrellas IN NUMBER  -- Nuevas estrellas del hotel
) RETURN BOOLEAN  -- Retorna TRUE si la actualización fue exitosa
AS
BEGIN
  -- Actualiza la información del hotel en la tabla Hoteles
  UPDATE Hoteles
  SET Nombre = p_Nombre,
      Dirección = p_Direccion,
      Ciudad = p_Ciudad,
      País = p_Pais,
      Estrellas = p_Estrellas
  WHERE ID_Hotel = p_ID_Hotel;
  
  RETURN SQL%ROWCOUNT > 0;  -- Retorna TRUE si se actualizó alguna fila
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    -- Manejo de caso donde no se encuentra el hotel para actualizar
    RAISE_APPLICATION_ERROR(-20004, 'No se encontró el hotel con ID ' || p_ID_Hotel);
  WHEN OTHERS THEN
    -- Manejo de errores general
    RAISE_APPLICATION_ERROR(-20005, 'Error al actualizar el hotel: ' || SQLERRM);
END;



CREATE OR REPLACE FUNCTION Eliminar_Hotel(
  p_ID_Hotel IN NUMBER  -- ID del hotel que se quiere eliminar
) RETURN BOOLEAN  -- Retorna TRUE si la eliminación fue exitosa
AS
BEGIN
  -- Elimina el hotel de la tabla Hoteles
  DELETE FROM Hoteles
  WHERE ID_Hotel = p_ID_Hotel;
  
  RETURN SQL%ROWCOUNT > 0;  -- Retorna TRUE si se eliminó alguna fila
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    -- Manejo de caso donde no se encuentra el hotel para eliminar
    RAISE_APPLICATION_ERROR(-20006, 'No se encontró el hotel con ID ' || p_ID_Hotel);
  WHEN OTHERS THEN
    -- Manejo de errores general
    RAISE_APPLICATION_ERROR(-20007, 'Error al eliminar el hotel: ' || SQLERRM);
END;



CREATE OR REPLACE FUNCTION Insertar_Reservacion(
  p_ID_Hotel IN NUMBER,  -- ID del hotel para la reservación
  p_ID_Cliente IN NUMBER,  -- ID del cliente que realiza la reservación
  p_Fecha_inicio IN DATE,  -- Fecha de inicio de la reservación
  p_Fecha_fin IN DATE,  -- Fecha de fin de la reservación
  p_Habitacion_asignada IN VARCHAR2  -- Habitación asignada
) RETURN NUMBER  -- Devuelve el ID de la reservación insertada
AS
  v_ID_Reservacion NUMBER;  -- Variable para almacenar el ID de la nueva reservación
BEGIN
  -- Inserta la nueva reservación en la tabla Reservaciones
  INSERT INTO Reservaciones (ID_Reservacion, ID_Hotel, ID_Cliente, Fecha_inicio, Fecha_fin, Habitacion_asignada)
  VALUES (seq_Reservaciones.NEXTVAL, p_ID_Hotel, p_ID_Cliente, p_Fecha_inicio, p_Fecha_fin, p_Habitacion_asignada)
  RETURNING ID_Reservacion INTO v_ID_Reservacion;  -- Obtiene el ID de la reservación
  
  RETURN v_ID_Reservacion;  -- Retorna el ID de la reservación
EXCEPTION
  WHEN OTHERS THEN
    -- Manejo de errores general
    RAISE_APPLICATION_ERROR(-20008, 'Error al insertar la reservación: ' || SQLERRM);
END;



CREATE OR REPLACE FUNCTION Obtener_Reservacion(
  p_ID_Reservacion IN NUMBER  -- ID de la reservación que se quiere obtener
) RETURN SYS_REFCURSOR  -- Devuelve un cursor para manejar múltiples filas
AS
  v_cursor SYS_REFCURSOR;  -- Declara el cursor
BEGIN
  -- Abre el cursor para seleccionar la información de la reservación
  OPEN v_cursor FOR
  SELECT ID_Hotel, ID_Cliente, Fecha_inicio, Fecha_fin, Habitacion_asignada
  FROM Reservaciones
  WHERE ID_Reservacion = p_ID_Reservacion;
  
  RETURN v_cursor;  -- Retorna el cursor con la información de la reservación
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    -- Manejo de caso donde no se encuentra la reservación
    RAISE_APPLICATION_ERROR(-20009, 'No se encontró la reservación con ID ' || p_ID_Reservacion);
  WHEN OTHERS THEN
    -- Manejo de errores general
    RAISE_APPLICATION_ERROR(-20010, 'Error al obtener la reservación: ' || SQLERRM);
END;



CREATE OR REPLACE FUNCTION Actualizar_Reservacion(
  p_ID_Reservacion IN NUMBER,  -- ID de la reservación que se quiere actualizar
  p_ID_Hotel IN NUMBER,  -- Nuevo ID del hotel
  p_ID_Cliente IN NUMBER,  -- Nuevo ID del cliente
  p_Fecha_inicio IN DATE,  -- Nueva fecha de inicio
  p_Fecha_fin IN DATE,  -- Nueva fecha de fin
  p_Habitacion_asignada IN VARCHAR2  -- Nueva habitación asignada
) RETURN BOOLEAN  -- Retorna TRUE si la actualización fue exitosa
AS
BEGIN
  -- Actualiza la información de la reservación en la tabla Reservaciones
  UPDATE Reservaciones
  SET ID_Hotel = p_ID_Hotel,
      ID_Cliente = p_ID_Cliente,
      Fecha_inicio = p_Fecha_inicio,
      Fecha_fin = p_Fecha_fin,
      Habitacion_asignada = p_Habitacion_asignada
  WHERE ID_Reservacion = p_ID_Reservacion;
  
  RETURN SQL%ROWCOUNT > 0;  -- Retorna TRUE si se actualizó alguna fila
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    -- Manejo de caso donde no se encuentra la reservación para actualizar
    RAISE_APPLICATION_ERROR(-20011, 'No se encontró la reservación con ID ' || p_ID_Reservacion);
  WHEN OTHERS THEN
    -- Manejo de errores general
    RAISE_APPLICATION_ERROR(-20012, 'Error al actualizar la reservación: ' || SQLERRM);
END;



CREATE OR REPLACE FUNCTION Eliminar_Reservacion(
  p_ID_Reservacion IN NUMBER  -- ID de la reservación que se quiere eliminar
) RETURN BOOLEAN  -- Retorna TRUE si la eliminación fue exitosa
AS
BEGIN
  -- Elimina la reservación de la tabla Reservaciones
  DELETE FROM Reservaciones
  WHERE ID_Reservacion = p_ID_Reservacion;
  
  RETURN SQL%ROWCOUNT > 0;  -- Retorna TRUE si se eliminó alguna fila
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    -- Manejo de caso donde no se encuentra la reservación para eliminar
    RAISE_APPLICATION_ERROR(-20013, 'No se encontró la reservación con ID ' || p_ID_Reservacion);
  WHEN OTHERS THEN
    -- Manejo de errores general
    RAISE_APPLICATION_ERROR(-20014, 'Error al eliminar la reservación: ' || SQLERRM);
END;




CREATE OR REPLACE PACKAGE Gestion_Habitaciones AS
  PROCEDURE Insertar_Tipo_Habitacion(
    p_Descripcion IN VARCHAR2,
    p_Precio_por_noche IN NUMBER,
    p_Capacidad IN NUMBER
  );
  
  FUNCTION Obtener_Tipo_Habitacion(
    p_ID_Tipo_Habitacion IN NUMBER
  ) RETURN SYS_REFCURSOR;
  
  PROCEDURE Actualizar_Tipo_Habitacion(
    p_ID_Tipo_Habitacion IN NUMBER,
    p_Descripcion IN VARCHAR2,
    p_Precio_por_noche IN NUMBER,
    p_Capacidad IN NUMBER
  );
  
  PROCEDURE Eliminar_Tipo_Habitacion(
    p_ID_Tipo_Habitacion IN NUMBER
  );
END Gestion_Habitaciones;
/



CREATE OR REPLACE PACKAGE Gestion_Habitaciones AS
  PROCEDURE Insertar_Tipo_Habitacion(
    p_Descripcion IN VARCHAR2,
    p_Precio_por_noche IN NUMBER,
    p_Capacidad IN NUMBER
  );
  
  FUNCTION Obtener_Tipo_Habitacion(
    p_ID_Tipo_Habitacion IN NUMBER
  ) RETURN SYS_REFCURSOR;
  
  PROCEDURE Actualizar_Tipo_Habitacion(
    p_ID_Tipo_Habitacion IN NUMBER,
    p_Descripcion IN VARCHAR2,
    p_Precio_por_noche IN NUMBER,
    p_Capacidad IN NUMBER
  );
  
  PROCEDURE Eliminar_Tipo_Habitacion(
    p_ID_Tipo_Habitacion IN NUMBER
  );
END Gestion_Habitaciones;
/


CREATE OR REPLACE PACKAGE BODY Gestion_Habitaciones AS

  PROCEDURE Insertar_Tipo_Habitacion(
    p_Descripcion IN VARCHAR2,
    p_Precio_por_noche IN NUMBER,
    p_Capacidad IN NUMBER
  ) IS
  BEGIN
    INSERT INTO Tipos_de_Habitaciones (ID_Tipo_Habitacion, Descripcion, Precio_por_noche, Capacidad)
    VALUES (seq_Tipos_de_Habitaciones.NEXTVAL, p_Descripcion, p_Precio_por_noche, p_Capacidad);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20015, 'Error al insertar el tipo de habitación: ' || SQLERRM);
  END Insertar_Tipo_Habitacion;

  FUNCTION Obtener_Tipo_Habitacion(
    p_ID_Tipo_Habitacion IN NUMBER
  ) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
  BEGIN
    OPEN v_cursor FOR
    SELECT Descripcion, Precio_por_noche, Capacidad
    FROM Tipos_de_Habitaciones
    WHERE ID_Tipo_Habitacion = p_ID_Tipo_Habitacion;
    
    RETURN v_cursor;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20016, 'No se encontró el tipo de habitación con ID ' || p_ID_Tipo_Habitacion);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20017, 'Error al obtener el tipo de habitación: ' || SQLERRM);
  END Obtener_Tipo_Habitacion;

  PROCEDURE Actualizar_Tipo_Habitacion(
    p_ID_Tipo_Habitacion IN NUMBER,
    p_Descripcion IN VARCHAR2,
    p_Precio_por_noche IN NUMBER,
    p_Capacidad IN NUMBER
  ) IS
  BEGIN
    UPDATE Tipos_de_Habitaciones
    SET Descripcion = p_Descripcion,
        Precio_por_noche = p_Precio_por_noche,
        Capacidad = p_Capacidad
    WHERE ID_Tipo_Habitacion = p_ID_Tipo_Habitacion;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20018, 'No se encontró el tipo de habitación con ID ' || p_ID_Tipo_Habitacion);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20019, 'Error al actualizar el tipo de habitación: ' || SQLERRM);
  END Actualizar_Tipo_Habitacion;

  PROCEDURE Eliminar_Tipo_Habitacion(
    p_ID_Tipo_Habitacion IN NUMBER
  ) IS
  BEGIN
    DELETE FROM Tipos_de_Habitaciones
    WHERE ID_Tipo_Habitacion = p_ID_Tipo_Habitacion;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20020, 'No se encontró el tipo de habitación con ID ' || p_ID_Tipo_Habitacion);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20021, 'Error al eliminar el tipo de habitación: ' || SQLERRM);
  END Eliminar_Tipo_Habitacion;

END Gestion_Habitaciones;
/



CREATE OR REPLACE PACKAGE Gestion_Reservaciones_Restaurantes AS
  PROCEDURE Insertar_Reservacion_Restaurante(
    p_ID_Reservacion IN NUMBER,
    p_Fecha IN DATE,
    p_Hora IN TIMESTAMP,
    p_Numero_de_personas IN NUMBER
  );
  
  FUNCTION Obtener_Reservacion_Restaurante(
    p_ID_Reservacion_Restaurante IN NUMBER
  ) RETURN SYS_REFCURSOR;
  
  PROCEDURE Actualizar_Reservacion_Restaurante(
    p_ID_Reservacion_Restaurante IN NUMBER,
    p_ID_Reservacion IN NUMBER,
    p_Fecha IN DATE,
    p_Hora IN TIMESTAMP,
    p_Numero_de_personas IN NUMBER
  );
  
  PROCEDURE Eliminar_Reservacion_Restaurante(
    p_ID_Reservacion_Restaurante IN NUMBER
  );
END Gestion_Reservaciones_Restaurantes;
/


CREATE OR REPLACE PACKAGE BODY Gestion_Reservaciones_Restaurantes AS

  PROCEDURE Insertar_Reservacion_Restaurante(
    p_ID_Reservacion IN NUMBER,
    p_Fecha IN DATE,
    p_Hora IN TIMESTAMP,
    p_Numero_de_personas IN NUMBER
  ) IS
  BEGIN
    INSERT INTO Reservaciones_Restaurantes (ID_Reservacion_Restaurante, ID_Reservacion, Fecha, Hora, Numero_de_personas)
    VALUES (seq_Reservaciones_Restaurantes.NEXTVAL, p_ID_Reservacion, p_Fecha, p_Hora, p_Numero_de_personas);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20022, 'Error al insertar la reservación de restaurante: ' || SQLERRM);
  END Insertar_Reservacion_Restaurante;

  FUNCTION Obtener_Reservacion_Restaurante(
    p_ID_Reservacion_Restaurante IN NUMBER
  ) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
  BEGIN
    OPEN v_cursor FOR
    SELECT ID_Reservacion, Fecha, Hora, Numero_de_personas
    FROM Reservaciones_Restaurantes
    WHERE ID_Reservacion_Restaurante = p_ID_Reservacion_Restaurante;
    
    RETURN v_cursor;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20023, 'No se encontró la reservación de restaurante con ID ' || p_ID_Reservacion_Restaurante);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20024, 'Error al obtener la reservación de restaurante: ' || SQLERRM);
  END Obtener_Reservacion_Restaurante;

  PROCEDURE Actualizar_Reservacion_Restaurante(
    p_ID_Reservacion_Restaurante IN NUMBER,
    p_ID_Reservacion IN NUMBER,
    p_Fecha IN DATE,
    p_Hora IN TIMESTAMP,
    p_Numero_de_personas IN NUMBER
  ) IS
  BEGIN
    UPDATE Reservaciones_Restaurantes
    SET ID_Reservacion = p_ID_Reservacion,
        Fecha = p_Fecha,
        Hora = p_Hora,
        Numero_de_personas = p_Numero_de_personas
    WHERE ID_Reservacion_Restaurante = p_ID_Reservacion_Restaurante;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20025, 'No se encontró la reservación de restaurante con ID ' || p_ID_Reservacion_Restaurante);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20026, 'Error al actualizar la reservación de restaurante: ' || SQLERRM);
  END Actualizar_Reservacion_Restaurante;

  PROCEDURE Eliminar_Reservacion_Restaurante(
    p_ID_Reservacion_Restaurante IN NUMBER
  ) IS
  BEGIN
    DELETE FROM Reservaciones_Restaurantes
    WHERE ID_Reservacion_Restaurante = p_ID_Reservacion_Restaurante;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20027, 'No se encontró la reservación de restaurante con ID ' || p_ID_Reservacion_Restaurante);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20028, 'Error al eliminar la reservación de restaurante: ' || SQLERRM);
  END Eliminar_Reservacion_Restaurante;

END Gestion_Reservaciones_Restaurantes;
/



CREATE OR REPLACE PACKAGE Gestion_Empleados AS
  PROCEDURE Insertar_Empleado(
    p_Nombre IN VARCHAR2,
    p_Apellido IN VARCHAR2,
    p_Cargo IN VARCHAR2,
    p_Fecha_contratacion IN DATE,
    p_ID_Hotel IN NUMBER
  );
  
  FUNCTION Obtener_Empleado(
    p_ID_Empleado IN NUMBER
  ) RETURN SYS_REFCURSOR;
  
  PROCEDURE Actualizar_Empleado(
    p_ID_Empleado IN NUMBER,
    p_Nombre IN VARCHAR2,
    p_Apellido IN VARCHAR2,
    p_Cargo IN VARCHAR2,
    p_Fecha_contratacion IN DATE,
    p_ID_Hotel IN NUMBER
  );
  
  PROCEDURE Eliminar_Empleado(
    p_ID_Empleado IN NUMBER
  );
END Gestion_Empleados;
/


CREATE OR REPLACE PACKAGE BODY Gestion_Empleados AS

  PROCEDURE Insertar_Empleado(
    p_Nombre IN VARCHAR2,
    p_Apellido IN VARCHAR2,
    p_Cargo IN VARCHAR2,
    p_Fecha_contratacion IN DATE,
    p_ID_Hotel IN NUMBER
  ) IS
  BEGIN
    INSERT INTO Empleados (ID_Empleado, Nombre, Apellido, Cargo, Fecha_contratacion, ID_Hotel)
    VALUES (seq_Empleados.NEXTVAL, p_Nombre, p_Apellido, p_Cargo, p_Fecha_contratacion, p_ID_Hotel);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20029, 'Error al insertar el empleado: ' || SQLERRM);
  END Insertar_Empleado;

  FUNCTION Obtener_Empleado(
    p_ID_Empleado IN NUMBER
  ) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
  BEGIN
    OPEN v_cursor FOR
    SELECT Nombre, Apellido, Cargo, Fecha_contratacion, ID_Hotel
    FROM Empleados
    WHERE ID_Empleado = p_ID_Empleado;
    
    RETURN v_cursor;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20030, 'No se encontró el empleado con ID ' || p_ID_Empleado);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20031, 'Error al obtener el empleado: ' || SQLERRM);
  END Obtener_Empleado;

  PROCEDURE Actualizar_Empleado(
    p_ID_Empleado IN NUMBER,
    p_Nombre IN VARCHAR2,
    p_Apellido IN VARCHAR2,
    p_Cargo IN VARCHAR2,
    p_Fecha_contratacion IN DATE,
    p_ID_Hotel IN NUMBER
  ) IS
  BEGIN
    UPDATE Empleados
    SET Nombre = p_Nombre,
        Apellido = p_Apellido,
        Cargo = p_Cargo,
        Fecha_contratacion = p_Fecha_contratacion,
        ID_Hotel = p_ID_Hotel
    WHERE ID_Empleado = p_ID_Empleado;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20032, 'No se encontró el empleado con ID ' || p_ID_Empleado);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20033, 'Error al actualizar el empleado: ' || SQLERRM);
  END Actualizar_Empleado;

  PROCEDURE Eliminar_Empleado(
    p_ID_Empleado IN NUMBER
  ) IS
  BEGIN
    DELETE FROM Empleados
    WHERE ID_Empleado = p_ID_Empleado;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20034, 'No se encontró el empleado con ID ' || p_ID_Empleado);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20035, 'Error al eliminar el empleado: ' || SQLERRM);
  END Eliminar_Empleado;

END Gestion_Empleados;
/



CREATE OR REPLACE PACKAGE Gestion_Historial_Reservaciones AS
  PROCEDURE Insertar_Historial(
    p_ID_Reservacion IN NUMBER,
    p_Fecha_modificacion IN TIMESTAMP,
    p_Comentario IN VARCHAR2
  );
  
  FUNCTION Obtener_Historial(
    p_ID_Historial IN NUMBER
  ) RETURN SYS_REFCURSOR;
  
  PROCEDURE Actualizar_Historial(
    p_ID_Historial IN NUMBER,
    p_ID_Reservacion IN NUMBER,
    p_Fecha_modificacion IN TIMESTAMP,
    p_Comentario IN VARCHAR2
  );
  
  PROCEDURE Eliminar_Historial(
    p_ID_Historial IN NUMBER
  );
END Gestion_Historial_Reservaciones;
/


CREATE OR REPLACE PACKAGE BODY Gestion_Historial_Reservaciones AS

  PROCEDURE Insertar_Historial(
    p_ID_Reservacion IN NUMBER,
    p_Fecha_modificacion IN TIMESTAMP,
    p_Comentario IN VARCHAR2
  ) IS
  BEGIN
    INSERT INTO Historial_Reservaciones (ID_Historial, ID_Reservacion, Fecha_modificacion, Comentario)
    VALUES (seq_Historial_Reservaciones.NEXTVAL, p_ID_Reservacion, p_Fecha_modificacion, p_Comentario);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20036, 'Error al insertar el historial de reservaciones: ' || SQLERRM);
  END Insertar_Historial;

  FUNCTION Obtener_Historial(
    p_ID_Historial IN NUMBER
  ) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
  BEGIN
    OPEN v_cursor FOR
    SELECT ID_Reservacion, Fecha_modificacion, Comentario
    FROM Historial_Reservaciones
    WHERE ID_Historial = p_ID_Historial;
    
    RETURN v_cursor;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20037, 'No se encontró el historial con ID ' || p_ID_Historial);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20038, 'Error al obtener el historial de reservaciones: ' || SQLERRM);
  END Obtener_Historial;

  PROCEDURE Actualizar_Historial(
    p_ID_Historial IN NUMBER,
    p_ID_Reservacion IN NUMBER,
    p_Fecha_modificacion IN TIMESTAMP,
    p_Comentario IN VARCHAR2
  ) IS
  BEGIN
    UPDATE Historial_Reservaciones
    SET ID_Reservacion = p_ID_Reservacion,
        Fecha_modificacion = p_Fecha_modificacion,
        Comentario = p_Comentario
    WHERE ID_Historial = p_ID_Historial;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20039, 'No se encontró el historial con ID ' || p_ID_Historial);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20040, 'Error al actualizar el historial de reservaciones: ' || SQLERRM);
  END Actualizar_Historial;

  PROCEDURE Eliminar_Historial(
    p_ID_Historial IN NUMBER
  ) IS
  BEGIN
    DELETE FROM Historial_Reservaciones
    WHERE ID_Historial = p_ID_Historial;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20041, 'No se encontró el historial con ID ' || p_ID_Historial);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20042, 'Error al eliminar el historial de reservaciones: ' || SQLERRM);
  END Eliminar_Historial;

END Gestion_Historial_Reservaciones;
/



CREATE OR REPLACE PACKAGE Gestion_Comentarios_Hotel AS
  PROCEDURE Insertar_Comentario(
    p_ID_Hotel IN NUMBER,
    p_ID_Cliente IN NUMBER,
    p_Comentario IN VARCHAR2,
    p_Puntuacion IN NUMBER,
    p_Fecha IN DATE
  );
  
  FUNCTION Obtener_Comentario(
    p_ID_Comentario IN NUMBER
  ) RETURN SYS_REFCURSOR;
  
  PROCEDURE Actualizar_Comentario(
    p_ID_Comentario IN NUMBER,
    p_ID_Hotel IN NUMBER,
    p_ID_Cliente IN NUMBER,
    p_Comentario IN VARCHAR2,
    p_Puntuacion IN NUMBER,
    p_Fecha IN DATE
  );
  
  PROCEDURE Eliminar_Comentario(
    p_ID_Comentario IN NUMBER
  );
END Gestion_Comentarios_Hotel;
/


CREATE OR REPLACE PACKAGE BODY Gestion_Comentarios_Hotel AS

  PROCEDURE Insertar_Comentario(
    p_ID_Hotel IN NUMBER,
    p_ID_Cliente IN NUMBER,
    p_Comentario IN VARCHAR2,
    p_Puntuacion IN NUMBER,
    p_Fecha IN DATE
  ) IS
  BEGIN
    INSERT INTO Comentarios_Hotel (ID_Comentario, ID_Hotel, ID_Cliente, Comentario, Puntuacion, Fecha)
    VALUES (seq_Comentarios_Hotel.NEXTVAL, p_ID_Hotel, p_ID_Cliente, p_Comentario, p_Puntuacion, p_Fecha);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20043, 'Error al insertar el comentario del hotel: ' || SQLERRM);
  END Insertar_Comentario;

  FUNCTION Obtener_Comentario(
    p_ID_Comentario IN NUMBER
  ) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
  BEGIN
    OPEN v_cursor FOR
    SELECT ID_Hotel, ID_Cliente, Comentario, Puntuacion, Fecha
    FROM Comentarios_Hotel
    WHERE ID_Comentario = p_ID_Comentario;
    
    RETURN v_cursor;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20044, 'No se encontró el comentario con ID ' || p_ID_Comentario);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20045, 'Error al obtener el comentario del hotel: ' || SQLERRM);
  END Obtener_Comentario;

  PROCEDURE Actualizar_Comentario(
    p_ID_Comentario IN NUMBER,
    p_ID_Hotel IN NUMBER,
    p_ID_Cliente IN NUMBER,
    p_Comentario IN VARCHAR2,
    p_Puntuacion IN NUMBER,
    p_Fecha IN DATE
  ) IS
  BEGIN
    UPDATE Comentarios_Hotel
    SET ID_Hotel = p_ID_Hotel,
        ID_Cliente = p_ID_Cliente,
        Comentario = p_Comentario,
        Puntuacion = p_Puntuacion,
        Fecha = p_Fecha
    WHERE ID_Comentario = p_ID_Comentario;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20046, 'No se encontró el comentario con ID ' || p_ID_Comentario);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20047, 'Error al actualizar el comentario del hotel: ' || SQLERRM);
  END Actualizar_Comentario;

  PROCEDURE Eliminar_Comentario(
    p_ID_Comentario IN NUMBER
  ) IS
  BEGIN
    DELETE FROM Comentarios_Hotel
    WHERE ID_Comentario = p_ID_Comentario;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20048, 'No se encontró el comentario con ID ' || p_ID_Comentario);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20049, 'Error al eliminar el comentario del hotel: ' || SQLERRM);
  END Eliminar_Comentario;

END Gestion_Comentarios_Hotel;
/


--15 cursores

CREATE OR REPLACE PROCEDURE Obtener_Todos_Hoteles IS
CURSOR c_hoteles IS
    SELECT
    "A1"."ID_HOTEL"  "ID_HOTEL",
    "A1"."NOMBRE"    "NOMBRE",
    "A1"."DIRECCION" "DIRECCION",
    "A1"."CIUDAD"    "CIUDAD",
    "A1"."PAIS"      "PAIS",
    "A1"."ESTRELLAS" "ESTRELLAS"
FROM
    "ESTUDIANTE"."HOTELES" "A1";
  
  v_hoteles Hoteles%ROWTYPE;
BEGIN
  OPEN c_hoteles;
  LOOP
    FETCH c_hoteles INTO v_hoteles;
    EXIT WHEN c_hoteles%NOTFOUND;
    -- Procesar cada fila, por ejemplo, imprimir resultados
    DBMS_OUTPUT.PUT_LINE('Hotel: ' || v_hoteles.Nombre || ', Ciudad: ' || v_hoteles.Ciudad);
  END LOOP;
  CLOSE c_hoteles;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error al obtener los hoteles: ' || SQLERRM);
END Obtener_Todos_Hoteles;
/



CREATE OR REPLACE FUNCTION Obtener_Clientes_Por_Apellido(p_Apellido IN VARCHAR2) RETURN SYS_REFCURSOR IS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
    SELECT ID_Cliente, Nombre, Apellido, Correo_electronico, Telefono
    FROM Clientes
    WHERE Apellido = p_Apellido;
  
  RETURN v_cursor;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20002, 'Error al obtener clientes por apellido: ' || SQLERRM);
END Obtener_Clientes_Por_Apellido;
/



CREATE OR REPLACE PROCEDURE Obtener_Reservaciones_Por_Fecha(p_Fecha IN DATE) IS
  CURSOR c_reservaciones IS
    SELECT ID_Reservacion, ID_Hotel, ID_Cliente, Fecha_inicio, Fecha_fin, Habitacion_asignada
    FROM Reservaciones
    WHERE Fecha_inicio = p_Fecha;
  
  v_reservaciones Reservaciones%ROWTYPE;
BEGIN
  OPEN c_reservaciones;
  LOOP
    FETCH c_reservaciones INTO v_reservaciones;
    EXIT WHEN c_reservaciones%NOTFOUND;
    -- Procesar cada fila, por ejemplo, imprimir resultados
    DBMS_OUTPUT.PUT_LINE('Reservación ID: ' || v_reservaciones.ID_Reservacion || ', Hotel ID: ' || v_reservaciones.ID_Hotel);
  END LOOP;
  CLOSE c_reservaciones;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20003, 'Error al obtener reservaciones por fecha: ' || SQLERRM);
END Obtener_Reservaciones_Por_Fecha;
/



CREATE OR REPLACE FUNCTION Obtener_Tipos_de_Habitaciones RETURN SYS_REFCURSOR IS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
    SELECT ID_Tipo_Habitacion, Descripcion, Precio_por_noche, Capacidad
    FROM Tipos_de_Habitaciones;
  
  RETURN v_cursor;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20004, 'Error al obtener tipos de habitaciones: ' || SQLERRM);
END Obtener_Tipos_de_Habitaciones;
/



CREATE OR REPLACE PROCEDURE Obtener_Reservaciones_Habitaciones IS
  CURSOR c_reservaciones_habitaciones IS
    SELECT ID_Reservacion_Habitacion, ID_Reservacion, ID_Tipo_Habitacion, Cantidad, Precio
    FROM Reservaciones_Habitaciones;
  
  v_reservaciones_habitaciones Reservaciones_Habitaciones%ROWTYPE;
BEGIN
  OPEN c_reservaciones_habitaciones;
  LOOP
    FETCH c_reservaciones_habitaciones INTO v_reservaciones_habitaciones;
    EXIT WHEN c_reservaciones_habitaciones%NOTFOUND;
    -- Procesar cada fila, por ejemplo, imprimir resultados
    DBMS_OUTPUT.PUT_LINE('Reservación Habitacion ID: ' || v_reservaciones_habitaciones.ID_Reservacion_Habitacion || ', Tipo de Habitacion ID: ' || v_reservaciones_habitaciones.ID_Tipo_Habitacion);
  END LOOP;
  CLOSE c_reservaciones_habitaciones;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20005, 'Error al obtener reservaciones de habitaciones: ' || SQLERRM);
END Obtener_Reservaciones_Habitaciones;
/




CREATE OR REPLACE FUNCTION Obtener_Servicios_Adicionales_Por_Hotel(p_ID_Hotel IN NUMBER) RETURN SYS_REFCURSOR IS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
    SELECT ID_Servicio, Nombre, Precio
    FROM Servicios_Adicionales
    WHERE ID_Hotel = p_ID_Hotel;
  
  RETURN v_cursor;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20006, 'Error al obtener servicios adicionales por hotel: ' || SQLERRM);
END Obtener_Servicios_Adicionales_Por_Hotel;
/



CREATE OR REPLACE PROCEDURE Obtener_Reservaciones_Servicios_Adicionales IS
  CURSOR c_reservaciones_servicios IS
    SELECT ID_Reservacion_Servicio, ID_Reservacion, ID_Servicio, Cantidad
    FROM Reservaciones_Servicios_Adicionales;
  
  v_reservaciones_servicios Reservaciones_Servicios_Adicionales%ROWTYPE;
BEGIN
  OPEN c_reservaciones_servicios;
  LOOP
    FETCH c_reservaciones_servicios INTO v_reservaciones_servicios;
    EXIT WHEN c_reservaciones_servicios%NOTFOUND;
    -- Procesar cada fila, por ejemplo, imprimir resultados
    DBMS_OUTPUT.PUT_LINE('Reservación Servicio ID: ' || v_reservaciones_servicios.ID_Reservacion_Servicio || ', Servicio ID: ' || v_reservaciones_servicios.ID_Servicio);
  END LOOP;
  CLOSE c_reservaciones_servicios;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20007, 'Error al obtener reservaciones de servicios adicionales: ' || SQLERRM);
END Obtener_Reservaciones_Servicios_Adicionales;
/



CREATE OR REPLACE FUNCTION Obtener_Comentarios_Por_Cliente(p_ID_Cliente IN NUMBER) RETURN SYS_REFCURSOR IS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
    SELECT ID_Comentario, ID_Hotel, Comentario, Puntuacion, Fecha
    FROM Comentarios_Hotel
    WHERE ID_Cliente = p_ID_Cliente;
  
  RETURN v_cursor;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20008, 'Error al obtener comentarios por cliente: ' || SQLERRM);
END Obtener_Comentarios_Por_Cliente;
/



CREATE OR REPLACE PROCEDURE Obtener_Historial_Por_Fecha(p_Fecha IN DATE) IS
  CURSOR c_historial IS
    SELECT ID_Historial, ID_Reservacion, Fecha_modificacion, Comentario
    FROM Historial_Reservaciones
    WHERE Fecha_modificacion >= p_Fecha;
  
  v_historial Historial_Reservaciones%ROWTYPE;
BEGIN
  OPEN c_historial;
  LOOP
    FETCH c_historial INTO v_historial;
    EXIT WHEN c_historial%NOTFOUND;
    -- Procesar cada fila, por ejemplo, imprimir resultados
    DBMS_OUTPUT.PUT_LINE('Historial ID: ' || v_historial.ID_Historial || ', Comentario: ' || v_historial.Comentario);
  END LOOP;
  CLOSE c_historial;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20009, 'Error al obtener historial de reservaciones por fecha: ' || SQLERRM);
END Obtener_Historial_Por_Fecha;
/



CREATE OR REPLACE FUNCTION Obtener_Facturas_Por_Reservacion(p_ID_Reservacion IN NUMBER) RETURN SYS_REFCURSOR IS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
    SELECT ID_Factura, Fecha_emision, Total
    FROM Facturas
    WHERE ID_Reservacion = p_ID_Reservacion;
  
  RETURN v_cursor;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20010, 'Error al obtener facturas por reservación: ' || SQLERRM);
END Obtener_Facturas_Por_Reservacion;
/


CREATE OR REPLACE PROCEDURE Obtener_Reservaciones_Por_Cliente(p_ID_Cliente IN NUMBER) IS
  -- Definición del cursor para obtener reservaciones por cliente
  CURSOR c_reservaciones IS
    SELECT ID_Reservacion, ID_Hotel, Fecha_inicio, Fecha_fin, Habitacion_asignada
    FROM Reservaciones
    WHERE ID_Cliente = p_ID_Cliente;
  
  -- Variable de tipo de registro personalizado para almacenar la fila del cursor
  TYPE t_reservacion IS RECORD (
    ID_Reservacion NUMBER,
    ID_Hotel NUMBER,
    Fecha_inicio DATE,
    Fecha_fin DATE,
    Habitacion_asignada VARCHAR2(50)
  );
  
  v_reservacion t_reservacion;
BEGIN
  -- Abrir el cursor
  OPEN c_reservaciones;
  LOOP
    -- Recuperar la siguiente fila del cursor
    FETCH c_reservaciones INTO v_reservacion;
    -- Salir del bucle cuando no hay más filas
    EXIT WHEN c_reservaciones%NOTFOUND;
    -- Procesar cada fila, por ejemplo, imprimir resultados
    DBMS_OUTPUT.PUT_LINE('Reservación ID: ' || v_reservacion.ID_Reservacion || ', Hotel ID: ' || v_reservacion.ID_Hotel || ', Fecha Inicio: ' || v_reservacion.Fecha_inicio || ', Fecha Fin: ' || v_reservacion.Fecha_fin);
  END LOOP;
  -- Cerrar el cursor
  CLOSE c_reservaciones;
EXCEPTION
  WHEN OTHERS THEN
    -- Manejo de excepciones
    RAISE_APPLICATION_ERROR(-20011, 'Error al obtener reservaciones por cliente: ' || SQLERRM);
END Obtener_Reservaciones_Por_Cliente;
/



CREATE OR REPLACE FUNCTION Obtener_Empleados_Por_Hotel(p_ID_Hotel IN NUMBER) RETURN SYS_REFCURSOR IS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
    SELECT ID_Empleado, Nombre, Apellido, Cargo, Fecha_contratacion
    FROM Empleados
    WHERE ID_Hotel = p_ID_Hotel;
  
  RETURN v_cursor;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20012, 'Error al obtener empleados por hotel: ' || SQLERRM);
END Obtener_Empleados_Por_Hotel;
/



CREATE OR REPLACE PROCEDURE Obtener_Reservaciones_Por_Tipo_Habitacion(p_ID_Tipo_Habitacion IN NUMBER) IS
  CURSOR c_reservaciones IS
    SELECT r.ID_Reservacion, r.ID_Hotel, r.ID_Cliente, r.Fecha_inicio, r.Fecha_fin, r.Habitacion_asignada
    FROM Reservaciones r
    JOIN Reservaciones_Habitaciones rh ON r.ID_Reservacion = rh.ID_Reservacion
    WHERE rh.ID_Tipo_Habitacion = p_ID_Tipo_Habitacion;
  
  v_reservaciones Reservaciones%ROWTYPE;
BEGIN
  OPEN c_reservaciones;
  LOOP
    FETCH c_reservaciones INTO v_reservaciones;
    EXIT WHEN c_reservaciones%NOTFOUND;
    -- Procesar cada fila, por ejemplo, imprimir resultados
    DBMS_OUTPUT.PUT_LINE('Reservación ID: ' || v_reservaciones.ID_Reservacion || ', Hotel ID: ' || v_reservaciones.ID_Hotel);
  END LOOP;
  CLOSE c_reservaciones;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20013, 'Error al obtener reservaciones por tipo de habitación: ' || SQLERRM);
END Obtener_Reservaciones_Por_Tipo_Habitacion;
/


    
CREATE OR REPLACE FUNCTION Obtener_Facturas_Por_Fecha(p_Fecha IN DATE) RETURN SYS_REFCURSOR IS
  v_cursor SYS_REFCURSOR;
BEGIN
  OPEN v_cursor FOR
    SELECT ID_Factura, ID_Reservacion, Fecha_emision, Total
    FROM Facturas
    WHERE Fecha_emision = p_Fecha;
  
  RETURN v_cursor;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20014, 'Error al obtener facturas por fecha de emisión: ' || SQLERRM);
END Obtener_Facturas_Por_Fecha;
/



CREATE OR REPLACE PROCEDURE Obtener_Todos_Comentarios IS
  CURSOR c_comentarios IS
    SELECT ID_Comentario, ID_Hotel, ID_Cliente, Comentario, Puntuacion, Fecha
    FROM Comentarios_Hotel;
  
  v_comentarios Comentarios_Hotel%ROWTYPE;
BEGIN
  OPEN c_comentarios;
  LOOP
    FETCH c_comentarios INTO v_comentarios;
    EXIT WHEN c_comentarios%NOTFOUND;
    -- Procesar cada fila, por ejemplo, imprimir resultados
    DBMS_OUTPUT.PUT_LINE('Comentario ID: ' || v_comentarios.ID_Comentario || ', Hotel ID: ' || v_comentarios.ID_Hotel);
  END LOOP;
  CLOSE c_comentarios;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20015, 'Error al obtener todos los comentarios: ' || SQLERRM);
END Obtener_Todos_Comentarios;
/





