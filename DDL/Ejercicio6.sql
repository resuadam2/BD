DROP database IF EXISTS depto_maternidad;
CREATE database depto_maternidad;
use depto_maternidad;

create or replace table planta(
num int primary key,
superficie decimal(5,2) not null
);

create or replace table paciente(
n_hist int primary key,
dni char(9) not null unique,
nss char(13) not null unique,
nombre varchar(20) not null,
apellidos varchar(50) not null,
fecha_nacimiento date not null,
direccion varchar(200) not null
);

create or replace table telefono(
telf int(9) not null,
n_hist int,
primary key (n_hist,telf),
foreign key (n_hist) references paciente(n_hist)
	on delete cascade
	on update cascade
);

create or replace table cama(
num int primary key auto_increment,
fecha_comp date not null
);

create or replace table habitacion(
	interior boolean not null,
	num int,
	num_planta int,
	primary key(num, num_planta),
	foreign key(num_planta)	references planta(num)
		on delete cascade
		on update cascade
);

create or replace table cama_pac(
	n_hist int,
	num int,
	primary key (n_hist, num),
	foreign key (n_hist) references paciente(n_hist)
		on delete cascade
		on update cascade,
	foreign key (num) references cama(num)
		on delete cascade
		on update cascade
);

create or replace table hab_mat(
num_hab int,
num_pla int,
telf int null,
banho boolean not null,
primary key (num_hab, num_pla),
foreign key (num_hab) references habitacion(num)
	on delete cascade
	on update cascade, 
foreign key (num_pla) references planta(num)
	on delete cascade
	on update cascade
);

create or replace table hab_neo(
num_hab int,
num_pla int,
mon_cardio boolean not null,
mon_resp boolean not null,
primary key (num_hab, num_pla),
foreign key (num_hab) references habitacion(num)
	on delete cascade
	on update cascade, 
foreign key (num_pla) references planta(num)
	on delete cascade
	on update cascade
);

alter table cama add column habitacion int not null;
alter table cama add column planta int not null;
alter table cama add constraint foreign key (habitacion,planta) 
	references habitacion(num,num_planta) on delete cascade on update cascade;
