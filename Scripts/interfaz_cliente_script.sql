USE TestDLR;
GO

-- SCRIPT TO INSERT INTO TABLA 1 FROM EACH SNG912 TABLE RECORD IN SNG912Cta FIELD
CREATE PROCEDURE InsertUpdateArrearsCredit
AS
BEGIN
	SET @ProcessDate = GETDATE()
	SET @ArrearCredits = (
		SELECT
			fsd.Pepais,
			fsd.Petdoc,
			fsd.Pendoc,
			getDate(),
			getDate()
		FROM dbo.FSR008 fsr
		JOIN dbo.FSD001 fsd ON fsd.Pendoc = fsr.Pendoc 
		WHERE fsr.CTNRO 
			IN (SELECT DISTINCT sng.SNG912Cta
				FROM dbo.SNG912 AS sng
				WHERE sng.SNG912Dm > 0
			) 
			AND fsr.Cttfir = 'T'
			AND fsr.Ttcod = 1
			AND fsd.Petipo = 'F';
	)
	IF EXISTS(SELECT dbo.Tabla1.Pendoc 
			  FROM dbo.Tabla1 t1 
			  WHERE t1.Pendoc 
			  IN @ArrearCredits)
	BEGIN
		UPDATE dbo.Tabla1
		SET dbo.Tabla1.ProcessDate = GETDATE() 
	END
	ELSE
	BEGIN
		INSERT INTO dbo.Tabla1 (
		Pepais, 
		Petdoc,
		Pendoc, 
		[Fecha Incumplimiento], 
		ProcessDate) @ArrearCredits
	END
END;


CREATE PROCEDURE dbo.InterfazCliente
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
		186 AS Entidad, 
		fst014.Tdnom  AS Tdom,
		t1.Pendoc AS Documento,
		fsd002.Pfnom1 AS [Primer Nombre],
		fsd002.Pfnom2 AS [Segundo Nombre],
		fsd002.Pfape1 AS [Primer Apellido],
		fsd002.Pfape2 AS [Segundo Apellido],
		fsd002.Pffnac AS [Fecha de Nacimiento],
		fsd002.Pfcant AS [Sexo],
		fst009.Ecnom AS [Estado Civil],
		fse001.PaisCon AS [Personas a cargo],
		fst115.ProfTxt AS [Profesion],
		fst750.ActNom1 AS [Actividad Economica],
		sngc60.SNGC60Aux1 AS [Tipo de Ingreso],
		fse101.PexIng AS [Ingresos],
		sngc60.SNGC60Rzso AS [Empresa],
		fst020.Vinom AS [Posicion],
		sngc60.SNGC60Fine AS [Fecha Ingreso],
	--	fst014.Tdnom AS [Nombre vendedor]
		fst014.Tdnom AS [Tipo de identificacion dl conyugue],
	--	fsr002.Rpndoc AS [Identificacion del cónyugue],
		fst068.DepNom AS [Provincia],
		fst070.LocNom AS [Distrito],
		fst071.Fst071Dsc AS [Corregimiento],
		sngc13.sngc13Ref AS [Barrio],
		sngc13.sngc13Ref1 AS [Detalle Ubicación],
		sngc32.SNGC32Lat AS [Latitud],
		sngc32.SNGC32Lng AS [Longitud],
		GETDATE() AS [Fecha de proceso]
	FROM dbo.Tabla1 AS t1
	FULL JOIN dbo.FST014 AS fst014 ON t1.Petdoc = fst014.Tdocum
	JOIN dbo.FSD002 AS fsd002 ON t1.Pendoc = fsd002.Pfndoc
	FULL JOIN dbo.FST009 AS fst009 ON fsd002.Pfeciv = fst009.Eccod
	FULL JOIN dbo.FSE001 AS fse001 ON fse001.D511Ndoc = t1.Pendoc
	FULL JOIN dbo.FSE002 AS fse002 ON fse002.PfxNdoc = t1.Pendoc
	FULL JOIN dbo.FST115 AS fst115 ON fst115.ProfCod = fse002.ProfCod
	FULL JOIN dbo.SNGC60 AS sngc60 ON sngc60.SNGC60Ndoc = t1.Pendoc
	FULL JOIN dbo.FST750 AS fst750 ON fst750.ActCod1 = sngc60.SNGC60Acte
	FULL JOIN dbo.FSE101 AS fse101 ON fse101.Pendoc = t1.Pendoc
	FULL JOIN dbo.FST020 AS fst020 ON sngc60.SNGC60Vcod = fst020.Vicod
	--FULL JOIN dbo.FST746 AS fst746 ON 
	--INNE1R JOIN dbo.FSR002 AS fsr002 ON fst014.Tdnom = fsr002.Rpndoc
	INNER JOIN dbo.SNGC13 AS sngc13 ON t1.Pendoc = sngc13.sngc13Ndoc
	INNER JOIN dbo.FST068 AS fst068 ON sngc13.sngc13Dpto = fst068.DepCod
	INNER JOIN dbo.FST070 AS fst070 ON sngc13.sngc13Prov = fst070.LocCod
	INNER JOIN dbo.FST071 AS fst071 ON sngc13.sngc13Dist = fst071.Fst071Col
	INNER JOIN dbo.FSR008 AS fsr008 ON t1.Pendoc = fsr008.Pendoc 
	INNER JOIN dbo.SNGC32 AS sngc32 ON fsr008.CTNRO = sngc32.SNGC32Cta
	WHERE 
		t1.Pendoc IS NOT NULL 
		AND fsd002.Pfnom1 IS NOT NULL
		AND fsd002.Pfnom2 IS NOT NULL
		AND fsd002.Pffnac IS NOT NULL
		AND fsd002.Pfcant IS NOT NULL;
END


EXECUTE InterfazCliente

USE TestDLR;
SELECT *
FROM dbo


