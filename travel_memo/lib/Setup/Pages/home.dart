import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:travel_memo/Setup/Pages/userForm.dart';
import 'package:travel_memo/Setup/Loginpages/signIn.dart';
import 'constants.dart';
import 'package:flutter_mobile_carousel/carousel.dart';
import 'package:flutter_mobile_carousel/carousel_arrow.dart';
import 'package:flutter_mobile_carousel/default_carousel_item.dart';
import 'package:flutter_mobile_carousel/types.dart';

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
    print("current user: " + user.uid);
    return (user.uid);
  }

  @override
  Widget build(BuildContext context) {
    getId();
    return new Scaffold(
      appBar: new AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.pin_drop),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: new Text(
            'TravelMemo',
            style: new TextStyle(
                fontFamily:'Billabong',
                fontSize: 25.0,),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.search),
            onPressed: (){},
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            new Carousel(
                rowCount: 3,
                children: [
                  'Item 1',
                  'Item 2',
                  'Item 3',
                  'Item 4',
                  'Item 5',
                  'Item 6',
                ].map((String itemText) {
                  return DefaultCarouselItem(itemText);
                }).toList()
            ),
            new Container(
              padding: EdgeInsets.only(top: 25),
              child: new Row(
                children: <Widget>[
                  Expanded (
                      child: leftSection),
                  Expanded (
                      child: middleSection),
                  Expanded (
                      child: rightSection)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    print('Working');
    if (choice == Constants.Settings) {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserForm()),
      );
    }
    else if (choice == Constants.Profile) {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserForm()),
      );
    }
    else if (choice == Constants.Logout) {
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()),
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
          padding: const EdgeInsets.all(10.0),
          child: Image.network(
            'https://picsum.photos/250?image=9',
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
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'TravelMemo',
            style: new TextStyle(
              fontFamily:'Billabong',
              fontSize: 25.0,),
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
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'TravelMemo',
            style: new TextStyle(
              fontFamily:'Billabong',
              fontSize: 25.0,),
          ),
        ),
      ],
    ),
  );
}