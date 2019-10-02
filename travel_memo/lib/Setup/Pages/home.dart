import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Home extends StatefulWidget {


  const Home({
    Key key,
    @required this.user
  }) : super(key: key);
  final FirebaseUser user;
  @override
  _HomeState createState() => _HomeState();
}
  final _formKey = GlobalKey<FormState>();
  String _firstName, _lastName;

_save(){
    if (_formKey.currentState.validate()){
      _formKey.currentState.save();
      print(_firstName);
      print(_lastName);
  }
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  'TravelMemo',
                  style: new TextStyle(
                      fontFamily:'Billabong',
                      fontSize: 50.0)
              ),
              Form(
                key: _formKey,
                child: Column(mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'First Name'),
                        validator:(input) => input.trim().isEmpty ? "Please enter valid name" : null,
                        onSaved: (input) => _firstName = input,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Last Name'),
                        validator:(input) => input.trim().isEmpty ? "Please enter valid name" : null,
                        onSaved: (input) => _lastName = input,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: GenderSelector(
                        onChanged: (gender){
                          print(gender);
                        },
                      )
                    ),

                    SizedBox(height: 20.0,),
                    Container(
                      width: 250.0,
                      child: FlatButton(
                          onPressed: _save,
                          color: Colors.blue,
                          padding: EdgeInsets.all(10.0),
                          child: Text('Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          )
                      ),
                    ),
                  ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
