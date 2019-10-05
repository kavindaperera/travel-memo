import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_memo/Setup/Pages/userForm.dart';
import 'package:travel_memo/Setup/Loginpages/signIn.dart';
import 'package:travel_memo/Setup/Pages/userForm.dart' as prefix0;
import 'package:travel_memo/Start.dart';
import 'constants.dart';
import 'package:carousel_pro/carousel_pro.dart';

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
  String _firstName = "user",_lastName = "name" ,email ,_url="http://turboclinic.co.za/wp-content/uploads/2014/02/facebook-avatar.jpg" ;
  final databaseReference = Firestore.instance;

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
  void getData(){
      getId().then((s) async {
      print("User ID string:");
      print (s);
      var user = await FirebaseAuth.instance.currentUser();
      //var userQuery = Firestore.instance.collection('profiles').document(s);
      databaseReference
        .collection("profiles")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        if(f.documentID==s){
          print('DATA CHECK');
          _lastName =  "${f.data.values.elementAt(0)}";
          gender_forSave= "${f.data.values.elementAt(2)}";
          _firstName = "${f.data.values.elementAt(1)}";
          _url = "${f.data.values.elementAt(3)}";
          print(_firstName);
          print(_lastName);
          print(gender_forSave);
          print(_url);
        }
        return ;});
    });    
      email = user.email;
      print(user.email);
      return(s);
    });
    
    
      }
 
  @override
  Widget build(BuildContext context) {
    getId();
    //getStringId();
    print('getId()');

    getData();
    print('getData()');

    return new Scaffold(
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
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text(_firstName + " " + _lastName??'default value'),
              accountEmail: Text(email??'default value'),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  print ('Avatar');
                },
                child: new CircleAvatar(
                  radius: 100,
                  backgroundColor: Color(0xFFFFFFFF),
                  child: ClipOval(
                    child: SizedBox(
                      width: 180.0,
                      height: 180.0,
                      child:FittedBox(
                        child: Image.network(
                          _url,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ) ,
              decoration: new BoxDecoration(
                color: Colors.black
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).pop();
                Home(user:user);
              },
              child: ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserForm()),
                );
              },
              child: ListTile(
                title: Text('Edit Profile'),
                leading: Icon(Icons.person),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).pop();
                signOut();
                //avigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child:StartPage()));
                Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => StartPage()),
                ModalRoute.withName('/'),
                );
              },
              child: ListTile(
                title: Text('Log Out'),
                leading: Icon(Icons.settings_backup_restore),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 150.0,
          width: 300.0,
          child: Carousel(
            boxFit: BoxFit.cover,
            autoplay: false,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 1000),
            dotSize: 6.0,
            dotIncreasedColor: Color(0xFFFF335C),
            dotBgColor: Colors.transparent,
            dotPosition: DotPosition.bottomCenter,
            dotVerticalPadding: 10.0,
            showIndicator: true,
            indicatorBgPadding: 7.0,
            images: [
              NetworkImage('https://thesoutheastern.com/wp-content/uploads/2018/08/underconstruction-900x472.jpg'),
              NetworkImage('https://i.pinimg.com/originals/f8/2c/28/f82c289b884966192493cad018b0f186.jpg'),
              NetworkImage('https://s1.1zoom.me/b5050/527/Sri_Lanka_Fields_Nuwara_Eliya_Trees_513491_1920x1080.jpg'),
              NetworkImage('http://dfizz.com/dfizz/public/uploads/banner1-i2cdjbanner1-05giibeautiful-resort-sri-lanka-wallpapers-1920x1080.jpg'),
            ],
          ),
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

 Future<void> signOut() async {
   GoogleSignIn _googleSignIn = GoogleSignIn();
   try{
    //create an instance you your firebase auth.
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    _googleSignIn.signOut();
    //return this future to the place you called it.
    return await FirebaseAuth.instance.signOut();{
      print("SignOut Done");
    }
   }
    catch(error) {
      print("error in signout $error");
    }
  }
}

  