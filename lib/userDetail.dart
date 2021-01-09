import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'services/firebase auth.dart';
import 'services/followinng.dart';


// ignore: camel_case_types
class userDetail extends StatefulWidget {
  final String widgetId;
  userDetail({Key key, @required this.widgetId}) : super(key: key);

 

  @override
  _userDetailState createState() => _userDetailState();
  }
  
  // ignore: camel_case_types
  class _userDetailState extends State<userDetail> {
  //  @override
    final User user = auth.currentUser;
    isFolList() async{
      final  QuerySnapshot followers =  await FirebaseFirestore
      .instance
      .collection("followers")
      .doc(widget.widgetId)
      .collection("UserFollowers").get();
        
        final List<DocumentSnapshot> followerList = followers.docs;
         
         return followerList;
        
    }
         
  List followList; 
  bool isFollowing;     
@override
void initState() async{
  super.initState();
  followList = isFolList().then((value){
     setState((){
           if (value.contains(user.uid)){
             isFollowing = true;
           }
           else {
             isFollowing = false;
           }
         });
  });
  
         
       
 
 
    }
    
    
  @override
  Widget build(BuildContext context) {
             CollectionReference users = FirebaseFirestore.instance.collection('users');
   return FutureBuilder<DocumentSnapshot>(
     future: users.doc(widget.widgetId).get(),
     builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
       if(snapshot.hasError){
         return  'Something went wrong'.text.black.semiBold.size(25).make().p16();
       }
       if(snapshot.connectionState == ConnectionState.done){
         Map<String, dynamic>data = snapshot.data.data();
         return Scaffold(
        body: Container(
           color: Colors.grey[100],
           child: Center(
             child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Icon(
                     Icons.person_pin,
                     size:130,
                     color: Colors.pink
                   ).py12(),
                 
                 "${data['username']}".text.center.size(30).black.bold.make().py12(),
                 "${data['occupation']}".text.center.size(20).gray600.make().py12(),
                   "${data['Bio']}".text.center.lg.gray700.make().py32(),
  
                  
                     FlatButton(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(18.0),
                  
                 ),
                 color:!isFollowing? Colors.pink : Colors.grey,
                 textColor: Colors.white,
                 onPressed: !isFollowing? () async {followUser(widget.widgetId, data['username']).then((value) => setState((){
          
             isFollowing = true;
                 }));
                } : null,
                  child: !isFollowing? "Follow".text.bold.make() : "Following".text.black.bold.make(),

               ).p12()
               ],).p16(),
             
           ),

         ).py16());
       }
      return Container(color:Colors.white);
     },
   );
  }
  }