import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/firebase_controller.dart';
import 'package:flutter_firebase_pegion_post/controller/function_controller.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseController>(context);
    final functionPro = Provider.of<FunctionController>(context);
    return Scaffold(
      backgroundColor: functionPro.currentBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Settings Screen',
          style: TextStyle(color: Color.fromARGB(255, 213, 156, 156)),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                provider.logoutFunction(context);
              },
              child: const Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                functionPro.changeTheme();
              },
              child: const Text('Change Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
