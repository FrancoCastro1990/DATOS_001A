-- 1. Lista de productos agrupados por categoría ordenados por precio
SELECT 
    categoria,
    UPPER(nombre) as nombre_producto,
    TO_CHAR(precio, 'FM$999,999.00') as precio_formato,
    COUNT(*) as cantidad_productos
FROM Productos
GROUP BY categoria, nombre, precio
ORDER BY precio DESC;

-- 2. Promedio de ventas mensuales y mes con mayores ventas
WITH ventas_mensuales AS (
    SELECT 
        EXTRACT(YEAR FROM fecha) as anio,
        EXTRACT(MONTH FROM fecha) as mes,
        SUM(cantidad) as total_ventas
    FROM Ventas
    GROUP BY EXTRACT(YEAR FROM fecha), EXTRACT(MONTH FROM fecha)
)
SELECT 
    TO_CHAR(TO_DATE('01-'||mes||'-2000', 'DD-MM-YYYY'), 'Month', 'NLS_DATE_LANGUAGE=SPANISH') as mes,
    anio,
    total_ventas,
    ROUND(AVG(total_ventas) OVER (), 2) as promedio_mensual
FROM ventas_mensuales
WHERE (anio, mes, total_ventas) IN (
    SELECT anio, mes, total_ventas
    FROM ventas_mensuales
    WHERE total_ventas = (SELECT MAX(total_ventas) FROM ventas_mensuales)
)
ORDER BY anio, mes;

-- 3. Cliente con mayor gasto en el último año (considerando precio * cantidad)
SELECT 
    c.cliente_id,
    c.nombre,
    c.ciudad,
    TO_CHAR(SUM(v.cantidad * p.precio), 'FM$999,999.00') as total_gastado,
    COUNT(v.venta_id) as numero_compras
FROM Clientes c
JOIN Ventas v ON c.cliente_id = v.cliente_id
JOIN Productos p ON v.producto_id = p.producto_id
WHERE v.fecha >= ADD_MONTHS(SYSDATE, -12)
    AND c.fecha_registro >= ADD_MONTHS(SYSDATE, -12)
GROUP BY c.cliente_id, c.nombre, c.ciudad
ORDER BY SUM(v.cantidad * p.precio) DESC
FETCH FIRST 1 ROWS ONLY;

-- 4. Productos más vendidos por categoría
SELECT 
    p.categoria,
    p.nombre,
    TO_CHAR(p.precio, 'FM$999,999.00') as precio,
    SUM(v.cantidad) as total_vendido
FROM Productos p
JOIN Ventas v ON p.producto_id = v.producto_id
GROUP BY p.categoria, p.nombre, p.precio
HAVING SUM(v.cantidad) >= ALL (
    SELECT SUM(v2.cantidad)
    FROM Ventas v2
    JOIN Productos p2 ON v2.producto_id = p2.producto_id
    WHERE p2.categoria = p.categoria
    GROUP BY p2.producto_id
)
ORDER BY p.categoria, total_vendido DESC;

-- 5. Análisis de ventas por ciudad
SELECT 
    c.ciudad,
    COUNT(DISTINCT c.cliente_id) as numero_clientes,
    SUM(v.cantidad) as total_productos_vendidos,
    TO_CHAR(SUM(v.cantidad * p.precio), 'FM$999,999.00') as valor_total_ventas,
    TO_CHAR(AVG(v.cantidad * p.precio), 'FM$999,999.00') as valor_promedio_venta
FROM Clientes c
JOIN Ventas v ON c.cliente_id = v.cliente_id
JOIN Productos p ON v.producto_id = p.producto_id
GROUP BY c.ciudad
ORDER BY SUM(v.cantidad * p.precio) DESC;

-- 6. Tendencia mensual de ventas
SELECT 
    TO_CHAR(fecha, 'YYYY-MM') as mes,
    COUNT(*) as numero_ventas,
    SUM(cantidad) as unidades_vendidas,
    TO_CHAR(SUM(cantidad * p.precio), 'FM$999,999.00') as valor_total_ventas
FROM Ventas v
JOIN Productos p ON v.producto_id = p.producto_id
GROUP BY TO_CHAR(fecha, 'YYYY-MM')
ORDER BY mes;

-- 7. Análisis de antiguedad de clientes
SELECT 
    c.nombre,
    c.ciudad,
    TO_CHAR(c.fecha_registro, 'DD/MM/YYYY') as fecha_registro,
    TRUNC(MONTHS_BETWEEN(SYSDATE, c.fecha_registro)/12) as anos_antiguedad,
    COUNT(v.venta_id) as total_compras,
    TO_CHAR(SUM(v.cantidad * p.precio), 'FM$999,999.00') as valor_total_compras
FROM Clientes c
LEFT JOIN Ventas v ON c.cliente_id = v.cliente_id
LEFT JOIN Productos p ON v.producto_id = p.producto_id
GROUP BY c.nombre, c.ciudad, c.fecha_registro
ORDER BY c.fecha_registro;