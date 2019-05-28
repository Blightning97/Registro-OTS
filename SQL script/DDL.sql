-- TABLAS --

CREATE TABLE SEG_PERMISO(
    SEG_PERMISO		INTEGER				        NOT NULL,
    DESCRIPCION_ESP	VARCHAR2(256)		        NOT NULL,
    DESCRIPCION_ING	VARCHAR2(256)		        NOT NULL,
    
    CONSTRAINT	"SEG_PERMISO_PK" 		        PRIMARY KEY (SEG_PERMISO),

	CONSTRAINT	"DESCRIPCION_ESP_PER_REGEX"	    CHECK(REGEXP_LIKE(DESCRIPCION_ESP, '^[a-zA-ZñÑáéíóúÁÉÍÓÚ ]+$')),
	CONSTRAINT	"DESCRIPCION_ING_PER_REGEX"	    CHECK(REGEXP_LIKE(DESCRIPCION_ING, '^[a-zA-Z ]+$'))
);

CREATE TABLE SEG_ROL(
    SEG_ROL		INTEGER				            NOT NULL,
	NOMBRE_ROL	VARCHAR2(13)   		            NOT NULL,
	
    CONSTRAINT	"SEG_ROL_PK" 		            PRIMARY KEY (SEG_ROL),

	CONSTRAINT	"SEG_ROL_RANGE" 	            CHECK (SEG_ROL  BETWEEN 1 and 3),
	CONSTRAINT	"NOMBRE_ROL_ENUM" 	            CHECK(NOMBRE_ROL IN ('SuperUser','Administrator','Student'))
);

CREATE TABLE PRO_PROGRAMA(
    PRO_PROGRAMA       VARCHAR2(3),
    NOMBRE             VARCHAR2(20)		        NOT NULL,
    ACTIVO             CHAR(1)			        DEFAULT '1',
	
	CONSTRAINT	"PRO_PROGRAMA_PK" 		        PRIMARY KEY (PRO_PROGRAMA),
	CONSTRAINT 	"ACTIVO_PRO_BOOL" 			    CHECK(ACTIVO IN ('1','0'))
);

CREATE TABLE SOL_PREGUNTA(
    SOL_PREGUNTA        INTEGER,
    DESCRIPCION_ESP     VARCHAR2(256)           NOT NULL,
    DESCRIPCION_ING     VARCHAR2(256)		    NOT NULL,
    TIPO                INTEGER                 DEFAULT '1',
    REQUERIDO           CHAR(1)		            DEFAULT '1',
    ACTIVO              CHAR(1)                 DEFAULT '1',

    CONSTRAINT  "SOL_PREGUNTA_PK"               PRIMARY KEY (SOL_PREGUNTA),

    CONSTRAINT	"DESCRIPCION_ESP_PRE_REGEX"	    CHECK(REGEXP_LIKE(DESCRIPCION_ESP, '^[a-zA-ZñÑáéíóúÁÉÍÓÚ ]+$')),
	CONSTRAINT	"DESCRIPCION_ING_PRE_REGEX"	    CHECK(REGEXP_LIKE(DESCRIPCION_ING, '^[a-zA-Z ]+$')),
    CONSTRAINT  "TIPO_RANGE"                    CHECK(TIPO BETWEEN 1 AND 4),
    CONSTRAINT 	"REQUERIDO_PRE_BOOL" 		    CHECK(REQUERIDO IN ('1','0')),
    CONSTRAINT 	"ACTIVO_PRE_BOOL" 			    CHECK(ACTIVO IN ('1','0'))
);

CREATE TABLE SOL_FORMULARIO(
    SOL_FORMULARIO      INTEGER,
    ACTIVO              CHAR(1)                 DEFAULT '1',
    
    CONSTRAINT  "SOL_FORMULARIO_PK"             PRIMARY KEY (SOL_FORMULARIO),
    CONSTRAINT 	"ACTIVO_FOR_BOOL" 			    CHECK(ACTIVO IN ('1','0'))
);

CREATE TABLE SEG_POSEE(
    SEG_ROL     INTEGER,
    SEG_PERMISO INTEGER,

    CONSTRAINT 	"SEG_POSEE_PK" 		            PRIMARY KEY(SEG_ROL, SEG_PERMISO),
    CONSTRAINT 	"SEG_ROL_POS_FK" 		        FOREIGN KEY (SEG_ROL) REFERENCES SEG_ROL(SEG_ROL)
                                                    ON DELETE CASCADE,
    CONSTRAINT 	"SEG_PERMISO_POS_FK" 	        FOREIGN KEY (SEG_PERMISO) REFERENCES SEG_PERMISO(SEG_PERMISO)
                                                    ON DELETE CASCADE
);

CREATE TABLE SEG_USUARIO(
    SEG_USUARIO			INTEGER				    NOT NULL,
    NOMBRE				VARCHAR2(30)		    NOT NULL,
    APELLIDO_1			VARCHAR2(30)		    NOT NULL,
    APELLIDO_2			VARCHAR2(30),
    NOMBRE_USUARIO		VARCHAR2(256)		    NOT NULL,
    CONTRASENA			VARCHAR2(60)		    NOT NULL, 
    CORREO				VARCHAR2(256)		    NOT NULL,
    NUMERO_TELEFONO		VARCHAR2(28)		    NOT NULL,
    NACIONALIDAD		VARCHAR2(20)		    NOT NULL,
    ACTIVO				CHAR(1)				    DEFAULT '1',
	SEG_ROL				INTEGER				    NOT NULL,
	CODIGO_R	        VARCHAR2(15),
    
    CONSTRAINT	"SEG_USUARIO_PK" 			    PRIMARY KEY (SEG_USUARIO),
	CONSTRAINT 	"SEG_ROL_USU_FK"				FOREIGN KEY (SEG_ROL) REFERENCES SEG_ROL(SEG_ROL),
                                                --ON DELETE RESTRICT?
	CONSTRAINT	"NOMBRE_USU_REGEX"				CHECK(REGEXP_LIKE(NOMBRE, '^[^±!@£$%^&*_+§¡€#¢§¶•ªº«\\/<>?:;|=.,\s]{1,30}$')),
	CONSTRAINT	"APELLIDO_1_USU_REGEX"			CHECK(REGEXP_LIKE(APELLIDO_1, '^([^±!@£$%^&*_+§¡€#¢§¶•ªº«\\/<>?:;|=.,\s]{1,30}|\s*)$')),
	CONSTRAINT	"APELLIDO_2_USU_REGEX"			CHECK(REGEXP_LIKE(APELLIDO_2, '^[^±!@£$%^&*_+§¡€#¢§¶•ªº«\\/<>?:;|=.,\s]{0,30}$')),
	CONSTRAINT	"NOMBRE_USUARIO_USU_REGEX"		CHECK(REGEXP_LIKE(NOMBRE_USUARIO, '^[^±!@£$%^&*_+§¡€#¢§¶•ªº«\\/<>?:;|=.,\s]{1,30}$')),
	CONSTRAINT	"CONTRASENA_USU_REGEX"			CHECK(REGEXP_LIKE(CONTRASENA, '^\$2[abxy]?\$([4-9]|[1-2][0-9]|3[0-1])\$[.\/A-Za-z0-9]{53}$')),
	CONSTRAINT	"CORREO_USU_REGEX"				CHECK(REGEXP_LIKE(CORREO, '^[^@.]+(\.[^@.]+)*@[^@.]+(\.[^@.]+)+$')),
	CONSTRAINT	"NUMERO_TELEFONO_USU_REGEX"		CHECK(REGEXP_LIKE(NUMERO_TELEFONO, '^(\d|-|\+| ){7,28}$')),
	CONSTRAINT	"NACIONALIDAD_USU_REGEX"		CHECK(REGEXP_LIKE(NACIONALIDAD, '^[a-zA-Z ]+$')),
	CONSTRAINT 	"ACTIVO_USU_BOOL" 				CHECK(ACTIVO IN ('1','0')),
	CONSTRAINT	"CODIGO_R_USU_REGEX"	        CHECK(REGEXP_LIKE(CODIGO_R, '^\w{15}$'))
);

CREATE TABLE SOL_OPCIONES(
    SOL_OPCIONES        INTEGER,
    SOL_PREGUNTA        INTEGER,
    DESCRIPCION_ESP     VARCHAR2(256)           NOT NULL,
    DESCRIPCION_ING     VARCHAR2(256)		    NOT NULL,
    
    CONSTRAINT  "SOL_OPCIONES_PK"               PRIMARY KEY (SOL_OPCIONES, SOL_PREGUNTA),
    CONSTRAINT  "SOL_PREGUNTA_OPC_FK"           FOREIGN KEY (SOL_PREGUNTA) REFERENCES SOL_PREGUNTA(SOL_PREGUNTA)
		                                            ON DELETE CASCADE,
    
    CONSTRAINT	"DESCRIPCION_ESP_OPC_REGEX"	    CHECK(REGEXP_LIKE(DESCRIPCION_ESP, '^[a-zA-ZñÑáéíóúÁÉÍÓÚ ]+$')),
	CONSTRAINT	"DESCRIPCION_ING_OPC_REGEX"	    CHECK(REGEXP_LIKE(DESCRIPCION_ING, '^[a-zA-Z ]+$'))
);

CREATE TABLE SOL_CONTIENE(
	SOL_PREGUNTA        INTEGER,
	SOL_FORMULARIO      INTEGER,
	NUMERO_PREGUNTA     INTEGER                 NOT NULL,
	
    CONSTRAINT  "SOL_CONTIENE_PK"               PRIMARY KEY (SOL_PREGUNTA, SOL_FORMULARIO),
	CONSTRAINT  "SOL_PREGUNTA_CON_FK"           FOREIGN KEY (SOL_PREGUNTA) REFERENCES SOL_PREGUNTA(SOL_PREGUNTA)
		                                            ON DELETE CASCADE, --ON DELETE RESTRICT??
    CONSTRAINT  "SOL_FORMULARIO_CON_FK"         FOREIGN KEY (SOL_FORMULARIO) REFERENCES SOL_FORMULARIO(SOL_FORMULARIO)
		                                            ON DELETE CASCADE
);

CREATE TABLE PRO_CURSO(
    PRO_CURSO           INTEGER,
    SIGLA               VARCHAR(16)             NOT NULL,
    NOMBRE              VARCHAR(64)             NOT NULL,
    FECHA_INICIO        DATE                    NOT NULL,
    FECHA_FINALIZACION  DATE                    NOT NULL,
    FECHA_LIMITE        DATE                    NOT NULL,
    CREDITOS            INTEGER                 DEFAULT 4,
    IDIOMA              VARCHAR(16)             NOT NULL,
    LOCACION            VARCHAR(64)             NOT NULL,
    ACTIVO              CHAR(1)                 DEFAULT '1',
    PRO_PROGRAMA        VARCHAR2(3),
    SOL_FORMULARIO      INTEGER,
    SEG_USUARIO         INTEGER,

    CONSTRAINT  "PRO_CURSO_PK"                  PRIMARY KEY (PRO_CURSO),
    CONSTRAINT  "PRO_PROGRAMA_CUR_FK"           FOREIGN KEY (PRO_PROGRAMA) REFERENCES PRO_PROGRAMA(PRO_PROGRAMA),
		                                            -- ON DELETE RESTRICT?,
    CONSTRAINT  "SOL_FORMULARIO_CUR_FK"         FOREIGN KEY (SOL_FORMULARIO) REFERENCES SOL_FORMULARIO(SOL_FORMULARIO)
		                                            ON DELETE SET NULL, --Pueden haber cursos con formularios especificos (que sean distintos al del programa) porque si no los hay el formulario va en el programa.
    CONSTRAINT  "SEG_USUARIO_CUR_FK"            FOREIGN KEY (SEG_USUARIO) REFERENCES SEG_USUARIO(SEG_USUARIO),
		                                            -- ON DELETE RESTRICT?, ESTE USUARIO ES EL ADMIN DEL CURSO

    CONSTRAINT	"SIGLA_CUR_REGEX"	            CHECK(REGEXP_LIKE(SIGLA, '^[a-zA-Z0-9\-]{16}$')),
    CONSTRAINT	"NOMBRE_CUR_REGEX"	            CHECK(REGEXP_LIKE(NOMBRE, '^[a-zA-ZñÑáéíóúÁÉÍÓÚ ]+$')),
    CONSTRAINT  "CREDITOS_CUR_RANGE"            CHECK(CREDITOS > 0),
    CONSTRAINT	"IDIOMA_CUR_REGEX"	            CHECK(REGEXP_LIKE(IDIOMA, '^[a-zA-ZñÑáéíóúÁÉÍÓÚ ]+$')),
    CONSTRAINT	"LOCACION_CUR_REGEX"	        CHECK(REGEXP_LIKE(LOCACION, '^[a-zA-ZñÑáéíóúÁÉÍÓÚ ]+$')),
    CONSTRAINT 	"ACTIVO_CUR_BOOL" 			    CHECK(ACTIVO IN ('1','0'))
);

CREATE TABLE SOL_SOLICITUD(
    SEG_USUARIO         INTEGER,
    PRO_CURSO           INTEGER,
    RESULTADO           CHAR(9)                 DEFAULT 'Proceso',
    ACTIVO              CHAR(1)                 DEFAULT '1',
    
    CONSTRAINT  "SOL_SOLICITUD_PK"              PRIMARY KEY (SEG_USUARIO,PRO_CURSO),
    CONSTRAINT  "SEG_USUARIO_SOL_FK"            FOREIGN KEY (SEG_USUARIO) REFERENCES SEG_USUARIO(SEG_USUARIO)
                                                    ON DELETE CASCADE, --ON DELETE RESTRICT?? 
    CONSTRAINT  "PRO_CURSO_SOL_FK"              FOREIGN KEY (PRO_CURSO) REFERENCES PRO_CURSO(PRO_CURSO)
                                                    ON DELETE CASCADE, --ON DELETE RESTRICT??

    CONSTRAINT  "RESULTADO_ENUM"                CHECK(RESULTADO IN ('Proceso','Rechazado','Aceptado')),
    CONSTRAINT 	"ACTIVO_SOL_BOOL" 			    CHECK(ACTIVO IN ('1','0'))
);

CREATE TABLE PRO_ASISTE(
    SEG_USUARIO        INTEGER,
    PRO_CURSO          INTEGER,
	ESTADO		       CHAR(1)		            DEFAULT '1',		
    
    CONSTRAINT  "PRO_ASISTE_PK"                 PRIMARY KEY (SEG_USUARIO, PRO_CURSO),
    CONSTRAINT  "SEG_USUARIO_ASI_FK"            FOREIGN KEY (SEG_USUARIO) REFERENCES SEG_USUARIO(SEG_USUARIO)
		                                            ON DELETE CASCADE,
    CONSTRAINT  "PRO_CURSO_ASI_FK"              FOREIGN KEY (PRO_CURSO) REFERENCES PRO_CURSO(PRO_CURSO),
                                                    --ON DELETE RESTRICT?,
    CONSTRAINT 	"ESTADO_ASI_BOOL" 			    CHECK(ESTADO IN ('1','0'))  -- 1 ASISTE , 0 NO ASISTE
);

CREATE TABLE SOL_TEXTO_CORTO(
    SEG_USUARIO         INTEGER,
    PRO_CURSO           INTEGER,
    SOL_PREGUNTA        INTEGER,
    RESPUESTA           VARCHAR(50)             NOT NULL,
    ACTIVO              CHAR(1)                 DEFAULT '1',

    CONSTRAINT  "SOL_TEXTO_CORTO_PK"            PRIMARY KEY (SEG_USUARIO,PRO_CURSO,SOL_PREGUNTA),
    CONSTRAINT  "SOL_SOLICITUD_TCT_FK"          FOREIGN KEY (SEG_USUARIO,PRO_CURSO) REFERENCES SOL_SOLICITUD(SEG_USUARIO,PRO_CURSO)
                                                    ON DELETE CASCADE, --ON DELETE RESTRICT?? 
    CONSTRAINT  "SOL_PREGUNTA_TCT_FK"           FOREIGN KEY (SOL_PREGUNTA) REFERENCES SOL_PREGUNTA(SOL_PREGUNTA)
                                                    ON DELETE CASCADE, --ON DELETE RESTRICT??
    CONSTRAINT 	"ACTIVO_SRC_BOOL" 			    CHECK(ACTIVO IN ('1','0'))
);

CREATE TABLE SOL_TEXTO_MEDIO(
    SEG_USUARIO         INTEGER,
    PRO_CURSO           INTEGER,
    SOL_PREGUNTA        INTEGER,
    RESPUESTA           VARCHAR(255)            NOT NULL,
    ACTIVO              CHAR(1)                 DEFAULT '1',
    
    CONSTRAINT  "SOL_TEXTO_MEDIO_PK"            PRIMARY KEY (SEG_USUARIO,PRO_CURSO,SOL_PREGUNTA),
    CONSTRAINT  "SOL_SOLICITUD_TMD_FK"          FOREIGN KEY (SEG_USUARIO,PRO_CURSO) REFERENCES SOL_SOLICITUD(SEG_USUARIO,PRO_CURSO)
                                                    ON DELETE CASCADE, --ON DELETE RESTRICT?? 
    CONSTRAINT  "SOL_PREGUNTA_TMD_FK"           FOREIGN KEY (SOL_PREGUNTA) REFERENCES SOL_PREGUNTA(SOL_PREGUNTA)
                                                    ON DELETE CASCADE, --ON DELETE RESTRICT??
    CONSTRAINT 	"ACTIVO_SRM_BOOL" 			    CHECK(ACTIVO IN ('1','0'))
);

CREATE TABLE SOL_TEXTO_LARGO(
    SEG_USUARIO         INTEGER,
    PRO_CURSO           INTEGER,
    SOL_PREGUNTA        INTEGER,
    RESPUESTA           VARCHAR(4000)           NOT NULL,
    ACTIVO              CHAR(1)                 DEFAULT '1',
    
    CONSTRAINT  "SOL_TEXTO_LARGO_PK"            PRIMARY KEY (SEG_USUARIO,PRO_CURSO,SOL_PREGUNTA),
    CONSTRAINT  "SOL_SOLICITUD_TLG_FK"          FOREIGN KEY (SEG_USUARIO,PRO_CURSO) REFERENCES SOL_SOLICITUD(SEG_USUARIO,PRO_CURSO)
                                                    ON DELETE CASCADE, --ON DELETE RESTRICT?? 
    CONSTRAINT  "SOL_PREGUNTA_TLG_FK"           FOREIGN KEY (SOL_PREGUNTA) REFERENCES SOL_PREGUNTA(SOL_PREGUNTA)
                                                    ON DELETE CASCADE, --ON DELETE RESTRICT??
    CONSTRAINT 	"ACTIVO_SRL_BOOL" 			    CHECK(ACTIVO IN ('1','0'))
);

CREATE TABLE SOL_FECHA(
    SEG_USUARIO         INTEGER,
    PRO_CURSO           INTEGER,
    SOL_PREGUNTA        INTEGER,
    RESPUESTA           DATE                    NOT NULL,
    ACTIVO              CHAR(1)                 DEFAULT '1',
    
    CONSTRAINT  "SOL_FECHA_PK"                  PRIMARY KEY (SEG_USUARIO,PRO_CURSO,SOL_PREGUNTA),
    CONSTRAINT  "SOL_SOLICITUD_FCH_FK"          FOREIGN KEY (SEG_USUARIO,PRO_CURSO) REFERENCES SOL_SOLICITUD(SEG_USUARIO,PRO_CURSO)
                                                    ON DELETE CASCADE, --ON DELETE RESTRICT?? 
    CONSTRAINT  "SOL_PREGUNTA_FCH_FK"           FOREIGN KEY (SOL_PREGUNTA) REFERENCES SOL_PREGUNTA(SOL_PREGUNTA)
                                                    ON DELETE CASCADE, --ON DELETE RESTRICT??
    CONSTRAINT 	"ACTIVO_SRF_BOOL" 			    CHECK(ACTIVO IN ('1','0'))
);

CREATE TABLE SOL_NUMERO(
    SEG_USUARIO         INTEGER,
    PRO_CURSO           INTEGER,
    SOL_PREGUNTA        INTEGER,
    RESPUESTA           NUMBER                  NOT NULL,
    ACTIVO              CHAR(1)                 DEFAULT '1',
    
    CONSTRAINT  "SOL_NUMERO_PK"                 PRIMARY KEY (SEG_USUARIO,PRO_CURSO,SOL_PREGUNTA),
    CONSTRAINT  "SOL_SOLICITUD_NUM_FK"          FOREIGN KEY (SEG_USUARIO,PRO_CURSO) REFERENCES SOL_SOLICITUD(SEG_USUARIO,PRO_CURSO)
                                                    ON DELETE CASCADE, --ON DELETE RESTRICT?? 
    CONSTRAINT  "SOL_PREGUNTA_NUM_FK"           FOREIGN KEY (SOL_PREGUNTA) REFERENCES SOL_PREGUNTA(SOL_PREGUNTA)
                                                    ON DELETE CASCADE, --ON DELETE RESTRICT??
    CONSTRAINT 	"ACTIVO_SRN_BOOL" 			    CHECK(ACTIVO IN ('1','0'))
);

CREATE TABLE SOL_ARCHIVO(
    SEG_USUARIO			INTEGER,
    SOL_FORMULARIO      INTEGER,
    SOL_PREGUNTA        INTEGER,
    NOMBRE              VARCHAR(64)             NOT NULL,
    FILEPATH            VARCHAR(128)            NOT NULL,		
    
    CONSTRAINT  "SOL_ARCHIVO_PK"                PRIMARY KEY (SEG_USUARIO, SOL_FORMULARIO, SOL_PREGUNTA),
    CONSTRAINT  "SEG_USUARIO_ARC_FK"            FOREIGN KEY (SEG_USUARIO) REFERENCES SEG_USUARIO(SEG_USUARIO),
    CONSTRAINT  "SOL_FORMULARIO_ARC_FK"         FOREIGN KEY (SOL_FORMULARIO) REFERENCES SOL_FORMULARIO(SOL_FORMULARIO),
    CONSTRAINT  "SOL_PREGUNTA_ARC_FK"           FOREIGN KEY (SOL_PREGUNTA) REFERENCES SOL_PREGUNTA(SOL_PREGUNTA),
    CONSTRAINT 	"NOMBRE_REGEX" 			        CHECK(REGEXP_LIKE(NOMBRE, '^[A-Za-z0-9_\-]+$')),
    CONSTRAINT 	"FILEPATH_REGEX" 			    CHECK(REGEXP_LIKE(FILEPATH, '^([A-Za-z0-9_\-]\/)+$'))
);

-- DISPARADORES --

CREATE OR REPLACE TRIGGER SEG_PERMISO_INS
BEFORE INSERT ON SEG_PERMISO
FOR EACH ROW
BEGIN
    SELECT COALESCE(MAX(SEG_PERMISO), -1) + 1
    INTO :NEW.SEG_PERMISO
    FROM SEG_PERMISO;
END;

CREATE OR REPLACE TRIGGER SEG_ROL_INS
BEFORE INSERT ON SEG_ROL
FOR EACH ROW
BEGIN
    IF :NEW.SEG_ROL = 1 THEN
       :NEW.NOMBRE_ROL := 'SuperUser';
    ELSE
        IF :NEW.SEG_ROL = 2 THEN
            :NEW.NOMBRE_ROL := 'Administrator';
        ELSE
            :NEW.NOMBRE_ROL := 'Student';
        END IF;
    END IF;
END;

CREATE OR REPLACE TRIGGER PRO_PROGRAMA_INS
BEFORE INSERT ON PRO_PROGRAMA
FOR EACH ROW
BEGIN
    :NEW.PRO_PROGRAMA := SUBSTR(:NEW.NOMBRE, 0, 3);
END;

CREATE OR REPLACE TRIGGER SOL_PREGUNTA_INS
BEFORE INSERT ON SOL_PREGUNTA
FOR EACH ROW
BEGIN
    SELECT COALESCE(MAX(SOL_PREGUNTA), -1) + 1
    INTO :NEW.SOL_PREGUNTA
    FROM SOL_PREGUNTA;
END;

CREATE OR REPLACE TRIGGER SOL_FORMULARIO_INS
BEFORE INSERT ON SOL_FORMULARIO
FOR EACH ROW
BEGIN
    SELECT COALESCE(MAX(SOL_FORMULARIO), -1) + 1
    INTO :NEW.SOL_FORMULARIO
    FROM SOL_FORMULARIO;
END;

CREATE OR REPLACE TRIGGER SEG_USUARIO_INS
BEFORE INSERT ON SEG_USUARIO
FOR EACH ROW
BEGIN
    SELECT COALESCE(MAX(SEG_USUARIO), -1) + 1
    INTO :NEW.SEG_USUARIO
    FROM SEG_USUARIO;
END;

CREATE OR REPLACE TRIGGER SOL_OPCIONES_INS
BEFORE INSERT ON SOL_OPCIONES
FOR EACH ROW
BEGIN
    SELECT COALESCE(MAX(SOL_OPCIONES), -1) + 1
    INTO :NEW.SOL_OPCIONES
    FROM SOL_OPCIONES
    WHERE SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
END;

CREATE OR REPLACE TRIGGER PRO_CURSO_INS
BEFORE INSERT ON PRO_CURSO
FOR EACH ROW
BEGIN
    SELECT COALESCE(MAX(PRO_CURSO), -1) + 1
    INTO :NEW.PRO_CURSO
    FROM PRO_CURSO;

    :NEW.FECHA_INICIO := TO_DATE(:NEW.FECHA_INICIO, 'DD/MM/YY');
    :NEW.FECHA_FINALIZACION  := TO_DATE(:NEW.FECHA_FINALIZACION, 'DD/MM/YY');
    :NEW.FECHA_LIMITE := TO_DATE(:NEW.FECHA_LIMITE, 'DD/MM/YY');

    :NEW.SIGLA := CONCAT(:NEW.PRO_PROGRAMA, CONCAT('-', CONCAT(SUBSTR(:NEW.NOMBRE, 0, 3), 
    CONCAT('-', CONCAT(TO_CHAR(:NEW.FECHA_INICIO, 'MON'), CONCAT('-', TO_CHAR(:NEW.FECHA_INICIO, 'YYYY')))))));
END;

CREATE OR REPLACE TRIGGER SOL_TEXTO_CORTO_INS
BEFORE INSERT ON SOL_TEXTO_CORTO
FOR EACH ROW
BEGIN
    DELETE FROM SOL_TEXTO_MEDIO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_TEXTO_LARGO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_FECHA
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_NUMERO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
END;

CREATE OR REPLACE TRIGGER SOL_TEXTO_MEDIO_INS
BEFORE INSERT ON SOL_TEXTO_MEDIO
FOR EACH ROW
BEGIN
    DELETE FROM SOL_TEXTO_CORTO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_TEXTO_LARGO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_FECHA
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_NUMERO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
END;

CREATE OR REPLACE TRIGGER SOL_TEXTO_LARGO_INS
BEFORE INSERT ON SOL_TEXTO_LARGO
FOR EACH ROW
BEGIN
    DELETE FROM SOL_TEXTO_CORTO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_TEXTO_MEDIO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_FECHA
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_NUMERO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
END;

CREATE OR REPLACE TRIGGER SOL_FECHA_INS
BEFORE INSERT ON SOL_FECHA
FOR EACH ROW
BEGIN
    DELETE FROM SOL_TEXTO_CORTO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_TEXTO_MEDIO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_TEXTO_LARGO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_NUMERO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
END;


CREATE OR REPLACE TRIGGER SOL_NUMERO_INS
BEFORE INSERT ON SOL_NUMERO
FOR EACH ROW
BEGIN
    DELETE FROM SOL_TEXTO_CORTO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_TEXTO_MEDIO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_TEXTO_LARGO
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
    DELETE FROM SOL_FECHA
    WHERE SEG_USUARIO = :NEW.SEG_USUARIO AND PRO_CURSO = :NEW.PRO_CURSO AND SOL_PREGUNTA = :NEW.SOL_PREGUNTA;
END;

-- ELIMINA LAS TABLA --
DROP TABLE SOL_TEXTO_CORTO;
DROP TABLE SOL_TEXTO_LARGO;
DROP TABLE SOL_TEXTO_MEDIO;
DROP TABLE SOL_FECHA;
DROP TABLE SOL_NUMERO;
DROP TABLE PRO_ASISTE;
DROP TABLE SOL_SOLICITUD;
DROP TABLE PRO_CURSO;
DROP TABLE SOL_CONTIENE;
DROP TABLE SOL_OPCIONES;
DROP TABLE SEG_USUARIO;
DROP TABLE SEG_POSEE;
DROP TABLE SOL_FORMULARIO;
DROP TABLE SOL_PREGUNTA;
DROP TABLE PRO_PROGRAMA;
DROP TABLE SEG_ROL;
DROP TABLE SEG_PERMISO;

SELECT L.SID, S.serial#, DO.object_name 
FROM v$lock L, dba_objects DO, v$session S
WHERE 'OTS' = DO.owner
AND DO.object_id = L.ID1
AND L.SID = S.SID;

SELECT B.Owner, B.Object_Name, A.Oracle_Username, A.OS_User_Name  
FROM V$Locked_Object A, All_Objects B
WHERE A.Object_ID = B.Object_ID;