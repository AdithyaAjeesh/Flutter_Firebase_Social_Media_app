import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/user_controller.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final int followers;
  final int following;
  final String userID;

  const UserProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.followers,
    required this.following,
    required this.userID,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('$name Profile'),
      ),
      body: Center(
        child: FutureBuilder<bool>(
            future: provider.checkIsFollowing(userID.toString()),
            builder: (context, snapshot) {
              bool isFollowig = snapshot.data!;
              return Container(
                height: 400,
                width: 300,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 213, 156, 156)),
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
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        provider.followFunction(userID);
                      },
                      child: const Text('Follow'),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
