import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/user_controller.dart';
import 'package:flutter_firebase_pegion_post/view/widgets/auth_textfeild.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserController>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Post',
          style: TextStyle(
            color: Color.fromARGB(255, 213, 156, 156),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 213, 156, 156),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                provider.pickImage();
              },
              child: Container(
                height: 200,
                width: 250,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 213, 156, 156),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  // image: provider.selectedImage != null
                  //     ? DecorationImage(
                  //         image: FileImage(provider.selectedImage),
                  //         fit: BoxFit.cover,
                  //       )
                  //     : null,
                ),
                // child: provider.selectedImage == null
                //     ? const Center(
                //         child: Icon(
                //           Icons.add_a_photo,
                //           color: Colors.white,
                //           size: 50,
                //         ),
                //       )
                //     : null,
              ),
            ),
            const SizedBox(height: 20),
            AuthTextfeild(
              controller: provider.titleController,
              text: 'Enter the Title',
              icon: Icons.ac_unit,
            ),
            AuthTextfeild(
              controller: provider.subTitleController,
              text: 'Enter subTitle',
              icon: Icons.abc,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 213, 156, 156),
              ),
              onPressed: () {
                provider.postFunction(context);
              },
              child: const Text(
                'Post',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
