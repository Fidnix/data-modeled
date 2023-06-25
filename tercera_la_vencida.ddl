-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-06-25 13:56:36 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE p_actividad (
    id_actividad NUMBER(10) NOT NULL,
    nombre       VARCHAR2(30 BYTE) NOT NULL,
    descripcion  CLOB NOT NULL
);

ALTER TABLE p_actividad ADD CONSTRAINT actividades_pk PRIMARY KEY ( id_actividad );

CREATE TABLE p_capacitacion (
    id_capacitacion VARCHAR2(30 BYTE) NOT NULL,
    nombre_curso    VARCHAR2(50 BYTE) NOT NULL,
    tipo            CHAR(1 BYTE) NOT NULL,
    acciones        CLOB NOT NULL,
    modalidad       CHAR(1 BYTE) NOT NULL,
    norma           CLOB,
    estatus         CHAR(1 BYTE) NOT NULL,
    fecha_inicio    DATE NOT NULL,
    fecha_fin       DATE NOT NULL
);

COMMENT ON COLUMN p_capacitacion.tipo IS
    '''F'': Formativa (Opcional)
''N'': Normativa (Obligatoria)';

COMMENT ON COLUMN p_capacitacion.estatus IS
    '''E'': En ejecucion
''C'': Cancelado
''R'': Retrasado
''A'': Aun no ha empezado
';

ALTER TABLE p_capacitacion ADD CONSTRAINT capacitacion_pk PRIMARY KEY ( id_capacitacion );

CREATE TABLE p_capacitacion_x_cargo (
    id_capacitacion VARCHAR2(30 BYTE) NOT NULL,
    id_cargo        NUMBER(10) NOT NULL
);

ALTER TABLE p_capacitacion_x_cargo ADD CONSTRAINT capactiacion_x_cargo_pk PRIMARY KEY ( id_capacitacion,
                                                                                        id_cargo );

CREATE TABLE p_cargo (
    id_cargo    NUMBER(10) NOT NULL,
    nombre      VARCHAR2(20 BYTE) NOT NULL,
    descripcion CLOB NOT NULL,
    min_salario NUMBER(7, 2) NOT NULL,
    max_salario NUMBER(7, 2)
);

ALTER TABLE p_cargo ADD CONSTRAINT cargo_pk PRIMARY KEY ( id_cargo );

CREATE TABLE p_centro_de_costos (
    id_centro_de_costos NUMBER(10) NOT NULL,
    nombre              VARCHAR2(30 BYTE) NOT NULL
);

ALTER TABLE p_centro_de_costos ADD CONSTRAINT centro_de_costos_pk PRIMARY KEY ( id_centro_de_costos );

CREATE TABLE p_contrato (
    id_contrato   NUMBER(10) NOT NULL,
    fecha_inicio  DATE NOT NULL,
    vigente       CHAR(1) NOT NULL,
    cod_empleado  VARCHAR2(10 BYTE) NOT NULL,
    id_cargo      NUMBER(10) NOT NULL,
    tipo_contrato CHAR(1 BYTE) NOT NULL
);

ALTER TABLE p_contrato
    ADD CONSTRAINT arc_tipo_contrato_lov CHECK ( tipo_contrato IN ( 'F', 'I' ) );

COMMENT ON COLUMN p_contrato.tipo_contrato IS
    '''F'': contrato de plazo fijo
''I'': contrato de plazo indeterminado';

ALTER TABLE p_contrato ADD CONSTRAINT contrato_pk PRIMARY KEY ( id_contrato );

CREATE TABLE p_contrato_plazo_fijo (
    id_contrato NUMBER(10) NOT NULL,
    fecha_fin   DATE NOT NULL
);

ALTER TABLE p_contrato_plazo_fijo ADD CONSTRAINT contrato_plazo_fijo_pk PRIMARY KEY ( id_contrato );

CREATE TABLE p_contrato_plazo_indeterminado (
    id_contrato   NUMBER(10) NOT NULL,
    tipo_contrato CHAR(1 BYTE) NOT NULL
);

COMMENT ON COLUMN p_contrato_plazo_indeterminado.tipo_contrato IS
    '"v": contrato estblecido verbalmente
"n": contrato estblecido no verbalmente (por escrito)';

ALTER TABLE p_contrato_plazo_indeterminado ADD CONSTRAINT contrato_pfijo_pk PRIMARY KEY ( id_contrato );

CREATE TABLE p_documento_identidad (
    num_doc_identidad NUMBER(8) NOT NULL,
    tipo_documento    CHAR(1 BYTE) NOT NULL
);

COMMENT ON COLUMN p_documento_identidad.tipo_documento IS
    '''n'': Documento nacional de identidad
''e'': Carnet de extranjeria';

ALTER TABLE p_documento_identidad ADD CONSTRAINT documento_identidad_pk PRIMARY KEY ( num_doc_identidad );

CREATE TABLE p_empleado (
    id_empleado         VARCHAR2(10 BYTE) NOT NULL,
    nombre              VARCHAR2(30 BYTE) NOT NULL,
    apellido_paterno    VARCHAR2(20 BYTE) NOT NULL,
    apellido_materno    VARCHAR2(20 BYTE) NOT NULL,
    direccion           VARCHAR2(40 BYTE) NOT NULL,
    telefono            VARCHAR2(16 BYTE) NOT NULL,
    telefono_emergencia VARCHAR2(16 BYTE) NOT NULL,
    correo_electronico  VARCHAR2(40 BYTE) NOT NULL,
    id_cargo            NUMBER(10) NOT NULL,
    id_centro_de_costos NUMBER(10) NOT NULL,
    id_fondo            NUMBER(10) NOT NULL,
    vigencia            CHAR(1 BYTE) NOT NULL,
    num_doc_identidad   NUMBER(8) NOT NULL
);

CREATE UNIQUE INDEX empleado__idx ON
    p_empleado (
        num_doc_identidad
    ASC );

ALTER TABLE p_empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( id_empleado );

CREATE TABLE p_empleadoxactividad (
    id_empleado  VARCHAR2(10 BYTE) NOT NULL,
    id_actividad NUMBER(10) NOT NULL
);

ALTER TABLE p_empleadoxactividad ADD CONSTRAINT empleadoxactividad_pk PRIMARY KEY ( id_empleado,
                                                                                    id_actividad );

CREATE TABLE p_empleadoxhorario (
    id_empleado VARCHAR2(10) NOT NULL,
    id_horario  NUMBER(10) NOT NULL
);

ALTER TABLE p_empleadoxhorario ADD CONSTRAINT empleadoxhorario_pk PRIMARY KEY ( id_empleado,
                                                                                id_horario );

CREATE TABLE p_encargado_actividades (
    id_encargado NUMBER(10) NOT NULL,
    id_empleado  VARCHAR2(10 BYTE) NOT NULL,
    id_actividad NUMBER(10) NOT NULL
);

CREATE UNIQUE INDEX encargado_actividades__idx ON
    p_encargado_actividades (
        id_empleado
    ASC );

ALTER TABLE p_encargado_actividades ADD CONSTRAINT encargado_actividades_pk PRIMARY KEY ( id_encargado );

CREATE TABLE p_examen_medico (
    id_examen_medico       VARCHAR2(10 BYTE) NOT NULL,
    tipo_examen            VARCHAR2(4 BYTE) NOT NULL,
    resultado              CHAR(1 BYTE) NOT NULL,
    descripcion            CLOB,
    fecha_fin              DATE,
    p_empleado_id_empleado VARCHAR2(10 BYTE) NOT NULL
);

ALTER TABLE p_examen_medico ADD CONSTRAINT examen_medico_pk PRIMARY KEY ( id_examen_medico );

CREATE TABLE p_fondo_de_pensiones (
    id_fondo     NUMBER(10) NOT NULL,
    nombre_fondo VARCHAR2(30 BYTE) NOT NULL,
    monto        NUMBER(5, 2) NOT NULL
);

ALTER TABLE p_fondo_de_pensiones ADD CONSTRAINT fondo_de_pensiones_pk PRIMARY KEY ( id_fondo );

CREATE TABLE p_horario (
    id_horario              NUMBER(10) NOT NULL,
    turno_horario           CHAR(1 BYTE) NOT NULL,
    dia                     VARCHAR2(10 BYTE) NOT NULL,
    hora_llegada            VARCHAR2(8 BYTE) NOT NULL,
    hora_salida             VARCHAR2(8 BYTE) NOT NULL,
    hora_salida_refrigerio  VARCHAR2(8 BYTE) NOT NULL,
    hora_regreso_refrigerio VARCHAR2(8 BYTE) NOT NULL
);

COMMENT ON COLUMN p_horario.turno_horario IS
    '"m": mañana
"t": tarde
"n": noche';

ALTER TABLE p_horario ADD CONSTRAINT horario_pk PRIMARY KEY ( id_horario );

CREATE TABLE p_marcacion (
    id_marcaciones   VARCHAR2(15 BYTE) NOT NULL,
    fecha_marcacion  DATE NOT NULL,
    hora_marcacion   VARCHAR2(8 BYTE) NOT NULL,
    tipo_marcacion   CHAR(1 BYTE) NOT NULL,
    estado_marcacion CHAR(1 BYTE) NOT NULL,
    id_empleado      VARCHAR2(10 BYTE) NOT NULL
);

COMMENT ON COLUMN p_marcacion.tipo_marcacion IS
    '''E'': Entrada
''S'':  Salida
''F'': Salida a refrigerio
''R'': Regreso de refrigerio';

COMMENT ON COLUMN p_marcacion.estado_marcacion IS
    '''p'': Puntual
''t'': Tarde';

ALTER TABLE p_marcacion ADD CONSTRAINT marcacion_pk PRIMARY KEY ( id_marcaciones );

CREATE TABLE p_registro_nomina (
    id_registro_nomina NUMBER(10) NOT NULL,
    tipo_moneda        VARCHAR2(10 BYTE) NOT NULL,
    cuenta_bancaria    VARCHAR2(30 BYTE) NOT NULL,
    horas_trabajadas   NUMBER(5) NOT NULL,
    cantidad_faltas    NUMBER(3) NOT NULL,
    hora_tardanzas     NUMBER(3) NOT NULL,
    sueldo             NUMBER(7, 2) NOT NULL,
    id_empleado        VARCHAR2(10 BYTE) NOT NULL,
    id_fondo           NUMBER(10) NOT NULL
);

CREATE UNIQUE INDEX nomina__idx ON
    p_registro_nomina (
        id_empleado
    ASC );

ALTER TABLE p_registro_nomina ADD CONSTRAINT nomina_pk PRIMARY KEY ( id_registro_nomina );

ALTER TABLE p_capacitacion_x_cargo
    ADD CONSTRAINT cc_capacitacion_fk FOREIGN KEY ( id_capacitacion )
        REFERENCES p_capacitacion ( id_capacitacion );

ALTER TABLE p_capacitacion_x_cargo
    ADD CONSTRAINT cc_cargo_fk FOREIGN KEY ( id_cargo )
        REFERENCES p_cargo ( id_cargo );

ALTER TABLE p_contrato
    ADD CONSTRAINT cont_cargo_fk FOREIGN KEY ( id_cargo )
        REFERENCES p_cargo ( id_cargo );

ALTER TABLE p_contrato
    ADD CONSTRAINT cont_empleado_fk FOREIGN KEY ( cod_empleado )
        REFERENCES p_empleado ( id_empleado );

ALTER TABLE p_contrato_plazo_fijo
    ADD CONSTRAINT cpfijo_contrato_fk FOREIGN KEY ( id_contrato )
        REFERENCES p_contrato ( id_contrato );

ALTER TABLE p_contrato_plazo_indeterminado
    ADD CONSTRAINT cpind_contrato_fk FOREIGN KEY ( id_contrato )
        REFERENCES p_contrato ( id_contrato );

ALTER TABLE p_empleadoxactividad
    ADD CONSTRAINT ea_actividad_fk FOREIGN KEY ( id_actividad )
        REFERENCES p_actividad ( id_actividad );

ALTER TABLE p_empleadoxactividad
    ADD CONSTRAINT ea_empleado_fk FOREIGN KEY ( id_empleado )
        REFERENCES p_empleado ( id_empleado );

ALTER TABLE p_empleadoxhorario
    ADD CONSTRAINT eh_empleado_fk FOREIGN KEY ( id_empleado )
        REFERENCES p_empleado ( id_empleado );

ALTER TABLE p_empleadoxhorario
    ADD CONSTRAINT eh_horario_fk FOREIGN KEY ( id_horario )
        REFERENCES p_horario ( id_horario );

ALTER TABLE p_empleado
    ADD CONSTRAINT emp_cargo_fk FOREIGN KEY ( id_cargo )
        REFERENCES p_cargo ( id_cargo );

ALTER TABLE p_empleado
    ADD CONSTRAINT emp_centro_de_costos_fk FOREIGN KEY ( id_centro_de_costos )
        REFERENCES p_centro_de_costos ( id_centro_de_costos );

ALTER TABLE p_empleado
    ADD CONSTRAINT emp_doc_id_fk FOREIGN KEY ( num_doc_identidad )
        REFERENCES p_documento_identidad ( num_doc_identidad );

ALTER TABLE p_empleado
    ADD CONSTRAINT emp_pensiones_fk FOREIGN KEY ( id_fondo )
        REFERENCES p_fondo_de_pensiones ( id_fondo );

ALTER TABLE p_encargado_actividades
    ADD CONSTRAINT enc_actividad_fk FOREIGN KEY ( id_actividad )
        REFERENCES p_actividad ( id_actividad );

ALTER TABLE p_encargado_actividades
    ADD CONSTRAINT enc_empleado_fk FOREIGN KEY ( id_empleado )
        REFERENCES p_empleado ( id_empleado );

ALTER TABLE p_marcacion
    ADD CONSTRAINT marc_empleado_fk FOREIGN KEY ( id_empleado )
        REFERENCES p_empleado ( id_empleado );

ALTER TABLE p_examen_medico
    ADD CONSTRAINT med_empleado_fk FOREIGN KEY ( p_empleado_id_empleado )
        REFERENCES p_empleado ( id_empleado );

ALTER TABLE p_registro_nomina
    ADD CONSTRAINT nom_empleado_fk FOREIGN KEY ( id_empleado )
        REFERENCES p_empleado ( id_empleado );

ALTER TABLE p_registro_nomina
    ADD CONSTRAINT nom_pensiones_fk FOREIGN KEY ( id_fondo )
        REFERENCES p_fondo_de_pensiones ( id_fondo );

CREATE OR REPLACE TRIGGER arc_arc__p_contrato_plazo_fijo BEFORE
    INSERT OR UPDATE OF id_contrato ON p_contrato_plazo_fijo
    FOR EACH ROW
DECLARE
    d CHAR(1 BYTE);
BEGIN
    SELECT
        a.tipo_contrato
    INTO d
    FROM
        p_contrato a
    WHERE
        a.id_contrato = :new.id_contrato;

    IF ( d IS NULL OR d <> 'F' ) THEN
        raise_application_error(-20223, 'FK CPFIJO_Contrato_FK in Table P_Contrato_plazo_fijo violates Arc constraint on Table P_Contrato - discriminator column tipo_contrato doesn''t have value ''F'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc__p_contrato_plazo_indeterm BEFORE
    INSERT OR UPDATE OF id_contrato ON p_contrato_plazo_indeterminado
    FOR EACH ROW
DECLARE
    d CHAR(1 BYTE);
BEGIN
    SELECT
        a.tipo_contrato
    INTO d
    FROM
        p_contrato a
    WHERE
        a.id_contrato = :new.id_contrato;

    IF ( d IS NULL OR d <> 'I' ) THEN
        raise_application_error(-20223, 'FK CPIND_Contrato_FK in Table P_Contrato_plazo_indeterminado violates Arc constraint on Table P_Contrato - discriminator column tipo_contrato doesn''t have value ''I'''
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
-- CREATE INDEX                             3
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
-- WARNINGS                                 0
