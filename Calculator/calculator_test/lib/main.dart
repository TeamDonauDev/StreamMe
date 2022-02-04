import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textFieldController1 = TextEditingController();
  TextEditingController textFieldController2 = TextEditingController();
  double _a = 0;
  double _b = 0;
  double _sum = 0;

  void _add() {
    setState(() {
      _a = double.parse(textFieldController1.text);
      _b = double.parse(textFieldController2.text);
      _sum = _a + _b;
    });
  }

  void _subtract() {
    setState(() {
      _a = double.parse(textFieldController1.text);
      _b = double.parse(textFieldController2.text);
      _sum = _a - _b;
    });
  }

  void _multiply() {
    setState(() {
      _a = double.parse(textFieldController1.text);
      _b = double.parse(textFieldController2.text);
      _sum = _a * _b;
    });
  }

  void _divide() {
    setState(() {
      _a = double.parse(textFieldController1.text);
      _b = double.parse(textFieldController2.text);
      _sum = _a / _b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
              children: <Widget> [
              InputFieldTest(hintTextPlaceholder: "A", textFieldController: textFieldController1),
              InputFieldTest(hintTextPlaceholder: "B", textFieldController: textFieldController2),
              Text(
                '$_sum',
                style: Theme.of(context).textTheme.headline4,
              ),
              Expanded(
                child: ButtonGrid(
                  cb1: CalculatorButton(buttonTooltip: 'Add', buttonIcon: const Icon(Icons.add), buttonPressed: _add), 
                  cb2: CalculatorButton(buttonTooltip: 'Subtract', buttonIcon: const Icon(Icons.remove), buttonPressed: _subtract), 
                  cb3: CalculatorButton(buttonTooltip: 'Multiply', buttonIcon: const Icon(Icons.trending_up_sharp), buttonPressed: _multiply), 
                  cb4: CalculatorButton(buttonTooltip: 'Divide', buttonIcon: const Icon(Icons.trending_down_sharp), buttonPressed: _divide)
                  ),
                ),
            ],
        ),
      ),
    );
  }
}

class InputFieldTest extends StatefulWidget {
  const InputFieldTest({Key? key, required this.hintTextPlaceholder, required this.textFieldController}) : super(key: key);
  final String hintTextPlaceholder;
  final TextEditingController textFieldController;

  @override
  _InputFieldTestState createState() => _InputFieldTestState();
}

class _InputFieldTestState extends State<InputFieldTest> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
            controller: widget.textFieldController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: widget.hintTextPlaceholder,
            ),
          ),
      ],
    );
  }
}

class CalculatorButton extends StatefulWidget {
  const CalculatorButton({ Key? key, required this.buttonTooltip, required this.buttonIcon, required this.buttonPressed }) : super(key: key);
  final String buttonTooltip;
  final Icon buttonIcon;
  final VoidCallback buttonPressed;

  @override
  _CalculatorButtonState createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FloatingActionButton(
          onPressed: widget.buttonPressed,
          tooltip: widget.buttonTooltip,
          child: widget.buttonIcon,
        ),
      ],
    );
  }
}

class ButtonGrid extends StatelessWidget {
  const ButtonGrid({ Key? key, required this.cb1, required this.cb2, required this.cb3, required this.cb4 }) : super(key: key);
  final CalculatorButton cb1;
  final CalculatorButton cb2;
  final CalculatorButton cb3;
  final CalculatorButton cb4;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: <Widget>[
        cb1, cb2, cb3, cb4,
      ],    
    );
  }
}