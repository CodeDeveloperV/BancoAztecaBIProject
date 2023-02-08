DELIMITER $$

DROP PROCEDURE IF EXISTS sp_interfaz_referencia_cliente;
CREATE PROCEDURE sp_interfaz_referencia_cliente()
BEGIN
--     DECLARE counter INT DEFAULT 2;
--     WHILE counter > 0 DO
    SELECT
        CONCAT(Operacion, SubOperacion),
        c.Tipo,
        vinculo,
        nombre,
        telefono,
        Relacion,
        date(NOW()) as 'Fecha de Actualización'
    FROM **


--         SET counter = counter - 1;
--     END WHILE;
END$$

DELIMITER ;

CALL sp_interfaz_referencia_cliente();

Select N

-- PROCEDIMIENTO ALMACENADO (HOY= now())
DELIMITER $$
CREATE PROCEDURE populate_TABLE1(
    @process_date DATE

) AS
BEGIN
    SELECT sngc912.SNG912Cta as SNG912CTA, fsr008.CLAVE_TITULAR as CLAVE_TITULA
    FROM SNGC912 sngc912
    INNER JOIN FSR008 fsr008
        ON sngc912.SNG912Cta = fsr008.Ctnro
    INNER JOIN FSD001 fsd001
        ON fsd001.CLAVE = fsr008.CLAVE
    WHERE sngc912.SNGC912Dm > 0
      AND (sngc912.SNG912Cta = fsr008.Ctnro
               AND fsr008.Cttfir = 'S'
               AND fsr008.Ttcod = '1'
               AND fsr008.Petipo = 'F');
END$$

CALL populate_TABLE1(GET_DATE())
-- PROCEDIMIENTO ALMACENADO