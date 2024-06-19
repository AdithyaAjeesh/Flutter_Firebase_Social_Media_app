import 'package:flutter/material.dart';

class AuthTextfeild extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final IconData icon;
  const AuthTextfeild({
    super.key,
    required this.controller,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
