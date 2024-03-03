import 'package:flutter/material.dart';

void SnackbarMessage(context, String _title ){
  final snackBar = SnackBar(
    content: Text(_title),
    backgroundColor: Colors.blue,
    duration: Duration(milliseconds: 3000),
    action: SnackBarAction(
      label: 'Kapat',
      onPressed: () {
        //ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}