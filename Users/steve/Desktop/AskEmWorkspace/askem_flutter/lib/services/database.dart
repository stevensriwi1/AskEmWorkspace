import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService
{

  final String uid;
  DatabaseService({this.uid});
   
  final CollectionReference users = Firestore.instance.collection('users');

  Future updateUserData(String firstName, String lastName) async{
    return await users.document(uid).setData({
      'firstName':firstName,
      'lastName':lastName
    });
  }

  //get user stream
  //getting the snapshot of the firestore database
  Stream<QuerySnapshot> get user {
    return users.snapshots();
  }
}