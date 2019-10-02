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
  void createAnAccount() async{
    if(validateandSave()){
      try{
      AuthResult result = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email,password: _password)) ;
      FirebaseUser user = result.user;
      print('Created Account as : ${user}');
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
        title: Text('Sign Up'),
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
                key: passKey,
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
              TextFormField(
                onSaved:(input) => _passwordConfirm= input,
                validator: (input){
                  var password = passKey.currentState.value;
                  return (input == password) ? null : "Confirm Password should match password";
                } ,
                
                decoration: InputDecoration(
                    labelText: 'Confirm Password'
                ),
                obscureText: true,
              ),
              RaisedButton(
                  
                //onPressed: ,
                child: Text('Sign Up'),
                onPressed:createAnAccount,
                
            ),
              FlatButton(
                child: Text('Already have an Account? Sign In'),
                onPressed:(){
                  Navigator.pop(context);
                } 
              )
          ],
        ),
      ),
      ),
    );
  }


}

