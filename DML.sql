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
