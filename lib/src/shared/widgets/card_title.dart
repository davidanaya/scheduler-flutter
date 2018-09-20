import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final Widget child;

  CardTitle({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Color(0xFFc1cedb),
                    width: 1.0,
                    style: BorderStyle.solid))),
        child: child);
  }
}
