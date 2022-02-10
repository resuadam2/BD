drop database if exists oficina_patentes;

create database oficina_patentes;

use oficina_patentes;

create or replace table PATENTE (
NUMERO INT primary key AUTO_INCREMENT,
INVENTO VARCHAR(150) not null,
INVERTOR CHAR(9) not null,
FECHA_OBTENCION DATE not null,
FECHA_COMPRA DATE null
);

create or replace table EMPRESA (
CODIGO INT primary key auto_increment,
NOMBRE VARCHAR(50) not null,
DIRECCIÓN VARCHAR(50) not null,
TELEFONO INT(10) not null,
check (TELEFONO >=0)
);

create or replace table INVENTOR (
DNI CHAR(9) primary key,
NOMBRE VARCHAR(50) not null,
TELEFONO INT(10) not null,
DIRECCION VARCHAR(200) not NULL
);

alter table PATENTE add column INVENTOR CHAR(9) not null;
alter table PATENTE add column EMPRESA INT null;

alter table PATENTE add constraint 
	foreign key (INVENTOR) references INVENTOR(DNI)
	on delete restrict on update cascade;
alter table PATENTE add constraint 
	foreign key (EMPRESA) references EMPRESA(CODIGO)
	on delete restrict on update cascade;

create or replace table AYUDANTE (
DNI CHAR(9) primary key,
NOMBRE VARCHAR(50) not null,
DIRECCION VARCHAR(50) not null,
TELEFONO INT(10) not null,
INVENTOR CHAR(9) not null,
foreign key (INVENTOR) references INVENTOR(DNI) on delete cascade on update CASCADE
);

create or replace table EMPRESA_INVENTOR (
EMPRESA INT,
INVENTOR CHAR(9),
FECHA_CONTRATO DATE not null,
primary key (EMPRESA, INVENTOR),
foreign key (EMPRESA) references EMPRESA(CODIGO)
	on delete restrict on update cascade,
foreign key (INVENTOR) references INVENTOR(DNI)
	on delete restrict on update cascade
);

create or replace table EMPRESA_AYUDANTE (
EMPRESA INT,
AYUDANTE CHAR(9),
FECHA_CONTRATO DATE not null,
primary key (EMPRESA, AYUDANTE),
foreign key (EMPRESA) references EMPRESA(CODIGO)
	on delete restrict on update cascade,
foreign key (AYUDANTE) references AYUDANTE(DNI)
	on delete restrict on update cascade
);

create or replace table ASESOR_INVENTOR (
ASESOR CHAR(9),
INVENTOR CHAR(9),
PATENTE INT,
primary key (ASESOR, INVENTOR, PATENTE),
foreign key (ASESOR) references INVENTOR(DNI)
	on delete restrict on update cascade,
foreign key (PATENTE) references PATENTE(NUMERO)
	on delete restrict on update cascade,
foreign key (INVENTOR) references INVENTOR(DNI)
	on delete restrict on update cascade
);