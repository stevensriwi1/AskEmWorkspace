import 'package:askem_flutter/screens/authenticate/authenticate.dart';
import 'package:askem_flutter/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:askem_flutter/models/user.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //collect the content of the data and what stream user from provider
    final user = Provider.of<User>(context);
    //return either home or authenticate widget     
    if (user == null)
    {
      return Authenticate();
    }
    else{
      //return home if there is a user
      return Home();
    }
    
  }
}