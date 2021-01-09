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
    
    final User user = auth.currentUser;
          bool isFollowing = true;
           checkFollowing() async{
            final  QuerySnapshot followers =  await FirebaseFirestore
      .instance
      .collection("followers")
      .doc(widget.widgetId)
      .collection("UserFollowers").get();
        
        final List<DocumentSnapshot> followerList = followers.docs;
        
         
         setState((){
           if (followerList.contains(user.uid)){
             isFollowing = true;
           }
           else {
             isFollowing = false;
           }
         });
          }
void iniState(){
 super.initState();
 checkFollowing();
 
 
    }
     Future<int> getFollowersCount() async{
      final count = await FirebaseFirestore
      .instance
      .collection("followers")
      .doc(widget.widgetId)
      .collection("UserFollowers")
      .snapshots().length;
      return count;
    }
     Future<int> getFollowingCount() async{
      final count = await FirebaseFirestore
      .instance
      .collection("following")
      .doc(widget.widgetId)
      .collection("UserFollowing")
      .snapshots().length;
      return count;
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
                 
                 "${data['username']}".text.center.size(30).black.bold.make().py8(),
                 "${data['occupation']}".text.center.size(20).gray600.make().py12(),
                   "${data['Bio']}".text.center.lg.gray700.make().py32(),
                   Divider().py16(),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                          Column(
                            children: [
                              
                            FutureBuilder<int>(
          future: getFollowersCount(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot){
            if(snapshot.hasData){
              return "${snapshot.data}".text.center.xl2.bold.black.make();
            }
            return "${0}".text.center.xl2.bold.black.make();
          },
        ),
                            "Followers".text.center.lg.bold.gray700.make()
                            ],
                          ),
                           Column(
                            children: [
                             
                            FutureBuilder<int>(
          future: getFollowingCount(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot){
            if(snapshot.hasData){
              return "${snapshot.data}".text.center.xl2.bold.black.make();
            }
            return "${0}".text.center.xl2.bold.black.make();
          },
        ),
                            "Following".text.center.lg.bold.gray700.make()
                            ],
                          )
                     ],
                   ),
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