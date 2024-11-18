
---desafio 1----
--consultas de pruebas para validar la cantidad
--SELECT ROUND(AVG(TO_NUMBER(TO_CHAR(fecha_inscripcion, 'YYYY'))))
--FROM CLIENTE;
--
--SELECT 
--    TO_CHAR(fecha_inscripcion, 'YYYY') as año,
--    COUNT(*) as cantidad
--FROM CLIENTE
--GROUP BY TO_CHAR(fecha_inscripcion, 'YYYY')
--ORDER BY año;

--consulta
SELECT 
    INITCAP(c.pnombre) || ' ' || INITCAP(c.appaterno) as nombre, 
    UPPER(p.nombre_prof_ofic) as PROFESION,
    TO_CHAR(c.fecha_inscripcion , 'DD-MM-YYYY') as FECHA, 
    c.direccion 
FROM CLIENTE c 
    INNER JOIN PROFESION_OFICIO p on c.cod_prof_ofic = p.cod_prof_ofic
    INNER JOIN TIPO_CLIENTE t on c.cod_tipo_cliente = t.cod_tipo_cliente
WHERE 
    UPPER(p.nombre_prof_ofic) IN ('CONTADOR', 'VENDEDOR')
    AND UPPER(t.nombre_tipo_cliente) LIKE 'TRABAJADORES DEPENDIENTES%'
    --entendi esto: solamente a los clientes inscritos cuyo año de inscripción es mayor al promedio redondeado de todos los años de inscripción de los cliente (es 2007)
    AND TO_NUMBER(TO_CHAR(c.fecha_inscripcion, 'YYYY')) > (
        SELECT ROUND(AVG(TO_NUMBER(TO_CHAR(fecha_inscripcion, 'YYYY'))))
        FROM CLIENTE
    )
    --AND TO_NUMBER(TO_CHAR(c.fecha_inscripcion, 'YYYY')) > 2007
ORDER BY
    c.numrun ASC
;


--desafio 2
--consultas de prueba
-- SELECT MAX(tc2.cupo_disp_compra)
--    FROM TARJETA_CLIENTE tc2
--    WHERE EXTRACT(YEAR FROM tc2.fecha_solic_tarjeta) = EXTRACT(YEAR FROM SYSDATE) - 1;

--Se intento hacer de esta forma, pero se descarto ya que en el pdf sale que al hacer el SELECT * FROM CLIENTES_CUPOS_COMPRA; 
--debia salir en un formato especifico
--CREATE TABLE CLIENTES_CUPOS_COMPRA (
--    numrun NUMBER(10),
--    dvrun VARCHAR2(1),
--    edad VARCHAR2(3),
--    cupo_disp_compra NUMBER(10,0),
--    CONSTRAINT PK_CLIENTES_CUPOS_COMPRA PRIMARY KEY (numrun)
--);

--INSERT INTO CLIENTES_CUPOS_COMPRA
--SELECT 
--    c.numrun,
--    c.dvrun,
--    FLOOR(MONTHS_BETWEEN(SYSDATE, c.fecha_nacimiento)/12) as edad,
--    tc.cupo_disp_compra
--FROM CLIENTE c 
--    JOIN TARJETA_CLIENTE tc on c.numrun = tc.numrun
--WHERE tc.cupo_disp_compra >= (
--    SELECT MAX(tc2.cupo_disp_compra)
--    FROM TARJETA_CLIENTE tc2
--    WHERE EXTRACT(YEAR FROM tc2.fecha_solic_tarjeta) = EXTRACT(YEAR FROM SYSDATE) - 1
--)
--ORDER BY c.numrun DESC;


--creamos la tabla
CREATE TABLE CLIENTES_CUPOS_COMPRA (
    rut_cliente VARCHAR2(12),
    edad VARCHAR(3),
    cupo_disp_compra NUMBER(10,0),
    tipo_cliente VARCHAR2(30 BYTE),
    CONSTRAINT PK_CLIENTES_CUPOS_COMPRA PRIMARY KEY (rut_cliente)
);


--insertamos los datos
INSERT INTO CLIENTES_CUPOS_COMPRA
SELECT 
    c.numrun || '-' || c.dvrun as rut_cliente,
    FLOOR(MONTHS_BETWEEN(SYSDATE, c.fecha_nacimiento)/12) as edad,
    tc.cupo_disp_compra,
    UPPER(t.nombre_tipo_cliente) as tipo_cliente
FROM CLIENTE c 
    INNER JOIN TIPO_CLIENTE t on c.cod_tipo_cliente = t.cod_tipo_cliente
    JOIN TARJETA_CLIENTE tc on c.numrun = tc.numrun
    --entendi esto: Dame el valor más alto (MAX) del cupo disponible para compras que existe en todas las tarjetas que fueron solicitadas el año pasado
WHERE tc.cupo_disp_compra >= (
    SELECT MAX(tc2.cupo_disp_compra)
    FROM TARJETA_CLIENTE tc2
    WHERE EXTRACT(YEAR FROM tc2.fecha_solic_tarjeta) = EXTRACT(YEAR FROM SYSDATE) - 1
)
ORDER BY c.numrun DESC;

--hacemos la consulta
SELECT * FROM CLIENTES_CUPOS_COMPRA;

