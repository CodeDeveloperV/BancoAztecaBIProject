USE TestDLR;
	

INSERT INTO dbo.TP001 (Pepais, Petdoc, Pendoc, [Fecha Incumplimiento], Prdate)
SELECT
	fsr008.Pepais, 
	fsr008.Petdoc, 
	fsr008.Pendoc, 
	GETDATE() AS [Fecha Incumplimiento], 
	GETDATE() AS Prdate   
FROM (SELECT DISTINCT sng912.SNG912Cta 
	FROM SNG912 AS sng912
	WHERE sng912.SNG912Dm > 0) sng912
INNER JOIN FSR008 fsr008 ON sng912.SNG912Cta = fsr008.CTNRO
INNER JOIN FSD001 fsd001 ON fsr008.Pendoc = fsd001.Pendoc
WHERE fsr008.Cttfir IS NOT NULL 
	AND fsr008.Cttfir = 'T' 
	AND fsr008.Ttcod = 1
	AND fsd001.Petipo = 'F';

TRUNCATE TABLE TP001;
