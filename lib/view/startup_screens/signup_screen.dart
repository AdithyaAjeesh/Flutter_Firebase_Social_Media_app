import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/firebase_controller.dart';
import 'package:flutter_firebase_pegion_post/view/startup_screens/login_screen.dart';
import 'package:flutter_firebase_pegion_post/view/widgets/auth_textfeild.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseController>(context);
    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 213, 156, 156)),
          child: Column(
            children: [
              const Text(
                'SignUp',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10),
              AuthTextfeild(
                controller: provider.nameController,
                text: 'Enter UserName',
                icon: Icons.verified_user,
              ),
              AuthTextfeild(
                controller: provider.emailController,
                text: 'Enter Email',
                icon: Icons.email,
              ),
              AuthTextfeild(
                controller: provider.passWordController,
                text: 'Enter PassWord',
                icon: Icons.password,
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  provider.signUpFunction(context);
                },
                child: const Text(
                  'SignUp',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 213, 156, 156),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('OR'),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}