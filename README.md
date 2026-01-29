# Predicción de Enfermedades Nutricionales Flutter + Flask

## Descripción del sistema

Este proyecto es un sistema de **predicción de enfermedades nutricionales**.

- La **app móvil** está desarrollada en **Flutter** y permite a los usuarios ingresar información personal, hábitos y resultados de laboratorio.  
- El **backend** está implementado en **Python Flask**, donde se encuentra el **modelo de Machine Learning** entrenado para predecir enfermedades y deficiencias según el dataset proporcionado.  
- Los resultados de las predicciones se almacenan en una **base de datos PostgreSQL**, permitiendo consultar el historial desde la app.

**Flujo del sistema:**

1. El usuario ingresa datos como edad, género, hábitos (alcohol, ejercicio, dieta), exposición al sol, niveles de vitaminas, síntomas, etc.  
2. La app envía estos datos al servidor Flask mediante el endpoint `/predict`.  
3. El backend procesa los datos usando el modelo entrenado y devuelve la predicción de enfermedad y posibles deficiencias.  
4. La predicción se guarda en PostgreSQL y se puede consultar mediante el endpoint `/history`.

---

## Tecnologías usadas

| Componente        | Tecnología |
|------------------|------------|
| App móvil         | Flutter (Dart) |
| Backend           | Python 3.x, Flask |
| Base de datos     | PostgreSQL |
| Machine Learning  | scikit-learn / pandas / numpy / joblib |
| Comunicación      | HTTP (REST API) |

---

## Cómo instalar el backend

1. Entrar a la carpeta del backend:
   ```bash  
   cd backend
2. Crear un entorno virtual:
   ```bash 
   python -m venv venv
3. Activar el entorno virtual:
   ```bash
   Linux / Mac:
source venv/bin/activate

4. Windows:
  ```bash
venv\Scripts\activate

5. Instalar dependencias:
   ```bash
pip install -r requirements.txt

6. Ejecutar servidor:
    ```bash
python app.py

## El servidor estará corriendo en http://localhost:5000.

7. Cómo crear la base de datos PostgreSQL

Abrir terminal de PostgreSQL:
    ```bash
psql -U postgres

8. Ejecutar script de creación:
   ```bash
\i db_setup.sql

9. Verificar que la tabla historial se creó correctamente:
   ```bash
\c predicciones_db
\dt

10. La tabla historial guarda todos los datos enviados y las predicciones generadas.


## Cómo correr la app Flutter

11. Entrar a la carpeta de la app:
   ```bash
cd flutter_app

12. Instalar dependencias:
  ```bash
flutter pub get

13. Ejecutar app en emulador o dispositivo:
  ```bash
flutter run

# Verificar que la app apunte al backend correcto (http://localhost:5000 o la IP de tu servidor si es un teléfono real):

# const String BASE_URL = 'http://localhost:5000';
