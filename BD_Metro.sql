drop database if exists proyecto_metro_in5cm;
create database proyecto_metro_in5cm;
use proyecto_metro_in5cm;

create table Pasajeros(
    id_pasajero Int Primary Key Auto_increment not null,
    nombre_pasajero Varchar(50) not null,
    tipo_pasajero Varchar(30) not null
);

create table Boletos(
    id_boleto Int Primary Key Auto_increment not null,
    precio Decimal(10,2) not null,
    fecha Date not null,
    id_pasajero int,
    Foreign Key (id_pasajero) References Pasajeros(id_pasajero)
);

DELIMITER //
create procedure sp_crear_pasajero(in p_id int, in p_nombre varchar(100), in p_tipo varchar(50))
begin
    insert into Pasajeros(id_pasajero, nombre_pasajero, tipo_pasajero) values(p_id, p_nombre, p_tipo);
end //

create procedure sp_leer_pasajero(in p_id int)
begin
    select * from Pasajeros where id_pasajero = p_id;
end //

create procedure sp_actualizar_pasajero(in p_id int, in p_nombre varchar(100), in p_tipo varchar(50))
begin
    update Pasajeros set nombre_pasajero = p_nombre, tipo_pasajero = p_tipo where id_pasajero = p_id;
end //

create procedure eliminar_pasajero(in p_id int)
begin
    delete from pasajeros where id_pasajero = p_id;
end //

-- CRUD BOLETOS
create procedure crear_boleto(in p_precio decimal(10,2), in p_fecha date, in p_id int)
begin
	insert into boletos(precio, fecha, id_pasajero) values(p_precio, p_fecha, p_id);
end //

create procedure leer_boletos()
begin
    select id_boleto, precio, fecha, nombre_pasajero, tipo_pasajero
    from boletos;
end //

create procedure actualizar_boleto( in p_id_boleto int,in p_precio decimal(10,2), in p_fecha date, in p_id int
)
begin
    update boletos
    set precio = p_precio, fecha = p_fecha,  id_pasajero = p_id
    where id_boleto = p_id_boleto;
end //

create procedure eliminar_boleto(in p_id_boleto int)
begin
    delete from boletos
    where id_boleto = p_id_boleto;
end //