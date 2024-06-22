import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
}
