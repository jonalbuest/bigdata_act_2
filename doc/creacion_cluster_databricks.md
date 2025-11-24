## 1. Creación del Cluster

### Paso 1.1: Acceder a la Sección de Clusters

1. En el menú lateral izquierdo, haz clic en **"Compute"** o **"Clusters"**
2. Se mostrará la lista de clusters existentes (si los hay)

**![alt text](photo\image.png)** 

### Paso 1.2: Iniciar la Creación del Cluster

1. Haz clic en el botón **"Create Compute"**


**![alt text](photo\image-1.png)**


2. Se abrirá el formulario de configuración del cluster

**![alt text](photo\image-2.png)**
---

## 2. Configuración del Cluster

### Paso 2.1: Configuración Básica

Completar los siguientes campos en el formulario:

#### **Cluster Name** (Nombre del Cluster)

- Ingresa un nombre descriptivo para tu cluster

![alt text](photo\image-3.png)


- **Ejemplo**: `heart-disease-analysis-cluster`

### Paso 2.2: Configuración de Runtime

#### **Databricks Runtime Version**

- **Standard**: 
  - Aqui encontramos diferentes versionnes LTS las cuales significan Long Term Support, es decir, versiones estables con soporte extendido, bajo el lenguaje de JAVA; pero eso no significa que no pueda trabajar con Python.
  - Este modelo es para procesamiento distribuido:
  - Ideal para: Producción, datasets grandes, procesamiento paralelo
  - Mejor rendimiento para Big Data
- **ML Compute**: Optimizado para machine learning
  - Ideal para: Entrenamiento de modelos ML, uso de librerías ML
  - Incluye optimizaciones específicas para ML

**Selección recomendada para este proyecto**: version Standard


1. Al desplegar el menú de versiones de runtime podemos ver varias opciones disponibles:

**Opciones recomendadas**:

- **Runtime 13.3 LTS** o superior (Long Term Support)
- **Runtime con ML**: Si planeas usar machine learning

**Para este proyecto**: Runtime 15.4 LTS (incluye Spark 3.4.x y Python 3.10)

**![alt text](photo\image-4.png)**


**Características del Runtime seleccionado**:

- Apache Spark 3.4.x
- Python 3.10
- Unity Catalog habilitado
- Delta Lake incluido
---

- El cluster dispone de 15 gb de memoria RAM y 4 núcleos de CPU 

- **Standard** (Azure): 4 cores, 14 GB RAM - Ideal para desarrollo


**![alt text](photo\image-5.png)**


---


## 3. Verificación del Cluster

### Paso 3.1: Crear el Cluster

1. Revisa toda la configuración
2. Haz clic en el botón **"Create Cluster"** o **"Crear Cluster"** al final del formulario
3. El cluster comenzará a crearse, hasta que su estado cambie a **Running** o un chulito verde aparezca junto al nombre del cluster

**![alt text](photo\image-6.png)**

### Paso 3.2: Monitorear el Estado de Creación

El cluster pasará por los siguientes estados:

1. **Pending** (Pendiente):
   - Asignando recursos
   - Color: Gris/Amarillo
2. **Starting** (Iniciando):
   - Iniciando nodos
   - Instalando runtime
   - Color: Amarillo
3. **Running** (En ejecución):
   - ✅ Cluster listo para usar
   - Color: Verde

**Tiempo estimado**: 3-5 minutos

**![alt text](photo\image-7.png)**

### Paso 3.2: Verificar Configuración del Cluster

Una vez que el cluster esté en estado **Running**:

1. Haz clic en el nombre del cluster para ver los detalles
2. Verifica la información:
   - **Status**: Running
   - **Uptime**: Tiempo activo
   - **Databricks Runtime**: Versión correcta
   - **Driver/Workers**: Nodos asignados
   - **Spark UI**: Enlace a la interfaz de Spark

La imagen a continuación muestra un ejemplo de un cluster de databricks gratuito, lamentablemente la versión gratuita no permite configurar Unity Catalog y observar los detalles completos. 

**![alt text](photo\image-8.png)**

### Paso 3.3: Probar el Cluster

**Crear un Notebook de Prueba**:

1. Ve a **Workspace** en el menú lateral
2. Haz clic derecho en tu carpeta de usuario
3. Selecciona **Create → Notebook**
4. Asigna el cluster recién creado al notebook
5. Ejecuta un comando de prueba:

```python
# Verificar versión de Spark
print(spark.version)

# Crear un DataFrame de prueba
data = [(1, "Test"), (2, "Cluster"), (3, "Working")]
df = spark.createDataFrame(data, ["id", "message"])
df.show()
```

**![alt text](photo\image-9.png)**

---

**Autores**: Jonathan Alvarez Bustamante  y Didier J. Alvarez Bustamante
**Proyecto**: Actividad 2: Taller: procesamiento de datos en una infraestructura -
**Base de datos:** cloud Heart Disease 2020 - Big Data Analysis  
**Curso**: Big Data - IU Digital de Antioquia  
**Fecha**: Noviembre 2025
