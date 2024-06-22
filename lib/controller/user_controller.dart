import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/model/user_model.dart';
import 'package:flutter_firebase_pegion_post/service/user_service.dart';

class UserController extends ChangeNotifier {
  UserService userService = UserService();
  CollectionReference firestore =
      FirebaseFirestore.instance.collection("users");

  Stream<List<UserModel>> getAllUser() {
    return firestore.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> followFunction(followUserId) async {
    userService.followUser(followUserId);
    notifyListeners();
  }

  Future<bool> checkIsFollowing( String userID) async {
    return userService.isfollowing(userID);
  }

  Future<void> unFollowFunction(unfollowUserId) async {
    userService.unfollowUser(unfollowUserId);
  }
}
