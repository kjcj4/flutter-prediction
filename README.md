Predicción de Enfermedades Nutricionales Flutter + Flask
1️⃣ Descripción del sistema

Este proyecto es un sistema de predicción de enfermedades nutricionales.

La app móvil está desarrollada en Flutter y permite a los usuarios ingresar información personal, hábitos y resultados de laboratorio.

El backend está implementado en Python Flask, donde se encuentra el modelo de Machine Learning entrenado para predecir enfermedades y deficiencias según el dataset proporcionado.

Los resultados de las predicciones se almacenan en una base de datos PostgreSQL, permitiendo consultar el historial desde la app.

Flujo del sistema:

El usuario ingresa datos como edad, género, hábitos (alcohol, ejercicio, dieta), exposición al sol, niveles de vitaminas, síntomas, etc.

La app envía estos datos al servidor Flask mediante un endpoint /predict.

El backend procesa los datos usando el modelo entrenado y devuelve la predicción de enfermedad y posibles deficiencias.

La predicción se guarda en PostgreSQL y se puede consultar mediante el endpoint /history.

2️⃣ Tecnologías usadas

Componente	Tecnología
App móvil	Flutter (Dart)
Backend	Python 3.x, Flask
Base de datos	PostgreSQL
Machine Learning	scikit-learn / pandas / numpy / joblib
Comunicación	HTTP (REST API)


3️⃣ Cómo instalar el backend

Entrar a la carpeta del backend:

cd backend


Crear entorno virtual:

python -m venv venv


Activar entorno:

Linux / Mac:

source venv/bin/activate


Windows:

venv\Scripts\activate


Instalar dependencias:

pip install -r requirements.txt


Ejecutar servidor:

python app.py


El servidor estará corriendo en http://localhost:5000.

4️⃣ Cómo crear la base de datos PostgreSQL

Abrir terminal de PostgreSQL:

psql -U postgres


Ejecutar script de creación:

\i db_setup.sql


Verificar que la tabla historial se creó correctamente:

\c predicciones_db
\dt


La tabla historial guarda todos los datos enviados y las predicciones generadas.

5️⃣ Cómo correr la app Flutter

Entrar a la carpeta de la app:

cd flutter_app


Instalar dependencias:

flutter pub get


Ejecutar app en emulador o dispositivo:

flutter run


Verificar que la app apunte al backend correcto (http://localhost:5000 o la IP de tu servidor si es un teléfono real):

const String BASE_URL = 'http://localhost:5000';

6️⃣ Endpoints del backend

Método	Endpoint	Descripción	Parámetros
POST	/predict	Recibe datos del usuario y devuelve predicción de enfermedad y deficiencias	JSON con los siguientes campos:
{
    "age": 25,
    "gender": "male",
    "bmi": 23.4,
    "smoking_status": "no",
    "alcohol_consumption": "moderate",
    "exercise_level": "high",
    "diet_type": "vegetarian",
    "sun_exposure": "low",
    "income_level": "medium",
    "latitude_region": "0.234",
    "vitamin_a_percent_rda": 90,
    "vitamin_c_percent_rda": 85,
    "vitamin_d_percent_rda": 60,
    "vitamin_e_percent_rda": 70,
    "vitamin_b12_percent_rda": 80,
    "folate_percent_rda": 75,
    "calcium_percent_rda": 95,
    "iron_percent_rda": 85,
    "hemoglobin_g_dl": 13.5,
    "serum_vitamin_d_ng_ml": 25,
    "serum_vitamin_b12_pg_ml": 400,
    "serum_folate_ng_ml": 12,
    "symptoms_count": 2,
    "symptoms_list": ["fatigue","pale_skin"],
    "has_night_blindness": false,
    "has_fatigue": true,
    "has_bleeding_gums": false,
    "has_bone_pain": false,
    "has_muscle_weakness": false,
    "has_numbness_tingling": false,
    "has_memory_problems": false,
    "has_pale_skin": true
}


| GET | /history | Devuelve todas las predicciones almacenadas | Ninguno |
| GET | /history/<id> | Devuelve predicción específica por ID | id = id de la predicción |

Ejemplo de response /predict:

{
    "prediccion": "Deficiencia de Vitamina D",
    "has_multiple_deficiencies": false,
    "status": "success"
}
