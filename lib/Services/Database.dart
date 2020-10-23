import 'package:aj_brew_crew_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aj_brew_crew_app/models/brew.dart';

class DatabaseServices {

  final String uid;
  DatabaseServices({this.uid});

  //Colletion Reference 
  final CollectionReference brewColletion = Firestore.instance.collection('brews');

  Future UpdateUserData(String sugars, String name, int strength) async{
    return await brewColletion.document(uid).setData({
      'sugars': sugars,
      'Name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot

  List<Brew> _BrewListFromSnapShot (QuerySnapshot snapShot){
    return snapShot.documents.map((doc){
      return Brew(
        name: doc.data['Name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0',
      );
    }).toList(); 
  }

  //user data from snapshot

  UserData _userdataFromSnapShot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['Name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  //get brews stream 

  Stream<List<Brew>> get brews{
    return brewColletion.snapshots()
    .map(_BrewListFromSnapShot);
  }

//get user doc stream
  Stream <UserData> get userData {
  return brewColletion.document(uid).snapshots()
  .map(_userdataFromSnapShot);
}


}



