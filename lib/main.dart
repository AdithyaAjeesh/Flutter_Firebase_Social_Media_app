import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/firebase_controller.dart';
import 'package:flutter_firebase_pegion_post/controller/function_controller.dart';
import 'package:flutter_firebase_pegion_post/controller/user_controller.dart';
import 'package:flutter_firebase_pegion_post/firebase_options.dart';
import 'package:flutter_firebase_pegion_post/view/startup_screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FirebaseController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserController(),
        ),
        ChangeNotifierProvider(
          create: (context) => FunctionController(),
        )
      ],
      child: const MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
