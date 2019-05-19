import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoify/graphql/queries/dailyTodos.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String _name = '';

  @override
  void initState() {
    super.initState();
    this._loadUserName();
  }

  _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = (prefs.getString('userName') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: dailyTodosQuery,
          pollInterval: 10,
        ),
        builder: (QueryResult result, {VoidCallback refetch}) {
          if (result.errors != null || result.loading) {
            return CircularProgressIndicator();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 32.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 1.0, right: 30.0),
                            child: Icon(
                              Icons.account_circle,
                              size: 45.0,
                              color: Colors.white,
                            ),
                          ),
                          MaterialButton(
                            highlightColor: Colors.white,
                            splashColor: Colors.white,
                            textColor: Colors.white,
                            highlightElevation: 1.0,
                            onPressed: () {
                              Navigator.pushNamed(context, '/add-todo');
                            },
                            child: Icon(Icons.add),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
                        child: Text(
                          "Hello, $_name.",
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                        ),
                      ),
                      Text(
                        "You have ${result.data['dailyTodos'].length} tasks to do today.",
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
        });
  }
}
