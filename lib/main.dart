import 'package:calculator/historycontext.dart';
import 'package:flutter/material.dart';
import './ResultDisplay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './keybutton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  List<String>? shared = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  onPressed: () => deleteHistory(),
                  icon: Icon(Icons.delete_forever_rounded)),
              IconButton(
                  onPressed: () => gethistory(context),
                  icon: Icon(Icons.history))
            ],
            title: const Text('Calculator'),
            backgroundColor: Color.fromARGB(255, 69, 97, 255),
          ),
          body: Calci()),
    );
  }

  void gethistory(BuildContext ctx) {
    loadData();
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(child: historycontext(shared!));
        });
  }

  loadData() async {
    final data = await SharedPreferences.getInstance();
    if (data.getStringList('history') == null) {
      return;
    }
    shared = data.getStringList('history');
    return shared;
  }

  deleteHistory() async {
    final data = await SharedPreferences.getInstance();
    if (data.getStringList('history') == null) {
      return;
    }
    shared = [];
    data.remove('history');
  }
}

class Calci extends StatefulWidget {
  @override
  _Calci createState() => _Calci();
}

class _Calci extends State<Calci> {
  final prefs = SharedPreferences.getInstance();
  dynamic? result;
  dynamic? firstOperand;
  dynamic? operator;
  dynamic? secondOperand;
  List<String> _shared = [];

  Widget _getButton(String text, dynamic onTap, double size) {
    return KeyButton(text, onTap, size);
  }

  numberPressed(int number) {
    setState(() {
      if (result != null) {
        result = null;
        firstOperand = number;
        return;
      }
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }
      if (operator == null) {
        firstOperand = int.parse('$firstOperand$number');
        return;
      }
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }
      secondOperand = int.parse('$secondOperand$number');
    });
  }

  operatorPressed(String operator) {
    setState(() {
      this.operator = operator;
    });
  }

  calculate() async {
    final prefs = await SharedPreferences.getInstance();

    if (operator == null) {
      return;
    }
    if (secondOperand == null) {
      return;
    }
    setState(() {
      switch (operator) {
        case '+':
          result = firstOperand + secondOperand;
          break;
        case '-':
          result = firstOperand - secondOperand;
          break;
        case '*':
          result = firstOperand * secondOperand;
          break;
        case '/':
          result = firstOperand ~/ secondOperand;
          break;
      }

      var text = '$firstOperand$operator$secondOperand=$result';

      if (prefs.getStringList('history') == null) {
        _shared.add(text);
        prefs.setStringList('history', _shared);
        _shared = [];
      } else {
        _shared = prefs.getStringList('history')!;
        _shared.add(text);
        prefs.setStringList('history', _shared);
        _shared = [];
      }

      firstOperand = result;
      operator = null;
      secondOperand = null;
      result = null;
    });
  }

  delete() {
    setState(() {
      if (secondOperand != null) {
        String secondOperand_tmp = '$secondOperand';
        secondOperand_tmp =
            secondOperand_tmp.substring(0, secondOperand_tmp.length - 1);
        secondOperand_tmp.length == 0
            ? secondOperand = null
            : secondOperand = int.parse(secondOperand_tmp);
        return;
      }
      if (operator != null) {
        operator = null;
        return;
      }
      if (firstOperand != null) {
        String firstOperand_tmp = '$firstOperand';
        firstOperand_tmp =
            firstOperand_tmp.substring(0, firstOperand_tmp.length - 1);
        firstOperand_tmp.length == 0
            ? firstOperand = null
            : firstOperand = int.parse(firstOperand_tmp);
        return;
      }
      return;
    });
  }

  clear() {
    setState(() {
      result = null;
      operator = null;
      secondOperand = null;
      firstOperand = null;
    });
  }

  String _getDisplayText() {
    if (result != null) {
      return '$result';
    }

    if (secondOperand != null) {
      return '$firstOperand$operator$secondOperand';
    }

    if (operator != null) {
      return '$firstOperand$operator';
    }

    if (firstOperand != null) {
      return '$firstOperand';
    }

    return '0';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            //   height: 10,
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.backspace),
              onPressed: () => delete(),
            ),
          ),
          ResultDisplay(
            _getDisplayText(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _getButton('1', () => numberPressed(1),
                  MediaQuery.of(context).size.width / 5),
              _getButton('2', () => numberPressed(2),
                  MediaQuery.of(context).size.width / 5),
              _getButton('3', () => numberPressed(3),
                  MediaQuery.of(context).size.width / 5),
              _getButton('+', () => operatorPressed('+'),
                  MediaQuery.of(context).size.width / 5),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _getButton('4', () => numberPressed(4),
                  MediaQuery.of(context).size.width / 5),
              _getButton('5', () => numberPressed(5),
                  MediaQuery.of(context).size.width / 5),
              _getButton('6', () => numberPressed(6),
                  MediaQuery.of(context).size.width / 5),
              _getButton(' -', () => operatorPressed('-'),
                  MediaQuery.of(context).size.width / 5),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _getButton('7', () => numberPressed(7),
                  MediaQuery.of(context).size.width / 5),
              _getButton('8', () => numberPressed(8),
                  MediaQuery.of(context).size.width / 5),
              _getButton('9', () => numberPressed(9),
                  MediaQuery.of(context).size.width / 5),
              _getButton('*', () => operatorPressed('*'),
                  MediaQuery.of(context).size.width / 5),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _getButton('=', () => calculate(),
                  MediaQuery.of(context).size.width / 5),
              _getButton('0', () => numberPressed(0),
                  MediaQuery.of(context).size.width / 5),
              _getButton(
                  'C', () => clear(), MediaQuery.of(context).size.width / 5),
              _getButton('/', () => operatorPressed('/'),
                  MediaQuery.of(context).size.width / 5),
            ],
          ),
        ],
      ),
    );
  }
}
