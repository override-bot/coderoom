import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'services/postUpload.dart';
// ignore: camel_case_types
class addPage extends StatefulWidget {
  addPage({Key key}) : super(key: key);

 

  @override
  _addPageState createState() => _addPageState();
  }
  // ignore: camel_case_types
  class _addPageState extends State<addPage> {
    // ignore: non_constant_identifier_names
    TextEditingController _PostField = TextEditingController();
     bool isEnabled = false;
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
                 onPressed: isEnabled? () async {addCategory(_PostField.text).then((value) {
                 Navigator.pop(context);
              });} : null,
                  child: "Add".text.bold.make(),

               ).p12()
               )]
      ),
      body: Container(
         width: MediaQuery.of(context).size.width/1,
         child: Column(
         children: [TextField(
            onChanged: (text){
                        setState((){
                          if(text.length > 2)
                          isEnabled = true;
                          else
                          isEnabled = false;
                        });
                      },
                      controller: _PostField,
           maxLength: 75,
           maxLengthEnforced: true,
           maxLines: 15,

            decoration: InputDecoration(
                        hintText: "Add a category",
                        
                        errorText: !isEnabled ? 'post should be more than 4 characters' : null
                      ), 

         ),
        
         ] ).p16(),
    ));
  }
  }