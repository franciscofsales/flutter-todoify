import 'package:flutter/material.dart';
import 'package:todoify/blocs/list-bloc.dart';
import 'package:todoify/blocs/list-provider.dart';
import 'package:todoify/components/card-list.dart';
import 'package:todoify/components/welcome.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    listBloc.dispose(); // call the dispose method to close our StreamController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: listBloc.getData,
      // pass our Stream getter here
      initialData: [ListProvider().list, ListProvider().currentColor],
      builder: (context, snapshot) {
        if (!snapshot.hasData == null) {
          return CircularProgressIndicator();
        }
        return Scaffold(
          backgroundColor: snapshot.data[1],
          appBar: new AppBar(
            title: new Text(
              "TODO",
              style: TextStyle(fontSize: 16.0),
            ),
            backgroundColor: snapshot.data[1],
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.search),
              ),
            ],
            elevation: 0.0,
          ),
          drawer: Drawer(),
          body: new Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Welcome(cardsList: snapshot.data[0]),
                CardList(cardsList: snapshot.data[0], color: snapshot.data[1])
              ])),
        );
      },
    );
  }
}
