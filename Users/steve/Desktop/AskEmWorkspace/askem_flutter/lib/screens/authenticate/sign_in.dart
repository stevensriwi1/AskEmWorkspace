import 'dart:async';
import 'dart:convert';
import 'package:askem_flutter/services/auth.dart';
import 'package:askem_flutter/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SignIn extends StatefulWidget {
  //toggle view
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  Future<String> getData() async {
    //add url to the connecttion between API and flutter app, attach your url
    http.Response response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {
          //this key is to authenticate, for now it nothing
          //"key": "sdcwfwfw"
          "Accept": "application/json"
        });
        //list all the data from the json file in body into "data"
        List data = json.decode(response.body);
        //calling first column and the title on it
        print(data[1]["title"]);
  }

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //textfield state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    //if loading is true then display loading, otherwise the real content
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              backgroundColor: Colors.blue[500],
              elevation: 0.0,
              title: Text('Sign in to AskEm'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    //email
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                        decoration: InputDecoration(hintText: "Email"),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter email';
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        }),
                    //password
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Password"),
                      validator: (val) {
                        if (val.length < 6) {
                          return 'Please enter your password more than 6 characters';
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      color: Colors.blueGrey[500],
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        if (_formKey.currentState.validate()) {
                          //call the sign in method
                          dynamic result =
                              await _authService.signIn(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'Could not sign in with those credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    RaisedButton(
                      color: Colors.blueGrey[500],
                      child: Text(
                        'Get Data',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: getData,
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
