import 'package:aj_brew_crew_app/Screens/Authentication/sign_in.dart';
import 'package:aj_brew_crew_app/Services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aj_brew_crew_app/models/user.dart';

class AuthServices{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user 

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User (uid: user.uid):null;
  }

  //auth change user stream

  Stream<User> get user{
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password

  Future signIn (String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //registrer with email & password

  Future Registrer (String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create a document for the user with uid

      await DatabaseServices(uid: user.uid).UpdateUserData('0','New Crew Member', 100);

      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future SignOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}