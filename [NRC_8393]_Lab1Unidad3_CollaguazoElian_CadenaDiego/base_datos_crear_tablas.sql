ALTER SESSION SET CONTAINER = DbBonoDesarrolloHumano;
alter pluggable database DbBonoDesarrolloHumano OPEN;
connect US_lecollaguazo1@DbBonoDesarrolloHumano


CREATE TABLE provincia (
pro_id		    NUMBER PRIMARY KEY,
pro_nombre	    VARCHAR(40) NOT NULL
);

CREATE TABLE canton (
can_id		    NUMBER PRIMARY KEY,   
can_nombre	    VARCHAR(40) NOT NULL,
pro_id		    INTEGER REFERENCES provincia(pro_id)
);


CREATE TABLE parroquia (
par_id		   NUMBER PRIMARY KEY,	   
par_nombre	   VARCHAR(40) NOT NULL,
can_id		   INTEGER REFERENCES canton(can_id)
);

CREATE TABLE programa (
pro_id                   NUMBER PRIMARY KEY ,
pro_nombre_bono          VARCHAR2(50) NOT NULL    ,
pro_poblacion            VARCHAR2(50) NOT NULL    ,
pro_valor                NUMBER     ,
pro_status               VARCHAR(20) NOT NULL
 );

CREATE TABLE encuestador (
enc_id               NUMBER PRIMARY KEY,
enc_nombre           VARCHAR2(50) NOT NULL,
enc_status           VARCHAR2(20) NOT NULL
 );

CREATE TABLE registro_social (
reg_id                      NUMBER PRIMARY KEY,
reg_puntaje                 NUMBER,
reg_status                  VARCHAR2(20) NOT NULL,
enc_id               		INTEGER REFERENCES encuestador(enc_id)
 );

CREATE TABLE parametro (
par_id              NUMBER PRIMARY KEY,
par_grupo           VARCHAR2(70) NOT NULL,
par_status          VARCHAR2(30) NOT NULL
 );

CREATE TABLE asignacion (
asi_id               NUMBER PRIMARY KEY,
par_id               INTEGER REFERENCES parametro(par_id),
pro_id               INTEGER REFERENCES programa(pro_id)
);

CREATE TABLE servicios (
ser_id               NUMBER  PRIMARY KEY,
ser_nombre_servicio  VARCHAR2(70) NOT NULL,
ser_status           VARCHAR2(20) NOT NULL,
pro_Id               INTEGER REFERENCES programa(pro_id)
);

CREATE TABLE agencia_mies(
age_id                NUMBER PRIMARY KEY,
age_linea_telefonica  VARCHAR2(10),
age_status            VARCHAR2(20),
par_id		   	INTEGER REFERENCES parroquia(par_id)
);

CREATE TABLE beneficiario(
ben_ci               NUMBER PRIMARY KEY,
ben_nombre           VARCHAR2(40) NOT NULL,
ben_edad             INTEGER NOT NULL,
ben_genero           VARCHAR2(20) NOT NULL,
ben_status            VARCHAR2(20) NOT NULL,
pro_id               INTEGER REFERENCES programa(pro_id),
reg_id               INTEGER REFERENCES registro_social(reg_id),
age_id               INTEGER REFERENCES agencia_mies(age_id)
);

CREATE TABLE monitoreo_mies (
mon_id              NUMBER PRIMARY KEY,
mon_fecha           DATE NOT NULL,
mon_medio           VARCHAR2(35),
ben_ci              INTEGER REFERENCES beneficiario(ben_ci)
);

CREATE TABLE registro_pagos (
rep_id             NUMBER PRIMARY KEY,
rep_fecha          DATE NOT NULL,
rep_valor          NUMBER,
rep_banco          VARCHAR2(50) NOT NULL,
rep_num_cuenta     VARCHAR2(30),
ben_ci             INTEGER REFERENCES beneficiario(ben_ci)
);

CREATE TABLE call_center (
cal_id              NUMBER PRIMARY KEY,
cal_nombre          VARCHAR2(30) NOT NULL,
cal_status          VARCHAR2(20) NOT NULL,
cal_horario         VARCHAR2(25) NOT NULL,
age_id              INTEGER REFERENCES agencia_mies(age_id)
);