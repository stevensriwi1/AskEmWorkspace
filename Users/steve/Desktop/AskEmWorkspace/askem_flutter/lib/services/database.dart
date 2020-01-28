import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DatabaseService
{

final FirebaseAuth _auth = FirebaseAuth.instance;

  final Firestore _firestore = Firestore.instance;
  final String uid;
  String firestoreUID;
  DatabaseService({this.uid, this.firestoreUID});
   
  final CollectionReference users = Firestore.instance.collection('users');
//collect and update firestore
  Future updateUserData(String firstName, String lastName) async{
    return await users.document(uid).setData({
      'firstName':firstName,
      'lastName':lastName
    });
  }
Future<DocumentReference> getUserDoc() async {
    

    FirebaseUser user = await _auth.currentUser();
    DocumentReference ref = _firestore.collection('users').document(user.uid);
    //getting the uid
    ref.collection(user.uid).document('firstName');
    print(ref.documentID);
    firestoreUID=ref.documentID;
    return ref;
  }
  //get user stream
  //getting the snapshot of the firestore database
  Stream<QuerySnapshot> get user {
    return users.snapshots();
  }
}