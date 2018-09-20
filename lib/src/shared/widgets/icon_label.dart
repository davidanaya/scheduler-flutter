import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  IconLabel({this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Icon(
        icon,
        size: 20.0,
        color: Colors.red,
      ),
      Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(label, style: TextStyle(fontSize: 20.0)))
    ]);
  }
}
