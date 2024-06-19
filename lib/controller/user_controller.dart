import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/model/user_model.dart';

class UserController extends ChangeNotifier {
  CollectionReference firestore =
      FirebaseFirestore.instance.collection("users");

  Stream<List<UserModel>> getAllUser() {
    return firestore.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
