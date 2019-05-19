import 'package:flutter/material.dart';

class UIProvider {
  Color currentColor = Color.fromRGBO(231, 129, 109, 1.0);

  void setColor(color) {
    currentColor = color;
  }
}
