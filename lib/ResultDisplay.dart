import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final String text;

  int result = 0;
  ResultDisplay(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 100,
        color: Colors.black,
        child: Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right: 20),
            child: Text(
              text,
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 34),
            )));
  }
}
