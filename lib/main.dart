import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todoify/helpers/graphql-client.dart';
import 'package:todoify/screens/add-todo.dart';
import 'package:todoify/screens/category.dart';
import 'package:todoify/screens/home.dart';
import 'package:todoify/screens/login.dart';
import 'package:todoify/screens/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GraphQLClientHelper.graphqlClient,
        child: MaterialApp(
          title: 'todoify',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: <String, WidgetBuilder>{
            '/login': (context) => Login(),
            '/home': (context) => Home(),
            '/category': (context) => Category(),
            '/add-todo': (context) => AddTodo(),
          },
          home: Splash(),
        ));
  }
}
