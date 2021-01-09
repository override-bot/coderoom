import 'package:cloud_firestore/cloud_firestore.dart';


//import '/coderoom/services/firebase auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'services/firebase auth.dart';
// ignore: camel_case_types
class followers extends StatefulWidget{
   followers({Key key}) : super(key: key);

 

  @override
  _followersState createState() => _followersState();
  }
  // ignore: camel_case_types
  class _followersState extends State<followers> {
    final User user = auth.currentUser;
    Future<int> getFollowersCount() async{
      final count = await FirebaseFirestore
      .instance
      .collection("followers")
      .doc(user.uid)
      .collection("UserFollowers")
      .snapshots().length;
      return count;
    }
    changeValue()async {
       userFollowers = await getFollowersCount();
    }
    int userFollowers;
    @override
    void initState() {
      super.initState();
      changeValue();
    }
  @override
  Widget build(BuildContext context) {
        return FutureBuilder<int>(
          future: getFollowersCount(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot){
            if(snapshot.hasData){
              return "$userFollowers".text.center.xl2.bold.black.make();
            }
            return "${0}".text.center.xl2.bold.black.make();
          },
        );
  }
  }