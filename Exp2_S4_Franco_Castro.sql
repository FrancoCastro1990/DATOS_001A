/* 
 * CREACI�N DE USUARIO SI TRABAJAS CON ORACLE LOCAL 
 *
 * Ejecuta este script conectado con el usuario SYSTEM o SYS
 * IMPORTANTE: el usuario SYS debe conectarse con rol SYSDBA
 *
 */
 
ALTER SESSION SET "_Oracle_Script"=TRUE;


CREATE USER MDY2131_P4 
IDENTIFIED BY "MDY2131.practica_4"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER MDY2131_P4 QUOTA UNLIMITED ON USERS;

GRANT CREATE SESSION TO MDY2131_P4;

GRANT "RESOURCE" TO MDY2131_P4;

ALTER USER MDY2131_P4 DEFAULT ROLE "RESOURCE";




/* 
 * CREACI�N DE USUARIO SI TRABAJAS CON ORACLE CLOUD 
 *
 * Ejecuta este script conectado con el usuario ADMIN
 *
 */

CREATE USER MDY2131_P4 
IDENTIFIED BY "MDY2131.practica_4"
DEFAULT TABLESPACE DATA
TEMPORARY TABLESPACE "TEMP";

ALTER USER MDY2131_P4 QUOTA UNLIMITED ON DATA;

GRANT CREATE SESSION TO MDY2131_P4;

GRANT "RESOURCE" TO MDY2131_P4;

ALTER USER MDY2131_P4 DEFAULT ROLE "RESOURCE";





/* 
 * CREACI�N DE SCHEMA CONECTADO CON USUARIO MDY2131_P4
 *
 */

-- Creaci�n de la tabla Clientes
CREATE TABLE Clientes (
    customer_id NUMBER PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    apellido VARCHAR2(50) NOT NULL,
    fecha_registro DATE DEFAULT SYSDATE,
    email VARCHAR2(100),
    telefono VARCHAR2(20)
);

-- Creaci�n de la tabla Productos
CREATE TABLE Productos (
    product_id NUMBER PRIMARY KEY,
    nombre_producto VARCHAR2(100) NOT NULL,
    categoria VARCHAR2(50),
    precio NUMBER(10, 2) NOT NULL,
    stock NUMBER NOT NULL
);

-- Creaci�n de la tabla Ventas
CREATE TABLE Ventas (
    sale_id NUMBER PRIMARY KEY,
    customer_id NUMBER NOT NULL,
    product_id NUMBER NOT NULL,
    cantidad NUMBER NOT NULL,
    fecha_venta DATE DEFAULT SYSDATE,
    total_venta NUMBER(10, 2),
    staff_id NUMBER,
    CONSTRAINT fk_staff FOREIGN KEY (staff_id) REFERENCES Personal_de_Ventas(staff_id),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Clientes(customer_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES Productos(product_id)
);

-- Creaci�n de la tabla Personal de Ventas
CREATE TABLE Personal_de_Ventas (
    staff_id NUMBER PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    apellido VARCHAR2(50) NOT NULL,
    email VARCHAR2(100),
    telefono VARCHAR2(20)
);


-- Inserciones en la tabla Clientes
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (1, 'Juan', 'P�rez', TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'juan.perez@example.com', '123456789');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (2, 'Mar�a', 'L�pez', TO_DATE('2023-02-20', 'YYYY-MM-DD'), 'maria.lopez@example.com', '987654321');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (3, 'Carlos', 'D�az', TO_DATE('2023-03-05', 'YYYY-MM-DD'), 'carlos.diaz@example.com', '1122334455');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (4, 'Ana', 'Gonz�lez', TO_DATE('2023-04-18', 'YYYY-MM-DD'), 'ana.gonzalez@example.com', '998877665');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (5, 'Pedro', 'Morales', TO_DATE('2023-05-23', 'YYYY-MM-DD'), 'pedro.morales@example.com', '556677889');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (6, 'Sof�a', 'Ram�rez', TO_DATE('2023-06-10', 'YYYY-MM-DD'), 'sofia.ramirez@example.com', '443322110');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (7, 'Felipe', 'Castillo', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'felipe.castillo@example.com', '667788990');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (8, 'Lorena', 'Soto', TO_DATE('2023-08-15', 'YYYY-MM-DD'), 'lorena.soto@example.com', '774411223');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (9, 'Gonzalo', 'Herrera', TO_DATE('2023-09-07', 'YYYY-MM-DD'), 'gonzalo.herrera@example.com', '665544332');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (10, 'Patricia', 'Figueroa', TO_DATE('2023-10-02', 'YYYY-MM-DD'), 'patricia.figueroa@example.com', '998899776');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (11, 'Diego', 'Fuentes', TO_DATE('2023-01-30', 'YYYY-MM-DD'), 'diego.fuentes@example.com', '123987456');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (12, 'Natalia', 'Vargas', TO_DATE('2023-02-12', 'YYYY-MM-DD'), 'natalia.vargas@example.com', '569874123');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (13, 'Esteban', 'Mart�nez', TO_DATE('2023-03-19', 'YYYY-MM-DD'), 'esteban.martinez@example.com', '789456123');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (14, 'Ver�nica', 'Tapia', TO_DATE('2023-04-25', 'YYYY-MM-DD'), 'veronica.tapia@example.com', '654321789');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (15, 'Andr�s', 'Paredes', TO_DATE('2023-05-15', 'YYYY-MM-DD'), 'andres.paredes@example.com', '987321654');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (16, 'Camila', 'Flores', TO_DATE('2023-06-22', 'YYYY-MM-DD'), 'camila.flores@example.com', '789123456');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (17, 'Jorge', 'Salinas', TO_DATE('2023-07-10', 'YYYY-MM-DD'), 'jorge.salinas@example.com', '456789123');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (18, 'Paulina', 'Rojas', TO_DATE('2023-08-05', 'YYYY-MM-DD'), 'paulina.rojas@example.com', '321654987');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (19, 'Ricardo', 'Vargas', TO_DATE('2023-09-20', 'YYYY-MM-DD'), 'ricardo.vargas@example.com', '951753852');
INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (20, 'Tamara', 'Fern�ndez', TO_DATE('2023-10-15', 'YYYY-MM-DD'), 'tamara.fernandez@example.com', '741258963');

-- Inserciones en la tabla Productos
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (1, 'Laptop', 'Electr�nica', 1500.00, 10);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (2, 'Tel�fono', 'Electr�nica', 800.00, 25);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (3, 'Teclado', 'Accesorios', 30.00, 50);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (4, 'Monitor', 'Electr�nica', 200.00, 20);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (5, 'Impresora', 'Oficina', 120.00, 15);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (6, 'Mouse', 'Accesorios', 25.00, 40);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (7, 'C�mara', 'Fotograf�a', 300.00, 10);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (8, 'Auriculares', 'Accesorios', 50.00, 35);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (9, 'Tablet', 'Electr�nica', 350.00, 18);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (10, 'Bocinas', 'Audio', 75.00, 30);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (11, 'Disco Duro', 'Almacenamiento', 100.00, 20);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (12, 'Memoria USB', 'Almacenamiento', 15.00, 100);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (13, 'Router', 'Redes', 60.00, 12);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (14, 'Cargador', 'Accesorios', 20.00, 60);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (15, 'Laptop Gamer', 'Electr�nica', 2500.00, 8);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (16, 'Silla de Oficina', 'Oficina', 100.00, 20);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (17, 'Proyector', 'Oficina', 450.00, 7);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (18, 'Microondas', 'Hogar', 90.00, 15);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (19, 'Refrigerador', 'Hogar', 800.00, 5);
INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES (20, 'Ventilador', 'Hogar', 40.00, 25);

-- Inserciones en la tabla Personal de Ventas
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (1, 'Pedro', 'Ram�rez', 'pedro.ramirez@example.com', '998877665');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (2, 'Luc�a', 'Mart�nez', 'lucia.martinez@example.com', '556677889');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (3, 'Jos�', 'Garc�a', 'jose.garcia@example.com', '443322110');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (4, 'Ana', 'Soto', 'ana.soto@example.com', '554433221');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (5, 'Carlos', 'R�os', 'carlos.rios@example.com', '667788990');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (6, 'Marta', 'Morales', 'marta.morales@example.com', '223344556');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (7, 'Jorge', 'Salinas', 'jorge.salinas@example.com', '778899221');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (8, 'Laura', 'P�rez', 'laura.perez@example.com', '334455667');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (9, 'Diego', 'Hern�ndez', 'diego.hernandez@example.com', '112233445');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (10, 'Carmen', 'Castro', 'carmen.castro@example.com', '667788990');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (11, 'Sandra', 'Vega', 'sandra.vega@example.com', '223344556');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (12, 'Luis', 'M�ndez', 'luis.mendez@example.com', '554433221');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (13, 'Silvia', 'Navarro', 'silvia.navarro@example.com', '778899221');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (14, 'Pablo', 'Lara', 'pablo.lara@example.com', '334455667');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (15, 'Isabel', 'Serrano', 'isabel.serrano@example.com', '112233445');
INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (16, 'Rafael', 'Romero', 'rafael.romero@example.com', '667788990');

-- Inserciones en la tabla Ventas
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (1, 1, 1, 1, 2, TO_DATE('2023-02-15', 'YYYY-MM-DD'), 3000.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (2, 2, 2, 2, 1, TO_DATE('2023-03-10', 'YYYY-MM-DD'), 800.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (3, 3, 3, 3, 3, TO_DATE('2023-05-07', 'YYYY-MM-DD'), 90.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (4, 4, 4, 4, 1, TO_DATE('2023-06-20', 'YYYY-MM-DD'), 200.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (5, 5, 5, 5, 2, TO_DATE('2023-07-15', 'YYYY-MM-DD'), 240.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (6, 6, 6, 6, 5, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 125.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (7, 7, 7, 7, 1, TO_DATE('2023-08-25', 'YYYY-MM-DD'), 300.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (8, 8, 8, 8, 2, TO_DATE('2023-09-05', 'YYYY-MM-DD'), 100.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (9, 9, 9, 9, 1, TO_DATE('2023-09-20', 'YYYY-MM-DD'), 350.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (10, 10, 10, 10, 3, TO_DATE('2023-10-01', 'YYYY-MM-DD'), 225.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (11, 11, 11, 1, 4, TO_DATE('2023-10-10', 'YYYY-MM-DD'), 400.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (12, 12, 12, 2, 10, TO_DATE('2023-10-15', 'YYYY-MM-DD'), 150.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (13, 13, 13, 3, 1, TO_DATE('2023-10-20', 'YYYY-MM-DD'), 60.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (14, 14, 14, 4, 3, TO_DATE('2023-10-25', 'YYYY-MM-DD'), 60.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (15, 15, 15, 5, 1, TO_DATE('2023-10-30', 'YYYY-MM-DD'), 2500.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (16, 16, 16, 6, 2, TO_DATE('2023-11-01', 'YYYY-MM-DD'), 200.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (17, 17, 17, 7, 1, TO_DATE('2023-11-05', 'YYYY-MM-DD'), 450.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (18, 18, 18, 8, 1, TO_DATE('2023-11-10', 'YYYY-MM-DD'), 90.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (19, 19, 19, 9, 1, TO_DATE('2023-11-15', 'YYYY-MM-DD'), 800.00);
INSERT INTO Ventas (sale_id, customer_id, product_id, staff_id, cantidad, fecha_venta, total_venta) VALUES (20, 20, 20, 10, 2, TO_DATE('2023-11-20', 'YYYY-MM-DD'), 80.00);

---TRABAJO---

---ejercicio 1---
SELECT Personal_de_Ventas.nombre || ' ' || Personal_de_Ventas.apellido AS nombre_completo,
COUNT(Ventas.sale_id) AS total_ventas,
SUM(Ventas.total_venta) AS ingreso_total
FROM
Personal_de_Ventas
JOIN
Ventas ON Personal_de_Ventas.staff_id = Ventas.staff_id
WHERE
EXTRACT(YEAR FROM Ventas.fecha_venta) = 2023 --EXTRACT(YEAR FROM SYSDATE)
GROUP BY
Personal_de_Ventas.nombre, Personal_de_Ventas.apellido
ORDER BY
ingreso_total DESC;

---ejercicio 2 ---
SELECT Clientes.nombre || ' ' || Clientes.apellido AS nombre_completo,
COUNT(Ventas.sale_id) AS total_ventas,
MIN(Ventas.fecha_venta) AS primera_venta,
MAX(Ventas.fecha_venta) AS ultima_venta
FROM
Clientes
JOIN
Ventas ON Clientes.customer_id = Ventas.customer_id
GROUP BY
Clientes.nombre, Clientes.apellido
HAVING
COUNT(Ventas.sale_id) >= 1
ORDER BY
total_ventas DESC;
