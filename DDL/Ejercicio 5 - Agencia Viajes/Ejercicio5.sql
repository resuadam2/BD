drop database if exists agencia_viajes;
create database if not exists agencia_viajes;
use agencia_viajes;

create or replace table hotel(
codigo int primary key auto_increment,
nombre varchar(30) not null,
direccion varchar(200)not null,
telefono int(9)not null,
plazas_disponibles int not null
);

create or replace table vuelo(
num_vuelo varchar(10),
fecha date not null,
hora time not null,
origen varchar(30)not null,
destino varchar(30) not null,
plazas_totales int not null,
plazas_turista int not null,
primary key(num_vuelo)
);

create or replace table agencia(
codigo int auto_increment,
direccion varchar(50)not null,
telefono int(9) not null,
primary key (codigo)
);

create or replace table cliente(
codigo int auto_increment,
nombre varchar(20)not null,
apellidos varchar(40)not null,
direccion varchar(50)not null,
telefono int(9)not null,
primary key(codigo)
);

create or replace table agencia_cliente(
agencia int,
cliente int,
foreign key(agencia)references agencia (codigo)
on delete restrict
on update cascade,
foreign key(cliente)references cliente(codigo)
on delete cascade
on update cascade,
primary key(agencia,cliente)
);

create or replace table cliente_hotel(
cliente int,
hotel int,
fecha_entrada date not null,
fecha_salida date not null,
regimen enum('sólo habitación','con desayuno','media pensión','pensión completa','todo incluído','otros') default 'otros',
foreign key (cliente)references cliente (codigo)
on delete cascade
on update cascade,
foreign key(hotel)references hotel(codigo)
on delete restrict
on update cascade,
primary key(cliente,hotel,fecha_entrada)
);

create or replace table cliente_vuelo(
cliente int,
vuelo varchar(10),
clase enum('turista','primera') not null,
foreign key (cliente)references cliente (codigo)
on delete cascade
on update cascade,
foreign key (vuelo)references vuelo(num_vuelo)
on delete cascade
on update cascade,
primary key(cliente,vuelo)
);