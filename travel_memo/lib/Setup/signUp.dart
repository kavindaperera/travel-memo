import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Pages/home.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user)));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
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
      _showDialogSuccessful("Successful","You have Successfully Registered!",user);  
      _controllerEmail.clear();
      _controllerPass.clear();
      _controllerConfPass.clear();   
      } catch (e){
      _controllerPass.clear();
      _controllerConfPass.clear();
        
        _showDialogError("Error","Email already exist!");  
        print('Error: {$e}');
      
    }
    }
  }
//show messages when done


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
                Text(
                    'Sign Up',
                    style: new TextStyle(
                        fontFamily:'Billabong',
                        fontSize: 60.0)
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
                      return 'Please type an email';
                    }
                    if(!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input)){
                      return "Invalid Email";
                    }
                  } ,
                  onSaved:(input) => _email = input,
                  decoration: InputDecoration(
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
                      return 'Please provide a password with atleast 6 characters';
                    }
                  } ,
                  onSaved:(input) => _password= input,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                    labelText: 'Enter Your Password'
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
                    return (input == password) ? null : "Confirm Password does not match with password";
                  } ,

                  decoration: InputDecoration(
                    border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                    labelText: 'Confirm Password'
                  ),
                  obscureText: true,
                  ),
                ),

                OutlineButton(
                  //onPressed: ,
                  child: Text('Sign Up',textScaleFactor: 1.5,),
                  borderSide: BorderSide(color: Colors.black,width: 3),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                  textColor: Colors.black,
                  onPressed:createAnAccount,

              ),
                FlatButton(
                  child: Text('Already have an Account? Sign In',textScaleFactor: 1.3),
                  onPressed:(){
                    Navigator.pop(context);
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


}

