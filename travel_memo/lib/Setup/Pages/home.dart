import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_memo/Setup/Pages/userForm.dart';
import 'package:travel_memo/Setup/Loginpages/signIn.dart';
import 'package:travel_memo/Start.dart';
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
  String getStringId() {
    getId().then((s) {
      print (s);
      return(s);
    });
  }

  @override
  Widget build(BuildContext context) {
    getId();
    getStringId();
    return new Scaffold(
      appBar: new AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
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
        automaticallyImplyLeading: true,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.search),
            onPressed: (){},
          ),
          /*PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )*/
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text('Username'),
              accountEmail: Text('user@travelmemo.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black,),
                ) ,
              ) ,
              decoration: new BoxDecoration(
                color: Colors.blue
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child:Home(user: null)));
              },
              child: ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child:UserForm()));
              },
              child: ListTile(
                title: Text('Edit Profile'),
                leading: Icon(Icons.person),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child:StartPage()));
              },
              child: ListTile(
                title: Text('Log Out'),
                leading: Icon(Icons.settings_backup_restore),
              ),
            ),
          ],
        ),
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

  /*void choiceAction(String choice) {
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
        context, MaterialPageRoute(builder: (context) => StartPage()),
      );
    }
  }*/


  final middleSection = new Container(
    //alignment: Alignment.center,
    child: new Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.network(
            'https://lonelyplanetimages.imgix.net/mastheads/GettyImages-550859245_full.jpg?sharp=10&vib=20&w=1200',
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