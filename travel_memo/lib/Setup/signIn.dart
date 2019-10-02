import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
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
      AuthResult user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email,password: _password)) ;
      print('Signed in : ${user}');
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              new TextFormField(
                controller: _controllerEmail,
                validator: (input){
                  if(input.isEmpty){
                    return 'Please type an email';
                  }
                } ,
                onSaved:(input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email'
                ),
              ),
              new TextFormField(
                controller: _controllerPass,
                validator: (input){
                  if(input.length < 6){
                    return 'Please provide a password with atleast 6 characters';
                  }
                } ,
                onSaved:(input) => _password= input,
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
                obscureText: true,
              ),
              RaisedButton(
                onPressed: validateandSubmit,
                child: Text('Sign In'),
            ),
              FlatButton(
                child: Text('Create an Account'),
                onPressed:(){
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                } 
              )
          ],
        ),
      ),
    ),
  );
  }

  List<Widget> buildInputs(){

  }
}