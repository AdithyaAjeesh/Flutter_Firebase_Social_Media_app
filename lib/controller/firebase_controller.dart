import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/user_controller.dart';
import 'package:flutter_firebase_pegion_post/service/firebase_auth.dart';
import 'package:flutter_firebase_pegion_post/view/startup_screens/login_screen.dart';
import 'package:flutter_firebase_pegion_post/view/widgets/bottom_nav_widget.dart';

class FirebaseController extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FirebaseAuthentication firebaseAuthentication = FirebaseAuthentication();

  Future<void> signUpFunction(BuildContext context) async {
    String username = nameController.text;
    String password = passWordController.text;
    String email = emailController.text;

    firebaseAuthentication.signUpAuth(
      email,
      password,
      username,
      context,
    );
    notifyListeners();
  }

  Future<void> loginFunction(BuildContext context) async {
    String password = passWordController.text;
    String email = emailController.text;
    firebaseAuthentication.loginAuth(email, password, context);
    notifyListeners();
  }

  Future<void> logoutFunction(BuildContext context) async {
    firebaseAuthentication.logoutAuth(context);
    notifyListeners();
  }

  Future<void> checkLoggedInFunction(BuildContext context) async {
    UserController userController = UserController();
    final currentUser = await userController.getCurrentUser();
    if (currentUser != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const BottomNavWidget(),
        ));
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
      });
    }
  }
}
