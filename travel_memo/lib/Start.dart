import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:travel_memo/Setup/LoginPages/signIn.dart' as prefix0;
import 'package:travel_memo/Setup/Loginpages/signIn.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  @override
  _startPageState createState() => _startPageState();
}

class _startPageState extends State<StartPage> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }  
  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() {
   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child: prefix0.LoginPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/start.png"),
              fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          'TravelMemo',
                          style: new TextStyle(
                            color: Colors.black87,
                            fontFamily:'Billabong',
                            fontSize: 70.0)
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(backgroundColor: Colors.white10,),
                   // Padding(padding: EdgeInsets.only(top:10.0),)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
