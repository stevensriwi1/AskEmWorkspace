import 'package:askem_flutter/screens/wrapper.dart';
import 'package:askem_flutter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:askem_flutter/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //what value or stream are we going to pass it to
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        //anything inside here can access the data
        home: Wrapper(),
      ),
    );
  }
}
