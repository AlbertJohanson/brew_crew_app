import 'package:aj_brew_crew_app/Screens/Authentication/resgistrer.dart';
import 'package:flutter/material.dart';
import 'package:aj_brew_crew_app/Screens/Authentication/sign_in.dart';


class authentication extends StatefulWidget {
  @override
  _authenticationState createState() => _authenticationState();
}

class _authenticationState extends State<authentication> {

  bool showSignin = true;

  void  toogleView() {
    setState(()=> showSignin = !showSignin);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignin){
      return SignIn(toogleView: toogleView);
    }else{
      return registrer(toogleView: toogleView);
    }
  }
}