import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'main.dart';
import 'services/postUpload.dart';
// ignore: camel_case_types
class uploadPage extends StatefulWidget {
  uploadPage({Key key}) : super(key: key);

 

  @override
  _uploadPageState createState() => _uploadPageState();
  }
  // ignore: camel_case_types
  class _uploadPageState extends State<uploadPage> {
    // ignore: non_constant_identifier_names
    TextEditingController _PostField = TextEditingController();
     bool isEnabled = false;
     String category;
   bool _isEnabled = false; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
               backgroundColor: Colors.white,
         elevation: 0.0,
         leading: IconButton(
           icon: Icon(Icons.arrow_back, color: Colors.pink),
            onPressed: () => Navigator.pop(context),
            ),
             actions: <Widget>[
               ButtonTheme(
                 height: 50.0,
              child: FlatButton(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(18.0),
                  
                 ),
                 color: Colors.pink,
                 textColor: Colors.white,
                 onPressed: isEnabled & !_isEnabled? () async {uploadPost(_PostField.text, category).then((value) {
                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => indexPage()), (route) => false);
              });} : null,
                  child: "Post".text.bold.make(),

               ).p12()
               )]
      ),
      body: Container(
         width: MediaQuery.of(context).size.width/1,
         child: Column(
         children: [TextField(
            onChanged: (text){
                        setState((){
                          if(text.length > 10)
                          isEnabled = true;
                          else
                          isEnabled = false;
                        });
                      },
                      controller: _PostField,
           maxLength: 2000,
           maxLengthEnforced: true,
           maxLines: 15,

            decoration: InputDecoration(
                        hintText: "Start a new conversation",
                        
                        errorText: !isEnabled ? 'post should be more than 10 characters' : null
                      ), 


         ),
         new StreamBuilder<QuerySnapshot>(
           stream:FirebaseFirestore.instance.collection("Categories").snapshots(),
           builder:(context, snapshot){
             if(!snapshot.hasData){
               return Center(
               child:  CircularProgressIndicator(backgroundColor: Colors.pink)
               );
             }
              
              return new Container(
               // padding: EdgeInsets.only(bottom:16.0),
                width: MediaQuery.of(context).size.width,
                child: new InputDecorator(
                  decoration: InputDecoration(
                    hintText: "Choose a category",
                    errorText: _isEnabled ? "Add a category": null,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                  ) ,
                  isEmpty: _isEnabled = false,
                  child: new DropdownButton(
                    value: category,
                    isExpanded: true,
                    isDense: true,
                    onChanged: (String newValue){
                      setState((){
                        category = newValue;
                        _isEnabled = true;
                      });

                    },
                    items: snapshot.data.docs.map((DocumentSnapshot document){
                      return new DropdownMenuItem<String>(
                      value:document.data()['category'],
                      child: new Container(
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(5.0)
                        ),
                        height:90,
                       
                        child: new Text(document.data()['category']),
                      ),
                     ); }).toList(),
                  ),
                ),
              );

             }
           
         ).py12(),
       ] ).p16(),
    ));
  }
  }