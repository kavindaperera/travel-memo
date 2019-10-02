import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:travel_memo/Setup/Pages/userForm.dart';
import 'package:travel_memo/Setup/signIn.dart';

import 'constants.dart';

class Home extends StatefulWidget {


  const Home({
    Key key,
    @required this.user
  }) : super(key: key);
  final FirebaseUser user;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
            'TravelMemo',
            style: new TextStyle(
                fontFamily:'Billabong',
                fontSize: 50.0)
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
    );
  }

  void choiceAction(String choice){
    print('Working');
    if (choice == Constants.Settings){
      print('Settings');
    }
    else if (choice == Constants.Edit_Profile){
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserForm()),
      );
    }
    else if (choice == Constants.Logout){
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
}

