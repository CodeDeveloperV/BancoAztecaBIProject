DROP TABLE IF EXISTS TestDLR.dbo.TP001;
CREATE TABLE TestDLR.dbo.TP001 (
	Pepais smallint NOT NULL,
	Petdoc smallint NOT NULL,
	Pendoc char(25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Prdate datetime NOT NULL,
	[Fecha Incumplimiento] date NOT NULL
);



DROP TABLE IF EXISTS TestDLR.dbo.TP002;
CREATE TABLE TestDLR.dbo.TP002 (
	Empresa smallint NOT NULL,
	Modulo int NOT NULL,
	Sucursal int NOT NULL,
	Moneda smallint NOT NULL,
	Papel int NOT NULL,
	Cuenta int NOT NULL,
	Operacion int NOT NULL,
	SubOperacion int NOT NULL,
	[Tipo Operacion] smallint NOT NULL,
	[Fecha Proceso] datetime NOT NULL,
	[Fecha Incumplimiento] datetime NULL
);

