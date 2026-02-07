import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String _output = "0";
  String _currentNumber = "";
  double _num1 = 0;
  String _operand = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      _currentNumber = "";
      _num1 = 0;
      _operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "*") {
      _num1 = double.parse(_output);
      _operand = buttonText;
      _currentNumber = "";
    } else if (buttonText == ".") {
      if (!_currentNumber.contains(".")) {
        _currentNumber = _currentNumber + buttonText;
      }
    } else if (buttonText == "=") {
      double num2 = double.parse(_output);
      if (_operand == "+") {
        _output = (_num1 + num2).toString();
      }
      if (_operand == "-") {
        _output = (_num1 - num2).toString();
      }
      if (_operand == "*") {
        _output = (_num1 * num2).toString();
      }
      if (_operand == "/") {
        _output = (_num1 / num2).toString();
      }
      _num1 = 0;
      _operand = "";
      _currentNumber = _output; // Keep the result for further calculations
    } else {
      _currentNumber = _currentNumber + buttonText;
      _output = _currentNumber;
    }

    setState(() {
      // Format output to remove unnecessary .0
      double value = double.parse(_output);
      if (value == value.toInt()) {
        _output = value.toInt().toString();
      } else {
        _output = value.toString();
      }
    });
    // Reset currentNumber after an operation for the next input
    if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "*" || buttonText == "="){
        _currentNumber = "";
    }
  }

  Widget buildButton(String buttonText, {Color color = Colors.black54, Color textColor = Colors.white}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(24.0),
            shape: const CircleBorder(),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Expanded(child: Divider()),
          Column(
            children: [
              Row(children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/", color: Colors.orange),
              ]),
              Row(children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("*", color: Colors.orange),
              ]),
              Row(children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-", color: Colors.orange),
              ]),
              Row(children: [
                buildButton("."),
                buildButton("0"),
                buildButton("CLEAR", color: Colors.redAccent),
                buildButton("+", color: Colors.orange),
              ]),
              Row(children: [
                buildButton("=", color: Colors.green),
              ]),
            ],
          )
        ],
      ),
    );
  }
}
