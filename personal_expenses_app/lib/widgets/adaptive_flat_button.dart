import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String title;
  final Function handler;

  const AdaptiveFlatButton({@required this.title, @required this.handler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
                          ? CupertinoButton(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: handler,
                            )
                          : FlatButton(
                              textColor: Theme.of(context).primaryColor,
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: handler,
                            );
  }
}