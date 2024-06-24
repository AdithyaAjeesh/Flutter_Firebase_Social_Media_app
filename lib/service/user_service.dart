import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_pegion_post/model/post_model.dart';
import 'package:image_picker/image_picker.dart';

class UserService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> followUser(String followUserId) async {
    String currentUserId = firebaseAuth.currentUser!.uid;
    try {
      await firestore
          .collection('followers')
          .doc(currentUserId)
          .collection('userFollowers')
          .doc(followUserId)
          .set(
        {'followed': true},
      );
      await firestore.collection('users').doc(followUserId).update(
        {
          'followers': FieldValue.increment(1),
        },
      );

      await firestore.collection('users').doc(currentUserId).update(
        {
          'following': FieldValue.increment(1),
        },
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> isfollowing(String userID) async {
    String currentUserId = firebaseAuth.currentUser!.uid;
    DocumentSnapshot documentSnapshot = await firestore
        .collection('followers')
        .doc(currentUserId)
        .collection('userFollowers')
        .doc(userID)
        .get();
    return documentSnapshot.exists;
  }

  Future<void> unfollowUser(String unfollowUserId) async {
    String currentUserId = firebaseAuth.currentUser!.uid;

    await firestore
        .collection('followers')
        .doc(currentUserId)
        .collection('userFollowers')
        .doc(unfollowUserId)
        .delete();

    await firestore.collection('users').doc(unfollowUserId).update(
      {
        'followers': FieldValue.increment(-1),
      },
    );

    await firestore.collection('users').doc(currentUserId).update(
      {
        'following': FieldValue.increment(-1),
      },
    );
  }

  Future<void> getProfileImage(XFile image) async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      try {
        TaskSnapshot uploadTask = await storage
            .ref('profile_images/${user.uid}')
            .putFile(File(image.path));
        String imageUrl = await uploadTask.ref.getDownloadURL();
        await firestore
            .collection('users')
            .doc(user.uid)
            .update({'image': imageUrl});
      } on FirebaseAuthException catch (e) {
        throw Exception(e);
      }
    } else {
      log('User Not Found');
    }
  }

  Future<void> createPost(
    XFile image,
    String title,
    String subtitle,
  ) async {
    User? user = firebaseAuth.currentUser;
    try {
      if (user != null) {
        TaskSnapshot snapshot = await storage
            .ref('post_images/${user.uid}/${image.name}')
            .putFile(File(image.path));
        String imageURL = await snapshot.ref.getDownloadURL();
        PostModel newPost = PostModel(
          image: imageURL,
          title: title,
          subTitle: subtitle,
          likes: 0,
          disLikes: 0,
        );
        await firestore.collection('posts').add(newPost.toJson());
      } else {
        log('Failed To Post User not Avalable');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }
}
