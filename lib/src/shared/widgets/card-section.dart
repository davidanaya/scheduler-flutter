import 'package:flutter/material.dart';

class CardSection extends StatelessWidget {
  final Widget child;
  final bool showBottomBorder;

  CardSection({this.child, this.showBottomBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: showBottomBorder
                ? Border(
                    bottom: BorderSide(
                        color: Color(0xFFc1cedb),
                        width: 1.0,
                        style: BorderStyle.solid))
                : null),
        child: child);
  }
}
