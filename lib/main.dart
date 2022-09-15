import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "BMI Calculator",
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
    ),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textInfo = "";

  void _resetFields(){
    _formKey.currentState?.reset();
    weightController.clear();
    heightController.clear();
    setState(() {
      _textInfo = "";
    });
  }

  void _calc(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _textInfo = "Underweight (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _textInfo = "Ideal weight (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _textInfo = "Slightly overweight (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _textInfo = "Grade I obesity (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _textInfo = "Grade II obesity (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _textInfo = "Grade III obesity (${imc.toStringAsPrecision(4)})";
      }

    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.person, size: 120, color: Colors.blueGrey),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Weight (kg)",
                  labelStyle: TextStyle(color: Colors.blueGrey)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Enter your weight!";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height (cm)',
                  labelStyle: TextStyle(color: Colors.blueGrey)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your height!";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: ButtonTheme(
                  height: 500.0,
                  highlightColor: Colors.amber,
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) _calc();
                    }, 
                    child: const Text(
                      "Calculate",
                      style: 
                      TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ),
              ),
              Text(
                _textInfo,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 25.0),
              ),
            ]
          ),
        ),
      )
    );
  }
}