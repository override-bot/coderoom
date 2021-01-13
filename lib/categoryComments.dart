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
           icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
            ),
      ),
      body: Column(children:[
        Expanded(

        child:Column(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child: "${widget.post}".text.lg.bold.make(),
            ).p16(),
            Divider(),
           
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Comments').doc(widget.postID).collection('postComments').orderBy("timeStamp", descending:false).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                
               
                
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                if(snapshot.hasData){
                  //return CircularProgressIndicator().p16();
                
                return new Expanded(child:
                ListView(
                  shrinkWrap: true,
                  children: snapshot.data.docs.map((DocumentSnapshot document){
                        return new Container(
                            decoration: BoxDecoration(
                               // border: Border.all(color:Colors.grey),
                                color: Colors.white,
                                boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0,3)
                                    ),
                                ],
                          ),
                          child:new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              "${document.data()['name']}".text.size(20).make().py12(),
                              
                            
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: 250,
                                ),
                                child: "${document.data()['comment']}".text.lg.bold.make().py24()
                              )
                            ],
                          )
                        ).p16();
                  }).toList()
                ));
                }
                   return Text('Something went wrong');
              },
            ),
         
              
    ]),
    
    ),
    Container(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child:
          TextFormField(
            onChanged:(text){
              setState((){
                    if(text.length>1)
                    isEnabled= true;
                    else
                    isEnabled = false;
              });
            },
            controller: commentController,
            decoration: InputDecoration(
              hintText: "add comment",
              errorText: !isEnabled? "Post should be more then one character":null,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              )
            )
          ).px2()),
          IconButton(
            icon: Icon(Icons.send, color:Colors.pink),
            iconSize: 30.0,
            onPressed: isEnabled? () async{
              await addComment(commentController.text, widget.postID).then((value) => commentController.clear());
            }:null,
          ).py4()
        ],
      ),
    )
    ]));
    
  }
  }