import 'package:askem_flutter/screens/authenticate/authenticate.dart';
import 'package:askem_flutter/screens/home/home.dart';
import 'package:flutter/material.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    
    //return either home or authenticate widget     
    return Authenticate();
  }
}