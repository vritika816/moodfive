import 'package:flutter/material.dart';
import 'package:moodfive/screens/authenticate/register.dart';
import 'package:moodfive/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView(){
   setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView); //value passed : function name(toggleView)
    }
    else {
      return Register(toggleView: toggleView);
    }
  }
}
