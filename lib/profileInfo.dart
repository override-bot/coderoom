import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coderoom/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'services/firebase auth.dart';

// ignore: camel_case_types
class profileInfo extends StatefulWidget{
   profileInfo({Key key}) : super(key: key);

 

  @override
  _profileInfoState createState() => _profileInfoState();
  }
  
  // ignore: camel_case_types
  class _profileInfoState extends State<profileInfo> {
     // ignore: non_constant_identifier_names
     TextEditingController _UsernameField = TextEditingController();
      // ignore: non_constant_identifier_names
      TextEditingController _BioField = TextEditingController();
       // ignore: non_constant_identifier_names
       TextEditingController _OccupationField = TextEditingController();
       final User user = auth.currentUser;
       bool isEnabled = false;
       
  @override
  Widget build(BuildContext context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text("Additional Info"),
                  actions: <Widget>[
          IconButton(icon: Icon(Icons.edit, color: Colors.white), 
          onPressed: isEnabled? () async {
              FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                        "userId": user.uid,
                        "username": _UsernameField.text,
                        "occupation": _OccupationField.text,
                        "Bio": _BioField.text
              }).then((value) {
                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => indexPage()), (route) => false);
              });
          }: null),
                   ] ),
                  body:Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                                     'CodeRoom'.text.pink600.semiBold.size(45).make().p16(),
                                 Container(
                  width: MediaQuery.of(context).size.width/1.2,
                    child: TextFormField(
                      onChanged: (text){
                        setState((){
                          if(text.length > 3)
                          isEnabled = true;
                          else
                          isEnabled = false;
                        });
                      },
                      controller: _UsernameField,
                      decoration: InputDecoration(
                        hintText: "John",
                        labelText: "Username",
                        errorText: isEnabled ? 'username should be more than 3 characters' : null
                      ), 
                    ),
                ),
                 Container(
                  width: MediaQuery.of(context).size.width/1.2,
                    child: TextFormField(
                       onChanged: (text){
                        setState((){
                          if(text.length > 7)
                          isEnabled = true;
                          else
                          isEnabled = false;
                        });
                      },
                      controller: _OccupationField,
                      decoration: InputDecoration(
                        hintText: "eg. Software Engineer",
                        labelText: "What you do",
                        errorText: isEnabled ? 'input should be more than 7 characters' : null
                      ), 
                    ),
                ),
                 Container(
                  width: MediaQuery.of(context).size.width/1.2,
                    child: TextFormField(
                       onChanged: (text){
                        setState((){
                          if(text.length > 14)
                          isEnabled = true;
                          else
                          isEnabled = false;
                        });
                      },
                      controller: _BioField,
                      decoration: InputDecoration(
                        hintText: "Bio researcher||Feminist||Husband||He/His",
                        labelText: "Bio",
                        errorText: isEnabled ? 'Bio should be more than 14 characters' : null
                      ), 
                    ),
                ),
                        ],
                      ),
                  )
              ),
            );
  }
}