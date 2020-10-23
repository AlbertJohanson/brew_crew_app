import 'package:aj_brew_crew_app/Services/auth.dart';
import 'package:aj_brew_crew_app/shared/constants.dart';
import 'package:aj_brew_crew_app/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toogleView;
  SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading =false;

  //Text fields State
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Iniciar Sesion',
          style: TextStyle(
            color: Colors.blue[900],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Registrate'),
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
                  setState(() => loading = true);
                   if(_formKey.currentState.validate()){
                     dynamic result = await _auth.signIn(email, password);
                    if(result==null){
                      setState((){ 
                        error = 'Escribe un Correo y una Contraseña que hayas registrado';
                        loading = false;
                      });
                    }
                  }
                },
                child: Text(
                  'Iniciar Sesion',
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
