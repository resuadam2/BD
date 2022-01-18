drop database if exists lab_informatica;

create database lab_informatica;

use lab_informatica;

create or replace table fabricante(
	id int primary key auto_increment,
	web varchar(100) unique not null,
	nombre varchar(50) not null,
	telf1 varchar(15) not null,
	telf2 varchar(15) null
);

create or replace table becario(
	dni char(9) primary key,
	nss char(13) unique not null,
	nombre varchar(20) not null,
	apellidos varchar(80) not null, 
	fecha_nac date not null,
	sustituto char(9) not null,
	foreign key (sustituto) references becario(dni) on delete restrict on update cascade
);


#Revisar con datos que ocurre al borrar al supervisor y arriba al sustituto también
create or replace table laboratorio(
	id int primary key auto_increment,
	num_planta int(2) not null,
	supervisor char(9) not null,
	foreign key (supervisor) references becario (dni) on delete restrict on update cascade
);

create or replace table ordenador(
	id int primary key auto_increment,
	ip varchar(15) unique not null,
	fecha_compra date not null,
	lab int not null,
	foreign key (lab) references laboratorio(id) on delete restrict on update cascade
);

create or replace table componente(
	id int primary key auto_increment,
	descripcion text not null,
	fabricante int not null,
	foreign key (fabricante) references fabricante(id) on delete restrict on update cascade
);

create or replace table ordenador_componente(
	id_ordenador int,
	id_componente int,
	primary key (id_ordenador, id_componente),
	foreign key (id_ordenador) references ordenador(id) on delete restrict on update cascade,
	foreign key (id_componente) references componente(id) on delete restrict on update cascade
