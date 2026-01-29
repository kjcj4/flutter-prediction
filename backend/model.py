import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import joblib

# =========================
# Cargar dataset
# =========================

data = pd.read_csv("vitamin_deficiency_disease_dataset_20260123.csv")

# =========================
# Separar X y y
# =========================

X = data.drop("disease_diagnosis", axis=1)
y = data["disease_diagnosis"]

# =========================
# Convertir columnas categóricas a numéricas
# =========================

X = pd.get_dummies(X)

# =========================
# Train / Test split
# =========================

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# =========================
# Entrenar modelo
# =========================

model = RandomForestClassifier(
    n_estimators=200,
    random_state=42
)

model.fit(X_train, y_train)

# =========================
# Guardar modelo + columnas
# =========================

joblib.dump(model, "trained_model.pkl")
joblib.dump(X.columns.tolist(), "model_columns.pkl")

print("Modelo entrenado correctamente")
