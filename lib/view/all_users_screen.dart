import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_pegion_post/controller/firebase_controller.dart';
import 'package:flutter_firebase_pegion_post/controller/user_controller.dart';
import 'package:flutter_firebase_pegion_post/model/user_model.dart';
import 'package:flutter_firebase_pegion_post/view/user_profile_screen.dart';
import 'package:provider/provider.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserController>(context);
    final authPro = Provider.of<FirebaseController>(context);
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
        backgroundColor: const Color.fromARGB(255, 213, 156, 156),
        actions: [
          IconButton(
            onPressed: () {
              authPro.logoutFunction(context);
            },
            icon: const Icon(
              Icons.login,
            ),
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: provider.getAllUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<UserModel> users = (snapshot.data as List<UserModel>)
                  .where((element) => element.uid != currentUserID)
                  .toList();
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final data = users[index];
                  final name = data.userName.toString();
                  final email = data.email.toString();
                  final followers = data.followers;
                  final following = data.following;
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserProfileScreen(
                          name: name,
                          email: email,
                          followers: followers!,
                          following: following!,
                        ),
                      ));
                    },
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 213, 156, 156),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          const Icon(Icons.person),
                          const SizedBox(width: 10),
                          Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(data.uid.toString()),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
