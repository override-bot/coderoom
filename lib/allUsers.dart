import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'userDetail.dart';


class AllUsers extends StatefulWidget {
  AllUsers({Key key}) : super(key: key);

 

  @override
  _AllUsersState createState() => _AllUsersState();
  }
  
  // ignore: camel_case_types
  class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
CollectionReference users = FirebaseFirestore.instance.collection('users');

return StreamBuilder<QuerySnapshot>(
  stream: users.snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasError){
                return "Something went wrong".text.lg.make().p16();
              }
              if (snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              if(!snapshot.hasData){
                return "No User".text.lg.make().p16();
              }
              return new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot documents){
                        return new GestureDetector(
                          onTap: (){
                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => userDetail(widgetId:documents.data()['userId'])));
          
                          },
                          child: SizedBox(
                            height:80.0,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                             // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 Icon(
                     Icons.person_pin,
                     size:70,
                     color: Colors.pink
                   ).p12(),
                   Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                        '${documents.data()['username']}'.text.black.size(25).bold.make().py12().px1(),
                        '${documents.data()['occupation']}'.text.gray500.size(20).bold.make().px1()
                     ],
                   ).px12(),
            
                          ],
                            ),
                          )
                        );
                }).toList()
              );
  },
);
    
  }
  }