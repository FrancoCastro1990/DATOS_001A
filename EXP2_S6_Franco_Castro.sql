---CASO 1----
--DROP TABLE RECAUDACION_BONOS_MEDICOS;
CREATE TABLE RECAUDACION_BONOS_MEDICOS (
    RUT_MEDICO VARCHAR2(15),
    nombre_medico VARCHAR2(50),
    total_recaudado NUMBER,
    unidad_medica VARCHAR2(50)
);



INSERT INTO RECAUDACION_BONOS_MEDICOS
SELECT 
    TO_CHAR(m.rut_med, '999G999G999') || '-' || m.dv_run AS RUT_MEDICO,
    m.pnombre || ' ' || m.apaterno || ' ' || m.amaterno AS NOMBRE_MEDICO,
    SUM(NVL(bc.costo, 0)) AS TOTAL_RECAUDADO,
    u.nombre AS UNIDAD_MEDICA
FROM 
    Medico m
LEFT JOIN 
    bono_consulta bc ON m.rut_med = bc.rut_med
LEFT JOIN 
    unidad_consulta u ON m.uni_id = u.uni_id
WHERE 
    EXTRACT(YEAR FROM bc.fecha_bono) = EXTRACT(YEAR FROM SYSDATE) - 1
    AND m.car_id NOT IN (
        SELECT car_id FROM Cargo WHERE nombre IN ('Presidente Junta médica', 'Psiquiatra', 'Director Médico')
    )
GROUP BY 
    m.rut_med, m.dv_run, m.pnombre, m.apaterno, m.amaterno, u.nombre
ORDER BY 
    TOTAL_RECAUDADO ASC;


SELECT *
FROM 
    RECAUDACION_BONOS_MEDICOS
ORDER BY 
    TOTAL_RECAUDADO ASC;

---CASO 2 -----

    
SELECT * FROM det_especialidad_med;
SELECT * FROM PAGOS;
SELECT * FROM BONO_CONSULTA;
SELECT * from especialidad_medica;

--PRUEBAS
SELECT COUNT (*) FROM 
(SELECT bono_consulta.fecha_bono as FECHA_BONO from BONO_CONSULTA
INTERSECT
select fecha_pago as  FECHA_BONO from PAGOS);

---ID QUE NO EXISTEN EN PAGO
SELECT id_bono FROM BONO_CONSULTA
MINUS
SELECT id_bono FROM PAGOS;



----CASO 2 LISTO
SELECT 
    em.nombre as ESPECIALIDAD_MEDICA,
    COUNT(bc.id_bono) as CANTIDAD_BONOS,
    '$' || TO_CHAR(SUM(bc.costo), 'FM999G999G999') as MONTO_PERDIDA,
    TO_CHAR(MIN(bc.fecha_bono), 'DD/MM/YYYY') as FECHA_BONO,
    CASE 
        WHEN EXTRACT(YEAR FROM MIN(bc.fecha_bono)) >= EXTRACT(YEAR FROM SYSDATE) - 1 
        THEN 'COBRABLE'
        ELSE 'INCOBRABLE'
    END AS ESTADO_DE_COBRO
FROM (
    SELECT * 
    FROM BONO_CONSULTA
    MINUS
    SELECT bc.*
    FROM BONO_CONSULTA bc
    JOIN PAGOS p ON p.id_bono = bc.id_bono
) bc
JOIN ESPECIALIDAD_MEDICA em ON bc.esp_id = em.esp_id
GROUP BY em.nombre
ORDER BY 
    COUNT(bc.id_bono) ASC,
    SUM(bc.costo) DESC;
    
    
    
    
    
    
--PRUEBA CASO 2
    SELECT * 
    FROM BONO_CONSULTA
    MINUS
    SELECT bc.*
    FROM BONO_CONSULTA bc
    JOIN PAGOS p ON p.id_bono = bc.id_bono;
    
    
    
    
    
----CASO 3 -----
DELETE FROM CANT_BONOS_PACIENTES_ANNIO;

INSERT INTO CANT_BONOS_PACIENTES_ANNIO
SELECT 
    EXTRACT(YEAR FROM SYSDATE) AS annio_calculo,
    p.pac_run,
    p.dv_run,
    TRUNC(MONTHS_BETWEEN(SYSDATE, p.fecha_nacimiento)/12) AS edad,
    COUNT(b.id_bono) AS cantidad_bonos,
    NVL(SUM(b.costo), 0) AS monto_total_bonos,
    CASE s.tipo_sal_id 
        WHEN 'F' THEN 'FONASA'
        WHEN 'P' THEN 'PARTICULAR'
        WHEN 'FA' THEN 'FUERZAS ARMADAS'
    END AS sistema_salud
FROM PACIENTE p
JOIN SALUD s ON p.sal_id = s.sal_id
LEFT JOIN BONO_CONSULTA b ON p.pac_run = b.pac_run 
    AND EXTRACT(YEAR FROM b.fecha_bono) = EXTRACT(YEAR FROM SYSDATE)
WHERE s.tipo_sal_id IN ('F', 'P', 'FA')
    AND p.pac_run IN (
        ----Lo que logre entender :c
        ----obtener pacientes cuyo monto total no supere el promedio del año anterior--
        SELECT DISTINCT p2.pac_run
        FROM PACIENTE p2
        LEFT JOIN BONO_CONSULTA b2 ON p2.pac_run = b2.pac_run 
            AND EXTRACT(YEAR FROM b2.fecha_bono) = EXTRACT(YEAR FROM SYSDATE)
        GROUP BY p2.pac_run
        HAVING NVL(SUM(b2.costo), 0) <= (
            -- Subconsulta para calcular el promedio del año anterior---
            SELECT ROUND(AVG(costo))
            FROM BONO_CONSULTA
            WHERE EXTRACT(YEAR FROM fecha_bono) = EXTRACT(YEAR FROM SYSDATE) - 1
        )
        UNION
        -- pacientes sin bono--
        SELECT pac_run
        FROM PACIENTE
        WHERE pac_run NOT IN (
            SELECT DISTINCT pac_run 
            FROM BONO_CONSULTA 
            WHERE EXTRACT(YEAR FROM fecha_bono) = EXTRACT(YEAR FROM SYSDATE)
        )
    )
GROUP BY 
    p.pac_run,
    p.dv_run,
    p.fecha_nacimiento,
    s.tipo_sal_id
ORDER BY 
    NVL(SUM(b.costo), 0) DESC,
    TRUNC(MONTHS_BETWEEN(SYSDATE, p.fecha_nacimiento)/12) DESC;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
------------------ejercicio 3 ---------------

SELECT 
    EXTRACT(YEAR FROM SYSDATE) AS annio_calculo,
    p.pac_run,
    p.dv_run,
    TRUNC(MONTHS_BETWEEN(SYSDATE, p.fecha_nacimiento)/12) AS edad,
    COUNT (bc.id_bono) as CANTIDAD_BONOS
FROM
    Paciente p
    JOIN bono_consulta bc on bc.pac_run = p.pac_run 
GROUP BY
    p.pac_run, EXTRACT(YEAR FROM SYSDATE), p.dv_run, TRUNC(MONTHS_BETWEEN(SYSDATE, p.fecha_nacimiento)/12)
;
    
    
    
    
    
    
    
    
    
    
    
    
    
    