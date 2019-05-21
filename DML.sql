-- Insertar


-- Cat�logo de tipos de departamento
INSERT INTO tipo_departamento (tipo) VALUES('A');
INSERT INTO tipo_departamento (tipo) VALUES('F');
INSERT INTO tipo_departamento (tipo) VALUES('VYL');


-- Sucursal
INSERT INTO sucursal (fecha_func, calle, numero, cp, estado) VALUES(TO_DATE('1990/07/19','yyyy-mm-dd'), 'Vidon', '36', '60691', 'CMX');
INSERT INTO sucursal (fecha_func, calle, numero, cp, estado) VALUES(TO_DATE('2000/01/25','yyyy-mm-dd'), 'Golondrina', '5', '73167', 'VER');


INSERT INTO tener_departamento
    SELECT id_sucursal, tipo
        FROM sucursal, tipo_departamento;

INSERT INTO persona (curp, nombre, apellido_p, apellido_m, fecha_nac) VALUES 
('VSQM201028HFA15050', 'Mahala', 'Dilke', 'Thwaites', TO_DATE('2018-11-21 04:11:13', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO persona (curp, nombre, apellido_p, apellido_m, fecha_nac) VALUES 
('KCHV151019HNC84099', 'Harriot', 'Meneghi', 'Kingerby', TO_DATE('2018-06-26 15:02:12', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO persona (curp, nombre, apellido_p, apellido_m, fecha_nac) VALUES 
('WFRN500929HFE10460', 'Justinian', 'Ricca', 'Ismay', TO_DATE('2018-08-10 11:21:30', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO persona (curp, nombre, apellido_p, apellido_m, fecha_nac) VALUES 
('WIOV691129MEP08990', 'Micaela', 'Angood', 'Tallboy', TO_DATE('2018-10-25 07:11:50', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO persona (curp, nombre, apellido_p, apellido_m, fecha_nac) VALUES 
('KAZS260909MAN61507', 'Martina', 'Spuner', 'Paish', TO_DATE('2019-03-05 15:07:21', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO persona (curp, nombre, apellido_p, apellido_m, fecha_nac) VALUES 
('LWXD841224HLO05262', 'Riki', 'Rigolle', 'Freear', TO_DATE('2018-12-28 04:30:44', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO persona (curp, nombre, apellido_p, apellido_m, fecha_nac) VALUES 
('EUBH531008HTK38587', 'Timi', 'Burgoine', 'Woolgar', TO_DATE('2019-03-08 19:43:31', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO persona (curp, nombre, apellido_p, apellido_m, fecha_nac) VALUES 
('BHZM661228HWK23877', 'Elisabetta', 'Saile', 'Dellatorre', TO_DATE('2019-04-08 03:48:34', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO persona (curp, nombre, apellido_p, apellido_m, fecha_nac) VALUES 
('RWAU331229HRB67964', 'Margi', 'Pratley', 'Phipp', TO_DATE('2018-10-10 10:25:23', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO persona (curp, nombre, apellido_p, apellido_m, fecha_nac) VALUES 
('TNAE291127HOC02613', 'Garrard', 'Krout', 'Mathiassen', TO_DATE('2018-08-01 01:38:28', 'yyyy-mm-dd hh24:mi:ss'));
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


INSERT INTO producto (codigo de barras, precio, cantidad, marca) VALUES (9270412946, 6.65, '250 gr', 'SIEN');
INSERT INTO producto (codigo de barras, precio, cantidad, marca) VALUES (1867655713, 7.74, '1 kg', 'BSL');

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
