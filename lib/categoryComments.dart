import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'services/postUpload.dart';

class categoryComments extends StatefulWidget{
  
final String post;
final String postID;
   categoryComments({Key key, @required this.post, this.postID}) : super(key: key);

 

  @override
  _categoryCommentsState createState() => _categoryCommentsState();
  }

  class _categoryCommentsState extends State<categoryComments> {
    
 TextEditingController commentController = TextEditingController();
 bool isEnabled = false;
  //CollectionReference comments = FirebaseFirestore.instance.collection('Comments').doc(widget.postID).collection('postComments');
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(
        title: Text('Comments'),
        leading: IconButton(
           icon: Icon(Icons.arrow_back, color: Colors.pink),
            onPressed: () => Navigator.pop(context),
            ),
      ),
      body: Stack(
        children: [ Column(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 200),
              child: Text(widget.post),
            ),
            Divider(),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Comments').doc(widget.postID).collection('postComments').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.hasError){
                  return Text('Something went wrong');
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document){
                        return new Card(
                          child:new Column(
                            children: [
                              new ListTile(
                                title: new Text(document.data()['name']),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: 200,
                                ),
                              )
                            ],
                          )
                        ).p16();
                  }).toList()
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height:20.0,
                padding: EdgeInsets.symmetric(vertical: 2.0),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextFormField(
                       onChanged: (text){
                        setState((){
                          if(text.length > 1)
                          isEnabled = true;
                          else
                          isEnabled = false;
                        });
                      },
                      controller: commentController,
                      decoration: new InputDecoration(
                        hintText: 'Add a comment',
                         errorText: !isEnabled ? 'post should be more than 1 character' : null,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                        )
                      )),
                    IconButton(
                      icon: Icon(Icons.send),
                      iconSize:20.0,
                      onPressed: isEnabled? ()async {
                        await addComment(commentController.text, widget.postID);}: null
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        ]),
    );
    
  }
  }