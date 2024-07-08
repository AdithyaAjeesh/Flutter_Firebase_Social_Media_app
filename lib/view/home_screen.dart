import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/user_controller.dart';
import 'package:flutter_firebase_pegion_post/model/post_model.dart';
import 'package:flutter_firebase_pegion_post/model/user_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return FutureBuilder<UserModel?>(
      future: userController.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text(
                'Loading...',
                style: TextStyle(
                  color: Color.fromARGB(255, 213, 156, 156),
                ),
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 213, 156, 156),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('No User Found'),
            ),
            body: const Center(child: Text('No user data available')),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
            ),
            body: StreamBuilder<List<PostModel>>(
              stream: userController.getAllPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No posts found'));
                } else {
                  List<PostModel> posts = snapshot.data!;
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      PostModel post = posts[index];
                      return Card(
                        color: const Color.fromARGB(255, 213, 156, 156),
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (post.image != null) Image.network(post.image!),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                post.title.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(post.subTitle.toString()),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.thumb_up),
                                    color: Colors.black,
                                    onPressed: () {},
                                  ),
                                  Text(post.likes.toString()),
                                  IconButton(
                                    icon: const Icon(Icons.thumb_down),
                                    color: Colors.black,
                                    onPressed: () {},
                                  ),
                                  Text(post.disLikes.toString()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}
