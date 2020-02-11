import 'package:askem_flutter/models/user.dart';
import 'package:askem_flutter/screens/authenticate/sign_in.dart';
import 'package:askem_flutter/screens/home/quiz.dart';
import 'package:askem_flutter/services/auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:askem_flutter/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QuizState();
  }
}

class QuizState extends State<Home> {
  User users = User();
  final AuthService _auth = AuthService();
  final DatabaseService _userFirestore = DatabaseService();
  @override
  Widget build(BuildContext context) {
    _userFirestore.getUserDoc();
    //return StreamProvider<QuerySnapshot>.value
    return StreamProvider.value(
      value: null,
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Text('AskEm Game'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign Out'),
              onPressed: () async {
                // once it is logged out it will check the wrapper again whether user is null of still sign in.
                await _auth.signOut();
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => new SignIn()));
              },
            )
          ],
        ),
        body: new Container(
          margin: const EdgeInsets.all(15.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new MaterialButton(
                  height: 50.0,
                  color: Colors.green,
                  onPressed: startQuiz,
                  child: new Text(
                    "Start the Quiz",
                    style: new TextStyle(fontSize: 18.0, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void startQuiz() {
    setState(() {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => new Quiz()));
    });
  }
}
