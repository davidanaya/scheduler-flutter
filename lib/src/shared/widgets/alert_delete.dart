import 'package:flutter/material.dart';

AlertDialog showAlertDelete(BuildContext context) {
  return AlertDialog(
      title: Text(
        'Delete meal?',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        FlatButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
        FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            })
      ]);
}
