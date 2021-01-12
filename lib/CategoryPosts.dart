import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'categoryComments.dart';
import 'uploadPage.dart';

class categoryPosts extends StatefulWidget{
  final String categoryName;

   categoryPosts({Key key,@required this.categoryName}) : super(key: key);

 

  @override
  _categoryPostsState createState() => _categoryPostsState();
  }

  class _categoryPostsState extends State<categoryPosts> {
  @override
  Widget build(BuildContext context) {
Query categoryPosts = FirebaseFirestore.instance
                              .collection('Posts')
                              .where('category', isEqualTo: widget.categoryName);
            return StreamBuilder<QuerySnapshot>(
              stream: categoryPosts.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.hasError){
                  return Text('Something went wrong');
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                   return Center(child: 
            CircularProgressIndicator(),);
          }
                
                return  new Scaffold(
                      appBar: AppBar(
         backgroundColor: Colors.white,
         elevation: 0.0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.edit, color: Colors.black), 
          onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => uploadPage()));
          }),
                    ]),
                    body: new ListView(
                      children: snapshot.data.docs.map((DocumentSnapshot document){
                        return new GestureDetector(
                          onTap: (){
                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => categoryComments(post:document.data()['post'], postID: document.id)));
                          },
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                                  new ListTile(
                                    title:  "${document.data()['name']}".text.bold.black.lg.make(),
                                    subtitle: "${document.data()['time']}".text.bold.gray500.make(),
                                  ),
                                  new Container(
                                    constraints: BoxConstraints(maxWidth:250),
                                    padding: EdgeInsets.all(10),
                                    child: new Text(document.data()['post'])
                                  ),
                                  Divider(),
                                  "Tap to join this conversation".text.bold.pink500.make()
                          ],
                              ),
                        ).p16();
                      }).toList()
                    ) ,
                );
              },
            );
                              
  }
  }