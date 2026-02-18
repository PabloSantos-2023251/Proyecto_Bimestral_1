drop database if exists proyecto_metro_in5cm;
create database proyecto_metro_in5cm;
use proyecto_metro_in5cm;

create table Lineas (
    id_linea int primary key auto_increment,
    nombre_linea varchar(50) not null,
    color varchar(30),
    longitud_km decimal(5,2)
);

create table personal (
    id_personal int primary key auto_increment,
    nombre varchar(100),
    cargo varchar(50)
);
create table trenes (
    id_tren int auto_increment primary key,
    modelo varchar(50) not null,
    capacidad_pasajeros int not null,
    estado varchar(30) not null
);
create table conductores (
    id_conductor int auto_increment primary key,
    nombre varchar(100) not null,
    licencia varchar(50) not null,
    anos_experiencia int not null
);
create table impacto_trafico (
    id_impacto int primary key auto_increment,
    zona varchar(100),
    reduccion_trafico_porcentaje decimal(5,2)
);

create table horarios (
    id_horario int primary key,
    hora_salida time,
    hora_llegada time,
    id_tren int,
    FOREIGN KEY (id_tren) REFERENCES trenes(id_tren)
);

create table Estaciones (
    id_estacion int primary key auto_increment,
    nombre varchar(50) not null,
    zona varchar(30),
    id_linea int,
    foreign key (id_linea) references Lineas(id_linea)
);

create table trenes (
    id_tren int auto_increment primary key,
    modelo varchar(50) not null,
    capacidad_pasajeros int not null,
    estado varchar(30) not null
);

DELIMITER //

create procedure sp_crear_personal(in _id int, in _nom varchar(100), in _car varchar(50))
begin
    insert into personal (id_personal, nombre, cargo) values (_id, _nom, _car);
end //

create procedure sp_leer_personal(in _id int)
begin
    select * from personal where id_personal = _id;
end //

create procedure sp_actualizar_personal(in _id int, in _nom varchar(100), in _car varchar(50))
begin
    update personal set nombre = _nom, cargo = _car where id_personal = _id;
end //

create procedure sp_eliminar_personal(in _id int)
begin
    delete from personal where id_personal = _id;
end //

create procedure sp_crear_impacto(in _id int, in _zona varchar(100), in _red decimal(5,2))
begin
    insert into impacto_trafico (id_impacto, zona, reduccion_trafico_porcentaje) values (_id, _zona, _red);
end //

create procedure sp_leer_impacto(in _id int)
begin
    select * from impacto_trafico where id_impacto = _id;
end //
-- CRUD: TRENES
create procedure sp_crear_tren(in _id int, in _modelo varchar(50), in _capacidad int, in _estado varchar(30))
begin
    insert into trenes(id_tren, modelo, capacidad_pasajeros, estado) values(_id, _modelo, _capacidad, _estado);
end //

create procedure sp_leer_tren(in _id int)
begin
    select * from trenes where id_tren = _id;
end //

-- Se crearon los procedimientos almacenados de Horarios - Miguel Santizo 
create procedure sp_crear_horario(in _id int, in _salida time, in _llegada time, in _tren int)
begin
    insert into horarios (id_horario, hora_salida, hora_llegada, id_tren) values (_id, _salida, _llegada, _tren);
end //

create procedure sp_leer_horario(in _id int)
begin
    select * from horarios where id_horario = _id;
end //

create procedure sp_actualizar_horario(in _id int, in _salida time, in _llegada time, in _tren int)
begin
    update horarios set hora_salida = _salida, hora_llegada = _llegada, id_tren = _tren where id_horario = _id;
end //

create procedure sp_eliminar_horario(in _id int)
begin
    delete from horarios where id_horario = _id;
end //

-- Se crearon los procedimientos almacenados de Mantenimiento - Miguel Santizo 

create procedure sp_crear_mantenimiento(in _id int, in _fec date, in _desc text, in _tren int)
begin
    insert into mantenimiento (id_mantenimiento, fecha, descripcion, id_tren) values (_id, _fec, _desc, _tren);
end //

create procedure sp_leer_mantenimiento(in _id int)
begin
    select * from mantenimiento where id_mantenimiento = _id;
end //

create procedure sp_actualizar_mantenimiento(in _id int, in _fec date, in _desc text, in _tren int)
begin
    update mantenimiento set fecha = _fec, descripcion = _desc, id_tren = _tren where id_mantenimiento = _id;
end //

create procedure sp_eliminar_mantenimiento(in _id int)
begin
    delete from mantenimiento where id_mantenimiento = _id;
end //
-- CRUD: CONDUCTORES (Corregido nombre de columna anios_experiencia)
create procedure sp_crear_conductor(in _id int, in _nombre varchar(100), in _licencia varchar(50), in _exp int)
begin
    insert into conductores(id_conductor, nombre, licencia, anos_experiencia) values(_id, _nombre, _licencia, _exp);
end //

create procedure sp_leer_conductor(in _id int)
begin
    select * from conductores where id_conductor = _id;
end //

create procedure sp_actualizar_conductor(in _id int, in _nombre varchar(100), in _licencia varchar(50), in _exp int)
begin
    update conductores set nombre = _nombre, licencia = _licencia, anos_experiencia = _exp where id_conductor = _id;
end //



DELIMITER ;

-- CRUD de Lineas y Estaciones 
Delimiter //
create procedure sp_crear_linea(in _id int, in _nombre varchar(50), in _color varchar(30), in _longitud decimal(5,2))
begin
    insert into lineas (id_linea, nombre_linea, color, longitud_km)
    values (_id, _nombre, _color, _longitud);
end //

create procedure sp_leer_linea(in _id int)
begin
    select * from lineas where id_linea = _id;
end //

create procedure sp_actualizar_linea(in _id int, in _nombre varchar(50), in _color varchar(30), in _longitud decimal(5,2))
begin
    update lineas 
    set nombre_linea = _nombre,
        color = _color,
        longitud_km = _longitud
    where id_linea = _id;
end //

create procedure sp_eliminar_linea(in _id int)
begin
    delete from lineas where id_linea = _id;
end //
delimiter ; 

-- CRUD de Estaciones 
Delimiter //
create procedure sp_crear_estacion(in _id int, in _nombre varchar(100), in _ubicacion varchar(150), in _id_linea int)
begin
    insert into estaciones (id_estacion, nombre_estacion, ubicacion, id_linea)
    values (_id, _nombre, _ubicacion, _id_linea);
end //

create procedure sp_leer_estacion(in _id int)
begin
    select * from estaciones where id_estacion = _id;
end //

create procedure sp_actualizar_estacion(in _id int, in _nombre varchar(100), in _ubicacion varchar(150), in _id_linea int)
begin
    update estaciones
    set nombre_estacion = _nombre,
        ubicacion = _ubicacion,
        id_linea = _id_linea
    where id_estacion = _id;
end //

create procedure sp_eliminar_estacion(in _id int)
begin
    delete from estaciones where id_estacion = _id;
end //
Delimiter ; 