---- Tabla Clientes
----drop table Clientes; 
--CREATE TABLE Clientes (
--    customer_id NUMBER PRIMARY KEY,
--    nombre VARCHAR2(50) NOT NULL,
--    apellido VARCHAR2(50) NOT NULL,
--    fecha_registro DATE DEFAULT SYSDATE,
--    email VARCHAR2(100),
--    telefono VARCHAR2(20)
--);
--
---- Tabla Productos
----drop table Productos;
--CREATE TABLE Productos (
--    product_id NUMBER PRIMARY KEY,
--    nombre_producto VARCHAR2(100) NOT NULL,
--    categoria VARCHAR2(50),
--    precio NUMBER(10, 2) CHECK (precio >= 0),
--    stock NUMBER(10) CHECK (stock >= 0)
--);
--
---- Tabla Personal de Ventas
----drop table Personal_de_Ventas;
--CREATE TABLE Personal_de_Ventas (
--    staff_id NUMBER PRIMARY KEY,
--    nombre VARCHAR2(50) NOT NULL,
--    apellido VARCHAR2(50) NOT NULL,
--    email VARCHAR2(100),
--    telefono VARCHAR2(20)
--);
--
---- Tabla Ventas
----DROP TABLE Ventas;
--CREATE TABLE Ventas (
--    sale_id NUMBER PRIMARY KEY,
--    customer_id NUMBER REFERENCES Clientes(customer_id),
--    product_id NUMBER REFERENCES Productos(product_id),
--    cantidad NUMBER(5) CHECK (cantidad > 0),
--    fecha_venta DATE DEFAULT SYSDATE,
--    total_venta NUMBER(10, 2),
--    staff_id NUMBER REFERENCES Personal_de_Ventas(staff_id)
--);
--
--
----Poblamiento
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (1, 'Juan', 'Pérez', DATE '2023-05-10', 'juan.perez@example.com', '123456789');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (2, 'Ana', 'López', DATE '2023-06-12', 'ana.lopez@example.com', '987654321');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (3, 'Carlos', 'García', DATE '2023-07-15', 'carlos.garcia@example.com', '555555555');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (4, 'Laura', 'Martínez', DATE '2023-08-10', 'laura.martinez@example.com', '444444444');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (5, 'Sofía', 'Díaz', DATE '2023-09-18', 'sofia.diaz@example.com', '666666666');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (6, 'Lucas', 'Mendoza', DATE '2023-10-02', 'lucas.mendoza@example.com', '333333333');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (7, 'Juliana', 'Torres', DATE '2023-11-05', 'juliana.torres@example.com', '222222222');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (8, 'Pedro', 'Ramírez', DATE '2023-08-08', 'pedro.ramirez@example.com', '111111111');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (9, 'Marta', 'González', DATE '2023-05-20', 'marta.gonzalez@example.com', '777777777');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (10, 'Luis', 'Herrera', DATE '2023-07-30', 'luis.herrera@example.com', '888888888');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (11, 'Carmen', 'Jiménez', DATE '2023-09-21', 'carmen.jimenez@example.com', '999999999');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (12, 'Gabriel', 'Ortiz', DATE '2023-10-10', 'gabriel.ortiz@example.com', '555123123');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (13, 'Raúl', 'Castro', DATE '2023-06-15', 'raul.castro@example.com', '444123123');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (14, 'Mariana', 'Morales', DATE '2023-11-01', 'mariana.morales@example.com', '333123123');
--INSERT INTO Clientes (customer_id, nombre, apellido, fecha_registro, email, telefono) VALUES (15, 'Ricardo', 'Vargas', DATE '2023-08-25', 'ricardo.vargas@example.com', '222123123');
--
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(1, 'Laptop X', 'Portátiles', 1500.00, 10);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(2, 'Monitor UltraHD', 'Monitores', 300.00, 20);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(3, 'Teclado Mecánico', 'Accesorios', 100.00, 50);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(4, 'Mouse Inalámbrico', 'Accesorios', 40.00, 30);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(5, 'Impresora Láser', 'Impresoras', 200.00, 15);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(6, 'Smartphone Pro', 'Teléfonos', 1200.00, 5);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(7, 'Tablet Z', 'Tabletas', 400.00, 8);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(8, 'Router Wi-Fi', 'Redes', 70.00, 25);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(9, 'Proyector HD', 'Proyectores', 500.00, 7);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(10, 'Cámara Web HD', 'Accesorios', 50.00, 45);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(11, 'Auriculares Bluetooth', 'Audio', 80.00, 35);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(12, 'Parlante Portátil', 'Audio', 120.00, 20);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(13, 'SSD 1TB', 'Almacenamiento', 150.00, 12);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(14, 'Disco Duro Externo 2TB', 'Almacenamiento', 100.00, 18);
--INSERT INTO Productos (product_id, nombre_producto, categoria, precio, stock) VALUES(15, 'UPS', 'Energía', 250.00, 6);
--
--INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (1, 'Daniel', 'Lara', 'daniel.lara@example.com', '123450000');
--INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (2, 'Sergio', 'Romero', 'sergio.romero@example.com', '123450001');
--INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (3, 'Paula', 'Vega', 'paula.vega@example.com', '123450002');
--INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (4, 'Andrea', 'Meza', 'andrea.meza@example.com', '456450003');
--INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (5, 'Mario', 'Pacheco', 'mario.pacheco@example.com', '456450004');
--INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (6, 'Laura', 'Silva', 'laura.silva@example.com', '456450005');
--INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (7, 'Jorge', 'Nuñez', 'jorge.nunez@example.com', '789450006');
--INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (8, 'Claudia', 'Ríos', 'claudia.rios@example.com', '789450007');
--INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (9, 'Raquel', 'Espinoza', 'raquel.espinoza@example.com', '789450008');
--INSERT INTO Personal_de_Ventas (staff_id, nombre, apellido, email, telefono) VALUES (10, 'Carlos', 'Ramos', 'carlos.ramos@example.com', '789450009');
--
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (1, 1, 1, 1,   DATE '2024-09-20', 1500.00, 1);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (2, 2, 3, 2,   DATE '2024-10-05', 200.00, 2);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (3, 3, 5, 1,   DATE '2024-10-10', 200.00, 3);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (4, 4, 7, 1,   DATE '2024-09-12', 400.00, 4);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (5, 5, 2, 1,   DATE '2024-09-22', 300.00, 5);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (6, 6, 1, 1,   DATE '2024-10-20', 1500.00, 6);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (7, 7, 6, 1,   DATE '2024-10-30', 1200.00, 7);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (8, 8, 10, 3,  DATE '2024-08-12', 150.00, 8);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (9, 9, 8, 1,   DATE '2024-09-18', 70.00, 9);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (10, 10, 11, 2,DATE '2024-10-05', 160.00, 10);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (11, 11, 13, 1,DATE '2024-10-15', 150.00, 2);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (12, 12, 14, 1,DATE '2024-09-25', 100.00, 3);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (13, 13, 15, 1,DATE '2024-10-25', 250.00, 4);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (14, 14, 12, 2,DATE '2024-11-05', 240.00, 5);
--INSERT INTO Ventas (sale_id, customer_id, product_id, cantidad, fecha_venta, total_venta, staff_id) VALUES (15, 15, 9, 1, DATE '2024-11-07', 500.00, 6);



--SELECT * FROM CLIENTES;
--SELECT * FROM VENTAS;
--SELECT * FROM PERSONAL_DE_VENTAS;
--SELECT * FROM Productos;




---ejercicio 1---
SELECT 
    c.nombre || ' ' || c.apellido AS nombre_cliente,
    p.nombre_producto,
    v.cantidad,
    v.fecha_venta,
    v.fecha_venta + 
    CASE 
        WHEN p.categoria IN ('Monitores', 'Portátiles', 'Proyectores') THEN 90
        WHEN p.categoria = 'Impresoras' THEN 90
        WHEN p.categoria IN ('Almacenamiento', 'Energía') THEN 180
        ELSE 30 
    END AS fecha_fin_garantia,
    CASE 
        WHEN (v.fecha_venta + 
            CASE 
                WHEN p.categoria IN ('Monitores', 'Portátiles', 'Proyectores') THEN 90
                WHEN p.categoria = 'Impresoras' THEN 90
                WHEN p.categoria IN ('Almacenamiento', 'Energía') THEN 180
                ELSE 30 
            END) >= SYSDATE THEN 'SI'
        ELSE 'NO'
    END AS garantia_vigente
FROM 
    Ventas v
    JOIN Clientes c ON v.customer_id = c.customer_id
    JOIN Productos p ON v.product_id = p.product_id
WHERE 
    v.fecha_venta >= ADD_MONTHS(SYSDATE, -3)
ORDER BY 
    v.fecha_venta DESC;
    
---ejercicio 2---
SELECT 
    UPPER(pv.nombre || ' ' || pv.apellido) AS nombre_completo,
    CASE 
        WHEN SUBSTR(pv.telefono, 1, 3) = '123' THEN 'Zona Alpha'
        WHEN SUBSTR(pv.telefono, 1, 3) = '456' THEN 'Zona Beta'
        WHEN SUBSTR(pv.telefono, 1, 3) = '789' THEN 'Zona Gamma'
        ELSE 'Otra Zona'
    END AS zona,
    COUNT(v.sale_id) as total_ventas,
    NVL(SUM(v.total_venta), 0) as monto_total_ventas
FROM 
    Personal_de_Ventas pv
    LEFT JOIN Ventas v ON pv.staff_id = v.staff_id
GROUP BY 
    pv.nombre, pv.apellido, pv.telefono
HAVING 
    NVL(SUM(v.total_venta), 0) >= 1000
ORDER BY 
    monto_total_ventas DESC;
    
    
    
---ejercicio 3 ---
SELECT 
    c.nombre || ' ' || c.apellido AS nombre_cliente,
    c.email,
    COALESCE(p.nombre_producto, 'Sin compras') AS producto,
    COALESCE(TO_CHAR(v.cantidad), 'N/A') AS cantidad
FROM 
    Clientes c
    LEFT JOIN Ventas v ON c.customer_id = v.customer_id
    LEFT JOIN Productos p ON v.product_id = p.product_id
ORDER BY 
    c.nombre, c.apellido;


---ejercicio 4 ---
SELECT 
    p.nombre_producto,
    p.categoria,
    p.precio,
    c.nombre || ' ' || c.apellido AS cliente_potencial,
    c.email,
    CASE 
        WHEN v.sale_id IS NOT NULL THEN 'Cliente Actual'
        ELSE 'Cliente Potencial'
    END AS estado_cliente
FROM 
    Productos p
    CROSS JOIN Clientes c
    LEFT JOIN Ventas v ON c.customer_id = v.customer_id 
        AND p.product_id = v.product_id
ORDER BY 
    p.nombre_producto, 
    estado_cliente DESC,
    c.nombre;