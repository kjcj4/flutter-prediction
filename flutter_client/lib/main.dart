import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MedicalApp());
}

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vitamin Health Check',
      theme: ThemeData(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const FormScreen(),
    );
  }
}

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> c = {
    'age': TextEditingController(),
    'bmi': TextEditingController(),
    'income_level': TextEditingController(),
    'vitamin_a_percent_rda': TextEditingController(),
    'vitamin_c_percent_rda': TextEditingController(),
    'vitamin_d_percent_rda': TextEditingController(),
    'vitamin_e_percent_rda': TextEditingController(),
    'vitamin_b12_percent_rda': TextEditingController(),
    'folate_percent_rda': TextEditingController(),
    'calcium_percent_rda': TextEditingController(),
    'iron_percent_rda': TextEditingController(),
    'hemoglobin_g_dl': TextEditingController(),
    'serum_vitamin_d_ng_ml': TextEditingController(),
    'serum_vitamin_b12_pg_ml': TextEditingController(),
    'serum_folate_ng_ml': TextEditingController(),
    'symptoms_count': TextEditingController(),
  };

  String gender = "Male";
  String smoking = "No";
  String alcohol = "No";
  String exercise = "Moderate";
  String diet = "Balanced";
  String sun = "Moderate";
  String region = "Equatorial";

  Map<String, bool> symptoms = {
    "has_night_blindness": false,
    "has_fatigue": false,
    "has_bleeding_gums": false,
    "has_bone_pain": false,
    "has_muscle_weakness": false,
    "has_numbness_tingling": false,
    "has_memory_problems": false,
    "has_pale_skin": false,
  };

  Widget input(String label, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: c[key],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget dropdown(String label, String value, List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField(
        value: value,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Future<void> sendData() async {
    Map<String, dynamic> data = {
      "age": c['age']!.text,
      "gender": gender,
      "bmi": c['bmi']!.text,
      "smoking_status": smoking,
      "alcohol_consumption": alcohol,
      "exercise_level": exercise,
      "diet_type": diet,
      "sun_exposure": sun,
      "income_level": c['income_level']!.text,
      "latitude_region": region,

      "vitamin_a_percent_rda": c['vitamin_a_percent_rda']!.text,
      "vitamin_c_percent_rda": c['vitamin_c_percent_rda']!.text,
      "vitamin_d_percent_rda": c['vitamin_d_percent_rda']!.text,
      "vitamin_e_percent_rda": c['vitamin_e_percent_rda']!.text,
      "vitamin_b12_percent_rda": c['vitamin_b12_percent_rda']!.text,
      "folate_percent_rda": c['folate_percent_rda']!.text,
      "calcium_percent_rda": c['calcium_percent_rda']!.text,
      "iron_percent_rda": c['iron_percent_rda']!.text,

      "hemoglobin_g_dl": c['hemoglobin_g_dl']!.text,
      "serum_vitamin_d_ng_ml": c['serum_vitamin_d_ng_ml']!.text,
      "serum_vitamin_b12_pg_ml": c['serum_vitamin_b12_pg_ml']!.text,
      "serum_folate_ng_ml": c['serum_folate_ng_ml']!.text,

      "symptoms_count": c['symptoms_count']!.text,

      ...symptoms
    };

    final response = await http.post(
      Uri.parse("http://192.168.10.100:5001/predict"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    final result = jsonDecode(response.body);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Resultado"),
        content: Text(result["prediction"].toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vitamin Deficiency Predictor")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              input("Age", "age"),
              dropdown("Gender", gender, ["Male", "Female"], (v)=>setState(()=>gender=v!)),
              input("BMI", "bmi"),
              input("Income Level", "income_level"),

              dropdown("Smoking", smoking, ["Yes", "No"], (v)=>setState(()=>smoking=v!)),
              dropdown("Alcohol", alcohol, ["Yes", "No"], (v)=>setState(()=>alcohol=v!)),
              dropdown("Exercise", exercise, ["Low","Moderate","High"], (v)=>setState(()=>exercise=v!)),
              dropdown("Diet", diet, ["Balanced","Poor","Rich"], (v)=>setState(()=>diet=v!)),
              dropdown("Sun Exposure", sun, ["Low","Moderate","High"], (v)=>setState(()=>sun=v!)),
              dropdown("Region", region, ["Equatorial","Tropical","Temperate","Polar"], (v)=>setState(()=>region=v!)),

              const SizedBox(height: 12),
              const Text("Vitamin Intake (%)", style: TextStyle(fontWeight: FontWeight.bold)),

              input("Vitamin A", "vitamin_a_percent_rda"),
              input("Vitamin C", "vitamin_c_percent_rda"),
              input("Vitamin D", "vitamin_d_percent_rda"),
              input("Vitamin E", "vitamin_e_percent_rda"),
              input("Vitamin B12", "vitamin_b12_percent_rda"),
              input("Folate", "folate_percent_rda"),
              input("Calcium", "calcium_percent_rda"),
              input("Iron", "iron_percent_rda"),

              const SizedBox(height: 12),
              const Text("Lab Results", style: TextStyle(fontWeight: FontWeight.bold)),

              input("Hemoglobin", "hemoglobin_g_dl"),
              input("Serum Vitamin D", "serum_vitamin_d_ng_ml"),
              input("Serum B12", "serum_vitamin_b12_pg_ml"),
              input("Serum Folate", "serum_folate_ng_ml"),

              input("Symptoms Count", "symptoms_count"),

              const SizedBox(height: 12),
              const Text("Symptoms", style: TextStyle(fontWeight: FontWeight.bold)),

              ...symptoms.keys.map((k) => CheckboxListTile(
                title: Text(k.replaceAll("_", " ")),
                value: symptoms[k],
                onChanged: (v)=>setState(()=>symptoms[k]=v!),
              )),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: sendData,
                child: const Text("Predict"),
              ),
              SizedBox(height: 10),

OutlinedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => HistoryScreen()),
    );
  },
  child: Text("Ver historial"),
),

            ],
          ),
        ),
      ),
    );
  }
}
class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  List history = [];

  Future loadHistory() async {
    final response = await http.get(
      Uri.parse("http://192.168.10.100:5001/history"),
    );

    history = jsonDecode(response.body);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Historial")),
      body: history.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.history),
                  title: Text(history[index]["result"]),
                  subtitle: Text(history[index]["date"]),
                );
              },
            ),
    );
  }
}

