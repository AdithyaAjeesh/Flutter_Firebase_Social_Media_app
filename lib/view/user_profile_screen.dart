import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/user_controller.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final int followers;
  final int following;
  final String userID;
  final String image;

  const UserProfileScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.followers,
    required this.following,
    required this.userID,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('$name Profile'),
      ),
      body: Center(
        child: FutureBuilder<bool>(
          future: provider.checkIsFollowing(userID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data found');
            } else {
              bool isFollowing = snapshot.data!;
              return Container(
                height: 400,
                width: 300,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 213, 156, 156)),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    CircleAvatar(
                      backgroundImage:
                          image.isNotEmpty ? NetworkImage(image) : null,
                      radius: 60,
                      child: image.isEmpty ? const Icon(Icons.person) : null,
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
                        if (isFollowing) {
                          provider.unFollowFunction(userID);
                        } else {
                          provider.followFunction(userID);
                        }
                      },
                      child: Text(isFollowing ? 'Unfollow' : 'Follow'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
