import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/user_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Post'),
            GestureDetector(
              onTap: () {
                provider.pickImage();
              },
              child: const CircleAvatar(),
            ),
            TextField(
              controller: provider.titleController,
            ),
            TextField(
              controller: provider.subTitleController,
            ),
            ElevatedButton(
              onPressed: () {
                provider.postFunction(context);
              },
              child: const Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
