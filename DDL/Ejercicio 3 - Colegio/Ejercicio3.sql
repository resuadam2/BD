drop database if exists colegio;

create database colegio;

use colegio;

create or replace table departamento(
	id int primary key auto_increment,
	nombre varchar(30) not null unique
);

# insert into departamento (nombre) value('Departamento por Defecto');

create or replace table profesor(
	nrp char(15) primary key,
	nombre varchar(50) not null,
	area varchar(50) not null,
	categoria varchar(20) not null
);

create or replace table asignatura(
	id int primary key auto_increment,
	nombre varchar(50) not null,
	creditos int(3) not null,
	caracter enum('troncal','obligatoria','optativa') not null,
	curso char(2) not null
);

create or replace table alumno(
	dni char(9) primary key,
	nombre varchar(50) not null,
	fecha_nac date not null,
	direccion varchar(200) not null,
	beca bool not null default false
);

create or replace table grupo(
	num int,
	id_asig int,
	tipo enum('teoria','practica') not null,
	maxAlumnos int(3) not null,
	primary key (num,id_asig),
	foreign key (id_asig) references asignatura(id)
		on delete cascade on update cascade
);

alter table profesor add column depto int not null default 1;


alter table profesor add foreign key (depto) references departamento(id)
		on delete set default on update cascade;

create or replace table prof_grupo(
	nrp char(15),
	num_grupo int,
	id_asig int,
	primary key (nrp,num_grupo,id_asig),
	foreign key (nrp) references profesor(nrp) on delete cascade on update cascade,
	foreign key (num_grupo,id_asig) references grupo(num,id_asig) on delete cascade on update cascade
);

create or replace table matricula(
	dni char(9),
	id_asig int,
	convocatoria date,
	calificacion real(3,2),
	primary key (dni,id_asig,convocatoria),
	foreign key (dni) references alumno(dni) on delete cascade on update cascade,
	foreign key (id_asig) references asignatura(id)
		on delete cascade on update cascade
);

alter table departamento add column director char(15) default null;

alter table departamento add foreign key (director) references profesor(nrp)
		on delete set null on update cascade;

create or replace table alumno_grupo(
	num_grupo int,
	id_asig int,
	dni char(9),
	primary key (dni,num_grupo,id_asig),
	foreign key (num_grupo,id_asig) references grupo(num,id_asig) on delete cascade on update cascade,
	foreign key (dni) references alumno(dni) on delete cascade on update cascade
);

#TODO no se puede hacer con checks, hay que hacerlo con PREPARED STATEMENTS o con alguna TRANSACCIÓN
/*
alter table alumno
	add constraint tiene_matricula 
		check((select alumno.dni, matricula.dni, alumno_grupo.dni, matricula.id_asig, alumno_grupo.id_asig
		from alumno, matricula, alumno_grupo 
		where alumno.dni=matricula.dni and alumno_grupo.dni=matricula.dni and matricula.id_asig=alumno_grupo.id_asig)>1)
;

*/

#TODO no se puede hacer con checks, hay que hacerlo con PREPARED STATEMENTS o con alguna TRANSACCIÓN
/*
alter table grupo 
	add constraint tiene_profesor 
		check((select prof_grupo.num_grupo, prof_grupo.id_asig, grupo.num, grupo.id_asig from prof_grupo, grupo where 
				prof_grupo.numgrupo=grupo.num and prof_grupo.id_asig=grupo.id_asig) >= 1)
;
*/
