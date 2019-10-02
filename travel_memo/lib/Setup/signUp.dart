import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              child: new Text("Continue"),
              onPressed: () {
                Navigator.of(context).pop();
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
      AuthResult user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email,password: _password)) ;
      print('Created Account as : ${user}');
      _showDialog("Successful","You have Successfully Registered!");
      }
      catch (e){
      print('Error: {$e}');
      
    }
    }
  }
//show messages when done


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
                  labelText: 'Enter Your Email'
                ),
              ),
              TextFormField(
                controller: _controllerPass,
                key: passKey,
                validator: (input){
                  if(input.length < 6){
                    return 'Please provide a password with atleast 6 characters';
                  }
                } ,
                onSaved:(input) => _password= input,
                decoration: InputDecoration(
                    labelText: 'Enter Your Password'
                ),
                obscureText: true,
              ),
              TextFormField(
                controller: _controllerConfPass,
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

