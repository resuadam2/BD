drop database if exists companhia_seguros;

create database companhia_seguros;

use companhia_seguros;

create or replace table Agente (
	DNI char(9) primary key,
	nombre varchar(60) not null,
	telefono varchar(15) not null
);

create or replace table Cliente (
	DNI char(9) primary key,
	nombre varchar(60) not null,
	telefono varchar(15) not null,
	direccion text not null
);

create or replace table Seguro (
	id int auto_increment primary key,
	DNI char(9),
	id_a char(9),
	prima double(3,2) not null,
	fecha date not null,
	cartera double(4,2),
	foreign key (DNI) references Cliente (DNI)
			on delete cascade 
			on update cascade,
	foreign key (id_a) references Agente (DNI)
		on delete restrict
		on update cascade
);

create or replace table Cliente_Agente (
	DNI_c char(9),
	DNI_a char(9),
	primary key (DNI_c, DNI_a),
	foreign key (DNI_c) references Cliente (DNI)
		on delete cascade
		on update cascade,
	foreign key (DNI_a) references Agente (DNI)
		on delete cascade
		on update cascade
);

create or replace table Seguro_Hogar (
	id int primary key,
	continente double (10,2) not null,
	contenido text not null,
	riesgos enum('RESPONSABILIDAD CIVIL','ASALTO','OTROS') not null,
	direccion text not null,
	foreign key (id) references Seguro (id)
		on delete cascade
		on update cascade
);

create or replace table Seguro_Vida (
	id int primary key,
	profesion enum('PROFESOR/A','DEPENDIENTE','ARQUITECTO/A','AZAFATO/A','POLICIA','PILOTO','MECÁNICO/A','OTROS') not null,
	fecha_nacimiento date not null,
	cobertura double (7,2) not null,
	foreign key (id) references Seguro (id)
		on delete cascade
		on update cascade
);

create or replace table Seguro_Coche (
	id int primary key,
	matricula char(7) unique not null,
	fecha_nacimiento date not null,
	categoria enum('UTILITARIO','GAMA MEDIA','GAMA ALTA','GRAN TURISMO','LUJO') not null,
	año_fabricacion date not null, 
	cobertura enum('TODO RIESGO','FRANQUICIA','TERCEROS') not null,
	foreign key (id) references Seguro (id)
		on delete cascade
		on update cascade
);

create or replace table Beneficiario_Seguro (
	id int primary key,
	beneficiario text not null,
	foreign key (id) references Seguro_Vida (id)
		on delete cascade
		on update cascade
);

create or replace table Estudios_Hogar (
	id int primary key,
	estudios text not null,
	foreign key (id) references Seguro_Hogar (id)
		on delete cascade
		on update cascade
);






