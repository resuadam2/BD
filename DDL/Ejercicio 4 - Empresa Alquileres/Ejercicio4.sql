drop database if exists empresa_alquileres;

create database if not exists empresa_alquileres;

use empresa_alquileres;

create or replace table cliente(
	id int primary key auto_increment,
	dni char(9) not null unique,
	nombre varchar(50) not null,
	direccion varchar(200) not null,
	telf int(9) not null,
	aval int null,
	foreign key (aval) references cliente(id) 
		on delete restrict on update cascade
);

create or replace table coche(
	matricula varchar(10) primary key,
	modelo varchar(20) not null,
	color varchar(15) not null,
	precio_dia decimal(5,2) not null,
	marca varchar (20) not null
);

#esto es un comentario de una linea

/*
 *  Esto es un comentario multilinea
 * 
 */

create or replace table garaje(
	id int primary key auto_increment,
	direccion varchar(200) not null,
	num_plazas int not null
);

alter table coche add column garaje int not null;

alter table coche 
	add constraint foreign key (garaje) 
	references garaje(id)
	on delete restrict on update cascade;
		
create or replace table reserva(
	cliente int,
	fecha_inicio date,
	fecha_fin date not null,
	precio_total double not null,
	agencia int not null,
	primary key (cliente,fecha_inicio),
	foreign key (cliente) references cliente(id) 
		on delete cascade on update cascade
);

create or replace table agencia(
	id int primary key auto_increment,	
	direccion varchar(200) not null,
	localidad varchar(50) not null
);

alter table reserva 
	add constraint foreign key (agencia) references agencia(id)
	on delete restrict on update cascade;
	
create or replace table coche_reserva(
	matricula varchar(10),
	cliente int,
	fecha_inicio date,
	litros double not null,
	indicador boolean not null,
	primary key (matricula,cliente,fecha_inicio),
	foreign key (matricula) references coche(matricula)
		on delete restrict on update cascade,
	foreign key (cliente,fecha_inicio) references reserva(cliente,fecha_inicio)
		on delete cascade on update cascade
);
