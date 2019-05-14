-- Insertar

-- Cat�logo de tipos de departamento
INSERT INTO tipo_departamento VALUES(('A'),('F'),('VYL'));

-- Sucursal
INSERT INTO sucursal 
    VALUES (('1990/07/19', 'Vidon', '36', '60691', 'CMX'), ('2000/01/25', 'Golondrina', '5', '73167', 'VER'));



INSERT INTO tener_departamento
    SELECT id_sucursal, tipo
        FROM sucursal, tipo_departamento;

-- Personas
-- Nota: cambiar el formato de las fechas
INSERT INTO persona VALUES(('90-9133657', 'Arlin', 'Fairweather', 'Llewelyn', '04/07/1998'),
                           ('16-4012688', 'Garwood', 'Askell', 'Stocks', '05/05/1987'),
                           ('93-6630973', 'Dionisio', 'Iddons', 'Constant', '12/05/1987'),
                           ('29-8748557', 'Prudi', 'Dekeyser', 'Phillpot', '09/12/1997'),
                           ('82-4204994', 'Quentin', 'Leither', 'Ferretti', '05/24/1991'),             
                           ('45-8775495', 'Electra', 'Alred', 'd''Escoffier', '01/31/1990'),
                           ('46-4561160', 'Hatty', 'Dunckley', 'Arkill', '12/08/1999'),
                           ('96-8795930', 'Ev', 'Smith', 'Onians', '05/12/1989'),
                           ('79-9657119', 'Xymenes', 'Ullyott', 'Joska', '07/20/1992'),
                           ('79-9115120', 'Efrem', 'Bourthouloume', 'MacLardie', '02/10/2000'));

-- Empleados
INSERT INTO empleado 
    SELECT curp, 'A', 'CAJERO' 
        FROM persona 
        WHERE ROWNUM <= 6;

    
UPDATE empleado 
    SET puesto = 'GERENTE'
    WHERE curp = '90-9133657' or curp = '16-4012688';


INSERT INTO sueldo
    SELECT tipo_departamento, puesto, registro, 10000
        FROM empleado
        WHERE puesto = 'CAJERO';

INSERT INTO sueldo
    SELECT tipo_departamento, puesto, registro, 20000
        FROM empleado
        WHERE puesto = 'GERENTE'; 


INSERT INTO producto (codigo de barras, precio, cantidad, marca) VALUES ((9270412946, 6.65, '250 gr', 'SIEN')
             ,(1867655713, 7.74, '1 kg', 'BSL'));

-- Consultas
-- 1. Conocer los datos de las sucursales que tengan más de 15 años.
SELECT *
FROM sucursal
WHERE (CURRENT_DATE - fecha_func)/365.25 > 15;

-- 2. Conocer el puesto, nombre, edad y la fecha en la que inicio a trabajar de todos
-- los empleados.
SELECT puesto, nombre, ((CURRENT_DATE - fecha_nac)/365.25) edad, registro fecha_inicio
FROM empleado NATURAL JOIN persona;

-- 3. Conocer el nombre y edad de todos los empleados que trabajan en mas de una
-- sucursal.
SELECT nombre, ((CURRENT_DATE - fecha_nac)/365.25) edad, num_trabajos
    FROM (
        (
            SELECT id_empleado, COUNT(id_sucursal) num_trabajos
            FROM trabajar
            GROUP BY id_empleado
            HAVING COUNT(id_sucursal) > 1
        ) 
        NATURAL JOIN 
        (
            SELECT nombre, id_empleado, fecha_nac
            FROM persona JOIN empleado ON empleado.curp = persona.curp
        ) 
    );

-- 4. Conocer los productos que se venden dentro de cada sucursal, para esto se debe
-- regresar el identificados de la sucursal, seguido del identificador del producto y
-- la descripción de éste.
-- Nota: hay que cambiar el esquema para poder ahcer esta consulta.
SELECT id_sucursal, id_producto, descripción
    FROM instancia_producto
    GROUP BY id_sucursal, id_producto;

-- 5. Conocer cuales son TODOS los productos que se tienen en cada uno de los
-- departamentos de las diferentes sucursales.
SELECT id_producto, id_departamento
    FROM instancia_producto
    GROUP BY id_departamento
    WHERE id_departamento NOT NULL;

-- 6. Conocer cuál es la sucursal con mayor número de productos registrados en sus
-- diferentes departamentos.
-- Nota: hay que cambiar el esquema para poder ahcer esta consulta.
SELECT id_sucursal, MAX(COUNT(id_producto))
    FROM instancia_producto
    GROUP BY id_sucursal;