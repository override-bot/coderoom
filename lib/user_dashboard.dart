import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'following.dart';
import 'services/firebase auth.dart';
import 'followers.dart';
// ignore: camel_case_types
// ignore: camel_case_types
class dashBoard extends StatefulWidget{
   dashBoard({Key key}) : super(key: key);

 

  @override
  _dashBoardState createState() => _dashBoardState();
  }
  // ignore: camel_case_types
  class _dashBoardState extends State<dashBoard> {
     final User user = auth.currentUser;
   
  @override
  Widget build(BuildContext context) {
   CollectionReference users = FirebaseFirestore.instance.collection('users');
   return FutureBuilder<DocumentSnapshot>(
     future: users.doc(user.uid).get(),
     builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
       if(snapshot.hasError){
         return  'Something went wrong'.text.black.semiBold.size(25).make().p16();
       }
       if(snapshot.connectionState == ConnectionState.done){
         Map<String, dynamic>data = snapshot.data.data();
         return Container(
           //color: Colors.grey[100],
           child: Center(
             child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Icon(
                     Icons.person_pin,
                     size:130,
                     color: Colors.pink
                   ).py12(),
                 
                 "${data['username']}".text.center.size(40).black.bold.make(),
                 "${data['occupation']}".text.center.size(25).gray600.make().py12(),
                   "${data['Bio']}".text.center.lg.gray700.make().py32(),
                   Divider().py16(),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                          Column(
                            children: [
                              
                             followers(),
                            "Followers".text.center.lg.bold.gray700.make()
                            ],
                          ),
                           Column(
                            children: [
                             
                            following(),
                            "Following".text.center.lg.bold.gray700.make()
                            ],
                          )
                     ],
                   )
               ],),
           ),

         );
       }
       return CircularProgressIndicator();
     },
   );
  }
  }