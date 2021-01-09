

// ignore: unused_import
import 'package:coderoom/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'profileInfo.dart';
import 'services/firebase auth.dart';

// ignore: camel_case_types

// ignore: camel_case_types
class signUpPage extends StatefulWidget {
  signUpPage({Key key}) : super(key: key);

 

  @override
  _signUpPageState createState() => _signUpPageState();
  }
  
  // ignore: camel_case_types
  class _signUpPageState extends State<signUpPage> {
   
    // ignore: non_constant_identifier_names
     // ignore: non_constant_identifier_names
     TextEditingController _EmailField = TextEditingController();
      // ignore: non_constant_identifier_names
      TextEditingController _PasswordField = TextEditingController();
      var authHandler = new Auth();

  @override
  Widget build(BuildContext context) {
    // 
    //throw UnimplementedError();
    
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: SafeArea(
            child: VxBox(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    'CodeRoom'.text.pink600.semiBold.size(45).make().p16(),
                    
               
                 Container(
                  width: MediaQuery.of(context).size.width/1.2,
                    child: TextFormField(
                      controller: _EmailField,
                      decoration: InputDecoration(
                        hintText: "Jdoe@email.com",
                        labelText: "Email"
                      ), 
                    ),
                ),
                 Container(
                  width: MediaQuery.of(context).size.width/1.2,
                    child: TextFormField(
                      controller: _PasswordField,
                       obscureText: true,
                        
                      decoration: InputDecoration(
                        
                        labelText: "Password",
                       
                      ), 
                    ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.pink[600],
                  ),
                  child: MaterialButton(onPressed: () async{
                    authHandler.handleSignUp(_EmailField.text, _PasswordField.text)
                    .then((user) {
                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => profileInfo()), (route) => false);
                    }).catchError((e) => print(e));
                  },
                  child: "Sign Up".text.white.semiBold.size(20).make().p16()),),
                  
                     Container(
                  width: MediaQuery.of(context).size.width/1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white
                  ),
                  child: MaterialButton(onPressed: () async {
                     authHandler.handleSignIn(_EmailField.text, _PasswordField.text).then((user){
                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => indexPage()), (route) => false);
                     }).catchError((e) => print(e));
                    
                  },
                  child:  "Login Instead".text.pink600.size(20).make().p12()),),
                    
                  
                  
                  

                
               
                
              ]
          )
        ).alignCenter.make()
      )
    );
  }
}
