import 'package:flutter/material.dart';
import 'package:aj_brew_crew_app/Screens/Authentication/authentication.dart';
import 'package:aj_brew_crew_app/Screens/Home/Home.dart';
import 'package:provider/provider.dart';
import 'package:aj_brew_crew_app/models/user.dart';

class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
   if(user == null){
     return authentication();
   }else{
     return Home();
   }
  }
}