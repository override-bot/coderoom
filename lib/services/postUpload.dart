import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase auth.dart';
final User user = auth.currentUser;
Future uploadPost(post) async {
   final  QuerySnapshot followers =  await FirebaseFirestore
      .instance
      .collection("followers")
      .doc(user.uid)
      .collection("UserFollowers").get();
        
        final List<DocumentSnapshot> followerList = followers.docs;
              
             //  return data;
         
      // });
      

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
              "Followers": followerList, 
              "post": post,
              "time": DateTime.now()
                   }).catchError((error) => print("failed"));
}