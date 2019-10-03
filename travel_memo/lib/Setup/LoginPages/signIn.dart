import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_memo/Setup/Pages/home.dart';
import 'signUp.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final  formKey = GlobalKey<FormState>();
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPass = new TextEditingController();

  void _showDialog(String messageTitle,String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(messageTitle),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                LoginPage();
              },
            ),
            
          ],
        );
      },
    );
  }

  bool validateandSave(){
    final form = formKey.currentState;
    if(form.validate()){
      print('Form is valid');
      form.save();
      return true;
    }
    else{
      print('Form is invalid');
      
      return false;
    }
}

  void validateandSubmit() async {
    if(validateandSave()){
      try{
      AuthResult result = (await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.trim(),
          password: _password.toString().trim())) ;
      FirebaseUser user = result.user;
      print('Signed in : ${user}');
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => Home(user:user)),
      );
      _controllerEmail.clear();
      _controllerPass.clear();
      }
      catch (e){
        _showDialog("Invalid","Your Email/Password is incorrect");
        _controllerEmail.clear();
        _controllerPass.clear();
        print('Error: {$e}');
      }
    }
    
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/new.png"),
            fit: BoxFit.cover,
          ),
        ),
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.only(top: 16),
        //padding: EdgeInsets.all(16.0),

        child: new Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.only(top: 16),
        alignment: Alignment.center,
        child: new Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                    'TravelMemo',
                    style: new TextStyle(
                        fontFamily:'Billabong',
                        fontSize: 60.0)
                ),
                 Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 15.0,
                        ),
                child: TextFormField(
                  controller: _controllerEmail,
                  validator: (input){
                    if(input.isEmpty){
                      return 'Please type an email';
                    }
                  } ,
                  onSaved:(input) => _email = input,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                    labelText: 'Email'
                  ),
                ),
                 ),
               Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 10.0,
                        ),
                child: TextFormField(

                  controller: _controllerPass,
                  validator: (input){
                    if(input.length < 6){
                      return 'Please provide a password with atleast 6 characters';
                    }
                  } ,
                  onSaved:(input) => _password= input,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                      labelText: 'Password'
                  ),
                  obscureText: true,
                ),
               ),
                Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 2.0,
                        ),
                child : OutlineButton(
                  onPressed: validateandSubmit,
                  child: Text('Sign In',textScaleFactor: 1.5,),
                  borderSide: BorderSide(color: Colors.black,width: 3),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                  textColor: Colors.black,
                  color: Colors.lightBlue[50],
                  ),
                ),
                Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 2.0,
                        ),
                child: FlatButton(
                  child: Text('Don\'t have an Account? Sign Up ',textScaleFactor: 1.15,),
                  onPressed:(){
                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child:SignUpPage()));
                    }
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  }

}