import 'dart:convert';

import 'package:askem_flutter/models/user.dart';
import 'package:askem_flutter/screens/authenticate/sign_in.dart';
import 'package:askem_flutter/screens/home/home.dart';
import 'package:askem_flutter/screens/wrapper.dart';
import 'package:askem_flutter/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const baseUrl = "http://10.0.2.2:3000/api";

//underscore means this property is private and cant be access by other files
//instance of firebaseauth
  final FirebaseAuth _auth = FirebaseAuth.instance;

//create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    //if user in firebase is not null then assign our model user id to firebase user uid
    return user != null ? User(uid: user.uid) : null;
  }

  User _userLoginFromFirebaseUser(String userId) {
    //if user in firebase is not null then assign our model user id to firebase user uid
    //return user != null ? User(uid: userId) : null;
    return User(uid: userId);
  }

//calling it user
//auth change user stream
//whenever there is a change in authentication, the stream will return firebase user
  Stream<User> get user {
    getStatus();
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future getStatus() async {
    var url = baseUrl + "/manageusers/getStatus";
    http.Response response = await http.get(url);
    print(response.body);
    return response.body;
  }

  //sign in email & pass
  Future signIn(String email, String password) async {
    //User user = new User({
    //  email: email,
    //  password: password
    //}
    //
    //);
    var url = baseUrl + "/manageusers/signIn";
    print(url);
    var user = jsonEncode({'email': email, 'password': password});

    http.Response response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: user.toString());
    int statusCode = response.statusCode;
    print(response.body);

    if (statusCode == 200) {
      print(
          "Successful connection to Webservice, and it is giving a result!!!!");
      if (response.body == null || response.body == "") {
        print("Wrong Credential");
        return null;
      } else {
        try {
          // AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
          // FirebaseUser user = result.user;
          //FirebaseUser user1 = response.body as FirebaseUser;
          // return _userFromFirebaseUser(user);
          return _userLoginFromFirebaseUser(response.body);
        } catch (e) {
          print(e.toString());
          return null;
        }
      }
    } else {
      print("unsuccessful");
      return null;
    }
  }

  //register with email & password
  Future register(
      String firstName, String lastName, String email, String password) async {
    var user = jsonEncode({'email': email, 'password': password});
    //create account for Auth
    var url = baseUrl + "/manageusers/createAccount";
    http.Response response = await http.post(url, headers: {"Content-Type": "application/json"}, body: user.toString());
    int statusCode = response.statusCode;
    print(response.body);


    var userDatabase = jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'uid': response.body
    });
    //create account for Database
    var url1 = baseUrl + "/manageusers/createDatabaseAccount";
    var response1 = await http.post(url1, headers: {"Content-Type": "application/json"}, body: userDatabase.toString());
    print(response1.body);

    

    if (statusCode == 200) {
      print(
          "Successful connection to Webservice, and it is giving a result!!!!");
      if (response.body == null || response.body == "") {
        print("Wrong Formats");
        return null;
      } else {
        try {
          // AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
          // FirebaseUser user = result.user;
          //FirebaseUser user1 = response.body as FirebaseUser;
          // return _userFromFirebaseUser(user);
          return _userLoginFromFirebaseUser(response.body);
        } catch (e) {
          print(e.toString());
          return null;
        }
      }
    } else {
      print("unsuccessful");
      return null;
    }

    // try {
    //   AuthResult result = await _auth.createUserWithEmailAndPassword(
    //       email: email, password: password);
    //   FirebaseUser user = result.user;
    //   //create a new document for the user in firestore with the uid of firebase
    //   await DatabaseService(uid: user.uid).updateUserData(firstName, lastName);
    //   return _userFromFirebaseUser(user);
    // } catch (e) {
    //   print(e.toString());
    //   return null;
    // }
  }

  //sign out
  Future signOut() async {
    var url = baseUrl + "/manageusers/signOut";
    var response = await http.get(url);
    try {
      //return await _auth.signOut();
      User(uid: null);
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
