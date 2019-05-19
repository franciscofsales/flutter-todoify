import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todoify/blocs/ui-bloc.dart';
import 'package:todoify/blocs/ui-provider.dart';
import 'package:todoify/components/card-list.dart';
import 'package:todoify/components/welcome.dart';
import 'package:todoify/graphql/queries/categories.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: uiBloc.getData,
        initialData: [UIProvider().currentColor],
        builder: (context, snapshot) {
          if (!snapshot.hasData == null) {
            return CircularProgressIndicator();
          }
          return Query(
            options: QueryOptions(
              document: categoriesQuery,
              pollInterval: 10,
            ),
            builder: (QueryResult result, {VoidCallback refetch}) {
              if(result.errors != null) {
                print(result.errors);
              }
              if (result.errors != null || result.loading) {
                return CircularProgressIndicator();
              }
              return Scaffold(
                backgroundColor: snapshot.data[0],
                appBar: new AppBar(
                  title: new Text(
                    "todoify",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  backgroundColor: snapshot.data[0],
                  centerTitle: true,
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Icon(Icons.search),
                    ),
                  ],
                  elevation: 0.0,
                ),
//                drawer: Drawer(),
                body: new Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Welcome(),
                      CardList(
                          cardsList: result.data["categories"],
                          color: snapshot.data[0]),
                    ])),
              );
            },
          );
        });
  }
}
