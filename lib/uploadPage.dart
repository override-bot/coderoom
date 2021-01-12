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
    Future<List<String>> getCategories() async {
       
        QuerySnapshot categories = await FirebaseFirestore
       .instance
       .collection("Categories").get();
     return categories.docs
     .map((snap) => snap.data()["category"]).toList();
    
     }
    
    
     List<String>categories = List<String>();
     @override
     void initState(){
       super.initState();
     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                 onPressed: isEnabled? () async {uploadPost(_PostField.text, category).then((value) {
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
                          if(text.length > 30)
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
                        
                        errorText: !isEnabled ? 'post should be more than 30 characters' : null
                      ), 

         ),
         InputDecorator(
           isEmpty: isEnabled = false,
           decoration: InputDecoration(
             errorText: !isEnabled ? 'Select a category' : null,
             hintText: 'Choose a category',
             isDense: true,
             border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),  
           ),
        child: FutureBuilder<List<String>>(
          future: getCategories(),
          builder: (context, snapshot){
            if(snapshot.hasData){
             return DropdownButton<String>(
           value: category,
           icon: Icon(Icons.arrow_downward),
           iconSize: 24,
          elevation: 16,
          style: TextStyle(
            color: Colors.pink
          ),
          underline: Container(
            height: 2,
            color: Colors.pinkAccent,
          ),
          onChanged: (String newValue){
            setState((){
              category = newValue;
            });
          },
          items: snapshot.data
          .map<DropdownMenuItem<String>>
          ((String value){
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          
         );
            }
            return Text("0");
          }
        
         ))] ).p16(),
    ));
  }
  }