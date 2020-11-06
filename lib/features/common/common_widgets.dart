import 'package:flutter/material.dart';

void textSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: 4),
          content: Text(message)
      )
  );
}