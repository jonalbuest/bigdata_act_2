-- ============================================================================
-- DDL en Spark SQL para Unity Catalog - Dataset Heart Disease 2020
-- ============================================================================
-- Arquitectura: Metastore → Catalog → Schema → Tables
-- Formato: Delta Lake con ACID compliance
-- ============================================================================

-- ============================================================================
-- PASO 1: Crear el Catálogo (Catalog)
-- ============================================================================
CREATE CATALOG IF NOT EXISTS heart_disease_catalog
COMMENT 'Catálogo para análisis de salud cardiovascular y factores de riesgo';

-- Usar el catálogo creado
USE CATALOG heart_disease_catalog;

-- ============================================================================
-- PASO 2: Crear el Schema
-- ============================================================================
CREATE SCHEMA IF NOT EXISTS heart2020_schema
COMMENT 'Schema para dataset Heart Disease 2020 - CDC BRFSS'
WITH DBPROPERTIES (
    'project' = 'heart_disease_analysis',
    'dataset_year' = '2020',
    'source' = 'https://www.cdc.gov/brfss/annual_data/annual_2020.html',
    'created_by' = 'Jonathan Alvarez Bustamante y Didier J. Alvarez Bustamante',
    'version' = '1.0'
);

-- Usar el schema creado
USE SCHEMA heart2020_schema;

-- ============================================================================
-- PASO 3: Crear las Tablas (Tables)
-- ============================================================================

-- Tabla: persona
-- Nombre completo: heart_disease_catalog.heart2020_schema.persona
-- Descripción: Almacena información demográfica y de salud general
CREATE TABLE IF NOT EXISTS heart_disease_catalog.heart2020_schema.persona (
    id_persona      INT NOT NULL COMMENT 'Identificador único de la persona',
    Sex             STRING COMMENT 'Sexo de la persona (Male/Female)',
    AgeCategory     STRING COMMENT 'Categoría de edad',
    Race            STRING COMMENT 'Raza/Etnia de la persona',
    BMI             DOUBLE COMMENT 'Índice de Masa Corporal',
    SleepTime       DOUBLE COMMENT 'Horas promedio de sueño por día',
    GenHealth       STRING COMMENT 'Estado general de salud',
    PhysicalHealth  DOUBLE COMMENT 'Días con mala salud física (últimos 30 días)',
    MentalHealth    DOUBLE COMMENT 'Días con mala salud mental (últimos 30 días)',
    DiffWalking     STRING COMMENT 'Dificultad para caminar (Yes/No)',
    CONSTRAINT pk_persona PRIMARY KEY (id_persona)
)
USING DELTA;

-- Tabla: habitos
-- Nombre completo: heart_disease_catalog.heart2020_schema.habitos
-- Descripción: Almacena información sobre hábitos y estilo de vida
CREATE TABLE IF NOT EXISTS heart_disease_catalog.heart2020_schema.habitos (
    id_habito        INT NOT NULL COMMENT 'Identificador único del registro de hábitos',
    Smoking          STRING COMMENT 'Ha fumado al menos 100 cigarrillos (Yes/No)',
    AlcoholDrinking  STRING COMMENT 'Consumo excesivo de alcohol (Yes/No)',
    PhysicalActivity STRING COMMENT 'Actividad física últimos 30 días (Yes/No)',
    Diabetic         STRING COMMENT 'Estado diabético',
    id_persona       INT COMMENT 'Referencia a la persona',
    CONSTRAINT pk_habito PRIMARY KEY (id_habito),
    CONSTRAINT fk_habito_persona FOREIGN KEY (id_persona) 
        REFERENCES heart_disease_catalog.heart2020_schema.persona(id_persona)
)
USING DELTA

-- Tabla: condiciones_medicas
-- Nombre completo: heart_disease_catalog.heart2020_schema.condiciones_medicas
-- Descripción: Almacena información sobre condiciones médicas preexistentes
CREATE TABLE IF NOT EXISTS heart_disease_catalog.heart2020_schema.condiciones_medicas (
    id_condicion  INT NOT NULL COMMENT 'Identificador único del registro de condiciones',
    Stroke        STRING COMMENT 'Ha tenido derrame cerebral (Yes/No)',
    Asthma        STRING COMMENT 'Tiene asma (Yes/No)',
    KidneyDisease STRING COMMENT 'Tiene enfermedad renal (Yes/No)',
    SkinCancer    STRING COMMENT 'Tiene cáncer de piel (Yes/No)',
    id_persona    INT COMMENT 'Referencia a la persona',
    CONSTRAINT pk_condicion PRIMARY KEY (id_condicion),
    CONSTRAINT fk_condicion_persona FOREIGN KEY (id_persona) 
        REFERENCES heart_disease_catalog.heart2020_schema.persona(id_persona)
)
USING DELTA

-- Tabla: salud_cardiaca
-- Nombre completo: heart_disease_catalog.heart2020_schema.salud_cardiaca
-- Descripción: Almacena información específica sobre enfermedades cardíacas
CREATE TABLE IF NOT EXISTS heart_disease_catalog.heart2020_schema.salud_cardiaca (
    id_saludcardiaca INT NOT NULL COMMENT 'Identificador único del registro de salud cardíaca',
    HeartDisease     STRING COMMENT 'Tiene enfermedad cardíaca (Yes/No)',
    id_persona       INT COMMENT 'Referencia a la persona',
    CONSTRAINT pk_saludcardiaca PRIMARY KEY (id_saludcardiaca),
    CONSTRAINT fk_saludcardiaca_persona FOREIGN KEY (id_persona) 
        REFERENCES heart_disease_catalog.heart2020_schema.persona(id_persona)
)
USING DELTA