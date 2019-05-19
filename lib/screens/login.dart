import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoify/graphql/mutations/auth.dart';
import 'package:todoify/components/input.dart';

import '../configs.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;

  final formkey = new GlobalKey<FormState>();
  checkFields() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  LoginUser(context, doAuth) {
    if (checkFields()) {
      doAuth({"email": _email, "password": _password});
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Mutation(
      options: MutationOptions(
        document: authMutation,
      ),
      builder: (
        RunMutation doAuth,
        QueryResult result,
      ) {
        return Scaffold(
          backgroundColor: appColors[0],
          body: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Center(
                      child: Form(
                    key: formkey,
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                          ),
                          Input("required email", false, "Email",
                              'Enter your Email', (value) => _email = value),
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                          ),
                          Input("required password", true, "Password",
                              'Password', (value) => _password = value),
                          new Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: OutlineButton(
                                              child: Text("Login "),
                                              onPressed: () =>
                                                  LoginUser(context, doAuth)),
                                          flex: 1,
                                        ),
                                        SizedBox(
                                          height: 18.0,
                                          width: 18.0,
                                        ),
                                        SizedBox(
                                          height: 18.0,
                                          width: 18.0,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: OutlineButton(
                                              child: Text("signup"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushNamed('/signup');
                                              }),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ),
              ),
            ],
          ),
        );
      },
      // you can update the cache based on results
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      // or do something with the result.data on completion
      onCompleted: (dynamic resultData) async {
        if (resultData != null &&
            resultData["auth"] != null &&
            resultData["auth"]["access"] != null) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setString(
              'authToken', resultData["auth"]["access"]);
          await preferences.setString(
              'refreshToken', resultData["auth"]["refresh"]);
          await preferences.setString('userId', resultData["auth"]["userId"]);
          await preferences.setString(
              'userName', resultData["auth"]["userName"]);
          Route route = MaterialPageRoute(builder: (context) => Home());
          Navigator.pushReplacement(context, route);
        }
      },
    );
  }
}
