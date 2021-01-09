import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

 final FirebaseAuth auth = FirebaseAuth.instance;
class Auth{    
  Future<User> handleSignUp(email, password) async {
    assert(password != null);
      final  UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
       
      // ignore: await_only_futures
    
              
              
              
              final User user = userCredential.user;
              await user.reload();
              return user;
                
          }
          
       
 Future<User>  handleSignIn(email, password) async{
   
    final UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
     final User user = userCredential.user;
       return user;
   }
      handleSignOut() async{
        await auth.signOut();
      }
   }
             
            
  
 
                  
