import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase auth.dart';
final User user = auth.currentUser;
Future followUser(userId, username) async{
    FirebaseFirestore
      .instance
      .collection("following")
      .doc(user.uid)
      .collection("UserFollowing")
      .add({
              "followerId": userId,
              "followerName": username
      }).then((value) {
         FirebaseFirestore
      .instance
      .collection("followers")
      .doc(user.uid)
      .collection("UserFollowers")
      .add({
        "followerId": userId,
        "followerName": username,
        userId : true
      });
      }).catchError((error) => print("Somtething went wrong"));

}
