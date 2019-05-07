-- Insertar

-- Catálogo de tipos de departamento
INSERT ALL
    INTO tipo_departamento VALUES('A')
    INTO tipo_departamento VALUES('F')
    INTO tipo_departamento VALUES('VYL')
    SELECT * FROM dual;

-- Sucursal
INSERT INTO sucursal 
    VALUES ('1990/07/19', 'Vidon', '36', '60691', 'CMX');
    
INSERT INTO sucursal 
    VALUES ('2000/01/25', 'Golondrina', '5', '73167', 'VER');

INSERT INTO tener_departamento
    SELECT id_sucursal, tipo
        FROM sucursal, tipo_departamento;

-- Personas
-- Nota: cambiar el formato de las fechas
INSERT ALL 
    INTO persona VALUES('90-9133657', 'Arlin', 'Fairweather', 'Llewelyn', '04/07/1998')
    INTO persona VALUES('16-4012688', 'Garwood', 'Askell', 'Stocks', '05/05/1987')
    INTO persona VALUES('93-6630973', 'Dionisio', 'Iddons', 'Constant', '12/05/1987')
    INTO persona VALUES('29-8748557', 'Prudi', 'Dekeyser', 'Phillpot', '09/12/1997')
    INTO persona VALUES('82-4204994', 'Quentin', 'Leither', 'Ferretti', '05/24/1991')
    INTO persona VALUES('45-8775495', 'Electra', 'Alred', 'd''Escoffier', '01/31/1990')
    INTO persona VALUES('46-4561160', 'Hatty', 'Dunckley', 'Arkill', '12/08/1999')
    INTO persona VALUES('96-8795930', 'Ev', 'Smith', 'Onians', '05/12/1989')
    INTO persona VALUES('79-9657119', 'Xymenes', 'Ullyott', 'Joska', '07/20/1992')
    INTO persona VALUES('79-9115120', 'Efrem', 'Bourthouloume', 'MacLardie', '02/10/2000')
    SELECT * FROM dual;

-- Empleados
INSERT INTO empleado 
    SELECT curp, 'A', 'CAJERO' 
        FROM persona 
        WHERE ROWNUM <= 6;
    
UPDATE empleado 
    SET puesto = 'GERENTE'
    WHERE curp = '90-9133657' or curp = '16-4012688';