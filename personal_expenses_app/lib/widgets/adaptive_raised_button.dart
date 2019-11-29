import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveRaisedButton extends StatelessWidget {
  final String title;
  final Function handler;

  const AdaptiveRaisedButton({
    @required this.title,
    @required this.handler,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            padding: const EdgeInsets.all(10),
            onPressed: handler,
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).textTheme.button.color,
              ),
            ),
            color: Theme.of(context).primaryColor,
          )
        : RaisedButton(
            child: Text(title),
            color: Theme.of(context).primaryColor,
            onPressed: handler,
            textColor: Theme.of(context).textTheme.button.color,
          );
  }
}
