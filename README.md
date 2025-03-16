# Tipos de Slowly Changing Dimensions (SCD)

Los **Slowly Changing Dimensions (SCD)** son estrategias utilizadas en bases de datos para manejar cambios en los datos de dimensiones a lo largo del tiempo. A continuación, se presentan los principales tipos de SCD y sus características:

---

## 🔹 SCD Tipo 0: Retener Original (Ignorar Cambios)

### 📌 ¿Qué hace?
Mantiene los datos exactamente como se insertaron inicialmente. No se realizan actualizaciones, incluso si la información cambia en el mundo real.

### 📌 Ejemplo:
- Tabla: `Producto_SCD0`
- Columnas: `NombreProductoOriginal`, `CategoriaOriginal`
- Si el nombre o la categoría de un producto cambian, estos cambios **no se reflejan** en la tabla.

### 📌 Utilidad:
Se usa para datos que no deberían cambiar, como:
- Fecha de nacimiento de una persona.
- Fecha de lanzamiento original de un producto.

---

## 🔹 SCD Tipo 1: Sobrescribir Cambios

### 📌 ¿Qué hace?
Actualiza los registros existentes con los nuevos valores, **perdiendo la información histórica**.

### 📌 Ejemplo:
- Tabla: `Cliente_SCD1`
- Columna: `DireccionActual`
- Cuando un cliente se muda, su nueva dirección **reemplaza** la anterior sin conservar un historial.

### 📌 Utilidad:
Es útil cuando solo se necesita la información más reciente, por ejemplo:
- Dirección actual del cliente.
- Estado actual de un pedido.

---

## 🔹 SCD Tipo 2: Agregar Nueva Fila (Seguimiento del Historial)

### 📌 ¿Qué hace?
Crea una nueva fila cada vez que se produce un cambio, registrando el historial completo. Se utilizan los campos:
- `FechaInicioVigencia`
- `FechaFinVigencia`
- `EsActual` (booleano para indicar si la fila es la información actual).

### 📌 Ejemplo:
- Tabla: `Empleado_SCD2`
- Seguimiento de cambios en el departamento de un empleado.
- Cuando un empleado cambia de departamento:
  1. Se crea una nueva fila con el nuevo departamento y la fecha de inicio del cambio.
  2. La fila anterior se marca con la fecha de finalización.

### 📌 Utilidad:
Esencial cuando se necesita un **historial completo de cambios**, por ejemplo:
- Análisis de tendencias.
- Auditorías de datos.

---

## 🔹 SCD Tipo 3: Agregar Nueva Columna (Historial Limitado)

### 📌 ¿Qué hace?
Agrega una nueva columna para almacenar el valor anterior de un atributo, permitiendo un **historial limitado**.

### 📌 Ejemplo:
- Tabla: `Producto_SCD3`
- Columnas: `PrecioActual`, `PrecioAnterior`
- Cuando el precio cambia:
  - `PrecioAnterior` se actualiza con el valor anterior.
  - `PrecioActual` se actualiza con el nuevo valor.

### 📌 Utilidad:
Ideal cuando solo se necesita rastrear el **cambio más reciente** de un atributo, sin mantener un historial extenso.

---

## 🔹 SCD Tipo 4: Historial en una Tabla Separada

### 📌 ¿Qué hace?
Crea una **tabla separada** para almacenar el historial de información que cambia constantemente. La tabla principal y la de historial se relacionan mediante una **clave foránea**.

### 📌 Ejemplo:
- Tablas:
  - `Cliente_SCD4_Principal`: Contiene la información principal del cliente y una clave foránea.
  - `Cliente_SCD4_Riesgo`: Almacena el historial de los niveles de riesgo del cliente.

### 📌 Utilidad:
Útil cuando ciertos atributos cambian con frecuencia y se requiere mantener un **historial detallado** sin afectar la tabla principal.

---

## 📌 Conclusión
Cada tipo de **SCD** tiene su propósito dependiendo de la necesidad de almacenamiento y consulta de datos históricos. Elegir la estrategia adecuada garantiza un mejor manejo de la información y optimiza el rendimiento de la base de datos.

🔗 Para más información, consulta el siguiente enlace: [Implementing Slowly Changing Dimensions (SCDs) in Data Warehouses](https://www.sqlshack.com/implementing-slowly-changing-dimensions-scds-in-data-warehouses/)


