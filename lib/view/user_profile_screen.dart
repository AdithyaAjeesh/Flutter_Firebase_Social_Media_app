import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final int followers;
  final int following;

  const UserProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.followers,
    required this.following,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name Profile'),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 213, 156, 156)),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const CircleAvatar(
                radius: 60,
              ),
              const SizedBox(height: 10),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text('Email: $email'),
              const SizedBox(height: 10),
              Text('Followers: $followers'),
              const SizedBox(height: 10),
              Text('Following: $following'),
            ],
          ),
        ),
      ),
    );
  }
}
