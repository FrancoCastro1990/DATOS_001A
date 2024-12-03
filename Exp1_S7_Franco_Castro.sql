--EJERCICIO 1
-- Creación de tabla temporal para rangos de bonificación
CREATE GLOBAL TEMPORARY TABLE rango_bonif_ticket (
    limite_inferior NUMBER,
    limite_superior NUMBER,
    porcentaje NUMBER
) ON COMMIT PRESERVE ROWS;

-- Insertamos los rangos según las reglas especificadas
INSERT INTO rango_bonif_ticket VALUES (0, 50000, 0);
INSERT INTO rango_bonif_ticket VALUES (50001, 100000, 0.05);
INSERT INTO rango_bonif_ticket VALUES (100001, 999999999, 0.07);
COMMIT;

-- Creación de sinónimos privados
CREATE SYNONYM syn_trabajador FOR trabajador;
CREATE SYNONYM syn_bono_antiguedad FOR bono_antiguedad;
CREATE SYNONYM syn_tickets_concierto FOR tickets_concierto;

-- Secuencia para tabla DETALLE_BONIFICACIONES_TRABAJADOR
CREATE SEQUENCE seq_det_bonif
    START WITH 100
    INCREMENT BY 10
    MAXVALUE 999999999
    NOCACHE
    NOCYCLE;

-- Vista para calcular bonificaciones usando NonEquiJoi
CREATE OR REPLACE VIEW v_bonificaciones AS
SELECT 
    t.numrut || '-' || t.dvrut AS rut,
    INITCAP(t.nombre || ' ' || t.appaterno || ' ' || t.apmaterno) AS nombre_trabajador,
    TO_NUMBER(t.sueldo_base) AS sueldo_base,
    NVL(TO_CHAR(tc.nro_ticket), 'No hay info') AS num_ticket,
    t.direccion,
    i.nombre_ISAPRE AS sistema_salud,
    TO_NUMBER(NVL(tc.monto_ticket, 0)) AS monto,
    TO_NUMBER(ROUND(NVL(tc.monto_ticket, 0) * 
        NVL((SELECT porcentaje 
             FROM rango_bonif_ticket r 
             WHERE NVL(tc.monto_ticket, 0) BETWEEN r.limite_inferior AND r.limite_superior),
        0)
    )) AS bonif_x_ticket,
    TO_NUMBER(ROUND(t.sueldo_base * (1 + ba.porcentaje))) AS simulacion_antiguedad,
    TO_NUMBER(ROUND(t.sueldo_base + 
        NVL(tc.monto_ticket, 0) * 
        NVL((SELECT porcentaje 
             FROM rango_bonif_ticket r 
             WHERE NVL(tc.monto_ticket, 0) BETWEEN r.limite_inferior AND r.limite_superior),
        0)
    )) AS simulacion_x_ticket
FROM trabajador t
LEFT JOIN tickets_concierto tc ON t.numrut = tc.numrut_t
JOIN isapre i ON t.cod_ISAPRE = i.cod_ISAPRE
JOIN bono_antiguedad ba ON 
    TRUNC(MONTHS_BETWEEN(SYSDATE, t.fecing)/12) 
    BETWEEN ba.limite_inferior AND ba.limite_superior
WHERE i.porc_descto_ISAPRE > 4 
AND TRUNC(MONTHS_BETWEEN(SYSDATE, t.fecnac)/12) < 50;

-- Inserción modificada incluyendo todas las columnas
INSERT INTO detalle_bonificaciones_trabajador (
    NUM,
    RUT,
    NOMBRE_TRABAJADOR,
    SUELDO_BASE,
    NUM_TICKET,
    DIRECCION,
    SISTEMA_SALUD,
    MONTO,
    BONIF_X_TICKET,
    SIMULACION_ANTIGUEDAD,
    SIMULACION_X_TICKET
)
SELECT 
    seq_det_bonif.NEXTVAL,
    CAST(rut AS VARCHAR2(20 BYTE)),
    CAST(nombre_trabajador AS VARCHAR2(70 BYTE)),
    CAST(sueldo_base AS NUMBER(7)),
    CAST(num_ticket AS VARCHAR2(12)),
    CAST(direccion AS VARCHAR2(50)),
    CAST(sistema_salud AS VARCHAR2(30)),
    CAST(monto AS NUMBER(8)),
    CAST(bonif_x_ticket AS NUMBER(8)),
    CAST(simulacion_antiguedad AS NUMBER(8)),
    CAST(simulacion_x_ticket AS NUMBER(8))
FROM v_bonificaciones;


SELECT * FROM detalle_bonificaciones_trabajador;


--EJERCICIO 2
-- Creación de sinónimos privados para mejor seguridad
CREATE OR REPLACE SYNONYM syn_trabajador FOR trabajador;
CREATE OR REPLACE SYNONYM syn_bono_escolar FOR bono_escolar;

-- Vista de aumentos por estudios
CREATE OR REPLACE VIEW v_aumentos_estudios AS
SELECT 
    LPAD(t.numrut, 10, '0') AS rut_trabajador,
    INITCAP(t.nombre || ' ' || t.appaterno || ' ' || t.apmaterno) AS trabajador,
    UPPER(be.descrip) AS nivel_educacion,
    LPAD(TO_CHAR(be.porc_bono, 'FM000000'), 7, '0') AS pct_estudios,
    TO_CHAR(t.sueldo_base, 'FM999999999') AS sueldo_actual,
    TO_CHAR(ROUND(t.sueldo_base * be.porc_bono/100), 'FM999999999') AS aumento,
    TO_CHAR(ROUND(t.sueldo_base * (1 + be.porc_bono/100)), 'FM999999999') AS sueldo_aumentado
FROM syn_trabajador t
JOIN syn_bono_escolar be ON t.id_escolaridad_1 = be.id_escolar
WHERE t.id_categoria_1 IN (
    SELECT id_categoria 
    FROM tipo_trabajador 
    WHERE UPPER(desc_categoria) = 'CAJERO'
)
OR EXISTS (
    SELECT 1
    FROM asignacion_familiar af
    WHERE af.numrut_t = t.numrut
    GROUP BY af.numrut_t
    HAVING COUNT(*) BETWEEN 1 AND 2
)
ORDER BY t.sueldo_base DESC;

SELECT * FROM v_aumentos_estudios;