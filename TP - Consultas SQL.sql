-- TP Bases de Datos - Consultas SQL

--	1) 	Crear las tres tablas.
--	2) 	Generar una instancia de la base de datos, que permita evaluar la 
--		correcta resolución de las consultas.
--	Esto se resuelve importando la base de datos

-- Creo una vista para ayudarme
CREATE VIEW INFO AS (SELECT G.PERSONA,F.BAR,S.CERVEZA 
	FROM GUSTA G,SIRVE S,FRECUENTA F
        WHERE 	F.PERSONA = G.PERSONA
        AND		G.CERVEZA = S.CERVEZA
        AND 	S.BAR = F.BAR
); -- Las personas que toman cervezas en bares que sirven cervezas de su agrado

CREATE VIEW TODOS_JUGADORES AS(SELECT J1_COD J_COD,C_COD FROM PARTIDAS)
    UNION(SELECT J2_COD,C_COD FROM PARTIDAS);

--	3) 	Resolver las siguientes consultas en SQL:
--	a. 	Mostrar los bares que sirven alguna cerveza que le guste a Jorge.
SELECT BAR FROM SIRVE WHERE CERVEZA IN(
	SELECT CERVEZA FROM GUSTA WHERE PERSONA = 'JORGE'); -- 4 Bares
	
--	b. 	Mostrar los nombres de las personas que frecuentan al menos un bar que
--		sirven alguna cerveza que les guste.
SELECT DISTINCT PERSONA FROM FRECUENTA WHERE PERSONA IN(
	SELECT PERSONA FROM GUSTA WHERE EXISTS(
		SELECT * FROM SIRVE WHERE
			GUSTA.CERVEZA = SIRVE.CERVEZA AND
			FRECUENTA.BAR = SIRVE.BAR
	)
); -- 22 Personas
-- ME DA LA SENSACION DE QUE SE OMITE A LA PERSONA

-- 	c. 	Mostrar los nombres de las personas que sólo frecuentan bares que
-- 		sirven alguna cerveza que les guste. (Asumir que a cada persona le
-- 		gusta al menos una cerveza y frecuenta al menos un bar).
SELECT DISTINCT PERSONA FROM GUSTA WHERE PERSONA NOT IN(
	SELECT PERSONA FROM FRECUENTA WHERE NOT EXISTS(
		SELECT * FROM SIRVE WHERE
			GUSTA.CERVEZA = SIRVE.CERVEZA AND
			FRECUENTA.BAR = SIRVE.BAR
	)
); -- 18 Personas
-- ME DA LA SENSACION DE QUE SE OMITE A LA PERSONA

SELECT PERSONA,COUNT(PERSONA) FROM FRECUENTA WHERE EXISTS(
	SELECT BAR FROM SIRVE WHERE EXISTS(
		SELECT CERVEZA FROM GUSTA WHERE
        	FRECUENTA.PERSONA = GUSTA.PERSONA AND
			GUSTA.CERVEZA = SIRVE.CERVEZA AND
			SIRVE.BAR = FRECUENTA.BAR
	)
) GROUP BY PERSONA; -- APARECE LA PERSONA TANTAS VECES COMO BARES SIRVEN LA CERVEZA Q LE GUSTA

-- 	d. 	Mostrar los nombres de las personas que no frecuenten ningún bar que
-- 		sirva una cerveza que les guste.
SELECT P_NOMBRE FROM PERSONA WHERE P_NOMBRE NOT IN(
	SELECT DISTINCT PERSONA FROM FRECUENTA WHERE PERSONA IN(
		SELECT PERSONA FROM GUSTA WHERE EXISTS(
			SELECT * FROM SIRVE WHERE
				GUSTA.CERVEZA = SIRVE.CERVEZA AND
				FRECUENTA.BAR = SIRVE.BAR
		)
	)
);
-- 	Busque seleccionar el conjunto negativo del ítem b ya que es lo mismo que
-- 	considerar a las personas que no frecuentan bares que sirvan cervezas de su
-- 	agrado (teniendo en cuenta que todas las personas frecuentan al menos un
-- 	bar y gustan de al menos una cerveza)

--	e. Mostrar los nombres de las personas que frecuentan todos los bares.
--	(Asumir que todos los bares sirven al menos una cerveza).
SELECT PERSONA FROM FRECUENTA GROUP BY PERSONA
	HAVING COUNT(DISTINCT BAR) = (SELECT COUNT(*) FROM BAR);

