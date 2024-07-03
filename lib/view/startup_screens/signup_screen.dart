import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/firebase_controller.dart';
import 'package:flutter_firebase_pegion_post/view/startup_screens/login_screen.dart';
import 'package:flutter_firebase_pegion_post/view/widgets/auth_textfeild.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseController>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 150),
              const Text(
                'SignUp with your Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color.fromARGB(255, 213, 156, 156),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter the Email address at which you want to contacted. other Users cant see this on your profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color.fromARGB(255, 213, 156, 156),
                ),
              ),
              const SizedBox(height: 10),
              AuthTextfeild(
                controller: provider.nameController,
                text: 'Enter your UserName',
                icon: Icons.verified_user,
              ),
              AuthTextfeild(
                controller: provider.emailController,
                text: 'Enter your Email',
                icon: Icons.email,
              ),
              AuthTextfeild(
                controller: provider.passWordController,
                text: 'Enter your PassWord',
                icon: Icons.password,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 213, 156, 156),
                    fixedSize: const Size(500, 40)),
                onPressed: () {
                  provider.signUpFunction(context);
                },
                child: const Text(
                  'SignUp',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 213, 156, 156),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          'G',
                          style: GoogleFonts.nunito(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'OR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 213, 156, 156),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 213, 156, 156),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(500, 40),
                  side: const BorderSide(
                    width: 3,
                    color: Color.fromARGB(255, 213, 156, 156),
                  ),
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
                },
                child: const Text(
                  'Already have an Account',
                  style: TextStyle(
                    color: Color.fromARGB(255, 213, 156, 156),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
