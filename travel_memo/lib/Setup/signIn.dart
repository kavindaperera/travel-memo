import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'Pages/home.dart';
import 'signUp.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final  formKey = GlobalKey<FormState>();


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
      AuthResult result = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email,password: _password)) ;
      FirebaseUser user = result.user;
      print('Signed in : ${user}');
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user)));
      }
      catch (e){
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
              TextFormField(
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
              TextFormField(
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