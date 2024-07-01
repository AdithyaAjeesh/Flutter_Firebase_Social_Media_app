import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/user_controller.dart';
import 'package:flutter_firebase_pegion_post/view/all_users_screen.dart';
import 'package:flutter_firebase_pegion_post/view/home_screen.dart';
import 'package:flutter_firebase_pegion_post/view/post_screen.dart';
import 'package:flutter_firebase_pegion_post/view/settings_screen.dart';

class FunctionController extends ChangeNotifier {
  int currentIndex = 0;
  Color lightModeTheme = const Color.fromARGB(255, 225, 222, 222);
  Color darkModeTheme = Colors.black;
  Color? currentBackgroundColor;
  int currentTheme = 1;
  final screens = [
    const HomeScreen(),
    const PostScreen(),
    const AllUsersScreen(),
    const SettingsScreen(),
  ];

  void navigateToNextPage(value) {
    currentIndex = value;
    notifyListeners();
  }

  Future<void> getAllDataReady() async {
    await UserController().getCurrentUser();
  }

  void changeTheme() {
    if (currentTheme == 1) {
      currentTheme = 2;
    } else if (currentTheme == 2) {
      currentTheme = 1;
    }
    if (currentTheme == 1) {
      currentBackgroundColor = lightModeTheme;
    } else {
      currentBackgroundColor = darkModeTheme;
    }
    notifyListeners();
  }
}
