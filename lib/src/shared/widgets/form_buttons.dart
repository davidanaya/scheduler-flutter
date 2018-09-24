import 'dart:async';

import 'package:flutter/material.dart';

import 'package:scheduler_flutter/src/shared/widgets/alert_delete.dart';
import 'package:scheduler_flutter/src/shared/widgets/card-section.dart';

class FormButtons extends StatelessWidget {
  final Function _saveFn;
  final Function _deleteFn;

  FormButtons(this._saveFn, this._deleteFn);

  @override
  Widget build(BuildContext context) {
    return CardSection(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              IconButton(
                onPressed: () {
                  _saveFn(context);
                },
                icon: Icon(Icons.check),
                color: Color(0xFF39a1e7),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
            ]),
            IconButton(
                onPressed: () async {
                  var delete = await _showAlertDelete(context);
                  if (delete) {
                    _deleteFn(context);
                    Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.delete),
                color: Colors.red),
          ]),
      showBottomBorder: false,
    );
  }

  Future<bool> _showAlertDelete(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return showAlertDelete(context);
        });
  }
}
