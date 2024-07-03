import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/firebase_controller.dart';
import 'package:flutter_firebase_pegion_post/view/startup_screens/signup_screen.dart';
import 'package:flutter_firebase_pegion_post/view/widgets/auth_textfeild.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseController>(context);
    // final userProvider = Provider.of<UserController>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 180),
                const Icon(
                  Icons.chat_bubble_outline,
                  size: 90,
                  color: Color.fromARGB(255, 213, 156, 156),
                ),
                const SizedBox(height: 20),
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
                  onPressed: () async {
                    provider.loginFunction(context);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        provider.signUpWithGoogle(context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 213, 156, 156),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
                const SizedBox(height: 140),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(500, 40),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 213, 156, 156),
                      width: 3,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ));
                  },
                  child: const Text(
                    'SignUp',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 213, 156, 156),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
