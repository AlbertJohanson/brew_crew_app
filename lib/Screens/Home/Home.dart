import 'package:aj_brew_crew_app/Screens/Home/sttings_form.dart';
import 'package:aj_brew_crew_app/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:aj_brew_crew_app/Services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aj_brew_crew_app/Screens/Home/sttings_form.dart';
import 'package:provider/provider.dart';
import 'package:aj_brew_crew_app/Screens/Home/brew_list.dart';
import 'package:aj_brew_crew_app/models/brew.dart';

class Home extends StatelessWidget {
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseServices().brews,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Bienvenido',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Cerrar Sesion'),
              onPressed: () async {
                await _auth.SignOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/coffee_bg.png'),
            fit: BoxFit.cover
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
