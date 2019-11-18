import 'dart:async';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_memo/Setup/Pages/userForm.dart';
import 'package:travel_memo/Setup/Pages/userForm.dart' as prefix0;
import 'package:travel_memo/main.dart';

import 'bottomDrawer.dart';
class Diary extends StatefulWidget {
  const Diary({
      Key key,
      @required this.user
    }) : super(key: key);
    final FirebaseUser user;
  @override
  _DiaryState createState() => _DiaryState();
  }
  
  class _DiaryState extends State<Diary>{
     var travelPlaces = List<Widget>();
     StreamController<int> _events;
      @override
      void initState() {
        getId(); 
        someFunction() async {
            await getData();
            return;
        }
        getData();
        print("okokok got data"); 
        getImagesList();
        _events = new StreamController<int>();
        _events.add(0);   
        super.initState();
      }
        
    final databaseReference = Firestore.instance;
    String _firstName = "user",_lastName = "name" ,email ,_url="http://turboclinic.co.za/wp-content/uploads/2014/02/facebook-avatar.jpg" ;
    var _images;
    var _keysList;
    
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
                    _lastName =  f.data.values.elementAt(4).toString();
                    gender_forSave= f.data.values.elementAt(1).toString();
                    _firstName = f.data.values.elementAt(0).toString();
                    _url = f.data.values.elementAt(3).toString();
                    _images = f.data.values.elementAt(2);
                    _keysList = _images.keys.toList();
                    print(_firstName);
                    print(_lastName);
                    print(gender_forSave);
                    print(_url);
                    print(_keysList);
                  }
            return ;});
          });    
            email = user.email;
            print(user.email);
            return(s);
          });   
        }
     getImagesList(){
          if(_keysList !=null){
                for(var i in _keysList) {
                  travelPlaces.add(_buildImageGrid(_images[i.toString()]));
                  travelPlaces.add(_imgGalleryDetail()); 
                  //return Text("Successfully added images");            
                    };
                };
     }
    
    @override
    Widget build(BuildContext context) {
      getImagesList();
      return new Scaffold(
        body: ListView(
        children: <Widget>[
            Padding(
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              height: 100.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.shade200),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.navigation, color: Colors.blue),
                    iconSize: 50.0,
                    onPressed: () {},
                  ),
                  SizedBox(width: 5.0),
                  Padding(
                    padding: EdgeInsets.only(top: 27.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 4.0),
                        Text(
                          'Create a New Diary',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                            ),
                            SizedBox(height: 4.0),
                        Text(
                            'Add you things here',
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 14.0),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child:UserForm(user: prefix0.user,)));
                      },
                    )
                  ],
                ),
              ),
            ),            
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'YOUR DIARIES',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontFamily: 'Montserrat'),
                ),
                Text(
                  'View',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      fontFamily: 'Montserrat'),
                )
              ],
            ),
          ),
          //getImagesList();
          
          Column(children: travelPlaces,),
          //child : travelPlaces;
          // _buildImageGrid(_images.keys(0)),
            //_imgGalleryDetail(_images.keys(0)),
          ],
        ),
      );
    }
  
  Widget _imgGalleryDetail() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Maui Summer 2018',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 15.0),
              ),
              SizedBox(height: 7.0),
              Row(
                children: <Widget>[
                  Text(
                    'Teresa Soto added 52 Photos',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    Icons.timer,
                    size: 4.0,
                    color: Colors.black,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    '2h ago',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  )
                ],
              )
            ],
          ),
          SizedBox(width: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 10.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  child: Image.asset('assets/images/fav.png'),
                ),
              ),
              SizedBox(width: 7.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  child: Image.asset('assets/images/chatbubble.png'),
                ),
              ),
              SizedBox(width: 7.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 22.0,
                  width: 22.0,
                  child: Image.asset('assets/images/navarrow.png'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildImageGrid(var key) {
    return Padding(
        padding: EdgeInsets.only(top: 25.0, left: 15.0, right: 15.0),
        child: Container(
          height: 225.0,
          child: Row(
            children: <Widget>[
              Container(
                height: 225.0,
                width: MediaQuery.of(context).size.width / 2 + 40.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0)),
                    image: DecorationImage(
                        image: NetworkImage(key[0]),
                        fit: BoxFit.cover)),
              ),
              SizedBox(width: 2.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 111.5,
                    width: MediaQuery.of(context).size.width / 2 - 72.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(key[1]),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    height: 111.5,
                    width: MediaQuery.of(context).size.width / 2 - 72.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15.0)),
                        image: DecorationImage(
                            image: NetworkImage(key[2]),
                            fit: BoxFit.cover)),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}