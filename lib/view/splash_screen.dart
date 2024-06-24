import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/firebase_controller.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseController>(context);
    provider.checkLoggedInFunction(context);
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
