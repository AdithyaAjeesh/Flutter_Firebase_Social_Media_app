// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/model/user_model.dart';
import 'package:flutter_firebase_pegion_post/view/startup_screens/splash_screen.dart';
import 'package:flutter_firebase_pegion_post/view/widgets/bottom_nav_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> signUpAuth(
    String email,
    String password,
    String userName,
    BuildContext context,
  ) async {
    try {
      UserCredential credential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      if (user != null) {
        UserModel userModel = UserModel(
          userName: userName,
          email: email,
          password: password,
          followers: 0,
          following: 0,
          image: '',
          uid: user.uid,
        );
        await firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toJson());
        log('Sucess');
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const BottomNavWidget(),
        ));
        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      log('$e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to Login because $e'),
          );
        },
      );
    }
    return null;
  }

  Future<User?> loginAuth(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (firebaseAuth.currentUser!.emailVerified) {
        return credential.user;
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const BottomNavWidget(),
      ));
    } on FirebaseAuthException catch (e) {
      log('$e');
    }
    return null;
  }

  Future<void> logoutAuth(BuildContext context) async {
    try {
      await firebaseAuth.signOut();
      log('Logged Out');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ));
    } on FirebaseAuthException catch (e) {
      log('$e');
    }
  }

  // Future<UserCredential?> signInWithGoogle(BuildContext context) async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) {
  //       return null;
  //     }
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final OAuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     UserCredential userCredential =
  //         await firebaseAuth.signInWithCredential(credential);
  //     User? user = userCredential.user;
  //     if (user != null) {
  //       DocumentReference userDoc = firestore.collection('users').doc(user.uid);
  //       DocumentSnapshot docSnapshot = await userDoc.get();

  //       if (!docSnapshot.exists) {
  //         UserModel newUser = UserModel(
  //           userName: googleUser.displayName,
  //           email: user.email,
  //           uid: user.uid,
  //           image: "",
  //           followers: 0,
  //           following: 0,
  //         );

  //         await userDoc.set(newUser.toJson());
  //       }
  //     }

  //     return userCredential;
  //   } on FirebaseException catch (e) {
  //     throw Exception(e);
  //   }
  // }
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        DocumentReference userDoc = firestore.collection('users').doc(user.uid);
        DocumentSnapshot docSnapshot = await userDoc.get();

        if (!docSnapshot.exists) {
          UserModel newUser = UserModel(
            userName: googleUser.displayName ?? 'Anonymous',
            email: user.email ?? '',
            uid: user.uid,
            image: "",
            followers: 0,
            following: 0,
          );

          await userDoc.set(newUser.toJson());
        }
      }

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const BottomNavWidget(),
      ));

      return userCredential;
    } on FirebaseException catch (e) {
      log('$e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to sign in with Google: ${e.message}'),
          );
        },
      );
    }
    return null;
  }
}
