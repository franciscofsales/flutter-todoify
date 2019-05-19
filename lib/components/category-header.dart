import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final dynamic category;
  final Color color;
  const CategoryHeader({dynamic category, Color color})
      : this.category = category,
        this.color = color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(right: 15.0, top: 7.5),
                        child: Icon(
                          IconData(category["icon"],
                              fontFamily: 'MaterialIcons'),
                          color: color,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
                      child: Text(
                        category["name"],
                        style: TextStyle(fontSize: 30.0, color: color),
                      ),
                    ),
                  ],
                ),
                Text(
                  "You have ${category["todos"].where((t) => t["status"] == "TODO").toList().length} todos for ${category["name"]}.",
                  style: TextStyle(
                    color: color,
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
