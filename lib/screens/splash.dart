import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final int splashDuration = 2;
  String _token;
  bool _checkedUser = false;

  startTime() async {
    return Timer(Duration(seconds: splashDuration), () {
      if (_checkedUser) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        if (_token != null) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      } else {
        startTime();
      }
    });
  }

  loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _checkedUser = true;
      _token = (prefs.getString('authToken') ?? null);
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(children: <Widget>[
          Expanded(child: Container(
            decoration: BoxDecoration(color: Colors.black),
            alignment: FractionalOffset(0.5, 0.3),
            child: Text("todoify",
              style: TextStyle(fontSize: 40.0, color: Colors.white),),),),
          Container(margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
            child: Text("© Copyright FSales 2019",
              style: TextStyle(fontSize: 16.0, color: Colors.white,),),),
        ],)));
  }
}
