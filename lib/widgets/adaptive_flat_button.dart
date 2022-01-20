import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String title;
  final Function buttonHandler;

  AdaptiveFlatButton(this.title, this.buttonHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: buttonHandler,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : FlatButton(
            onPressed: buttonHandler,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            textColor: Theme.of(context).primaryColor,
          );
  }
}
