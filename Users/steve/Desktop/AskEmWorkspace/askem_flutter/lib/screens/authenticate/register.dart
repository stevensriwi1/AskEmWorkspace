import 'package:askem_flutter/screens/home/home.dart';
import 'package:askem_flutter/services/auth.dart';
import 'package:askem_flutter/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //textfield state
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 0.0,
        title: Text('Sign Up with AskEm'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          //with this wyou can access all the data from just the key
          key: _formKey,
          child: Column(
            children: <Widget>[
              //firstname
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  decoration: InputDecoration(hintText: "First Name"),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter First Name';
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      firstName = val;
                    });
                  }),

              //lastname
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  decoration: InputDecoration(hintText: "Last Name"),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter Last Name';
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      lastName = val;
                    });
                  }),
              //email
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter some email';
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  }),
              //password
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: "Password"),
                validator: (val) {
                  if (val.length < 6) {
                    return 'Please enter password with more than 6 char long';
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
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                   setState(() {
                     loading=true;
                   });
                  if (_formKey.currentState.validate()) {
                    //call the register method
                    dynamic result = await _auth.register(firstName, lastName, email, password);
                    if (result == null) {
                      setState(() {
                        error='Please supply valid Email';
                        loading = false;
                      });
                    }
                    else {
                      loading = false;
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new Home()));
                          }
                    
                  }
                },
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
