import 'package:flutter/material.dart';

class KeyButton extends StatelessWidget {
  final String label;
  final VoidCallback ONTap;
  final double size;

  KeyButton(this.label, this.ONTap, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 67, 67, 67),
                    offset: Offset(2, 2),
                    blurRadius: 5),
              ],
              borderRadius: BorderRadius.all(Radius.circular(size / 2)),
              color: Colors.blueAccent),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(size / 2)),
            ),
            onTap: ONTap,
            child: Center(
                child: Text(
              label,
              style: TextStyle(fontSize: 24, color: Colors.white),
            )),
          ),
        ));
  }
}
