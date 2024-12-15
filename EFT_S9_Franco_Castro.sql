--EXAMEN FINAL
--se crean los index
CREATE INDEX IDX_REGION ON CLIENTE(COD_REGION);
CREATE INDEX IDX_CLI_REGION ON CLIENTE(COD_REGION, FECHA_INSCRIPCION);

--informe 1
CREATE OR REPLACE VIEW V_CLIENTES_REGION AS
SELECT 
    r.nombre_region,
    COUNT(CASE 
        WHEN MONTHS_BETWEEN(SYSDATE, c.fecha_inscripcion)/12 >= 20 
        THEN 1 END) AS clientes_antiguos,
    COUNT(*) AS total_clientes
FROM cliente c
    INNER JOIN region r ON c.cod_region = r.cod_region
GROUP BY r.nombre_region
ORDER BY clientes_antiguos ASC;

--mostramos los datos
SELECT * from V_CLIENTES_REGION;

--informe 2
--SET
SELECT 
    TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS fecha,
    tpt.cod_tptran_tarjeta AS codigo,
    tpt.nombre_tptran_tarjeta AS descripcion,
    ROUND(AVG(ttc.monto_transaccion), 0) AS monto_promedio_transaccion
FROM tipo_transaccion_tarjeta tpt
    INNER JOIN transaccion_tarjeta_cliente ttc ON tpt.cod_tptran_tarjeta = ttc.cod_tptran_tarjeta
    INNER JOIN cuota_transac_tarjeta_cliente cttc ON ttc.nro_tarjeta = cttc.nro_tarjeta 
    AND ttc.nro_transaccion = cttc.nro_transaccion
WHERE EXTRACT(MONTH FROM cttc.fecha_venc_cuota) BETWEEN 6 AND 12
GROUP BY tpt.cod_tptran_tarjeta, tpt.nombre_tptran_tarjeta
ORDER BY AVG(ttc.monto_transaccion);

--SUBCONSULTA
INSERT INTO seleccion_tipo_transaccion
SELECT 
    TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS fecha,
    tpt.cod_tptran_tarjeta,
    tpt.nombre_tptran_tarjeta,
    ROUND(AVG(ttc.monto_transaccion), 0) AS monto_promedio
FROM tipo_transaccion_tarjeta tpt
    INNER JOIN transaccion_tarjeta_cliente ttc ON tpt.cod_tptran_tarjeta = ttc.cod_tptran_tarjeta
WHERE EXISTS (
    SELECT 1 
    FROM cuota_transac_tarjeta_cliente cttc 
    WHERE ttc.nro_tarjeta = cttc.nro_tarjeta 
    AND ttc.nro_transaccion = cttc.nro_transaccion
    AND EXTRACT(MONTH FROM cttc.fecha_venc_cuota) BETWEEN 6 AND 12
)
GROUP BY tpt.cod_tptran_tarjeta, tpt.nombre_tptran_tarjeta
ORDER BY AVG(ttc.monto_transaccion);

--mostramos los datos
SELECT * FROM seleccion_tipo_transaccion;

--actualizacion tabla de interes
UPDATE tipo_transaccion_tarjeta tpt
SET tasaint_tptran_tarjeta = tasaint_tptran_tarjeta - 0.01
WHERE EXISTS (
    SELECT 1 
    FROM seleccion_tipo_transaccion stt
    WHERE stt.cod_tipo_transac = tpt.cod_tptran_tarjeta
    AND stt.fecha = TO_CHAR(SYSDATE, 'DD-MM-YYYY')
);

--mostramos los datos
SELECT * FROM tipo_transaccion_tarjeta;


--respuestas
/*
1. ¿Cuál es el problema que se debe resolver?
Se debe analizar las transacciones con cuotas que vencen en el segundo semestre del año,
calculando promedios de montos por tipo de transacción y actualizar tasas de interés.

2. ¿Cuál es la información significativa que necesita para resolver el problema?
- Fechas de vencimiento de cuotas
- Montos de transacciones
- Tipos de transacciones
- Tasas de interés actuales

3. ¿Cuál es el propósito de la solución que se requiere?
Identificar los tipos de transacciones que tienen vencimientos en el segundo semestre
y sus montos promedio, para aplicar una reducción en su tasa de interés.

4. Pasos para construir la alternativa con SUBCONSULTA:
- Identificar las tablas necesarias y sus relaciones
- Crear subconsulta para filtrar transacciones del segundo semestre
- Calcular promedios por tipo de transacción
- Insertar resultados en tabla temporal
- Actualizar tasas basado en los resultados

5. Pasos para construir la alternativa con OPERADOR SET:
- Identificar las tablas necesarias y sus relaciones
- Unir las tablas con INNER JOINS
- Filtrar por fechas del segundo semestre
- Calcular promedios por tipo de transacción
- Ordenar resultados por monto promedio
*/