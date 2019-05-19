import 'package:flutter/material.dart';
import 'package:todoify/blocs/ui-bloc.dart';
import 'package:todoify/components/card-item.dart';
import 'package:todoify/configs.dart';
import 'package:todoify/models/card-item-model.dart';

class CardList extends StatefulWidget {
  final List<dynamic> cardsList;
  final Color color;

  const CardList({List<dynamic> cardsList, Color color})
      : this.cardsList = cardsList,
        this.color = color;

  @override
  _CardListState createState() => new _CardListState(cardsList, color);
}

class _CardListState extends State<CardList> with TickerProviderStateMixin {
  var cardIndex = 0;
  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;

  ScrollController scrollController;
  _CardListState(this.cardsList, this.color);

  final List<dynamic> cardsList;
  final Color color;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: this.cardsList.length,
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, position) {
            return GestureDetector(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CardItem(
                    position: position,
                    cardsList: this.cardsList,
                  )),
              onHorizontalDragEnd: (details) {
                animationController = AnimationController(
                    vsync: this, duration: Duration(milliseconds: 200));
                curvedAnimation = CurvedAnimation(
                    parent: animationController, curve: Curves.fastOutSlowIn);
                animationController.addListener(() {
                  uiBloc.setColor(colorTween.evaluate(curvedAnimation));
                });
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  if (cardIndex > 0) {
                    cardIndex--;
                    colorTween = ColorTween(
                        begin: this.color, end: appColors[cardIndex]);
                  }
                } else {
                  if (cardIndex < this.cardsList.length - 1) {
                    cardIndex++;
                    colorTween = ColorTween(
                        begin: this.color, end: appColors[cardIndex]);
                  }
                }
                setState(() {
                  scrollController.animateTo((cardIndex) * 256.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn);
                });

                colorTween.animate(curvedAnimation);

                animationController.forward();
              },
            );
          }),
    );
  }
}
