import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:take_a_break/take_a_break.dart';

class FirestoreService {
  static final FirestoreService _singleton = FirestoreService._internal();
  late FirebaseFirestore db;
  late CollectionReference userDataCollection;


  factory FirestoreService() {
    _singleton.db = FirebaseFirestore.instance;
    _singleton.userDataCollection = _singleton.db.collection("userData");
    return _singleton;
  }

  FirestoreService._internal();

  DocumentReference getDocument(String path){
    return userDataCollection.doc(path);
  }

  Future<DocumentReference> createUser(UserCredentials userCredentials) async {
   return await userDataCollection.add(UserData(userCredentials: userCredentials).toJson()).then(
      (doc) {
        if(kDebugMode) {
          debugPrint("document created with id: ${doc.id}");
        }
        return doc;
      },
    );
  }


  void updateQuestionnaire(DocumentReference doc,Questionnaire questionnaire) async{
    await doc.update({"questionnaire":questionnaire.toJson()}).then(
      (_) {
        if(kDebugMode) {
          debugPrint("fields updated");
        }
      },
    );
  }
}
