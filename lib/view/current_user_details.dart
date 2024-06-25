import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/user_controller.dart';
import 'package:flutter_firebase_pegion_post/model/post_model.dart';
import 'package:flutter_firebase_pegion_post/model/user_model.dart';
import 'package:flutter_firebase_pegion_post/view/post_screen.dart';
import 'package:provider/provider.dart';

class CurrentUserDetails extends StatelessWidget {
  const CurrentUserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<UserModel?>(
              future: provider.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                    child: Text('No user data found.'),
                  );
                } else {
                  final user = snapshot.data!;
                  final name = user.userName;
                  final email = user.email;
                  final followers = user.followers?.toString();
                  final following = user.following?.toString();
                  final image = user.image ?? '';
                  return Container(
                    height: 400,
                    width: 300,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 213, 156, 156),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            provider.uploadImageFromGallery();
                          },
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: image.isEmpty
                                ? null
                                : NetworkImage(image) as ImageProvider,
                            child:
                                image.isEmpty ? const Text('Add Image') : null,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          name.toString(),
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const PostScreen(),
                              ),
                            );
                          },
                          child: const Text('Post'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            Expanded(
              child: StreamBuilder<List<PostModel>>(
                stream: provider.getAllPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No posts found'));
                  } else {
                    List<PostModel> posts = snapshot.data!;
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        PostModel post = posts[index];
                        return Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 213, 156, 156),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Image(
                                  image: NetworkImage(
                                    post.image.toString(),
                                  ),
                                ),
                              ),
                              Text(
                                post.title.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
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
            ),
          ],
        ),
      ),
    );
  }
}
