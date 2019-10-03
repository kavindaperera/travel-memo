import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_memo/Setup/LoginPages/signIn.dart' as prefix0;
import 'package:travel_memo/Start.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => prefix0.LoginPage(),
  "/intro": (BuildContext context) => StartPage(),
};

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Memo',
      theme:  ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.black87
      ),
      home:  StartPage(),
      routes: routes
    );
  }
}





