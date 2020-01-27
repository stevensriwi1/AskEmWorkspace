import 'package:askem_flutter/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('AskEm Game'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign Out'),
            onPressed: () async{
              // once it is logged out it will check the wrapper again whether user is null of still sign in.
              await _auth.signOut();
            },)
        ],
        
      ),
    );
  }
}