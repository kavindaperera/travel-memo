import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {


  const Home({
    Key key,
    @required this.user
  }) : super(key: key);
  final FirebaseUser user;
  @override
  _HomeState createState() => _HomeState();
  }
  
  class _HomeState extends State<Home>{
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
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
    
}