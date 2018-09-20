import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function fn;
  final String text;

  ActionButton({this.text, this.fn});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: fn,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        color: Color(0xFF97c747),
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontWeight: FontWeight.w600)));
  }
}
