import 'dart:async';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_memo/Setup/Pages/home.dart';
import 'signUp.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  int _state = 0,_stateGoogle=0;  
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
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginPage()),
                );
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
      setState(() {
        _state = 0;
      });
      }
      catch (e){
        _showDialog("Invalid","Your Email/Password is incorrect");
        _controllerEmail.clear();
        _controllerPass.clear();
        setState(() {
        _state = 0;
      });
        print('Error: {$e}');
      }  
    }
}
final FirebaseAuth _auth = FirebaseAuth.instance;
 GoogleSignIn _googleSignIn = GoogleSignIn();

Future<String> googleSignin() async {
      try{
  final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult result = await _auth.signInWithCredential(credential);
    FirebaseUser user = result.user;
    _email = user.email;
    setState(() {
          _stateGoogle = 0;
        });
    assert(!user.isAnonymous);
    assert(user.displayName != null);
    assert(await user.getIdToken() != null);
    String name = user.displayName;
    print("name got from the google ${name}");
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home(user:user)),
        );
        print('signInWithGoogle succeeded: $_email');
    return 'signInWithGoogle succeeded: $user';
        }
        catch (e){
          //_showDialog("Error","Something went wrong\nPlease try Again");
          setState(() {
          _stateGoogle = 0;
        });
          print('Error: {$e}');
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
                ColorizeAnimatedTextKit(
                           duration: Duration(milliseconds: 5000),
                           isRepeatingAnimation: false,
                            onTap: () {
                              print("Tap Event");
                            },
                            text: [
                              ' TravelMemo',
                            ],
                            textStyle: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Billabong',
                                fontSize: 70.0
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
                child: TextFormField(
                  controller: _controllerEmail,
                  validator: (input){
                    if(input.isEmpty){
                      setState(() {
                        _state = 0;
                        });
                      return 'Please type an email';
                    }
                  } ,
                  onSaved:(input) => _email = input,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white30,

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
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white30,
                  ),
                  obscureText: true,
                  
                ),
               ),
                Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 2.0,
                        ),
                child : MaterialButton(
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
                ),
                Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 15.0,
                        ),
                  child:Text(
                            '-or-',
                          style: new TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold ),
                      ),    
                  ),
                MaterialButton(
                  //onPressed: ,
                  //child: Text('Sign Up',textScaleFactor: 1.5,),
                  //borderSide: BorderSide(color: Colors.black,width: 3),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  textColor: Colors.black,
                  child :setUpButtonChildGoogle(),
                  onPressed: () {
                  setState(() {
                    if (_stateGoogle == 0) {
                      animateButtonGoogle();
                    }
                    
                  });
                },
                elevation: 4.0,
                minWidth: 130.0,
                height: 55.0,
                color: Colors.black,
                ),
                Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 2.0,
                        ),
                child: FlatButton(
                  child: Text('Don\'t have an Account? Sign Up ',textScaleFactor: 1.15,),
                  onPressed:(){
                    
                    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child:SignUpPage()));
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
Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "Sign In",
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
      validateandSubmit();
    });
  }

Widget setUpButtonChildGoogle() {
    if (_stateGoogle == 0) {
      return  Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Sign In with Google",
                style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                  ),
                ),
              ),
            ],
          );
    }
    else if (_stateGoogle == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return new Text(
        "Sign In with Google",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          ),
        );
      };
    }
  void animateButtonGoogle() {
    setState(() {
      _stateGoogle = 1;
    });

    Timer(Duration(milliseconds: 1500), () {
      googleSignin();
    });
    }
  }


     