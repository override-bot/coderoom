import 'package:coderoom/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class Splash extends StatefulWidget{
  @override
  _Splash createState() => _Splash();
}
class _Splash extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      body: Center(child: 
      'CodeRoom'.text.pink600.semiBold.size(45).make().p16(),)
    );
  }
  @override 
  void initState(){
    super.initState();
    _handleStartScreen();
  }
Future<void> _handleStartScreen() async {
   //Auth authHandler = new Auth();
   FirebaseAuth.instance.authStateChanges().listen((User user){
          if(user == null){
             Navigator.push(context, new MaterialPageRoute(builder: (context) => signUpPage()));
          }
          else{
             Navigator.push(context, new MaterialPageRoute(builder: (context) => indexPage()));
          }
        });
}
}