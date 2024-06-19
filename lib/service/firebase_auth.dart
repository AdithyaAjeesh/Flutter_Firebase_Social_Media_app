// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/model/user_model.dart';
import 'package:flutter_firebase_pegion_post/view/all_users_screen.dart';
import 'package:flutter_firebase_pegion_post/view/startup_screens/login_screen.dart';

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
          builder: (context) => const AllUsersScreen(),
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
  }

  Future<User?> loginAuth(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (firebaseAuth.currentUser!.emailVerified) {
        return credential.user;
      } else {
        log('email not Verified');
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const AllUsersScreen(),
      ));
    } on FirebaseAuthException catch (e) {
      log('$e');
    }
  }

  Future<void> logoutAuth(BuildContext context) async {
    try {
      await firebaseAuth.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ));
      log('Logged Out');
    } on FirebaseAuthException catch (e) {
      log('$e');
    }
  }
}
