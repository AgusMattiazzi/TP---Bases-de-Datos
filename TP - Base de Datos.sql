-- Base de Datos TP
DROP DATABASE IF EXISTS BD_TP;

CREATE DATABASE BD_TP;
USE BD_TP;

-- ENTIDADES ---------------------------------------------------------------- /
-- PERSONA(NOMBRE,APELLIDO)
CREATE TABLE IF NOT EXISTS PERSONA (
  P_NOMBRE	CHAR(30) NOT NULL,
  PRIMARY KEY  (P_NOMBRE)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO PERSONA (P_NOMBRE) VALUES
('Ana'),
('Adriana'),
('Barbara'),
('Celeste'),
('Dalcio'),
('David'),
('Enzo'),
('Fernando'),
('Franco'),
('Gianluca'),
('Giuliano'),
('Guido'),
('Guillermo'),			-- Aparece en el item d)
('Joaquin'),
('Jorge'),
('Juan Manuel'),
('Julian'),
('Lucina'),
('Maria Julia'),
('Mariano E'),
('Mariano M'),			-- Aparece en el item e)
('Tina'),
('Yanina');

-- BAR(NOMBRE,DIRECCION)
CREATE TABLE IF NOT EXISTS BAR (
  B_NOMBRE	CHAR(30) NOT NULL,
  PRIMARY KEY  (B_NOMBRE)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO BAR (B_NOMBRE) VALUES
('Antares'),
('Barra Vieja'),
('Canmore'),
('Cervario'),
('El abasto'),
('Griffin'),
('Kuhstall'),
('Manush'),
('N40'),
('Plaza Pichincha'),
('Quitapenas');

-- CERVEZA(NOMBRE)
CREATE TABLE IF NOT EXISTS CERVEZA (
  C_NOMBRE	CHAR(30) NOT NULL,
  PRIMARY KEY  (C_NOMBRE)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO CERVEZA (C_NOMBRE) VALUES
('Barley Wine'),
('Don Satur'),
('Golden Ale'),
('Honey'),
('IPA'),
('Irish'),
('Poker'),
('Porter'),
('Santa Fe'),
('Scottish'),
('Stella');

-- RELACIONES --------------------------------------------------------------- /
-- FRECUENTA (PERSONA, BAR)
CREATE TABLE IF NOT EXISTS FRECUENTA (
  PERSONA 	CHAR(30) NOT NULL,
  BAR		CHAR(30) NOT NULL,
  PRIMARY KEY  (PERSONA, BAR),
  
  FOREIGN KEY (PERSONA) REFERENCES PERSONA
	(P_NOMBRE) ON UPDATE CASCADE ON DELETE CASCADE,
	
  FOREIGN KEY (BAR) REFERENCES BAR
	(B_NOMBRE) ON UPDATE CASCADE ON DELETE CASCADE
  
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO FRECUENTA (PERSONA, BAR) VALUES
('Ana',			'Barra Vieja'),			-- Aparece en b) pero no en c)
('Ana',			'Canmore'),				-- Aparece en b) pero no en c)

('Adriana',		'Antares'),
('Barbara',		'El abasto'),
('Celeste',		'Antares'),
('Dalcio',		'Antares'),
('David',		'Kuhstall'),
('Enzo',		'Manush'),
('Fernando',	'Canmore'),
('Franco',		'Plaza Pichincha'),
('Gianluca',	'Manush'),
('Giuliano',	'Canmore'),

('Guido',		'Canmore'),				-- Aparece en b) pero no en c)
('Guido',		'Antares'),				-- Aparece en b) pero no en c)

('Guillermo',	'Antares'),				-- Aparece en d)

('Joaquin',		'Griffin'),
('Jorge',		'Canmore'),

('Juan Manuel',	'Kuhstall'),			-- Aparece en b) pero no en c)
('Juan Manuel',	'Antares'),				-- Aparece en b) pero no en c)

('Julian',		'Antares'),
('Lucina',		'Quitapenas'),
('Maria Julia',	'Cervario'),
('Mariano E',	'Manush'),

('Mariano M',	'Manush'),				-- Item e)	Va a todos los bares
('Mariano M',	'Antares'),				-- Item e)
('Mariano M',	'Cervario'),			-- Item e)
('Mariano M',	'Canmore'),				-- Item e)
('Mariano M',	'Plaza Pichincha'),		-- Item e)
('Mariano M',	'El abasto'),			-- Item e)
('Mariano M',	'Barra Vieja'),			-- Item e)
('Mariano M',	'N40'),					-- Item e)
('Mariano M',	'Quitapenas'),			-- Item e)
('Mariano M',	'Kuhstall'),			-- Item e)
('Mariano M',	'Griffin'),				-- Item e)

('Tina',		'Barra Vieja'),
('Yanina',		'N40');

-- SIRVE (CERVEZA,BAR)
CREATE TABLE IF NOT EXISTS SIRVE (
  CERVEZA 	CHAR(30) NOT NULL,
  BAR 		CHAR(30) NOT NULL,
  PRIMARY KEY  (CERVEZA, BAR),
  
  FOREIGN KEY (CERVEZA) REFERENCES CERVEZA
	(C_NOMBRE) ON UPDATE CASCADE ON DELETE CASCADE,
	
  FOREIGN KEY (BAR) REFERENCES BAR
	(B_NOMBRE) ON UPDATE CASCADE ON DELETE CASCADE
	
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO SIRVE (CERVEZA, BAR) VALUES
('Barley Wine',	'Manush'),
('Don Satur',	'Canmore'),
('Golden Ale',	'Kuhstall'),
('Honey',		'Canmore'),
('IPA',			'Antares'),
('IPA',			'Canmore'),
('IPA',			'Cervario'),
('IPA',			'Griffin'),
('IPA',			'Manush'),
('Irish',		'El abasto'),
('Irish',		'Kuhstall'),
('Irish',		'Manush'),
('Poker',		'Antares'),
('Porter',		'Antares'),
('Porter',		'Barra Vieja'),
('Santa Fe',	'Barra Vieja'),
('Scottish',	'Plaza Pichincha'),		-- Item a) Jorge
('Scottish',	'N40'),					-- Item a) Jorge
('Scottish',	'Canmore'),				-- Item a) Jorge
('Stella',		'Quitapenas');


-- GUSTA (PERSONA, CERVEZA)
CREATE TABLE IF NOT EXISTS GUSTA (
  PERSONA 	CHAR(30) NOT NULL,
  CERVEZA	CHAR(30) NOT NULL,
  PRIMARY KEY  (PERSONA,CERVEZA),
  
  FOREIGN KEY (PERSONA) REFERENCES PERSONA
	(P_NOMBRE) ON UPDATE CASCADE ON DELETE CASCADE,
  
  FOREIGN KEY (CERVEZA) REFERENCES CERVEZA
	(C_NOMBRE) ON UPDATE CASCADE ON DELETE CASCADE
	
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO GUSTA (PERSONA, CERVEZA) VALUES
('Adriana',		'Porter'),
('Ana',			'Santa Fe'),
('Ana',			'IPA'),
('Barbara',		'Irish'),
('Celeste',		'IPA'),
('Dalcio',		'IPA'),
('David',		'Irish'),
('Enzo',		'IPA'),
('Fernando',	'Don Satur'),
('Franco',		'Scottish'),
('Franco',		'Irish'),
('Gianluca',	'Irish'),
('Giuliano',	'IPA'),
('Guido',		'Honey'),
('Guillermo',	'Barley Wine'),	-- Item d)
('Joaquin',		'IPA'),
('Jorge',		'Scottish'),	-- Item a) Jorge
('Jorge',		'Santa Fe'),	-- Item a) Jorge
('Juan Manuel',	'Golden Ale'),
('Julian',		'Poker'),
('Lucina',		'Stella'),
('Maria Julia',	'IPA'),
('Mariano E',	'Barley Wine'),
('Mariano M',	'Scottish'),
('Tina',		'Porter'),
('Yanina',		'Scottish');


