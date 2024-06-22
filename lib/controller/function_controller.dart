import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/view/all_users_screen.dart';
import 'package:flutter_firebase_pegion_post/view/home_screen.dart';
import 'package:flutter_firebase_pegion_post/view/settings_screen.dart';

class FunctionController extends ChangeNotifier {
  int currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const AllUsersScreen(),
    const SettingsScreen(),
  ];

  void navigateToNextPage(value) {
    currentIndex = value;
    notifyListeners();
  }
}
