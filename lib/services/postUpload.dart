import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase auth.dart';
final User user = auth.currentUser;
Future uploadPost(post,category) async {
      // ignore: non_constant_identifier_names
      final Username = await FirebaseFirestore
      .instance
      .collection('users')
      .doc(user.uid).get();
            Map<String, dynamic> data(){ 
             Map<String, dynamic>data =  Username.data();
             return data;
          // ignore: unused_local_variable
         }
          String  displayname = data()["username"];
         
          //return displayname;
         

           
        final name = displayname;
      // ignore: non_constant_identifier_names
      
    
      return FirebaseFirestore.instance.collection('Posts').add({
              "name": name,
              "userId": user.uid,
              "category": category,
              "post": post,
              "time": DateTime.now()
                   }).catchError((error) => print("failed"));
}
Future addCategory(category) async {
  return FirebaseFirestore.instance.collection('Categories').add({
            "category": category
  });
}
Future addComment(comment, postId) async{
  final Username = await FirebaseFirestore
      .instance
      .collection('users')
      .doc(user.uid).get();
            Map<String, dynamic> data(){ 
             Map<String, dynamic>data =  Username.data();
             return data;
         }
          String  displayname = data()["username"];
        final name = displayname; 
        FirebaseFirestore.instance.collection('Comments').doc(postId).collection('postComments').add({
                  'name': name,
                  'comment':comment ,
                  "timeStamp": DateTime.now()        
        });
}