//add sign in widget and sign up
import 'package:askem_flutter/screens/authenticate/register.dart';
import 'package:askem_flutter/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;


  void toggleAuthView()
  {
    setState(() {
      //show reversed of what the current view is. If it is false, then it will change it to true, and when it is false, it will be true
      showSignIn=!showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {

    if(showSignIn == true)
    {
      return  SignIn(toggleView:toggleAuthView);
    
    }
    else{
      return Register(toggleView:toggleAuthView);
    }
    
  }
}
