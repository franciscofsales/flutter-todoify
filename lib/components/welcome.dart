import 'package:flutter/material.dart';
import 'package:todoify/models/card-item-model.dart';

class Welcome extends StatelessWidget {
  final List<CardItemModel> cardsList;
  const Welcome({List<CardItemModel> cardsList}) : this.cardsList = cardsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: Icon(
                    Icons.account_circle,
                    size: 45.0,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
                  child: Text(
                    "Hello, Francisco.",
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                ),
                Text(
                  "You have ${cardsList.length} tasks to do today.",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
