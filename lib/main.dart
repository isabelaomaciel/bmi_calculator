import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe os seus dados';

  void _resetField() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe os seus dados';
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double bmi = weight / (height * height);
      if (bmi < 18.6) {
        _infoText = 'Abaixo do Peso (${bmi.toStringAsPrecision(2)})';
      } else if (bmi >= 18.6 && bmi < 24.9) {
        _infoText = 'Peso ideal (${bmi.toStringAsPrecision(2)})';
      } else if (bmi >= 24.9 && bmi < 29.9) {
        _infoText = 'Levemente acima do peso (${bmi.toStringAsPrecision(2)})';
      } else if (bmi >= 29.9 && bmi < 34.9) {
        _infoText = 'Obesidade Grau I (${bmi.toStringAsPrecision(2)})';
      } else if (bmi >= 34.9) {
        _infoText = 'Obesidade Grau II (${bmi.toStringAsPrecision(2)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora de IMC',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            onPressed: _resetField,
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.black,
              ),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Peso(kg)',
                    labelStyle: TextStyle(color: Colors.grey)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 25.0),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Insira seu peso!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Altura(cm)',
                    labelStyle: TextStyle(color: Colors.grey)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 25.0),
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Insira a sua altura!';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _calculate();
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child:  const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
