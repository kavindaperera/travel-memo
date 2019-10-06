import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:gender_selector/gender_selector.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:travel_memo/Setup/Pages/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;


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
int _state = 0;
String _firstName, _lastName;
String gender_forSave = 'Rather not mention';
String _url = "http://turboclinic.co.za/wp-content/uploads/2014/02/facebook-avatar.jpg";
FirebaseUser user;
enum ConfirmAction { CANCEL, ACCEPT }


class _UserFormState extends State<UserForm> {


  Future<String> getId() async {
     user = await FirebaseAuth.instance.currentUser();
    print("current user: " + user.uid);
    return (user.uid);
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    Timer(Duration(milliseconds: 2000), () {



    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Make Profile Picture?'),
          //content: const Text(
              //'This will reset your device to its default factory settings.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('ACCEPT'),
              onPressed: () {
                uploadPic(context);
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
    });
  }

  String getStringId() {
    
  }

  File _profilePicture;


  final databaseReference = Firestore.instance;
  @override
  Widget build(BuildContext context) {

    Future getImage() async{
      var profilePicture = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _profilePicture = profilePicture;
        print('Image Path $_profilePicture');
      });
    }



    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
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
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Color(0xFF000000),
                            child: ClipOval(
                              child: SizedBox(
                                width: 180.0,
                                height: 180.0,
                                child:FittedBox(
                                  child: (_profilePicture!=null)?Image.file(_profilePicture, fit: BoxFit.fill)
                                  :Image.network(
                                    _url,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 60.0),
                          child: IconButton(
                              icon: const Icon(
                                  Icons.camera_alt
                              ),
                            onPressed: (){
                                getImage();
                                _asyncConfirmDialog(context);

                            },
                          ),
                        ),
                      ],
                    ),
                    /*MaterialButton(
                      color: Colors.grey[400],
                      onPressed: (){
                        uploadPic(context);
                      },
                      child: Text(
                        'Upload',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white
                        ),
                      ),
                    ),*/
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'First Name'),
                        validator:(input){
                          if(input.trim().isEmpty){
                            setState(() {
                              _state = 0;
                            });
                            return "Please enter valid name";
                          }
                        },
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
                        validator:(input){
                      if(input.trim().isEmpty){
                      setState(() {
                      _state = 0;
                      });
                      return "Please enter valid name";
                      }
                      },
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
                      child: /*FlatButton(
                          onPressed: save,
                          color: Colors.blue,
                          padding: EdgeInsets.all(10.0),
                          child: Text('Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          )
                      ),*/
                      /*RaisedButton(
                        color: Color(0xff476cfb),
                        onPressed: () {
                          uploadPic(context);
                          save();
                        },

                        elevation: 4.0,
                        splashColor: Colors.blueGrey,
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),*/
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
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "Submit",
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
        "Submit",
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

      save();
    });

  }

  Future uploadPic(BuildContext context) async{
    String fileName = Path.basename(user.uid);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(
        fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_profilePicture);
    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    _url = dowurl.toString();
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print("Profile Picture uploaded : " + _url);
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Profile Picture Uploaded')));
    });
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
          'gender' : gender_forSave,
          'url' : _url??'default value',
        });
      return(s);
    });
    _showDialog("","Successfully Updated");
    print(_firstName);
    print(_lastName);
    setState(() {
      _state = 0;
    });
  }
}
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
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home(user:user)),
                );
              },
            ),
            
          ],
        );
      },
    );
  }
}

