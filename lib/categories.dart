import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'CategoryPosts.dart';
import 'addComment.dart';

class categoryPage extends StatefulWidget{
   categoryPage({Key key}) : super(key: key);

 

  @override
  _categoryPageState createState() => _categoryPageState();
  }

  class _categoryPageState extends State<categoryPage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference categories = FirebaseFirestore.instance.collection('Categories');
    return StreamBuilder<QuerySnapshot>(
      stream: categories.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return "Somethinng went wrong".text.bold.size(30).make().p16();
        }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: 
            CircularProgressIndicator(),);
          }
          return Scaffold(
                  appBar: AppBar(
         backgroundColor: Colors.white,
         elevation: 0.0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add, color: Colors.black), 
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => addPage()));
          }),
                    ]),
                    body: new ListView(
                      children: snapshot.data.docs.map((DocumentSnapshot document){
                            return new Container(decoration: BoxDecoration(
                              border: Border.all(color: Colors.pinkAccent)
                            ),
                            child: new GestureDetector(
                              child:  '${document.data()['category']}'.text.size(30).bold.make(),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => categoryPosts(categoryName:document.data()['category'])));
                              },).py16());
                      }).toList(),
                    ),
          );
      },
    );
  }
  }