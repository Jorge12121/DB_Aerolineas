# DB_Aerolineas

## Instrucciones para ejecutar los scripts y crear la base de datos

### 1. Requisitos previos
- Tener instalado PostgreSQL en tu sistema.
- Tener el cliente `psql` disponible en la terminal PowerShell (Agregado psql al PATH).

### 2. Crear la base de datos
Abre PowerShell y ejecuta:

psql -U postgres -c "CREATE DATABASE vuelos_db;"

Reemplaza `postgres` por tu usuario si es diferente.

### 3. Crear las tablas y relaciones
Ejecuta el script de creación de tablas (En powershell):

psql -U postgres -d vuelos_db -f "Ruta donde se encuentra el archivo dbCreate.sql"

Ejemplo de ejecucion en mi caso:

psql -U postgres -d vuelos_db -f "c:\Users\Nelson\Desktop\DB_Aerolineas\dbCreate.sql"

### 4. Cargar datos de prueba
Ejecuta el script de carga de datos:

psql -U postgres -d vuelos_db -f "Ruta donde se encuentra el archivo loadData.sql"

Ejemplo de ejecucion en mi caso:

psql -U postgres -d vuelos_db -f "c:\Users\Nelson\Desktop\DB_Aerolineas\loadData.sql"


### 5. Ejecutar consultas estadísticas
Ejecuta el script de consultas:

psql -U postgres -d vuelos_db -f "c:\Users\Nelson\Desktop\DB_Aerolineas\runStatements.sql"

### 6. Archivos incluidos
- `dbCreate.sql`: Script para crear las tablas e índices.
- `loadData.sql`: Script para cargar datos de prueba.
- `runStatements.sql`: Consultas estadísticas y reportes.
- `Diccionario de datos.docx`: Descripción de las tablas y campos.
- `tablas.pdf`: Visualizacion de la estructura de las tablas.
- `DBA.png`: Diagrama de base de datos.