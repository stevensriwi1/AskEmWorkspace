import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
//underscore means this property is private and cant be access by other files
//instance of firebaseauth
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //sign in anon
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    }
    catch (e){
      print(e.toString());
      return null;
    }
  }
  //sign in email & pass

  //register with email & password

  //sign out
}
