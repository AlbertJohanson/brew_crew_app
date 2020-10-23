import 'package:aj_brew_crew_app/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:aj_brew_crew_app/Screens/Home/wrapper.dart';
import 'package:aj_brew_crew_app/Services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value:AuthServices().user,
          child: MaterialApp(
        home: wrapper(),
      ),
    );
  }
}