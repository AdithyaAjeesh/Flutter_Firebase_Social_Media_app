import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/model/post_model.dart';
import 'package:flutter_firebase_pegion_post/model/user_model.dart';
import 'package:flutter_firebase_pegion_post/service/user_service.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends ChangeNotifier {
  UserService userService = UserService(); 
  CollectionReference firestore =
      FirebaseFirestore.instance.collection("users");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker picker = ImagePicker();

  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();

  Stream<List<UserModel>> getAllUser() {
    return firestore.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<UserModel?> getCurrentUser() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();
      if (userDoc.exists) {
        return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      }
    }
    return null;
  }

  Future<void> uploadImageFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await userService.getProfileImage(image);
      notifyListeners();
    }
  }

  Future<void> followFunction(followUserId) async {
    userService.followUser(followUserId);
    notifyListeners();
  }

  Future<bool> checkIsFollowing(String userID) async {
    return userService.isfollowing(userID);
  }

  Future<void> unFollowFunction(unfollowUserId) async {
    userService.unfollowUser(unfollowUserId);
  }

  XFile? selectedImage;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    selectedImage = image;
  }

  Future<void> postFunction(BuildContext context) async {
    if (selectedImage != null) {
      userService.createPost(
        selectedImage!,
        titleController.text,
        subTitleController.text,
      );
      log('Poster');
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Error'),
            content: Text('image not Found'),
          );
        },
      );
    }
  }

  Stream<List<PostModel>> getAllPosts() {
    return _firestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return PostModel.fromJson(doc.data());
      }).toList();
    });
  }
}
