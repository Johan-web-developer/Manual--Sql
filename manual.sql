-- Creamos la base de datos
CREATE DATABASE IF NOT EXISTS mundo;

-- Con esta sentencia haremos uso de ella
USE mundo;

-- Para continuar con el ejemplo de la base de datos mundo, crearemos la tabla pais donde se almacenarán los datos de los paises:
CREATE TABLE IF NOT EXISTS pais (
    id int PRIMARY KEY,
    nombre varchar(20),
    continente varchar(50),
    poblacion int
);

-- Creando la tabla Temp:
CREATE TABLE Temp (
id integer,
dato varchar(20)
);

-- Borrando la tabla:
DROP TABLE Temp;

-- Utilizando la sentencia "ALTER TABLE" junto con la cláusula "ADD PRIMARY KEY", puedes especificar la columna que deseas establecer como llave primaria.
ALTER TABLE pais;
ADD PRIMARY KEY (id);

-- Aplicando la sintaxis de inserción a la tabla país para agregar 6 registros quedaría así:
INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (101, "Colombia", "Sur América", 50000000);

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (102, "Ecuador", "Sur América", 17000000);

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (103, "Guatemala", "Centro América", 17000000);

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (104, "México", "Centro América", 126000000);

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (105, "Estados Unidos", "Norte América", 331000000);

INSERT INTO pais (id, nombre, continente, poblacion)
VALUES (106, "Canada", "Centro América", 38000000);


-- Siguiendo con el ejercicio de la tabla País, se modificará, actualizando, el registro de Colombia cuyo id=101. El campo que se va a actualizar es la población al valor 50887423. La sentencia UPDATE quedaría:
UPDATE pais
SET poblacion = 50887423
WHERE id=101;

-- Continuando con el ejercicio de la tabla país, se quiere borrar el registro de Canada, cuyo id es el 106. La sentencia quedaría
DELETE FROM pais
WHERE id = 106;

-- Mostar un listado con los todos los países que están registrados
SELECT id, nombre, continente, poblacion 
FROM pais;

-- //Cuando se desea consultar todos los campos de una tabla se usa el operador comodín “*”; la anterior consulta quedaría de la siguiente manera:
SELECT * 
FROM pais;

--  Seleccionar los nombres de los países con menos de 100 millones de habitantes:
SELECT nombre
FROM pais
WHERE poblacion <= 100000000;


-- Seleccionar los dos primeros nombres de los países con menos de 100 millones de habitantes.
SELECT nombre 
FROM pais
ORDER BY nombre
LIMIT 2;



-- Usando la tabla país se puede construir la siguiente consulta para crear una tabla:
CREATE TABLE tempPais
AS
SELECT nombre, poblacion
FROM pais
WHERE poblacion <= 100000000;


-- Se puede usar en la tabla tempPais que se creó en el apartado anterior así:
DESCRIBE tempPais;


-- creando la tabla ciudad relacionándola con la tabla pais:
CREATE TABLE ciudad (
    id int PRIMARY KEY,
    nombre varchar(20),
    id_pais int,
    FOREIGN KEY (id_pais)
    REFERENCES pais (id)
);


-- Ahora se creará una tabla de idioma y esta se relacionará con la tabla país. Creación de la tabla idioma:
create table idioma(
id int primary key,
idioma varchar(50)
);



-- Luego se creará la tabla idioma_pais que tendrá los campos que se relacionarán con la tablas idioma y país. La sentencia sql es:
create table idioma_pais (
id_idioma int,
id_pais int,
es_oficial boolean default false,
primary key (id_idioma, id_pais),
foreign key (id_idioma) references idioma(id),
foreign key (id_pais) references pais(id)
);



-- 1. Alias de Campo Simple:
SELECT nombre AS cliente_nombre, edad AS edad_cliente FROM clientes;



-- 2. Alias de Campo con Funciones:
SELECT AVG(precio) AS promedio_precio FROM productos;



    -- 3. Alias de Campo con Expresiones:
SELECT cantidad * precio AS total FROM pedidos;



-- Alias de tabla simple:
SELECT u.nombre, u.edad
FROM usuarios AS u;



-- Alias de tabla con joins:
SELECT u.nombre, p.fecha
FROM usuarios AS u
JOIN pedidos AS p ON u.id = p.usuario_id;



-- Uso de alias de tabla en subconsultas:
SELECT u.nombre
FROM (SELECT * FROM usuarios WHERE edad > 30) AS |;



-- En la siguiente informacion se muestran algunas de las funciones de campos más utilizadas en MySQL, junto con sus definiciones y ejemplos de uso.

Función
Definición
Ejemplo de uso
CONCAT()
Concatena dos o más cadenas de texto


SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo FROM usuarios;
UPPER()
Convierte una cadena a mayúsculas


SELECT UPPER(nombre) AS nombre_mayusculas FROM usuarios;
LOWER()
Convierte una cadena a minúsculas


SELECT LOWER(apellido) AS apellido_minusculas FROM usuarios;
LENGTH()
Devuelve la longitud de una cadena


SELECT LENGTH(nombre) AS longitud_nombre FROM usuarios;
SUBSTRING()
Extrae una parte de una cadena


SELECT SUBSTRING(nombre, 1, 3) AS subcadena FROM usuarios;
TRIM()
Elimina espacios en blanco de una cadena


SELECT TRIM(nombre) AS nombre_sin_espacios FROM usuarios;
ROUND()
Redondea un número


SELECT ROUND(precio, 2) AS precio_redondeado FROM productos;
DATE_FORMAT()
Formatea una fecha
SELECT DATE_FORMAT(fecha_nacimiento, '%d-%m-%Y') AS fecha_formato FROM usuarios;
NOW()
Devuelve la fecha y hora actual


SELECT NOW() AS fecha_actual FROM usuarios;
IFNULL();
-- Devuelve un valor alternativo si es nulo

SELECT IFNULL(nombre, 'N/A') AS nombre_alternativo FROM usuarios;



-- Ejemplo de asignación condicional:
SELECT nombre, precio, IF(precio > 100, 'Alto', 'Bajo') AS categoria_precio 
FROM productos;


-- Ejemplo de cálculo condicional
SELECT nombre, salario, bono, 
    IF(salario > 5000, salario + bono, salario) AS salario_total 
FROM empleados;



-- Inner Joins
SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;


-- Un ejemplo con los INNER JOINS sería listar todas las ciudades de México. La consulta SQL seria:
SELECT pais.nombre AS pais, ciudad.nombre AS ciudad
FROM pais
INNER JOIN ciudad
ON pais.id = ciudad.id_pais
WHERE pais.nombre = "México";


-- Left Joins

-- La sintaxis de los LEFT JOINS es:
SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name = table2.column_name;


-- Un ejemplo con los LEFT JOINS sería listar todos los países y las ciudades que estén en la base de datos. La consulta SQL seria:
SELECT pais.nombre AS pais, ciudad.nombre AS ciudad
FROM pais
LEFT JOIN ciudad
ON pais.id = ciudad.id_pais;



-- Right Join

-- La sintaxis de los RIGHT JOIN es:
SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name = table2.column_name;


-- Un ejemplo con los RIGHT JOIN sería listar todas las ciudades y los países al que pertenecen. La consulta SQL seria:
SELECT pais.nombre AS pais, ciudad.nombre AS ciudad
FROM pais
RIGHT JOIN ciudad
ON pais.id = ciudad.id_pais;



-- Subconsultas
SELECT column_name(s)
FROM table1
WHERE column_name OPERATOR (SELECT column_name(s) FROM table2);


-- Un primer ejemplo de una subconsulta sería:
SELECT nombre 
FROM pais 
WHERE poblacion > (SELECT AVG(poblacion) FROM pais);

--     1. Paso 1. Se identifica las tablas y se resuelve la consulta interna.
-- La consulta interna resuelve la pregunta de encontrar la menor población que existe en la tabla país.

SELECT min(poblacion) FROM pais;

--     2. Paso 2. Se identifica las tablas y se resuelve la consulta externa
-- La consulta externa lista los nombres de las ciudades de los países

SELECT C.nombre
FROM ciudad AS C
INNER JOIN pais AS P ON P.id = C.id_pais;

--     3. Paso 3. Se agrega la consulta interna a la consulta externa
-- Para agregar la consulta interna a la consulta externa se hace a través de un filtro WHERE que iguale la población de un país al resultado de la subconsulta que encontró la población menor de todos los países.
SELECT C.nombre
FROM ciudad AS C
INNER JOIN pais AS P ON P.id = C.id_pais
WHERE P.poblacion = (SELECT min(poblacion) FROM país);