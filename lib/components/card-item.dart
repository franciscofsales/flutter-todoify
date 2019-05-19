import 'package:flutter/material.dart';
import 'package:todoify/configs.dart';
import 'package:todoify/screens/category.dart';

class CardItem extends StatelessWidget {
  final int position;
  final List<dynamic> cardsList;

  const CardItem({int position, List<dynamic> cardsList})
      : this.position = position,
        this.cardsList = cardsList;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/category',
              arguments: CategoryScreenArguments(cardsList[position]["_id"]));
        },
        child: Card(
          child: Container(
            width: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        IconData(cardsList[position]["icon"],
                            fontFamily: 'MaterialIcons'),
                        color: appColors[position],
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Text(
                          "${cardsList[position]["tasksRemaining"]} Tasks",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Text(
                          "${cardsList[position]["name"]}",
                          style: TextStyle(fontSize: 28.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(
                          value:
                              cardsList[position]["taskCompletion"].toDouble(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ));
  }
}
