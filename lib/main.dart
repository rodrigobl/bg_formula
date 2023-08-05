import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BG Formula',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BG Formula'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _x = 0;
  double _y = 0;
  double _z = 0;
  double _result = 0;

  String _equationText = "";

  final xController = TextEditingController(text: "0");
  final yController = TextEditingController(text: "0");
  final zController = TextEditingController(text: "0");

  void _incrementCounter() {

    int nullValue = 0;
    _equationText = "";

    setState(() {

      _x = double.tryParse(xController.text) ?? 0;
      _y = double.tryParse(yController.text) ?? 0;
      _z = double.tryParse(zController.text) ?? 0;

      if(_x == 0) {
        nullValue += 1;
      }

      if(_y == 0) {
        nullValue += 2;
      }

      if(_z == 0) {
        nullValue += 3;
      }

      switch(nullValue)
      {
        case 1:
          _result=_y*_z;
          _equationText = "Y * Z = X   ->    $_y * $_z = X   ->   $_result";
          break;

        case 2:
          _result=_x/_z;
          _equationText = "X / Z = Y   ->    $_x / $_z = Y   ->   $_result";
          break;

        case 3:
          _result=_x/_y;
          _equationText = "X / Y = Z   ->    $_x / $_y = Z   ->   $_result";
          break;

        default:
          _equationText = "error";
      }

      xController.text = "0";
      yController.text = "0";
      zController.text = "0";
      _x = 0;
      _y = 0;
      _z = 0;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Calculate',
        child: const Icon(Icons.calculate),
      ),
    );
  }

  Widget buildBody(){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Board games you want to play (X)"),
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
            ],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: xController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'want to play (X)'
            ),
          ),
          const Text("% in decimal of how many are new, 25% is 0.25 (Y)"),
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
            ],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: yController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'how many are new (Y)'
            ),
          ),
          const Text("Plays per year (Z)"),
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
            ],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: zController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'plays per year (Z)'
            ),
          ),
          Text("Result: $_result"),
          Text("Calculation: $_equationText")
        ],
      ),
    );
  }
}
