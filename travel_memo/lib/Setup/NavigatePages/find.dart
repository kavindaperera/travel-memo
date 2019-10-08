
import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}


class _FindPageState extends State<FindPage> {

@override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: new AppBar(
        backgroundColor: Color(0xFF000000),
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
     );
  }
}