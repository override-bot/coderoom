import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'allUsers.dart';
import 'services/firebase auth.dart';
import 'signup.dart';
import 'splash.dart';
import 'uploadPage.dart';
import 'user_dashboard.dart';
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(MyApp());
  
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: Splash(),

    );
 
   
  }
}

// ignore: camel_case_types
class indexPage extends StatefulWidget {
  indexPage({Key key}) : super(key: key);

 

  @override
  _indexPageState createState() => _indexPageState();
}
//int index = 0;
// ignore: camel_case_types
class _indexPageState extends State<indexPage> {
   var authHandler = new Auth();
  int currentPage = 0;
  PageController _myPage = PageController(initialPage:0);
  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
         backgroundColor: Colors.white,
         elevation: 0.0,
        leading: Icon(Icons.person_pin, color: Colors.pink),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications, color: Colors.black), 
          onPressed: () {}),
           IconButton(icon: Icon(Icons.logout, color: Colors.black), 
          onPressed: () => showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
              title: Text('Warning'),
              content: Text('Do you really want to log out'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  // ignore: sdk_version_set_literal
                  onPressed:() async {
                    authHandler.handleSignOut().then((value){
                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => signUpPage()), (route) => false);
                    });
                  },
                ),
                 FlatButton(
                  child: Text('No'),
                  // ignore: sdk_version_set_literal
                  onPressed:() => Navigator.pop(c),
                ),
              ],
            )
          ))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        shape:CircularNotchedRectangle(),
        child:Container(
          height:70,
          child: Row(mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              iconSize: 25.0,
             padding: EdgeInsets.only(left:28.0),
              icon: Icon(Icons.home, color: currentPage== 0 ? Colors.pink : Colors.black),
              onPressed: () {
                setState(() {
                  _myPage.jumpToPage(0);
                  
                });
              },
            ),
             IconButton(
              iconSize: 25.0,
  padding: EdgeInsets.only(right:28.0),
              icon: Icon(Icons.people, color: currentPage== 1 ? Colors.pink : Colors.black),
              onPressed: () {
                setState(() {
                  _myPage.jumpToPage(1);
                });
              },
            ),
              IconButton(
              iconSize: 25.0,
  padding: EdgeInsets.only(left:28.0),
              icon: Icon(Icons.messenger, color: currentPage== 2 ? Colors.pink : Colors.black),
              onPressed: () {
                setState(() {
                  _myPage.jumpToPage(2);
                });
              },
            ),
             IconButton(
              iconSize: 25.0,
            padding: EdgeInsets.only(right:28.0),
              icon: Icon(Icons.person, color: currentPage== 3 ? Colors.pink : Colors.black),
              onPressed: () {
                setState(() {
                  _myPage.jumpToPage(3);
                });
              },
            ),
          ],)
        )
      ),
       body: PageView(
         
        controller: _myPage,
        onPageChanged: (int page){
          currentPage = page;
        },
        children: <Widget>[
          Center(child:Container(
            
            color: Colors.grey.shade200,
          ),),
           Center(child:AllUsers(),),
           Center(child:Container(
             color: Colors.grey.shade200,
          ),),
           Center(child:dashBoard(),)
        ],

    ),
    floatingActionButton: Container(
      height:55.0,
      width: 55.0,
      child: FittedBox(
        child: FloatingActionButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => uploadPage())
          );},
        child: Icon(Icons.edit, 
        color: Colors.white,),
        elevation: 2.0,
        )
      )
    ),
    );
   
  }
}
