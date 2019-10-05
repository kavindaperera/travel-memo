import 'dart:async';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_memo/Setup/LoginPages/signIn.dart';
import 'package:travel_memo/Setup/Pages/home.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _state = 0;  
  String _email, _password ,_passwordConfirm;
  final  formKey = GlobalKey<FormState>();
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPass = new TextEditingController();
  TextEditingController _controllerConfPass = new TextEditingController();

  var passKey = GlobalKey<FormFieldState>();
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

  void _showDialogSuccessful(String messageTitle,String message,FirebaseUser user) {
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
              child: new Text("Continue"),
              onPressed: () {
                Navigator.of(context).pop();
               Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home(user:user)),
                  );
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user)));
                ///Navigator.pop(context);
                /////////////////////////////////////////
                ///navigate to the home screen ******
                ///funciton call here
              },
            ),
          ],
        );
      },
    );
  }
  void _showDialogError(String messageTitle,String message) {
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
                //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                ///Navigator.pop(context);
                /////////////////////////////////////////
                ///navigate to the home screen ******
                ///funciton call here
              },
            ),
          ],
        );
      },
    );
  }
  void createAnAccount() async{
    if(validateandSave()){
      try{
      AuthResult result = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email,password: _password)) ;
      FirebaseUser user = result.user;
      print('Created Account as : ${user}');
      setState(() {
        _state = 0;
      });
      _showDialogSuccessful("Successful","You have Successfully Registered!",user);  
      _controllerEmail.clear();
      _controllerPass.clear();
      _controllerConfPass.clear();   
      } catch (e){
      _controllerPass.clear();
      _controllerConfPass.clear();
        setState(() {
        _state = 0;
      });
        _showDialogError("Error","Account already exist");  
        print('Error: {$e}');
      
    }
    }
  }
  



  @override
  Widget build(BuildContext context) {
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
                ColorizeAnimatedTextKit(
                           duration: Duration(milliseconds: 5000),
                           isRepeatingAnimation: false,
                            onTap: () {
                              print("Tap Event");
                            },
                            text: [
                              ' Sign Up',
                            ],
                            textStyle: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Billabong',
                                fontSize: 65.0
                            ),
                            colors: [
                              Colors.red,
                              Colors.purple,
                              Colors.blue,
                          
                            ],
                            //textAlign: TextAlign.start,
                            //alignment: AlignmentDirectional
                                //.topStart // or Alignment.topLeft
                        ),
                Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 15.0,
                        ),
                child : TextFormField(
                  controller: _controllerEmail,
                  validator: (input){
                    if(input.isEmpty){
                      setState(() {
                          _state = 0;
                      });
                      return 'Please type an email';
                    }
                    if(!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input)){
                      setState(() {
                          _state = 0;
                      });
                      return "Invalid Email";
                    }
                  } ,
                  onSaved:(input) => _email = input,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white30,
                    labelText: 'Enter Your Email',
                    border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
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
                  key: passKey,
                  validator: (input){
                    if(input.length < 6){
                      setState(() {
                         _state = 0;
                      });
                      return 'Please provide a password with atleast 6 characters';
                    }
                  } ,
                  onSaved:(input) => _password= input,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                    labelText: 'Enter Your Password',
                    filled: true,
                    fillColor: Colors.white30,
                  ),
                  obscureText: true,
                  ),
                ),
                Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 15.0,
                        ),
                  child: TextFormField(
                  controller: _controllerConfPass,
                  onSaved:(input) => _passwordConfirm= input,
                  validator: (input){
                    var password = passKey.currentState.value;
                    setState(() {
                      _state = 0;
                    });
                    return (input == password) ? null : "Confirm Password does not match with password";
                  } ,

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white30,
                    border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                    labelText: 'Confirm Password'
                  ),
                  obscureText: true,
                  ),
                ),

                MaterialButton(
                  //onPressed: ,
                  //child: Text('Sign Up',textScaleFactor: 1.5,),
                  //borderSide: BorderSide(color: Colors.black,width: 3),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  textColor: Colors.black,
                  child :setUpButtonChild(),
                  onPressed: () {
                  setState(() {
                    if (_state == 0) {
                      animateButton();
                    }
                    
                  });
                },
                elevation: 4.0,
                minWidth: 150.0,
                height: 48.0,
                color: Colors.black,
                ),
                 
                FlatButton(
                  child: Text('Already have an Account? Sign In',textScaleFactor: 1.15),
                  onPressed:(){
                    _controllerEmail.clear();
                    _controllerPass.clear();
                    _controllerConfPass.clear();  
                    Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "Sign Up",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return new Text(
        "Sign Up",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 1000), () {
      createAnAccount();
    });
    
  }

}

