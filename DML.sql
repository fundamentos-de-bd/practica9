-- ========================================================================== --
--                              INSERT                                        --
-- ========================================================================== --

-- 1. Catalogo de tipos de departamento
INSERT INTO tipo_departamento (tipo) VALUES('A');
INSERT INTO tipo_departamento (tipo) VALUES('F');
INSERT INTO tipo_departamento (tipo) VALUES('VYL');

-- ========================================================================= --
-- 2. Sucursal
INSERT INTO sucursal (fecha_func, calle, numero, cp, estado) VALUES
  (TO_DATE('1990/07/19','yyyy-mm-dd'), 'Vidon', '36', '60691', 'CMX');
INSERT INTO sucursal (fecha_func, calle, numero, cp, estado) VALUES
  (TO_DATE('2000/01/25','yyyy-mm-dd'), 'Golondrina', '5', '73167', 'VER');
-- ========================================================================= --
-- 3. Departemantos
INSERT INTO tener_departamento
    SELECT id_sucursal, tipo
        FROM sucursal, tipo_departamento;
        
-- ========================================================================= --
-- 4. Persona
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

-- ========================================================================= --
-- 5. Horarios
INSERT INTO horario
    SELECT tipo, 'CAJERO', '0480', '1933'
    FROM tipo_departamento;
    
INSERT INTO horario
    SELECT tipo, 'GERENTE', '0480', '1933'
    FROM tipo_departamento; 
    
INSERT INTO horario
    SELECT tipo, 'OTRO', '0480', '1933'
    FROM tipo_departamento;  

-- ========================================================================= --
-- 6. Sueldos
INSERT INTO sueldo
    SELECT id_tipo_dep, puesto, CURRENT_DATE, 10000
    FROM horario
    WHERE puesto = 'CAJERO';

INSERT INTO sueldo
    SELECT id_tipo_dep, puesto, CURRENT_DATE, 20000
        FROM horario
        WHERE puesto = 'GERENTE';        

INSERT INTO sueldo
    SELECT id_tipo_dep, puesto, CURRENT_DATE, 20000
        FROM horario
        WHERE puesto = 'OTRO';  

-- ========================================================================= --                                                                
-- 7. Empleados
INSERT INTO empleado(curp, tipo_dep, puesto, registro) 
    SELECT curp, id_tipo_dep, puesto, registro
        FROM persona, (
        SELECT id_tipo_dep, puesto, registro
        FROM sueldo
        WHERE id_tipo_dep = 'A' AND puesto = 'CAJERO'
        )
        WHERE ROWNUM <= 5;

-- ========================================================================= --
-- 8. Producto       
INSERT INTO producto (codigo_barras, precio, cantidad, marca) VALUES(9270412946, 6.65, '250 gr', 'SIEN');
INSERT INTO producto (codigo_barras, precio, cantidad, marca) VALUES(1867655713, 7.74, '1 kg', 'BSL');
INSERT INTO producto (codigo_barras, precio, cantidad, marca) VALUES(3404510077, 9.96, '1 L', 'NASDAQ');
INSERT INTO producto (codigo_barras, precio, cantidad, marca) VALUES(3569371542, 27.74, '3 kg', 'BSL');
INSERT INTO producto (codigo_barras, precio, presentacion, cantidad, marca) VALUES(3559348209, 10.53, 'LATA', '500 ml', 'NYSE');
INSERT INTO producto (codigo_barras, precio, cantidad, marca) VALUES(3198042307, 4.38, '100 gr', 'CACI');
INSERT INTO producto (codigo_barras, precio, cantidad, marca) VALUES(1007783263, 6.26, '50 ml', 'GFNSL');
INSERT INTO producto (codigo_barras, precio, cantidad, marca) VALUES(3447985732, 10.24, '500 gr', 'LIND');
INSERT INTO producto (codigo_barras, precio, cantidad, marca) VALUES(1919203175, 5.96, '2 L', 'TPZ');
INSERT INTO producto (codigo_barras, precio, cantidad, marca) VALUES(8102804929, 9.24, '2 kg', 'ASV');
INSERT INTO producto (codigo_barras, precio, cantidad, marca) VALUES(0232337489, 7.97, '375 ml', 'YEXT');

-- ========================================================================= --
-- 9. Lote
INSERT INTO lote VALUES(9270412946, 8230058285, CURRENT_DATE + 365);
INSERT INTO lote VALUES(9270412946, 9615009480, CURRENT_DATE + 365);
INSERT INTO lote VALUES(3559348209, 6809361161, CURRENT_DATE + 365);
INSERT INTO lote VALUES(3404510077, 4830294789, CURRENT_DATE + 365);

-- ========================================================================= --
-- 10. Poniendo a la venta algunos productos
INSERT INTO instancia_producto(codigo_barras, id_produccion, id_departamento, id_sucursal) VALUES(9270412946, 8230058285, 'F', 1);
INSERT INTO instancia_producto(codigo_barras, id_produccion, id_departamento, id_sucursal) VALUES(9270412946, 9615009480, 'F', 1);
INSERT INTO instancia_producto(codigo_barras, id_produccion, id_departamento, id_sucursal) VALUES(3559348209, 6809361161, 'F', 1);
INSERT INTO instancia_producto(codigo_barras, id_produccion, id_departamento, id_sucursal) VALUES(3404510077, 4830294789, 'F', 1);

-- ========================================================================= --
-- 11. Mandando a trabajar a algunos empleados
INSERT INTO trabajar VALUES(1, 1);
INSERT INTO trabajar VALUES(1, 2);
INSERT INTO trabajar VALUES(2, 1);
INSERT INTO trabajar VALUES(2, 3);
INSERT INTO trabajar VALUES(2, 4);

-- ========================================================================= --
--                                UPDATE                                     --
-- ========================================================================= --

-- 1. Actualiza la informacion de empleados
UPDATE empleado 
    SET puesto = 'GERENTE', registro = (
      SELECT registro 
        FROM sueldo 
        WHERE puesto = 'GERENTE' AND id_tipo_dep = 'F'
      )
    WHERE id_empleado IN (1, 2);

-- ========================================================================= --    
-- 2. Modificar el horario de los cajeros
UPDATE horario 
  SET hora_entrada = '8', hora_salida = '20'
  WHERE puesto = 'CAJERO';

-- ========================================================================= --  
-- 3. Aumentar el sueldo de los cajeros en 10%
UPDATE sueldo
  SET sueldo = 1.1*sueldo
  WHERE puesto = 'CAJERO';
  
-- ========================================================================= --  
-- 4. Disminuir el precio de los productos de alguna empresa
UPDATE producto
  SET precio = 0.9*precio
  where marca = 'SIEN';

-- ========================================================================= --  
-- 5. Mofificar el numero de alguna sucursal
UPDATE sucursal 
  SET numero = '10'
  WHERE estado = 'VER';
  
-- ========================================================================= --  
-- 6. Modificar algun apellido
UPDATE persona
  SET apellido_p = 'Doe'
  WHERE nombre IN ('John','Jane','Justinian');
                                                       
-- ========================================================================= --
-- 7. Cambiar al departamento de farmacia el empleado con identificador 1.
UPDATE empleado
    SET tipo_dep = 'F'
    WHERE id_empleado = 1;
-- ========================================================================= --
-- 8. Aumentar el sueldo en $1000 a los empleados de Abarrotes 
UPDATE sueldo
    SET sueldo = sueldo+1000
    WHERE id_tipo_dep = 'A';
-- ========================================================================= --
-- 9. Hacer que todos los productos de lata cuyo precio sea mayor al precio
-- promedio de todos los produtos sean refrigerados.
UPDATE producto
    SET es_refrigerado = 1
    WHERE codigo_barras IN (
        SELECT codigo_barras 
            FROM producto
            WHERE precio > (SELECT AVG(precio) FROM producto) AND UPPER(presentacion) LIKE 'LATA'
    );
-- ========================================================================= --
-- 10. Aumentar en 10% el precio de todos los productos cuya unidad de cantidad
-- sea mililitros o litros y que estén a la venta en el departamento de farmacia
UPDATE producto
    SET precio = precio*1.1
    WHERE UPPER(cantidad) LIKE '%L'
        AND codigo_barras IN (
            SELECT codigo_barras
            FROM instancia_producto
            WHERE id_departamento LIKE 'F'
        );

-- ========================================================================= --
--                              CONSULTAS                                    --
-- ========================================================================= --

-- 1. Conocer los datos de las sucursales que tengan mas de 15 anios.
SELECT *
    FROM sucursal
    WHERE (CURRENT_DATE - fecha_func)/365.25 > 15;

-- ========================================================================= --
-- 2. Conocer el puesto, nombre, edad y la fecha en la que inicio a trabajar de todos
-- los empleados.
SELECT puesto, nombre, ((CURRENT_DATE - fecha_nac)/365.25) edad, registro fecha_inicio
    FROM empleado NATURAL JOIN persona;

-- ========================================================================= --
-- 3. Conocer el nombre y edad de todos los empleados que trabajan en mas de una
-- sucursal.
SELECT nombre, ((CURRENT_DATE - fecha_nac)/365.25) edad, num_trabajos
    FROM (
        (
            SELECT id_empleado, COUNT(id_suc) num_trabajos
            FROM trabajar
            GROUP BY id_empleado
            HAVING COUNT(id_suc) > 1
        ) 
        NATURAL JOIN 
        (
            SELECT nombre, id_empleado, fecha_nac
            FROM persona JOIN empleado ON empleado.curp = persona.curp
        ) 
    );

-- ========================================================================= --
-- 4. Conocer los productos que se venden dentro de cada sucursal, para esto se debe
-- regresar el identificados de la sucursal, seguido del identificador del producto y
-- la descripcion de este.
-- Nota: hay que cambiar el esquema para poder hacer esta consulta.
SELECT id_sucursal, id_producto, descripcion
    FROM instancia_producto
    ORDER BY id_sucursal, id_producto;

-- ========================================================================= --
-- 5. Conocer cuales son TODOS los productos que se tienen en cada uno de los
-- departamentos de las diferentes sucursales.
SELECT id_sucursal, id_departamento, id_producto
    FROM instancia_producto
    WHERE id_departamento IS NOT NULL
    ORDER BY id_sucursal, id_departamento;

-- ========================================================================= --
-- 6. Conocer cuál es la sucursal con mayor número de productos registrados en sus
-- diferentes departamentos.
SELECT id_sucursal, MAX(num_prods)
    FROM 
    (
        SELECT id_sucursal, COUNT(id_producto) num_prods
            FROM instancia_producto
            GROUP BY id_sucursal
    )
    GROUP BY id_sucursal;

-- ========================================================================== --
--                                 DELETE                                     --
-- ========================================================================== --

-- 1. Eliminar el empleado con id_empelado = 4
DELETE FROM empleado WHERE id_empleado = 4; 

-- ========================================================================= --
-- 2. Eliminar los sueldos que no corresponda a ningun empleado
DELETE 
    FROM sueldo 
    WHERE puesto NOT IN 
                       (SELECT DISTINCT puesto FROM sueldo NATURAL JOIN empleado);

-- ========================================================================= --
-- 3. Eliminar productos que sean de la marca BSL
DELETE FROM producto WHERE marca = 'BSL';

-- ========================================================================= --
-- 4. Eliminar departamento de la sucursal mas antigua
DELETE FROM tener_departamento where id_tipo = 'VYL' AND id_suc = (SELECT id_sucursal
                                                                   FROM sucursal 
                                                                   WHERE fecha_func = (SELECT MIN(fecha_func)
                                                                                       FROM sucursal));  
-- ========================================================================= --
-- 5. Eliminar sucursal mas antigua
DELETE FROM sucursal WHERE fecha_func= (SELECT MIN(fecha_func) FROM sucursal);

-- ========================================================================= --
-- 6. Eliminar personas que no son empleados
DELETE FROM persona WHERE NOT EXISTS ( SELECT curp FROM empleado WHERE persona.curp = empleado.curp);

-- ========================================================================= --
-- 7. Eliminar empleado mas viejo con respecto a la edad
DELETE FROM empleado WHERE curp = (SELECT curp FROM persona
                                    WHERE fecha_nac = (SELECT MIN(fecha_nac) FROM persona));

-- ========================================================================= --                                    
-- 8. Eliminar productos con precio menor a 6
DELETE FROM producto WHERE precio <= 6;

-- ========================================================================= --
-- 9. Eliminar empleados de tipo_dep = F de la sucursal mas nueva
DELETE FROM empleado 
    WHERE tipo_dep = 'F'
        AND id_empleado IN (
            SELECT id_empleado 
            FROM trabajar
            WHERE id_suc = (
                SELECT id_sucursal
                FROM sucursal
                WHERE fecha_func = (SELECT MIN(fecha_func) FROM sucursal)
            )
        );
                                                       
-- ========================================================================= --
-- 10. Eliminar empleado que se hayan registrado durante el anio en curso
DELETE FROM empleado WHERE EXTRACT(YEAR FROM registro) = EXTRACT(YEAR FROM CURRENT_DATE);
