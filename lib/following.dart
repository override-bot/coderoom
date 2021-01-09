import 'package:cloud_firestore/cloud_firestore.dart';


//import '/coderoom/services/firebase auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'services/firebase auth.dart';
// ignore: camel_case_types
class following extends StatefulWidget{
   following({Key key}) : super(key: key);

 

  @override
  _followingState createState() => _followingState();
  }
  // ignore: camel_case_types
  class _followingState extends State<following> {
    final User user = auth.currentUser;
     Future<int> getFollowingCount() async{
      final count = await FirebaseFirestore
      .instance
      .collection("following")
      .doc(user.uid)
      .collection("UserFollowing")
      .snapshots().length;
      return count;
    }
    int userFollowing;
    changeVal() async {
        userFollowing = await getFollowingCount();
    }
    @override
   void initState(){
     super.initState();
     changeVal();
   
   
   }
  @override
  Widget build(BuildContext context) {
        return FutureBuilder<int>(
          future: getFollowingCount(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot){
            if(snapshot.hasData){
              return "$userFollowing".text.center.xl2.bold.black.make();
            }
            return "${0}".text.center.xl2.bold.black.make();
          },
        );
  }
  }