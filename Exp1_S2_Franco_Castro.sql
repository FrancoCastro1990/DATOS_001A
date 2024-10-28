-- Creación de tablas
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    nombre VARCHAR2(50),
    apellido VARCHAR2(50),
    fecha_registro DATE,
    email VARCHAR2(100),
    telefono VARCHAR2(20)
);

CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    nombre_producto VARCHAR2(100),
    categoria VARCHAR2(50),
    precio NUMBER(10,2),
    stock NUMBER
);

CREATE TABLE sales_staff (
    staff_id NUMBER PRIMARY KEY,
    nombre VARCHAR2(50),
    apellido VARCHAR2(50),
    email VARCHAR2(100),
    telefono VARCHAR2(20)
);

CREATE TABLE sales (
    sale_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    product_id NUMBER,
    cantidad NUMBER,
    fecha_venta DATE,
    total_venta NUMBER(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Inserción de datos de prueba
INSERT INTO customers VALUES (1, 'Juan', 'Pérez', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'juan.perez@mail.com', '123456789');
INSERT INTO customers VALUES (2, 'María', 'González', TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'maria.gonzalez@mail.com', '987654321');
INSERT INTO customers VALUES (3, 'Pedro', 'Sánchez', TO_DATE('2024-02-10', 'YYYY-MM-DD'), 'pedro.sanchez@mail.com', '456789123');
INSERT INTO customers VALUES (4, 'Ana', 'Martínez', TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'ana.martinez@mail.com', '789123456');
INSERT INTO customers VALUES (5, 'Carlos', 'López', TO_DATE('2024-03-28', 'YYYY-MM-DD'), 'carlos.lopez@mail.com', '321654987');

INSERT INTO products VALUES (1, 'Laptop Moderna', 'Computadores', 999.99, 15);
INSERT INTO products VALUES (2, 'Tableta', 'Dispositivos Móviles', 299.99, 25);
INSERT INTO products VALUES (3, 'Impresora', 'Periféricos', 199.99, 8);
INSERT INTO products VALUES (4, 'Cámara', 'Fotografía', 449.99, 12);
INSERT INTO products VALUES (5, 'Consola', 'Videojuegos', 599.99, 20);

INSERT INTO sales_staff VALUES (1, 'Roberto', 'García', 'roberto.garcia@tecnologi.com', '111222333');
INSERT INTO sales_staff VALUES (2, 'Laura', 'Fernández', 'laura.fernandez@tecnologi.com', '444555666');
INSERT INTO sales_staff VALUES (3, 'Diego', 'Torres', 'diego.torres@tecnologi.com', '777888999');
INSERT INTO sales_staff VALUES (4, 'Carmen', 'Ruiz', 'carmen.ruiz@tecnologi.com', '000111222');
INSERT INTO sales_staff VALUES (5, 'Miguel', 'Herrera', 'miguel.herrera@tecnologi.com', '333444555');

INSERT INTO sales VALUES (1, 1, 1, 1, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 999.99);
INSERT INTO sales VALUES (2, 2, 2, 2, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 599.98);
INSERT INTO sales VALUES (3, 3, 3, 1, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 199.99);
INSERT INTO sales VALUES (4, 4, 4, 1, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 449.99);
INSERT INTO sales VALUES (5, 5, 5, 1, TO_DATE('2024-03-28', 'YYYY-MM-DD'), 599.99);

-- Desafío 1: Clientes registrados en el último mes
SELECT 
    CONCAT(nombre, ' ') || apellido AS nombre_completo,
    TO_CHAR(fecha_registro, 'DD-MON-YYYY') AS fecha_registro
FROM 
    customers
WHERE 
    EXTRACT(MONTH FROM fecha_registro) = EXTRACT(MONTH FROM SYSDATE)
    AND EXTRACT(YEAR FROM fecha_registro) = EXTRACT(YEAR FROM SYSDATE)
ORDER BY 
    fecha_registro DESC;

-- Desafío 2: Incremento del 15% en productos que terminan en A
SELECT 
    nombre_producto,
    precio AS precio_actual,
    ROUND(precio * 1.15, 1) AS precio_incrementado,
    stock
FROM 
    products
WHERE 
    UPPER(nombre_producto) LIKE '%A'
    AND stock > 10
ORDER BY 
    precio_incrementado ASC;

-- Desafío 3: Lista de personal con contraseña generada
SELECT 
    nombre || ' ' || apellido AS nombre_completo,
    email,
    SUBSTR(nombre, 1, 4) || 
    LENGTH(email) || 
    SUBSTR(apellido, -3) AS contraseña
FROM 
    sales_staff
ORDER BY 
    apellido DESC,
    nombre ASC;