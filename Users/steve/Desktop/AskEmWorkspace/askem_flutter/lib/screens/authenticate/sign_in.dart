import 'package:askem_flutter/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 0.0,
        title: Text('Sign in to AskEm'),
      ),
      body: Container(
        child: RaisedButton(
          child: Text('Sign In anon'),
          onPressed: () async{
            //dynamic as it could be null or a firebase user
            dynamic result = await _authService.signInAnon();
            if (result==null)
            {
              print('error signing in');

            }
            else
            {
              print('signed in');
              print(result);
            }
          },
        ),
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 150.0),
      ),
    );
  }
}
