-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-06-19 19:16:41 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE actividad (
    id_actividad NUMBER(10) NOT NULL,
    nombre       VARCHAR2(30 BYTE) NOT NULL,
    descripcion  CLOB NOT NULL
);

ALTER TABLE actividad ADD CONSTRAINT actividades_pk PRIMARY KEY ( id_actividad );

CREATE TABLE capacitacion (
    id_capacitacion VARCHAR2(30 BYTE) NOT NULL,
    nombre_curso    VARCHAR2(50 BYTE) NOT NULL,
    tipo            CHAR(1),
    acciones        CLOB NOT NULL,
    modalidad       CHAR(1) NOT NULL,
    mes_inicio      VARCHAR2(10) NOT NULL,
    norma           CLOB,
    estatus         CHAR(1) NOT NULL,
    duracion        VARCHAR2(20 BYTE) NOT NULL,
    fecha_inicio    DATE,
    fecha_fin       DATE
);

COMMENT ON COLUMN capacitacion.tipo IS
    '''F'': Formativa (Opcional)
''N'': Normativa (Obligatoria)';

COMMENT ON COLUMN capacitacion.estatus IS
    '''E'': En ejecucion
''C'': Cancelado
''R'': Retrasado
''A'': Aun no ha empezado
';

ALTER TABLE capacitacion ADD CONSTRAINT capacitacion_pk PRIMARY KEY ( id_capacitacion );

CREATE TABLE capacitacion_x_cargo (
    id_capacitacion VARCHAR2(30 BYTE) NOT NULL,
    id_cargo        NUMBER(10) NOT NULL
);

ALTER TABLE capacitacion_x_cargo ADD CONSTRAINT capactiacion_x_cargo_pk PRIMARY KEY ( id_capacitacion,
                                                                                      id_cargo );

CREATE TABLE cargo (
    id_cargo    NUMBER(10) NOT NULL,
    nombre      VARCHAR2(20 BYTE) NOT NULL,
    descripcion CLOB NOT NULL,
    min_salario NUMBER(7, 2) NOT NULL,
    max_salario NUMBER(7, 2)
);

ALTER TABLE cargo ADD CONSTRAINT cargo_pk PRIMARY KEY ( id_cargo );

CREATE TABLE centro_de_costos (
    id_centro_de_costos NUMBER(10) NOT NULL,
    nombre              VARCHAR2(30 BYTE) NOT NULL
);

ALTER TABLE centro_de_costos ADD CONSTRAINT centro_de_costos_pk PRIMARY KEY ( id_centro_de_costos );

CREATE TABLE contrato (
    id_contrato   NUMBER(10) NOT NULL,
    fecha_inicio  DATE NOT NULL,
    vigente       CHAR(1) NOT NULL,
    cod_empleado  VARCHAR2(10) NOT NULL,
    id_cargo      NUMBER(10) NOT NULL,
    tipo_contrato CHAR(1 BYTE) NOT NULL
);

ALTER TABLE contrato
    ADD CONSTRAINT arc_tipo_contrato_lov CHECK ( tipo_contrato IN ( 'f', 'i' ) );

COMMENT ON COLUMN contrato.tipo_contrato IS
    '''f'': contrato de plazo fijo
''i'': contrato de plazo indeterminado';

CREATE UNIQUE INDEX contrato__idx ON
    contrato (
        id_cargo
    ASC );

ALTER TABLE contrato ADD CONSTRAINT contrato_pk PRIMARY KEY ( id_contrato );

CREATE TABLE contrato_plazo_fijo (
    id_contrato NUMBER(10) NOT NULL,
    fecha_fin   DATE NOT NULL
);

ALTER TABLE contrato_plazo_fijo ADD CONSTRAINT contrato_plazo_fijo_pk PRIMARY KEY ( id_contrato );

CREATE TABLE contrato_plazo_indeterminado (
    id_contrato   NUMBER(10) NOT NULL,
    tipo_contrato CHAR 
--  WARNING: CHAR size not specified 
     NOT NULL
);

COMMENT ON COLUMN contrato_plazo_indeterminado.tipo_contrato IS
    '"v": contrato estblecido verbalmente
"n": contrato estblecido no verbalmente (por escrito)';

ALTER TABLE contrato_plazo_indeterminado ADD CONSTRAINT contrato_pfijo_pk PRIMARY KEY ( id_contrato );

CREATE TABLE documento_identidad (
    num_doc_identidad NUMBER NOT NULL,
    tipo_documento    VARCHAR2(30 BYTE) NOT NULL
);

ALTER TABLE documento_identidad ADD CONSTRAINT documento_identidad_pk PRIMARY KEY ( num_doc_identidad );

CREATE TABLE empleado (
    id_empleado         VARCHAR2(10) NOT NULL,
    nombre              VARCHAR2(30 BYTE) NOT NULL,
    apellido_paterno    VARCHAR2(20 BYTE) NOT NULL,
    apellido_materno    VARCHAR2(20) NOT NULL,
    direccion           VARCHAR2(40 BYTE) NOT NULL,
    telefono            VARCHAR2(16) NOT NULL,
    telefono_emergencia VARCHAR2(16) NOT NULL,
    correo_electronico  VARCHAR2(40 BYTE) NOT NULL,
    id_cargo            NUMBER(10) NOT NULL,
    id_centro_de_costos NUMBER(10) NOT NULL,
    id_fondo            NUMBER(10) NOT NULL,
    id_examen_medico    VARCHAR2(10 BYTE) NOT NULL,
    vigencia            CHAR(1) NOT NULL,
    num_doc_identidad   NUMBER NOT NULL
);

CREATE UNIQUE INDEX empleado__idx ON
    empleado (
        num_doc_identidad
    ASC );

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( id_empleado );

CREATE TABLE empleadoxactividad (
    id_empleado  VARCHAR2(10) NOT NULL,
    id_actividad NUMBER(10) NOT NULL
);

ALTER TABLE empleadoxactividad ADD CONSTRAINT empleadoxactividad_pk PRIMARY KEY ( id_empleado,
                                                                                  id_actividad );

CREATE TABLE empleadoxhorario (
    id_empleado VARCHAR2(10) NOT NULL,
    id_horario  NUMBER(10) NOT NULL
);

ALTER TABLE empleadoxhorario ADD CONSTRAINT empleadoxhorario_pk PRIMARY KEY ( id_empleado,
                                                                              id_horario );

CREATE TABLE encargado_actividades (
    id_encargado NUMBER(10) NOT NULL,
    id_empleado  VARCHAR2(10) NOT NULL,
    id_actividad NUMBER(10) NOT NULL
);

CREATE UNIQUE INDEX encargado_actividades__idx ON
    encargado_actividades (
        id_empleado
    ASC );

ALTER TABLE encargado_actividades ADD CONSTRAINT encargado_actividades_pk PRIMARY KEY ( id_encargado );

CREATE TABLE examen_medico (
    id_examen_medico VARCHAR2(10 BYTE) NOT NULL,
    tipo_examen      VARCHAR2(4 BYTE) NOT NULL,
    resultado        CHAR(1 BYTE) NOT NULL,
    descripcion      CLOB,
    fecha_fin        DATE
);

ALTER TABLE examen_medico ADD CONSTRAINT examen_medico_pk PRIMARY KEY ( id_examen_medico );

CREATE TABLE fondo_de_pensiones (
    id_fondo     NUMBER(10) NOT NULL,
    nombre_fondo VARCHAR2(30) NOT NULL
);

ALTER TABLE fondo_de_pensiones ADD CONSTRAINT fondo_de_pensiones_pk PRIMARY KEY ( id_fondo );

CREATE TABLE horario (
    id_horario              NUMBER(10) NOT NULL,
    turno_horario           CHAR(1 BYTE) NOT NULL,
    dia                     VARCHAR2(10 BYTE) NOT NULL,
    hora_llegada            DATE NOT NULL,
    hora_salida             DATE NOT NULL,
    hora_salida_refrigerio  DATE NOT NULL,
    hora_regreso_refrigerio DATE NOT NULL
);

COMMENT ON COLUMN horario.turno_horario IS
    '"m": mañana
"t": tarde
"n": noche';

ALTER TABLE horario ADD CONSTRAINT horario_pk PRIMARY KEY ( id_horario );

CREATE TABLE marcacion (
    id_marcaciones   VARCHAR2(15 BYTE) NOT NULL,
    fecha_marcacion  DATE NOT NULL,
    hora_marcacion   DATE NOT NULL,
    tipo_marcacion   CHAR(1 BYTE) NOT NULL,
    estado_marcacion CHAR(1 BYTE),
    id_empleado      VARCHAR2(10) NOT NULL
);

COMMENT ON COLUMN marcacion.tipo_marcacion IS
    '''E'': Entrada
''S'':  Salida
''F'': Salida a refrigerio
''R'': Regreso de refrigerio';

COMMENT ON COLUMN marcacion.estado_marcacion IS
    '''p'': Puntual
''t'': Tarde
''f'': Falta';

ALTER TABLE marcacion ADD CONSTRAINT marcacion_pk PRIMARY KEY ( id_marcaciones,
                                                                id_empleado );

CREATE TABLE registro_nomina (
    id_registro_nomina NUMBER(10) NOT NULL,
    tipo_moneda        VARCHAR2(10) NOT NULL,
    cuenta_bancaria    VARCHAR2(30) NOT NULL,
    horas_trabajadas   NUMBER(5) NOT NULL,
    cantidad_faltas    NUMBER(3) NOT NULL,
    cantidad_tardanzas NUMBER(3) NOT NULL,
    id_empleado        VARCHAR2(10) NOT NULL,
    id_fondo           NUMBER(10) NOT NULL
);

CREATE UNIQUE INDEX nomina__idx ON
    registro_nomina (
        id_empleado
    ASC );

CREATE UNIQUE INDEX registro_nomina__idx ON
    registro_nomina (
        id_fondo
    ASC );

ALTER TABLE registro_nomina ADD CONSTRAINT nomina_pk PRIMARY KEY ( id_registro_nomina );

ALTER TABLE capacitacion_x_cargo
    ADD CONSTRAINT cc_capacitacion_fk FOREIGN KEY ( id_capacitacion )
        REFERENCES capacitacion ( id_capacitacion );

ALTER TABLE capacitacion_x_cargo
    ADD CONSTRAINT cc_cargo_fk FOREIGN KEY ( id_cargo )
        REFERENCES cargo ( id_cargo );

ALTER TABLE contrato
    ADD CONSTRAINT cont_cargo_fk FOREIGN KEY ( id_cargo )
        REFERENCES cargo ( id_cargo );

ALTER TABLE contrato
    ADD CONSTRAINT cont_empleado_fk FOREIGN KEY ( cod_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE contrato_plazo_fijo
    ADD CONSTRAINT cpfijo_contrato_fk FOREIGN KEY ( id_contrato )
        REFERENCES contrato ( id_contrato );

ALTER TABLE contrato_plazo_indeterminado
    ADD CONSTRAINT cpind_contrato_fk FOREIGN KEY ( id_contrato )
        REFERENCES contrato ( id_contrato );

ALTER TABLE empleadoxactividad
    ADD CONSTRAINT ea_actividad_fk FOREIGN KEY ( id_actividad )
        REFERENCES actividad ( id_actividad );

ALTER TABLE empleadoxactividad
    ADD CONSTRAINT ea_empleado_fk FOREIGN KEY ( id_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE empleadoxhorario
    ADD CONSTRAINT eh_empleado_fk FOREIGN KEY ( id_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE empleadoxhorario
    ADD CONSTRAINT eh_horario_fk FOREIGN KEY ( id_horario )
        REFERENCES horario ( id_horario );

ALTER TABLE empleado
    ADD CONSTRAINT emp_cargo_fk FOREIGN KEY ( id_cargo )
        REFERENCES cargo ( id_cargo );

ALTER TABLE empleado
    ADD CONSTRAINT emp_centro_de_costos_fk FOREIGN KEY ( id_centro_de_costos )
        REFERENCES centro_de_costos ( id_centro_de_costos );

ALTER TABLE empleado
    ADD CONSTRAINT emp_doc_id_fk FOREIGN KEY ( num_doc_identidad )
        REFERENCES documento_identidad ( num_doc_identidad );

ALTER TABLE empleado
    ADD CONSTRAINT emp_examen_medico_fk FOREIGN KEY ( id_examen_medico )
        REFERENCES examen_medico ( id_examen_medico );

ALTER TABLE empleado
    ADD CONSTRAINT emp_pensiones_fk FOREIGN KEY ( id_fondo )
        REFERENCES fondo_de_pensiones ( id_fondo );

ALTER TABLE encargado_actividades
    ADD CONSTRAINT enc_actividad_fk FOREIGN KEY ( id_actividad )
        REFERENCES actividad ( id_actividad );

ALTER TABLE encargado_actividades
    ADD CONSTRAINT enc_empleado_fk FOREIGN KEY ( id_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE marcacion
    ADD CONSTRAINT marc_empleado_fk FOREIGN KEY ( id_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE registro_nomina
    ADD CONSTRAINT nom_empleado_fk FOREIGN KEY ( id_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE registro_nomina
    ADD CONSTRAINT nom_pensiones_fk FOREIGN KEY ( id_fondo )
        REFERENCES fondo_de_pensiones ( id_fondo );

CREATE OR REPLACE TRIGGER arc_arc_ti_contrato_plazo_fijo BEFORE
    INSERT OR UPDATE OF id_contrato ON contrato_plazo_fijo
    FOR EACH ROW
DECLARE
    d CHAR(1 BYTE);
BEGIN
    SELECT
        a.tipo_contrato
    INTO d
    FROM
        contrato a
    WHERE
        a.id_contrato = :new.id_contrato;

    IF ( d IS NULL OR d <> 'f' ) THEN
        raise_application_error(-20223, 'FK CPFIJO_Contrato_FK in Table Contrato_plazo_fijo violates Arc constraint on Table Contrato - discriminator column tipo_contrato doesn''t have value ''f'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc__contrato_plazo_indetermin BEFORE
    INSERT OR UPDATE OF id_contrato ON contrato_plazo_indeterminado
    FOR EACH ROW
DECLARE
    d CHAR(1 BYTE);
BEGIN
    SELECT
        a.tipo_contrato
    INTO d
    FROM
        contrato a
    WHERE
        a.id_contrato = :new.id_contrato;

    IF ( d IS NULL OR d <> 'i' ) THEN
        raise_application_error(-20223, 'FK CPIND_Contrato_FK in Table Contrato_plazo_indeterminado violates Arc constraint on Table Contrato - discriminator column tipo_contrato doesn''t have value ''i'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            18
-- CREATE INDEX                             5
-- ALTER TABLE                             39
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 1
