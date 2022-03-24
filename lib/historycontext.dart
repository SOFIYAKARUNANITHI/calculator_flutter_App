import 'package:flutter/material.dart';

class historycontext extends StatefulWidget {
  final List<String> data;
  historycontext(this.data);

  @override
  State<historycontext> createState() => _historycontextState();
}

class _historycontextState extends State<historycontext> {
  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return Container(
        height: 50,
        child: const Text(
          'No History Availabe',
          style: TextStyle(fontSize: 20, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Container(
        color: Color.fromARGB(255, 252, 252, 252),
        width: double.infinity,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              color: Colors.blueAccent,
              child: ListTile(
                title: Text(
                  widget.data[index],
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
          itemCount: widget.data.length,
        ),
      );
    }
  }
}
