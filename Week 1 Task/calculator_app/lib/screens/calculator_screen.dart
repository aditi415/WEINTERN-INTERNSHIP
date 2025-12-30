import 'package:flutter/material.dart';
import '../widgets/calc_button.dart';
import '../utils/calculator_logic.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();

  String result = "";

  void onButtonPressed(String operator) {
    setState(() {
      result = CalculatorLogic.calculate(
        num1Controller.text,
        num2Controller.text,
        operator,
      );
    });
  }

  void clear() {
    num1Controller.clear();
    num2Controller.clear();
    setState(() {
      result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Calculator"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: num1Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "First Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: num2Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Second Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalcButton(text: "+", onTap: onButtonPressed),
                CalcButton(text: "-", onTap: onButtonPressed),
                CalcButton(text: "×", onTap: onButtonPressed),
                CalcButton(text: "÷", onTap: onButtonPressed),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: clear,
              child: const Text("Clear"),
            ),

            const SizedBox(height: 20),

            Text(
              result,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
