-- *************** CASO 1: CREACIÓN DE USUARIOS Y ROLES ***************
-- Crear usuarios
CREATE USER PRY2205_USER1 IDENTIFIED BY oracle;
CREATE USER PRY2205_USER2 IDENTIFIED BY oracle;

-- Crear roles
CREATE ROLE PRY2205_ROL_D;
CREATE ROLE PRY2205_ROL_P;

-- Asignar privilegios a los roles
GRANT CREATE PROCEDURE TO PRY2205_ROL_P;
GRANT SELECT ON PRY2205_USER1.MEDICO TO PRY2205_ROL_D;
GRANT SELECT ON PRY2205_USER1.CARGO TO PRY2205_ROL_D;

-- Asignar roles a usuarios
GRANT PRY2205_ROL_D TO PRY2205_USER2;
GRANT PRY2205_ROL_P TO PRY2205_USER1;

-- Dar privilegios necesarios a usuarios
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SYNONYM TO PRY2205_USER1;
GRANT UNLIMITED TABLESPACE TO PRY2205_USER1;
GRANT CREATE SESSION, CREATE VIEW TO PRY2205_USER2;

-- Creación de sinónimos (ejecutar como PRY2205_USER1)
CREATE PUBLIC SYNONYM PAGOS_PUB FOR PRY2205_USER1.PAGOS;
CREATE PUBLIC SYNONYM PACIENTE_PUB FOR PRY2205_USER1.PACIENTE;
CREATE SYNONYM PAGOS_PRIV FOR PRY2205_USER1.PAGOS;
CREATE SYNONYM PACIENTE_PRIV FOR PRY2205_USER1.PACIENTE;

-- Otorgar privilegios sobre las tablas
GRANT SELECT ON PRY2205_USER1.PACIENTE TO PRY2205_USER2;
GRANT SELECT ON PRY2205_USER1.BONO_CONSULTA TO PRY2205_USER2;
GRANT SELECT ON PRY2205_USER1.SALUD TO PRY2205_USER2;
GRANT SELECT ON PRY2205_USER1.SISTEMA_SALUD TO PRY2205_USER2;

-- *************** CASO 2: VISTA DE RECÁLCULO DE PAGOS ***************
-- Crear vista para consultas después de las 17:15 (como PRY2205_USER2)
CREATE OR REPLACE VIEW PRY2205_USER2.V_RECALCULO_PAGOS AS 
SELECT 
    p.pac_run as PAC_RUN,
    p.dv_run as DV_RUN,
    s.descripcion as SIST_SALUD,
    INITCAP(p.apaterno) || ' ' || INITCAP(p.pnombre) as NOMBRE_PCIENTE,
    bc.costo as COSTO,
    CASE
        WHEN bc.costo BETWEEN 15000 AND 25000 THEN 
            ROUND(bc.costo * 1.15)
        WHEN bc.costo > 25000 THEN 
            ROUND(bc.costo * 1.20)
        ELSE bc.costo
    END as MONTO_A_CANCELAR,
    TRUNC(MONTHS_BETWEEN(SYSDATE, p.fecha_nacimiento)/12) as EDAD
FROM 
    PACIENTE_PUB p
    INNER JOIN PRY2205_USER1.BONO_CONSULTA bc ON p.pac_run = bc.pac_run
    INNER JOIN PRY2205_USER1.SALUD s ON p.sal_id = s.sal_id
    INNER JOIN PRY2205_USER1.SISTEMA_SALUD ss ON s.tipo_sal_id = ss.tipo_sal_id
WHERE 
    TO_NUMBER(SUBSTR(bc.hr_consulta,1,2)) >= 17 AND 
    TO_NUMBER(SUBSTR(bc.hr_consulta,4,2)) >= 15
ORDER BY 
    p.pac_run,
    MONTO_A_CANCELAR;

GRANT SELECT ON PRY2205_USER2.V_RECALCULO_PAGOS TO PRY2205_USER1;

-- *************** CASO 3.1: VISTA DE AUMENTO MÉDICOS ***************
-- Crear índice para optimizar primera vista
CREATE INDEX IDX_MEDICO_CARGO ON PRY2205_USER1.MEDICO(car_id, sueldo_base);

-- Crear vista de médicos con cargo de atención
CREATE OR REPLACE VIEW PRY2205_USER1.VISTA_AUM_MEDICO_X_CARGO AS
SELECT 
    REPLACE(LTRIM(TO_CHAR(m.rut_med, 'FM99,999,999')), ',', '.') || '-' || m.dv_run AS RUT_MEDICO,
    'Médico ' || c.nombre AS CARGO,
    m.sueldo_base AS SUELDO_BASE,
    '$' || REPLACE(LTRIM(TO_CHAR(ROUND(m.sueldo_base * 1.15), 'FM999,999,999')), ',', '.') AS SUELDO_AUMENTADO
FROM 
    PRY2205_USER1.MEDICO m
    INNER JOIN PRY2205_USER1.CARGO c ON m.car_id = c.car_id
WHERE 
    LOWER(c.nombre) LIKE '%atención%'
ORDER BY 
    m.sueldo_base * 1.15;

-- *************** CASO 3.2: VISTA DE MÉDICOS AMBULATORIOS ***************
-- Crear índice para optimizar segunda vista
CREATE INDEX IDX_MEDICO_SUELDO_CARGO ON PRY2205_USER1.MEDICO(car_id, sueldo_base, rut_med);

-- Crear vista de médicos ambulatorios
CREATE OR REPLACE VIEW PRY2205_USER1.VISTA_AUM_MEDICO_X_CARGO_2 AS
SELECT 
    REPLACE(LTRIM(TO_CHAR(m.rut_med, 'FM99,999,999')), ',', '.') || '-' || m.dv_run AS RUT_MEDICO,
    'Médico ' || c.nombre AS CARGO,
    m.sueldo_base AS SUELDO_BASE,
    '$' || REPLACE(LTRIM(TO_CHAR(ROUND(m.sueldo_base * 1.15), 'FM999,999,999')), ',', '.') AS SUELDO_AUMENTADO
FROM 
    PRY2205_USER1.MEDICO m
    INNER JOIN PRY2205_USER1.CARGO c ON m.car_id = c.car_id
WHERE 
    m.car_id = 400
    AND m.sueldo_base < 1500000
ORDER BY 
    m.rut_med ASC;

-- Verificar resultados
SELECT * FROM PRY2205_USER1.VISTA_AUM_MEDICO_X_CARGO;
SELECT * FROM PRY2205_USER1.VISTA_AUM_MEDICO_X_CARGO_2;