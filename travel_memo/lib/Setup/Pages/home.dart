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


  Future<String> getId() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print (user.uid);
    return (user.uid);
  }

    @override
  Widget build(BuildContext context) {
    getId();
    return new Scaffold(
      body: new Container(
        //alignment: Alignment.center,
        padding: EdgeInsets.only(top: 27),
        child: new Row(
          children: <Widget>[
            leftSection,
            middleSection,
            rightSection
            ],
          ),         
      ),
    );
  }
}
  void choiceAction(String choice,BuildContext context){
    print('Working');
    if (choice == Constants.Settings){
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserForm()),
      );
    }
    else if (choice == Constants.Profile){
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserForm()),
      );
    }
    else if (choice == Constants.Logout){
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

final middleSection = new Container(
  //alignment: Alignment.center,
  child: new Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 37.0,
                        vertical: 15.0,
                      ),
            child:Text(
            'TravelMemo',
            style: new TextStyle(
                fontFamily:'Billabong',
                fontSize: 30.0),
            ),
          ),
        ],
      ),
    );
final rightSection = new Container(
  child: new Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 31.0,
                        vertical: 10.0,
                      ),
            child: PopupMenuButton<String>(
            //onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ],          
        ),
    );
final leftSection = new Container(

  child: new Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 15.0,
                      ),
              child:Text(
                'icon',
                style: new TextStyle(
                  fontFamily:'Billabong',
                  fontSize: 30.0),
            ),
          ),
        ],
      ),
    );