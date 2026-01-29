from flask import Flask, request, jsonify
from flask_cors import CORS
import joblib
import psycopg2
import json
import pandas as pd

app = Flask(__name__)
CORS(app)

# =========================
# Cargar modelo y columnas
# =========================

model = joblib.load("trained_model.pkl")
model_columns = joblib.load("model_columns.pkl")

# =========================
# Conexión PostgreSQL
# =========================

conn = psycopg2.connect(
    host="localhost",
    database="predicciones_ex",
    port="5433",
    user="postgres",
    password="123"
)

# =========================
# Endpoint POST /predict
# =========================

@app.route("/predict", methods=["POST"])
def predict():

    data = request.json

    # Convertir JSON a DataFrame
    df = pd.DataFrame([data])

    # Aplicar one-hot encoding igual que entrenamiento
    df = pd.get_dummies(df)

    # Agregar columnas faltantes
    for col in model_columns:
        if col not in df.columns:
            df[col] = 0

    # Reordenar columnas
    df = df[model_columns]

    # Predicción
    prediction = model.predict(df)[0]

    # Guardar en PostgreSQL
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO history (input_data, result) VALUES (%s,%s)",
        (json.dumps(data), str(prediction))
    )
    conn.commit()

    return jsonify({
        "prediction": prediction
    })


# =========================
# Endpoint GET /history
# =========================

@app.route("/history", methods=["GET"])
def history():
    cur = conn.cursor()
    cur.execute("""
        SELECT result, created_at
        FROM history
        ORDER BY created_at DESC
        LIMIT 10
    """)
    rows = cur.fetchall()

    history_list = []

    for r in rows:
        history_list.append({
            "result": r[0],
            "date": r[1].strftime("%Y-%m-%d %H:%M:%S")
        })

    return jsonify(history_list)



# =========================
# Ejecutar servidor
# =========================

if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5001,
        debug=True
    )
