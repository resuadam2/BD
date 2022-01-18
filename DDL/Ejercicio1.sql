drop database if exists empresa_aplicaciones;

create database empresa_aplicaciones;

use empresa_aplicaciones;


create or replace table APLICACIONES(
	NOMBRE VARCHAR(40) primary key,
	DESCRIPCION TEXT not NULL
);

create or replace table PROGRAMADORES(
	NIF CHAR(9) primary key, 
	NOMBRE VARCHAR(50) not null, 
	NSS CHAR(13) not null unique,  
	EMAIL VARCHAR(100) not null unique
);

create or replace table INCIDENCIAS(
	ID INT primary key auto_increment,
	FECHA_APERTURA DATE not null,
	FECHA_CIERRE DATE, 
	PROGRAMADOR CHAR(9) not null, 
	APLICACION VARCHAR(40) not null, 
	foreign key (PROGRAMADOR) 
					references PROGRAMADORES(NIF)
						on delete restrict 
						on update cascade, 
	foreign key (APLICACION) 
					references APLICACIONES(NOMBRE)
						on delete cascade
						on update cascade
);

create or replace table VERSIONES(
	APLICACION VARCHAR(40) default "Aplicacion Borrada", 
	ID_VERSION VARCHAR(10),
	primary key (APLICACION, ID_VERSION),
	foreign key (APLICACION) 
					references APLICACIONES(NOMBRE)
						on delete set default 
						on update cascade
);


create or replace table PROGRAMADOR_INCIDENCIA(
	INCIDENCIA INT, 
	PROGRAMADOR CHAR(9),
	TIEMPO TIME not null,
	primary key (INCIDENCIA, PROGRAMADOR),
	foreign key (PROGRAMADOR) 
					references PROGRAMADORES(NIF)
						on delete cascade 
						on update cascade, 
	foreign key (INCIDENCIA) 
					references INCIDENCIAS(ID)
						on delete cascade
						on update cascade					
);
