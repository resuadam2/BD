drop database if exists reserva_natural;

create database reserva_natural;

use reserva_natural;

create or replace table EMPLEADO(
	ID INT auto_increment primary key,
	FECHA_INI DATE not null,
	NOMBRE VARCHAR(30) not null,
	TLF INT(9) not null,
	DIRECCION VARCHAR(50) not null,
	TIPO ENUM('CUIDADOR','GUIA') not null	
);

create or replace table ITINERARIO(
	CODIGO INT auto_increment primary key,
	LONGITUD DOUBLE(3,2) not null,
	DURACION TIME not null,
	MAX_VISISTANTES INT(2),
	NUMERO_ESPECIES INT
);

create or replace table ZONA(
	NOMBRE VARCHAR(30) primary key,
	EXTENSION DOUBLE(3,2) not null 
);

create or replace table ESPECIE(
	NOMBRE_CIENT VARCHAR(100) primary key,
	NOMBRE_ESP VARCHAR(100) unique,
	DESCRIPCION TEXT,
	ZONA VARCHAR(30),
	foreign key (ZONA) references ZONA(NOMBRE) on delete restrict on update cascade
);

create or replace table GUIA_ITINERARIOS(
	EMPLEADO INT,
	ITINERARIO INT,
	HORA_ITINERARIO TIME  not null,
	primary key (EMPLEADO,ITINERARIO,HORA_ITINERARIO),
	foreign key (EMPLEADO) references EMPLEADO(ID) on delete cascade on update cascade,
	foreign key (ITINERARIO) references ITINERARIO(CODIGO) on delete cascade on update cascade
);

create or replace table CUIDADOR_ESPECIE(
	EMPLEADO INT,
	ESPECIE VARCHAR(100),
	FECHA_CUIDADO DATE not null,
	primary key(EMPLEADO,ESPECIE),
	foreign key (EMPLEADO) references EMPLEADO(ID) on delete cascade on update cascade,
	foreign key(ESPECIE) references ESPECIE(NOMBRE_CIENT) on delete cascade on update cascade
);

create or replace table HABITAT(
	NOMBRE VARCHAR(30) primary key,
	VEGETACION VARCHAR(50) not null,
	CLIMA VARCHAR(50) not null
	
);

create or replace table ESPECIE_HABITAT(
	ESPECIE VARCHAR(100),
	HABITAT VARCHAR(30),
	primary key( ESPECIE , HABITAT),
	foreign key (ESPECIE) references ESPECIE(NOMBRE_CIENT) on delete cascade on update cascade,
	foreign key (HABITAT) references HABITAT(NOMBRE) on delete cascade on update cascade
);

create or replace table ITINERARIO_ZONA(
	ITINERARIO INT,
	ZONA VARCHAR(30),
	primary key (ITINERARIO , ZONA),
	foreign key(ITINERARIO) references ITINERARIO(CODIGO) on delete cascade on update cascade,
	foreign key(ZONA) references ZONA(NOMBRE) on delete cascade on update cascade
);

create or replace table CONTINENTE(
	NOMBRE_CONTINENTE ENUM('EUROPA','ASIA','ÁFRICA','OCEANIA','AMÉRICA','ANTÁRTIDA'),
	HABITAT VARCHAR(30),
	primary key(NOMBRE_CONTINENTE,HABITAT),
	foreign key(HABITAT) references HABITAT(NOMBRE) on delete cascade on update cascade
);

