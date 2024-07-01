import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/function_controller.dart';
import 'package:provider/provider.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FunctionController>(context);
    return Scaffold(
      body: provider.screens[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home Screen',
            backgroundColor: Color.fromARGB(255, 34, 19, 19),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Post',
            backgroundColor: Color.fromARGB(255, 34, 19, 19),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'All Users',
            backgroundColor: Color.fromARGB(255, 34, 19, 19),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Color.fromARGB(255, 34, 19, 19),
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 1,
        currentIndex: provider.currentIndex,
        selectedItemColor: const Color.fromARGB(255, 213, 156, 156),
        unselectedItemColor: const Color.fromARGB(255, 59, 56, 56),
        onTap: (value) {
          provider.navigateToNextPage(value);
        },
      ),
    );
  }
}
