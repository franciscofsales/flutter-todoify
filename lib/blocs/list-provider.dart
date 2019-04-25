import 'package:flutter/material.dart';
import 'package:todoify/models/card-item-model.dart';

class ListProvider {
  List<CardItemModel> list = [
    CardItemModel("Personal", Icons.account_circle, 9, 0.83),
    CardItemModel("Work", Icons.work, 12, 0.24),
    CardItemModel("Home", Icons.home, 8, 0.32)
  ];

  Color currentColor = Color.fromRGBO(231, 129, 109, 1.0);

  void push(data) {
    data.add(CardItemModel(data.title, data.icon, data.todos, data.percentage));
  }

  void setColor(color) {
    currentColor = color;
  }
}
