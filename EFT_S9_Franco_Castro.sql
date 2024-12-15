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

-- Transacciones con vencimientos en segundo semestre (Julio-Septiembre)
SELECT 
    TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS fecha,
    tpt.cod_tptran_tarjeta AS codigo,
    tpt.nombre_tptran_tarjeta AS descripcion,
    ROUND(AVG(ttc.monto_transaccion), 0) AS monto_promedio_transaccion
FROM tipo_transaccion_tarjeta tpt
    INNER JOIN transaccion_tarjeta_cliente ttc ON tpt.cod_tptran_tarjeta = ttc.cod_tptran_tarjeta
    INNER JOIN cuota_transac_tarjeta_cliente cttc ON ttc.nro_tarjeta = cttc.nro_tarjeta 
    AND ttc.nro_transaccion = cttc.nro_transaccion
WHERE EXTRACT(MONTH FROM cttc.fecha_venc_cuota) BETWEEN 7 AND 9
GROUP BY TO_CHAR(SYSDATE, 'DD-MM-YYYY'), tpt.cod_tptran_tarjeta, tpt.nombre_tptran_tarjeta

MINUS

-- Transacciones con vencimientos en último trimestre (Octubre-Diciembre)
SELECT 
    TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS fecha,
    tpt.cod_tptran_tarjeta AS codigo,
    tpt.nombre_tptran_tarjeta AS descripcion,
    ROUND(AVG(ttc.monto_transaccion), 0) AS monto_promedio_transaccion
FROM tipo_transaccion_tarjeta tpt
    INNER JOIN transaccion_tarjeta_cliente ttc ON tpt.cod_tptran_tarjeta = ttc.cod_tptran_tarjeta
    INNER JOIN cuota_transac_tarjeta_cliente cttc ON ttc.nro_tarjeta = cttc.nro_tarjeta 
    AND ttc.nro_transaccion = cttc.nro_transaccion
WHERE EXTRACT(MONTH FROM cttc.fecha_venc_cuota) BETWEEN 10 AND 12
GROUP BY TO_CHAR(SYSDATE, 'DD-MM-YYYY'), tpt.cod_tptran_tarjeta, tpt.nombre_tptran_tarjeta

MINUS

-- Excluimos las transacciones que no tienen vencimientos
SELECT 
    TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS fecha,
    tpt.cod_tptran_tarjeta AS codigo,
    tpt.nombre_tptran_tarjeta AS descripcion,
    ROUND(AVG(ttc.monto_transaccion), 0) AS monto_promedio_transaccion
FROM tipo_transaccion_tarjeta tpt
INNER JOIN transaccion_tarjeta_cliente ttc ON tpt.cod_tptran_tarjeta = ttc.cod_tptran_tarjeta
INNER JOIN cuota_transac_tarjeta_cliente cttc ON ttc.nro_tarjeta = cttc.nro_tarjeta 
    AND ttc.nro_transaccion = cttc.nro_transaccion
WHERE cttc.fecha_venc_cuota IS NULL
GROUP BY TO_CHAR(SYSDATE, 'DD-MM-YYYY'), tpt.cod_tptran_tarjeta, tpt.nombre_tptran_tarjeta
ORDER BY monto_promedio_transaccion;


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
Se debe identificar y analizar las transacciones con vencimientos de cuotas en el segundo semestre 
(julio a diciembre), calculando el monto promedio por tipo de transacción. Se requieren dos soluciones 
diferentes (una usando SET y otra con subconsultas) para posteriormente actualizar las tasas de interés 
de los tipos de transacciones identificados.

2. ¿Cuál es la información significativa que necesita para resolver el problema?
- Fechas de vencimiento de las cuotas (para identificar segundo semestre)
- Tipos de transacciones y sus descripciones
- Montos de las transacciones para calcular promedios
- Tasas de interés actuales de los tipos de transacción
- Relación entre transacciones, cuotas y tipos de transacción

3. ¿Cuál es el propósito de la solución que se requiere?
Obtener dos diferentes perspectivas (usando SET y subconsultas) del comportamiento de los tipos de 
transacciones que tienen vencimientos en el segundo semestre, para identificar cuáles requieren un 
ajuste en su tasa de interés, aplicando una reducción del 1% a aquellos tipos identificados.

4. Detallar los pasos para construir la alternativa que usa SUBCONSULTA:
a) Identificar las tablas necesarias (tipo_transaccion_tarjeta, transaccion_tarjeta_cliente, 
   cuota_transac_tarjeta_cliente)
b) Construir la subconsulta para filtrar las transacciones con vencimientos en segundo semestre
c) Realizar los JOIN necesarios entre las tablas
d) Calcular los promedios agrupando por tipo de transacción
e) Ordenar por el monto promedio de manera ascendente
f) Insertar los resultados en la tabla seleccion_tipo_transaccion
g) Actualizar las tasas de interés basado en los resultados almacenados

5. Detallar los pasos para construir la alternativa que usa OPERADOR SET:
a) Construir la primera consulta que obtiene transacciones del primer semestre
b) Construir la segunda consulta que obtiene transacciones del segundo semestre
c) Utilizar el operador MINUS para obtener solo los registros del segundo semestre
d) Asegurar que ambas consultas tengan la misma estructura de columnas
e) Incluir los cálculos de promedios y agrupaciones necesarias en cada subconsulta
f) Ordenar el resultado final por monto promedio de manera ascendente
g) Verificar que ambas consultas usen las mismas funciones para obtener fecha y redondeo
*/
