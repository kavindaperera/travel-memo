import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:travel_memo/Setup/Pages/home.dart';

class UserForm extends StatefulWidget {
  const UserForm({
    Key key,
    @required this.user
  }) : super(key: key);
  final FirebaseUser user;

  @override
  _UserFormState createState() => _UserFormState();
}
final _formKey = GlobalKey<FormState>();
String _firstName, _lastName;
String gender_forSave;
FirebaseUser user;
bool validateandSave(){
    final form = _formKey.currentState;
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


class _UserFormState extends State<UserForm> {
    
  Future<String> getId() async {
     user = await FirebaseAuth.instance.currentUser();
    print("current user: " + user.uid);
    return (user.uid);
  }
  String getStringId() {
    
  }

  final databaseReference = Firestore.instance;
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
                            if(gender==Gender.MALE){
                                gender_forSave = "male";
                            }else{
                              gender_forSave="female";
                            }                            
                            print(gender);
                          },
                        )
                    ),

                    SizedBox(height: 20.0,),
                    Container(
                      width: 250.0,
                      child: FlatButton(
                          onPressed: save,
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



void save(){  
  if (validateandSave()){
    getId().then((s) async {
    print("User ID string:");
      print (s);
      await databaseReference.collection("profiles")
        .document(s)
        .setData({
          'firstName': _firstName,
          'secondName': _lastName,
          'gender' : gender_forSave
        });
      return(s);
    });
    _showDialog("","Successfully Updated");
    print(_firstName);
    print(_lastName);
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
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                /*Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home(user:user)),
                );*/
              },
            ),
            
          ],
        );
      },
    );
  }
}

