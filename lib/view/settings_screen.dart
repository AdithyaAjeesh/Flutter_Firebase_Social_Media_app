import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/firebase_controller.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            provider.logoutFunction(context);
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
