--PRUEBAS LISTA ACTIVIDADES
/
exec p_ListaActividadesProgramadas;
/
--PRUEBA TRIGGER_EMPLEADOS_RETIRADOS
CREATE TABLE RETIRADOS(
    ID_EMPLEADO VARCHAR2(10 BYTE),
    NOMBRE VARCHAR2(30 BYTE),
    APELLIDO_PATERNO VARCHAR2(30 BYTE),
    APELLIDO_MATERNO VARCHAR2(30 BYTE),
    TELEFONO VARCHAR2(16 BYTE),
    CORREO_ELECTRONICO VARCHAR2(40 BYTE),
    CARGO VARCHAR2(50 BYTE),
    NUM_DOC NUMBER
);
/
SELECT *FROM P_EMPLEADO;

UPDATE P_EMPLEADO SET VIGENCIA = 'R'
WHERE  ID_EMPLEADO = '9136852470';
UPDATE P_EMPLEADO SET VIGENCIA = 'R'
WHERE ID_EMPLEADO = '9375208614';
SELECT *FROM RETIRADOS;
/
--PRUEBA POSPONER_CAPACITACION
select *from p_capacitacion;
/
exec pr_posponer_capacitacion('BIO289','30/06/22','15/09/22');
exec pr_posponer_capacitacion('LITE897','20/06/23','20/08/23');
exec pr_posponer_capacitacion('CASS632','22/04/23','30/07/23')
-- Caso de error
exec pr_posponer_capacitacion('COEF378','10/05/23','16/05/23')
/
--PRUEBA CAMBIAR ESTATUS

--En ejecución
exec pr_cambiar_estatus_capacitacion('ETCO543','E');
--RETRASADO
exec pr_cambiar_estatus_capacitacion('BIO289','R');
--CANCELADO
exec pr_cambiar_estatus_capacitacion('GEST451','C'); 
--Caso de excepcion
exec pr_cambiar_estatus_capacitacion('PA104','X'); 
exec pr_cambiar_estatus_capacitacion('COEF378','Z'); 

/
--Prueba para impresión de los n empleados destacados y no destacados
exec PR_SELECT_EMP_DEST(5); 
exec PR_SELECT_EMP_NO_DEST(4); 
/
--Prueba fue_puntual

select f_fue_puntual('05/06/2023','07:05:00','E','1567308942') FROM DUAL;
SELECT f_fue_puntual('05/06/2023','08:20:00','E','1567308942') FROM DUAL;
SELECT f_fue_puntual('07/06/2023','03:11:00','F','2956038147') FROM DUAL;

--Prueba de marcacion

--
DECLARE
    id_empleado VARCHAR2(20);
    tipo CHAR(1);
BEGIN
    id_empleado :='2058634197';
    tipo := 'E';
    p_realizaMarcacion(id_empleado,tipo);
END;
