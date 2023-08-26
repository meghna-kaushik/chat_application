import 'package:flutter/material.dart';

class Logreg extends StatelessWidget {
  Logreg(this.col, this.name, this.fun);
  final Color col;
  final String name;
  final void Function() fun;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: col,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: fun,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            name,
          ),
        ),
      ),
    );
  }
}
