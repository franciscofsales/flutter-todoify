import 'package:flutter/material.dart';

Widget Input(String validation, bool, String label, String hint, save) {
  return new TextFormField(
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.w200),
      labelText: label,
      labelStyle: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
      border: InputBorder.none,
    ),
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
    obscureText: bool,
    validator: (value) => value.isEmpty ? validation : null,
    onSaved: save,
  );
}
