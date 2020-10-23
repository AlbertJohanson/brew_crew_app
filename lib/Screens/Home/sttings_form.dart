import 'dart:math';
import 'package:aj_brew_crew_app/Services/Database.dart';
import 'package:aj_brew_crew_app/shared/loading.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:aj_brew_crew_app/shared/constants.dart';
import 'package:aj_brew_crew_app/models/user.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseServices(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Actualiza los ajustes de Brew',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Porfavor Ingresa un nombre ' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  //dropdownw
                  DropdownButtonFormField(
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar Sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),

                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? 100],
                    inactiveColor: Colors.brown[_currentStrength ?? 100],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  //slider
                  RaisedButton(
                    color: Colors.blue[500],
                    child: Text(
                      'Actualizar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                     if(_formKey.currentState.validate()){
                       await DatabaseServices(uid: user.uid).UpdateUserData(
                         _currentSugars ?? userData.sugars,
                         _currentName ?? userData.name,
                         _currentStrength ?? userData.strength
                         );
                         Navigator.pop(context);
                     }
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
