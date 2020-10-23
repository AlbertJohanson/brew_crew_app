import 'package:flutter/material.dart';
import 'package:aj_brew_crew_app/Services/auth.dart';
import 'package:aj_brew_crew_app/shared/constants.dart';
import 'package:aj_brew_crew_app/shared/loading.dart';

class registrer extends StatefulWidget {
  final Function toogleView;
  registrer({this.toogleView});

  @override
  _registrerState createState() => _registrerState();
}

class _registrerState extends State<registrer> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error ='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Registrate',
          style: TextStyle(
            color: Colors.blue[900],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Inicia Sesion'),
            onPressed: () {
              widget.toogleView();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Correo'),
                validator: (val) => val.isEmpty ?'Ingresa un Correo' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Contraseña'),
                validator: (val) => val.length < 6 ?'Ingresa un contraseña con mas 6 caracteres' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue[900],
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(()=> loading = true);
                    dynamic result = await _auth.Registrer(email, password);
                    if(result==null){
                      setState((){ error = 'Porfavor escribe un correo valido';
                      loading = false;
                      });
                    }
                  }
                },
                child: Text(
                  'Registrate',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0),
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
