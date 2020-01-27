import 'package:askem_flutter/models/user.dart';
import 'package:askem_flutter/screens/authenticate/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
//underscore means this property is private and cant be access by other files
//instance of firebaseauth
  final FirebaseAuth _auth = FirebaseAuth.instance;

//create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    //if user in firebase is not null then assign our model user id to firebase user uid
    return user != null ? User(uid: user.uid) : null;
  }

//calling it user
//auth change user stream
//whenever there is a change in authentication, the stream will return firebase user
Stream<User> get user{
  return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
}

  //sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign in email & pass
Future signIn(/*String fistName, String lastName,*/ String email, String password) async{
    
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password);
        FirebaseUser user = result.user;
        return _userFromFirebaseUser(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  //register with email & password
  Future register(/*String fistName, String lastName,*/ String email, String password) async{
    
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password);
        FirebaseUser user = result.user;
        return _userFromFirebaseUser(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }



}
