import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final Function handler;
  final TextInputType textInputType;

  const AdaptiveTextField({
    @required this.title,
    @required this.controller,
    @required this.handler,
    @required this.textInputType
  });
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            placeholder: title,
            controller: controller,
            onSubmitted: (_) => handler(),
            placeholderStyle: TextStyle(color: Theme.of(context).primaryColor),
            keyboardType: textInputType,
          )
        : TextField(
            decoration: InputDecoration(
              labelText: title,
            ),
            controller: controller,
            onSubmitted: (_) => handler(),
            keyboardType: textInputType,
          );
  }
}
