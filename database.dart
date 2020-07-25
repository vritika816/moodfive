import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodfive/models/mood.dart';
import 'package:moodfive/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference moodCollection = Firestore.instance.collection('Moods');

  Future updateUserData(String happy, String name, int strength) async {
    return await moodCollection.document(uid).setData({
      'happy' : happy,
      'name' : name,
      'strength' : strength,
    });
  }

  //mood list from snapshot
  List<Mood> _moodListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
         return Mood(
           name: doc.data['name'] ?? '',
           strength: doc.data['strength'] ?? 0,
           happy: doc.data['happy'] ?? '0'
         );
    }).toList();
  }

  //user data from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      happy: snapshot.data['happy'],
      strength: snapshot.data['strength'],

    );
  }

  //get mood stream
Stream<List<Mood>> get mood{
    return moodCollection.snapshots()
    .map(_moodListFromSnapshot);
}

//get user doc stream

  Stream<UserData> get userData{
    return moodCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }



}